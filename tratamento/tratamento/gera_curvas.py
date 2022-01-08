import os
import itertools  # Para transformar arrays em arrays unidimensionais
import pandas as pd
import numpy as np
import gerar_views as gv

from third_party import kepler_spline
from third_party import kepler_io
from third_party import util

import sys
import time

import traceback  # Para armazenar logs de erro
import msgpack as mp # Para salvar e carregar arquivos
import msgpack_numpy as mpn


def processar_curva_luz(tempo_total, fluxo_total):
    tempo_total, fluxo_total = util.split(tempo_total, fluxo_total, gap_width=0.75)
    spline = kepler_spline.fit_kepler_spline(tempo_total, fluxo_total, verbose=False)[0]

    tempo = np.concatenate(tempo_total)
    fluxo = np.concatenate(fluxo_total)
    spline = np.concatenate(spline)

    finite_i = np.isfinite(spline)
    if not np.all(finite_i):
        tempo = tempo[finite_i]
        fluxo = fluxo[finite_i]
        spline = spline[finite_i]

    # "Achata" a curva de luz (remove variabilidades de curta frequência)
    # dividindo-a pelo spline
    fluxo /= spline
    
    return tempo, fluxo


def phase_fold_and_sort_light_curve(time, values, period, t0):
    time = util.phase_fold_time(time, period, t0)
    
    sorted_i = np.argsort(time)
    time = time[sorted_i]
    values = values[sorted_i]
    
    return time, values


def print_percent_done(index, total, kic, bar_len=25, title='Processando'):
    '''
    index is expected to be 0 based index. 
    0 <= index < total
    '''

    title = "Processando KIC {}".format(kic)

    percent_done = (index)/total*100
    percent_done = round(percent_done, 1)

    done = round(percent_done/(100/bar_len))
    togo = bar_len-done

    done_str = '█'*int(done)
    togo_str = '░'*int(togo)
    
    t_estim = (total-i)/4

    #print(f'\t⏳{title}: [{done_str}{togo_str}] {percent_done}% concluído. Tempo Estimado: {t_estim}', end='\r')
    
    print('\t⏳{}: [{}{}] {}% concluído. Tempo estimado: {:.2f} min.'.format(title,
                                                                   done_str,
                                                                   togo_str,
                                                                   percent_done,
                                                                   t_estim))
    
    if round(percent_done) == 100:
        print('\t✅')

# ----------------------------

pasta = str(12)
print('\n Pasta ', pasta)

salva_arq = "/home/caminho/da/pasta/kepler_" + pasta

PASTA_DADOS_KEPLER = "/home/caminho/da/pasta/dados/kepler_" + pasta
PASTA_ARQ_CSV = "/home/caminho/da/pasta/dr24_tce.csv"

# Cria a pasta para armazenar os arquivos salvos caso não exista.
if not os.path.exists(salva_arq):
    print('Criando pasta para salvar os arquivos.')
    os.makedirs(salva_arq)

# Lê todas as pastas da pasta principal dos dados baixados do kepler e armazena em sub_ids
# Seus nomes correspondem aos primeiros quatro dígitos do Kepler_ID
print('Lendo todas as pastas da pasta principal dos dados baixados do kepler')
sub_ids = [item for item in os.listdir(PASTA_DADOS_KEPLER) if os.path.isdir(
    os.path.join(PASTA_DADOS_KEPLER, item))]

# ----------------------------

# Lista com todas as subpastas da pasta raiz dos dados
print('Processando lista com todas as subpastas da pasta raiz dos dados')
sub_pastas = [os.path.join(PASTA_DADOS_KEPLER, item) for item in sub_ids]

IDs = []                  # Lista com todos o Kepler_IDs
pastas_TCEs = []          # Lista com todos as pastas dos TCEs
for i in sub_pastas:
    pastas_TCEs.append(
        [os.path.join(i, item) for item in os.listdir(i) if os.path.isdir(os.path.join(i, item))])
    IDs.append([item for item in os.listdir(i) if os.path.isdir(os.path.join(i, item))])

pastas_TCEs = list(itertools.chain(*pastas_TCEs))
IDs = list(itertools.chain(*IDs))

# ----------------------------

print('Iniciando dataframe do Pandas')
tabela_tce = pd.read_csv(PASTA_ARQ_CSV, index_col="rowid", comment="#")

tabela_tce = tabela_tce.drop(columns = ['Unnamed: 10', 'Unnamed: 11', 'Unnamed: 12'])

ids_permitidos = []
for i in tabela_tce.index:
    kep_id = "{:09d}".format(tabela_tce["kepid"][i])
    
    if not kep_id in IDs:
        continue
    
    ids_permitidos.append(int(kep_id))
    
tce_existentes = tabela_tce["kepid"].apply(lambda l: l in ids_permitidos) # Filtra TCEs existentes
tabela_tce = tabela_tce[tce_existentes]    # Tabela apenas com TCEs existentes

coluna_labels = "av_training_set"          # Coluna dos labels
labels_permitidos = {"PC", "AFP", "NTP"}   # Label dos TCEs permitidos

