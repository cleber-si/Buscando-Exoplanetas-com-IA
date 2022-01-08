import msgpack
import msgpack_numpy as mpn

def carrega_treino():
    raiz = "/home/caminho/da/pasta/dados/Arqs_ML"

    print('Iniciando leitura dos arquivos de treino.')

    arq_g_treino = raiz + "/g_treino.msgpack"
    arq_l_treino = raiz + "/l_treino.msgpack"

    # Lê os arquivos de treino
    with open(arq_g_treino, "rb") as arquivo:
        byte_data = arquivo.read()
        g_treino = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos de treino globais lidos.')

    with open(arq_l_treino, "rb") as arquivo:
        byte_data = arquivo.read()
        l_treino = msgpack.unpackb(byte_data, object_hook=mpn.decode)
    
    print('Arquivos de treino locais lidos.')
        
    return g_treino, l_treino

def carrega_treino_aumentado():
    raiz = "/home/caminho/da/pasta/dados/Treino_Aumentado"

    print('Iniciando leitura dos arquivos de treino aumentado.')

    arq_g_treino = raiz + "/g_treino.msgpack"
    arq_l_treino = raiz + "/l_treino.msgpack"

    # Lê os arquivos de treino
    with open(arq_g_treino, "rb") as arquivo:
        byte_data = arquivo.read()
        g_treino = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos de treino aumentado globais lidos.')

    with open(arq_l_treino, "rb") as arquivo:
        byte_data = arquivo.read()
        l_treino = msgpack.unpackb(byte_data, object_hook=mpn.decode)
    
    print('Arquivos de treino aumentado locais lidos.')
        
    return g_treino, l_treino


def carrega_val():
    raiz = "/home/caminho/da/pasta/dados/Arqs_ML"

    print('Iniciando leitura dos arquivos de validação.')

    arq_g_val = "/g_val.msgpack"
    arq_l_val = "/l_val.msgpack"
    
    # Lê os arquivos de validação
    with open(raiz + arq_g_val, "rb") as arquivo:
        byte_data = arquivo.read()
        g_val = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos de validação globais lidos.')

    with open(raiz + arq_l_val, "rb") as arquivo:
        byte_data = arquivo.read()
        l_val = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos de validação locais lidos.')
        
    return g_val, l_val


def carrega_teste():
    raiz = "/home/caminho/da/pasta/dados/Arqs_ML"

    print('Iniciando leitura dos arquivos de teste.')

    arq_g_teste = "/g_teste.msgpack"
    arq_l_teste = "/l_teste.msgpack"
    
    # Lê os arquivos de teste
    with open(raiz + arq_g_teste, "rb") as arquivo:
        byte_data = arquivo.read()
        g_teste = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos de teste globais lidos.')

    with open(raiz + arq_l_teste, "rb") as arquivo:
        byte_data = arquivo.read()
        l_teste = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos de teste locais lidos.')
        
    return g_teste, l_teste


def carrega_add():
    raiz = "/home/caminho/da/pasta/dados/Add"

    print('Iniciando leitura dos arquivos adicionais de teste.')

    arq_g_add = "/g_add.msgpack"
    arq_l_add = "/l_add.msgpack"
    
    # Lê os arquivos adicionais
    with open(raiz + arq_g_add, "rb") as arquivo:
        byte_data = arquivo.read()
    g_add = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos adicionais de teste globais lidos.')

    with open(raiz + arq_l_add, "rb") as arquivo:
        byte_data = arquivo.read()
    l_add = msgpack.unpackb(byte_data, object_hook=mpn.decode)

    print('Arquivos adicionais de teste locais lidos.')
        
    return g_add, l_add


def ajusta_dados(g, l):
    X_g = []
    for i in range(len(g)):
        X_g.append(g[i][3:])

    X_l = []
    for i in range(len(g)):
        X_l.append(l[i][3:])

    y = []
    for i in range(len(g)):
        y.append(g[i][2])

    y_b = []
    for i in y:
        # Retorna binário
        y_b.append(True if i == 'PC' else False)

        # Retorna multiplas classes
        #if i == 'PC':
        #    y_b.append(2)
        #elif i == 'AFP':
        #    y_b.append(1)
        #else:
        #    y_b.append(0)
        

    return X_g, X_l, y_b