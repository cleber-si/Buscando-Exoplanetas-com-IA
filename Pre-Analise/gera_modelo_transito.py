'''
Rascunho de algoritmo para gerar modelos de trânsito do tipo BLS para possíveis valores 
de período, dada uma curva de luz com apenas dois trânsitos.
'''

import lightkurve as lk
import numpy as np
import matplotlib.pyplot as plt

# Para plotar figuras mais bonitas
import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.rc('axes', labelsize=14)
mpl.rc('xtick', labelsize=12)
mpl.rc('ytick', labelsize=12)
plt.rcParams["figure.figsize"] = (16, 8)
plt.rcParams.update({'font.size': 10})


# Gera um objeto tipo LightKurve
lc_2193_col = lk.search_lightcurve('TIC 219345200', author="SPOC").download_all()
lc_2193 = lc_2193_col.stitch()
lc_2193_limpa = lc_2193.remove_outliers(sigma_lower=np.inf, sigma_upper=5)


def gera_modelo_transito(lc, duracao_dias, t0_dias, periodo_dias, divisoes):
  #periodo_dias = 719.0375/divisoes

  # Lê os valores de tempo e fluxo da curva
  fluxo = lc.flux.value
  tempo = lc.time.value

  # Calcula o tamanho do array relativo à duração do trânsito com base no intervalo padrão
  intervalo_padrao = 0.001388914
  duracao_array = int(duracao_dias / intervalo_padrao)

  # Cria um array completo de tempos para preencher gaps
  tempo_novo = []
  cont_tempo = tempo[0]
  while cont_tempo < tempo[-1]:
    tempo_novo.append(cont_tempo)
    cont_tempo += intervalo_padrao
  tempo_novo = np.array(tempo_novo)

  # Calcula o fluxo mínimo do modelo com base no menor valor de fluxo da série temporal
  fluxo_minimo = np.min(fluxo)
  fluxo_minimo_modelo = fluxo_minimo + (1 - fluxo_minimo)*0.25

  # Encontra o valor disponível mais próximo do valor t0 no array de tempos e seu índice
  t0 = tempo_novo.flat[np.abs(tempo_novo - t0_dias).argmin()]
  t0_indice = np.where(tempo_novo == t0)[0][0]

  # Calcula quantas quedas haverão depois de t0 com base no período do trânsito
  periodo_array = int(periodo_dias/intervalo_padrao)
  intervalo_disp_dias = tempo_novo[-1] - tempo_novo[t0_indice]
  intervalo_disp_array = int(intervalo_disp_dias / intervalo_padrao)
  num_quedas = int(intervalo_disp_array / periodo_array)

  # Calcula quantas quedas haverão antes de t0 com base no período do trânsito
  intervalo_disp_dias_antes = tempo_novo[t0_indice] - tempo_novo[0]
  intervalo_disp_array_antes = int(intervalo_disp_dias_antes / intervalo_padrao)
  num_quedas_antes = int(intervalo_disp_array_antes / periodo_array)
  print(num_quedas_antes)

  # Cria array com os instantes iniciais das quedas depois de t0
  instantes_quedas = [t0_indice]
  for i in range(num_quedas):
    instantes_quedas.append(instantes_quedas[i]+periodo_array)
  
  # Cria array com os instantes iniciais das quedas antes de t0
  if num_quedas_antes > 0:
    instantes_quedas_antes = [t0_indice]
    for i in range(num_quedas_antes):
      instantes_quedas_antes.append(instantes_quedas_antes[i]-periodo_array)
    instantes_quedas_antes = np.delete(instantes_quedas_antes, 0)

    # Concatena os arrays das quedas
    instantes_quedas = np.concatenate((instantes_quedas, instantes_quedas_antes), axis=None)

  # Calcula o modelo com base nos parâmetros calculados acima
  modelo_transito = [1]*len(tempo_novo)
  ajust = 30 # Constante de ajustabilidade arbitrária para centralizar o trânsito
  for queda in instantes_quedas:
    for i in range(duracao_array):
      try:
        modelo_transito[queda + i + ajust] = fluxo_minimo_modelo
      except:
        pass

  # Plota a curva de luz e o modelo do trânsito
  plt.plot(tempo, fluxo, '.k')
  plt.plot(tempo_novo, modelo_transito, 'r')
  plt.xlim(1410, 1493) # Setores iniciais
  #plt.xlim(2140, 2205) # Setores finais
  plt.show()

# Possíveis valores de divisões para os primeiros setores: 17, 22, 23 e 24
# Possíveis valores de divisões para os últimos setores: 22 e 44

for i in range(100):
  divisoes = i+1
  periodo = 719.0375/divisoes
  print('Divisões: {} - Período: {}'.format(i+1, periodo))
  gera_modelo_transito(lc_2193_limpa, 0.154, 1434.8, periodo, divisoes)