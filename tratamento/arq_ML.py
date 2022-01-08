import os.path
import msgpack_numpy as mpn
import random
import msgpack as mp

raiz = "/home/caminho/da/pasta/dados/processados/kepler_"

# Lê todas as curvas de luz tratadas
for item in range(15):
    pasta_proc = raiz + str(item+1)
    #print("kep_" + str(item+1), end = " ")
    
    arq_g_view = pasta_proc + "/g_views_" + str(item+1) + ".msgpack"
    arq_l_view = pasta_proc + "/l_views_" + str(item+1) + ".msgpack"

    # Lê os arquivos de treino
    
    
    if item == 0:
        with open(arq_g_view, "rb") as arquivo:
            byte_data = arquivo.read()
            g_views = mp.unpackb(byte_data, object_hook=mpn.decode)
        print("Global - Rodada: " + str(item+1), arquivo.closed)
        
        with open(arq_l_view, "rb") as arquivo:
            byte_data = arquivo.read()
            l_views = mp.unpackb(byte_data, object_hook=mpn.decode)
        print("Local - Rodada: " + str(item+1), arquivo.closed)

    else:
        with open(arq_g_view, "rb") as arquivo:
            byte_data = arquivo.read()
            g_views += mp.unpackb(byte_data, object_hook=mpn.decode)
        print("Global - Rodada: " + str(item+1), arquivo.closed)
        
        with open(arq_l_view, "rb") as arquivo:
            byte_data = arquivo.read()
            l_views += mp.unpackb(byte_data, object_hook=mpn.decode)
        print("Local - Rodada: " + str(item+1), arquivo.closed)
        
        
# Faz uma correspondência entre as curva global com a respectiva local.
curvas = list(zip(g_views, l_views))

# Embaralha os elementos de cada lista.
#   Estabelecer uma raiz e criar uma nova lista com os mesmos elementos
#   das demais listas (mas embaralhados) é puro preciosismo da minha parte.
random.seed(23)
random.shuffle(curvas)

# Retorna os valores embaralhados para as listas originais.
g_views, l_views = zip(*curvas)

# Partição da tabela dos TCEs como segue:
#   tces_treino = 80% dos TCEs
#   tces_val    = 10% dos TCEs
#   tces_teste  = 10% dos TCEs
num_tces = len(g_views)

corte_treino = int(0.80 * num_tces)
corte_val = int(0.90 * num_tces)

g_treino = g_views[0:corte_treino]
l_treino = l_views[0:corte_treino]

g_val = g_views[corte_treino:corte_val]
l_val = l_views[corte_treino:corte_val]

g_teste = g_views[corte_val:]
l_teste = l_views[corte_val:]


# Salva os arquivos de treino, validação e teste
salva_arq = "/home/caminho/da/pasta/dados/Arqs_ML"

#   Cria a pasta para armazenar os arquivos salvos caso não exista.
if not os.path.exists(salva_arq):
    os.makedirs(salva_arq)


    
salva_ML_arq = salva_arq + "/g_treino.msgpack"

with open(salva_ML_arq, "wb") as arq_ML:
    packed = mp.packb(g_treino, default = mpn.encode)
    arq_ML.write(packed)
    
print("Arquivo g_treino.msgpack salvo com sucesso.")

salva_ML_arq = salva_arq + "/l_treino.msgpack"

with open(salva_ML_arq, "wb") as arq_ML:
    packed = mp.packb(l_treino, default = mpn.encode)
    arq_ML.write(packed)

print("Arquivo l_treino.msgpack salvo com sucesso.")


salva_ML_arq = salva_arq + "/g_val.msgpack"

with open(salva_ML_arq, "wb") as arq_ML:
    packed = mp.packb(g_val, default = mpn.encode)
    arq_ML.write(packed)
    
print("Arquivo g_val.msgpack salvo com sucesso.")

salva_ML_arq = salva_arq + "/l_val.msgpack"

with open(salva_ML_arq, "wb") as arq_ML:
    packed = mp.packb(l_val, default = mpn.encode)
    arq_ML.write(packed)
    
print("Arquivo l_val.msgpack salvo com sucesso.")


salva_ML_arq = salva_arq + "/g_teste.msgpack"

with open(salva_ML_arq, "wb") as arq_ML:
    packed = mp.packb(g_teste, default = mpn.encode)
    arq_ML.write(packed)
    
print("Arquivo g_teste.msgpack salvo com sucesso.")

salva_ML_arq = salva_arq + "/l_teste.msgpack"

with open(salva_ML_arq, "wb") as arq_ML:
    packed = mp.packb(l_teste, default = mpn.encode)
    arq_ML.write(packed)
    
print("Arquivo l_teste.msgpack salvo com sucesso.")


print("Fim do processamento.")