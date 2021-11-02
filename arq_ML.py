import os.path
import _pickle as cPickle  # Para salvar os arquivos
import random

# Seleciona a pasta raiz onde as pastas 'kepler_n' estão
raiz = "insira/o/caminho"
""" 
Exemplo:
(Linux)   raiz = "/home/você/Documentos/kepler_separados/kepler_" + pasta
(Windows) raiz = "C:\\Users\\você\\Documentos\\kepler_separados\\kepler_" + pasta
"""

# Informa ao script até que pasta você quer trabalhar.
# Insira o valor (se você seguiu o meu exemplo) para usar todo o dataset.
# Valores menores que isso são para testes.
# Deve ser um valor inteiro e maior que 0.
n = 1

# Lê todas as curvas de luz tratadas que foram selecionadas
for item in range(n):
    pasta_proc = raiz + str(item+1)
    #print("kep_" + str(item+1), end = " ")
    
    arq_g_view = pasta_proc + "/g_views_" + str(item+1) + ".pickle"
    arq_l_view = pasta_proc + "/l_views_" + str(item+1) + ".pickle"
    
    """ 
    A diferença entre o if e o else é que no if, que só vai rodar uma vez,
    estamos criando um array, ao passo que no else, que vai acontecer em todas
    as demais rodas, é que ele vai adicionar elementos nesses arrays criados.
    """
    if item == 0:
        with open(arq_g_view, "rb") as input_file:
            g_views = cPickle.load(input_file)
        print("Global - Rodada: " + str(item+1), input_file.closed)
            
        with open(arq_l_view, "rb") as input_file:
            l_views = cPickle.load(input_file)
        print("Local  - Rodada: " + str(item+1), input_file.closed)
    else:
        with open(arq_g_view, "rb") as input_file:
            g_views += cPickle.load(input_file)
        print("Global - Rodada: " + str(item+1), input_file.closed)
            
        with open(arq_l_view, "rb") as input_file:
            l_views += cPickle.load(input_file)
        print("Local  - Rodada: " + str(item+1), input_file.closed)


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


# Pasta para salvar os arquivos de treino, validação e teste
salva_arq = "insira/o/caminho"

#   Cria a pasta para armazenar os arquivos salvos caso não exista.
if not os.path.exists(salva_arq):
    os.makedirs(salva_arq)

# Salva os arquivos
salva_ML_arq = salva_arq + "/g_treino.pickle"
with open(salva_ML_arq, "wb") as arq_ML:
    cPickle.dump(g_treino, arq_ML)
print("Arquivo g_treino.pickle salvo com sucesso.")

salva_ML_arq = salva_arq + "/l_treino.pickle"
with open(salva_ML_arq, "wb") as arq_ML:
    cPickle.dump(l_treino, arq_ML)
print("Arquivo l_treino.pickle salvo com sucesso.")

salva_ML_arq = salva_arq + "/g_val.pickle"
with open(salva_ML_arq, "wb") as arq_ML:
    cPickle.dump(g_val, arq_ML)
print("Arquivo g_val.pickle salvo com sucesso.")

salva_ML_arq = salva_arq + "/l_val.pickle"
with open(salva_ML_arq, "wb") as arq_ML:
    cPickle.dump(l_val, arq_ML)
print("Arquivo l_val.pickle salvo com sucesso.")

salva_ML_arq = salva_arq + "/g_teste.pickle"
with open(salva_ML_arq, "wb") as arq_ML:
    cPickle.dump(g_teste, arq_ML)
print("Arquivo g_teste.pickle salvo com sucesso.")

salva_ML_arq = salva_arq + "/l_teste.pickle"
with open(salva_ML_arq, "wb") as arq_ML:
    cPickle.dump(l_teste, arq_ML)
print("Arquivo l_teste.pickle salvo com sucesso.")

print("Fim do processamento.")