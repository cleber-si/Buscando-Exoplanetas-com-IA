from tratamento import kepler_io
from tratamento import processos as pc
import numpy as np
import os
import itertools  # Para transformar arrays em arrays unidimensionais
import pandas as pd

import _pickle as cPickle  # Para salvar os arquivos
import traceback  # Para armazenar logs de erro


# -------- Gerenciamento de Pastas e Arquivos --------
n = 1 # Número da pasta e do processo para ser executado
pasta = str(n)
salva_arq = "insira/o/caminho" + pasta
""" 
Exemplo:
(Linux)   raiz = "/home/você/Documentos/kepler_separados/kepler_" + pasta
(Windows) raiz = "C:\\Users\\você\\Documentos\\kepler_separados\\kepler_" + pasta
"""

PASTA_DADOS_KEPLER = "insira/o/caminho" + pasta
PASTA_ARQ_CSV = "insira/o/caminho"

# Cria a pasta para armazenar os arquivos salvos caso não exista.
if not os.path.exists(salva_arq):
    os.makedirs(salva_arq)

# Lê todas as pastas da pasta principal dos dados baixados do kepler e armazena em sub_ids
# Seus nomes correspondem aos primeiros quatro dígitos do Kepler_ID
sub_ids = [item for item in os.listdir(PASTA_DADOS_KEPLER) if os.path.isdir(
    os.path.join(PASTA_DADOS_KEPLER, item))]

# Lista com todas as subpastas da pasta raiz dos dados
sub_pastas = [os.path.join(PASTA_DADOS_KEPLER, item) for item in sub_ids]

IDs = []                  # Lista com todos o Kepler_IDs
pastas_TCEs = []          # Lista com todos as pastas dos TCEs
for i in sub_pastas:
    pastas_TCEs.append(
        [os.path.join(i, item) for item in os.listdir(i) if os.path.isdir(os.path.join(i, item))])
    IDs.append([item for item in os.listdir(i) if os.path.isdir(os.path.join(i, item))])

pastas_TCEs = list(itertools.chain(*pastas_TCEs))
IDs = list(itertools.chain(*IDs))


# -------- Criação e filtragem do dataframe --------

# Cria um dataframe do Pandas com base no arquivo "dr24_tce.csv"
tabela_tce = pd.read_csv(PASTA_ARQ_CSV, index_col="rowid", comment="#")

'''
# Remove colunas obsoletas (remova qualquer coluna que não for usar)
tabela_tce = tabela_tce.drop(columns = ['Unnamed: 10', 'Unnamed: 11', 'Unnamed: 12'])
'''

# Cria uma lista com os IDs que deverão ser mantidos no dataframe
ids_permitidos = []
for i in tabela_tce.index:
    kep_id = "{:09d}".format(tabela_tce["kepid"][i])
    if not kep_id in IDs:
        continue
    ids_permitidos.append(int(kep_id))

# Filtra TCEs existentes na lista IDs
tce_existentes = tabela_tce["kepid"].apply(lambda l: l in ids_permitidos)

# Tabela apenas com TCEs existentes
tabela_tce = tabela_tce[tce_existentes]   

coluna_labels = "av_training_set"          # Coluna dos labels
labels_permitidos = {"PC", "AFP", "NTP"}   # Label permitidos dos TCEs

# Filtra TCEs permitidos com base nos labels
tce_permitidos = tabela_tce[coluna_labels].apply(lambda l: l in labels_permitidos)

# Tabela apenas com TCEs permitidos
tabela_tce = tabela_tce[tce_permitidos]


# -------- Leitura dos Arquivos .fits --------

# Array com os nomes de todos os arquivos .fits baixados
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


# -------- Execução principal --------

g_views = [] # Array onde todas todas as curvas globais serão armazenadas
l_views = [] # Array onde todas todas as curvas locais serão armazenadas

i = 0 # Contador do processo atual

log_arq = "/log_erros_" + pasta + ".txt" # Arquivo para armazenar os logs de erro
salva_log = salva_arq + log_arq # Caminho do arquivo para armazenar os logs de erro