tce_permitidos = tabela_tce[coluna_labels].apply(lambda l: l in labels_permitidos) # Filtra TCEs permitidos
tabela_tce = tabela_tce[tce_permitidos]    # Tabela apenas com TCEs permitidos

# ----------------------------

# Array com os nomes de todos os arquivos .fits baixados
print('Processando array com os nomes de todos os arquivos .fits baixados')
nomes_arquivos = []
fluxos = []
tempos = []
kep_ids_str = []

kep_ids_int = pd.unique(tabela_tce["kepid"]) 

for i in kep_ids_int:
    i = "{:09d}".format(i)
    kep_ids_str.append(i)
    
    nome_arq = kepler_io.kepler_filenames(PASTA_DADOS_KEPLER, i)
    assert nome_arq, "Não foi possível encontrar um aquivo .fits com ID {} em {}".format(i, PASTA_DADOS_KEPLER)
    nomes_arquivos.append(nome_arq)
    
    tempo, fluxo = kepler_io.read_kepler_light_curve(nome_arq)
    
    tempos.append(tempo)
    fluxos.append(fluxo)

# ----------------------------

g_views = []
l_views = []

i = 0

log_arq = "/log_erros_" + pasta + ".txt"
salva_log = salva_arq + log_arq

print('Iniciando processamento principal')
with open(salva_log, "w") as log:
    for index, tce in tabela_tce.iterrows():
        
        controle = 0
        
        #if i > 2:
        #    break
        
        # Barra de progresso
        print("Rodada", i+1, end = '')
        kic = "{:09d}".format(tce["kepid"])
        print_percent_done(i, len(tabela_tce), kic)
        sys.stdout.flush()
        
        i += 1

        try:
            # Índice para correspondência dos IDs com os kepid da tabela.
            indice = list(kep_ids_int).index(tce["kepid"])

            # Lê e processa a curva de luz.
            time, flux = processar_curva_luz(tempos[indice], fluxos[indice])

            # Lê o período, duração e epoch do TCE na tabela.
            # O fator 1/1000 em t0 serve para centralizar o TCE na curva de luz.
            period = tce["tce_period"]
            duration = tce["tce_duration"]
            t0 = tce["tce_time0bk"]/1000

            # "Folda" a curva de luz e organiza seus dados em ordem cronológica (tempo_min até tempo_max).
            time, flux = phase_fold_and_sort_light_curve(time, flux, period, t0)

            # Gera as visões globais e locais e as converte em listas
            g_view = list(gv.gera_g_view(flux))
            l_view = list(gv.gera_l_view(time, flux, duration))
            
            # Guarda o KeplerID na primeira posição das listas
            g_view.insert(0, tce["kepid"])
            l_view.insert(0, tce["kepid"])
            
            # Guarda o numero do TCE de um dado KeplerID na primeira posição das listas
            g_view.insert(1, tce["tce_plnt_num"])
            l_view.insert(1, tce["tce_plnt_num"])

            # Guarda o label do TCE na segunda posição das listas
            g_view.insert(2, tce["av_training_set"])
            l_view.insert(2, tce["av_training_set"])

            # Armazena os dados das visões globais e locais.
            '''''
            Para plotar cada visualização, é necessário criar um array de inteiros de tamanho
            2001 para a visão global ou 201 para a visão local:

            g_bins = np.linspace(0, 2000, num = 2001) # Bins para a visão global

            l_bins = np.linspace(0, 200, num = 201) # Bons para a visão local
            '''''

            g_views.append(g_view)
            l_views.append(l_view)

        except:
            """
            Esse if checa se g_views recebeu a curva de luz da rodada atual. Se o problema
            for levantado apenas em l_views, g_views já vai ter recebidoa acurva de luz, mas
            l_views não. Assim, as duas listas terão tamanhos diferentes. Para evitar isso, 
            estou inserindo um 'NaN' na posição que deveria receber uma curva de luz na
            visualização local.
            """
            if len(g_views) > len(l_views):
                l_views.append(float("NaN"))
                
            log.write("Problema em KIC {0} na rodada {1}\n".format(tce["kepid"], i-1))
            traceback.print_exc(file=log)
            log.write("\n \n")
            continue
        
# Salva as curvas de luz tratadas em um arquivo binário no formato .pickle
"""
Para carregar os arquivos, basta usar:

with open(local_arq, "rb") as arquivo:
        byte_data = arquivo.read()
    array = msgpack.unpackb(byte_data, object_hook=mpn.decode)
"""

arq_g_views = "/g_views_" + pasta + ".msgpack"
arq_l_views = "/l_views_" + pasta + ".msgpack"

with open(salva_arq + arq_g_views, "wb") as saida_g_views:
    packed = mp.packb(g_views, default = mpn.encode)
    saida_g_views.write(packed)
    print("{} curvas de luz globais armazenadas.".format(len(g_views)))

with open(salva_arq + arq_l_views, "wb") as saida_l_views:
    packed = mp.packb(l_views, default = mpn.encode)
    saida_l_views.write(packed)
    print("{} curvas de luz locais armazenadas.".format(len(l_views)))