with open(salva_log, "w") as log:
    for index, tce in tabela_tce.iterrows():

        # Barra de progresso
        print("Rodada", i+1, end = '')
        kic = "{:09d}".format(tce["kepid"])
        pc.print_percent_done(i, len(tabela_tce), kic)
        
        i += 1

        try:
            # Índice para correspondência dos IDs com os kepid da tabela.
            indice = list(kep_ids_int).index(tce["kepid"])

            # Lê e processa a curva de luz.
            time, flux = pc.processar_curva_luz(tempos[indice], fluxos[indice])

            # Lê o período, duração e epoch do TCE na tabela.
            # O fator 1/1000 em t0 serve para centralizar o TCE na curva de luz.
            period = tce["tce_period"]
            duration = tce["tce_duration"]
            t0 = tce["tce_time0bk"]/1000

            # "Folda" a curva de luz e organiza seus dados em ordem cronológica (tempo_min até tempo_max).
            time, flux = pc.phase_fold_and_sort_light_curve(time, flux, period, t0)

            # Gera as visões globais e locais e as converte em listas
            g_view = list(pc.global_view(time, flux, period))
            l_view = list(pc.local_view(time, flux, period, duration))
            
            # Guarda o KeplerID na primeira posição das listas
            g_view.insert(0, tce["kepid"])
            l_view.insert(0, tce["kepid"])
            
            # Guarda o label do TCE na segunda posição das listas
            g_view.insert(1, tce["av_training_set"])
            l_view.insert(1, tce["av_training_set"])

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
            for levantado apenas em l_views, g_views já vai ter recebido a acurva de luz, mas
            l_views não. Assim, as duas listas terão tamanhos diferentes. Para evitar isso, 
            estou inserindo um 'NaN' na posição que deveria receber uma curva de luz na
            visualização local.
            """
            if len(g_views) > len(l_views):
                l_views.append(float("NaN"))
            
            # Escreve e armazena os logs de erro
            log.write("Problema em KIC {0} na rodada {1}\n".format(tce["kepid"], i-1))
            traceback.print_exc(file=log)
            log.write("\n \n")
            continue
        

# -------- Salvamento das Curvas --------

# Salva as curvas de luz tratadas em um arquivo binário no formato .pickle
"""
Para carregar os arquivos, basta usar algo como:

with open(r"visualizacao.pickle", "rb") as input_file:
    visualizacao = cPickle.load(input_file)

Vale lembrar que o primeiro elemento das listas é o 
kepid do TCE e o segundo é o seu label.
"""

# Strings com os locais onde devem ser salvos os arquivos
arq_g_views = "/g_views_" + pasta + ".pickle"
arq_l_views = "/l_views_" + pasta + ".pickle"

# Salva as curvas de luz globais
with open(salva_arq + arq_g_views, "wb") as saida_g_views:
    cPickle.dump(g_views, saida_g_views)
    print("{} curvas de luz globais armazenadas.".format(len(g_views)))
   
# Salva as curvas de luz locais 
with open(salva_arq + arq_l_views, "wb") as saida_l_views:
    cPickle.dump(l_views, saida_l_views)
    print("{} curvas de luz locais armazenadas.".format(len(l_views)))


""" 
# -------- Teste --------
 
# Para plotar figuras mais bonitas
import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.rc('axes', labelsize=14)
mpl.rc('xtick', labelsize=12)
mpl.rc('ytick', labelsize=12)
plt.rcParams["figure.figsize"] = (16,8)
plt.rcParams.update({'font.size': 10})
 
g_bins = np.linspace(0, 2000, num = 2001) # Bins para a visão global
l_bins = np.linspace(0, 200, num = 201) # Bons para a visão local

curva = 0

print(g_views[curva][1])
plt.plot(g_bins, g_views[curva][2:], ".")
plt.show()

plt.plot(l_bins, l_views[curva][2:], ".")
plt.show()
 """