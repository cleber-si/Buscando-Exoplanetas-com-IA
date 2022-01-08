import numpy as np


def gera_l_view(tempo, fluxo, duracao):
    # Número de durações para cada lado do evento
    k = 4

    # Metade do intervalo, em dias, considerado para a visualização local
    h = k*(duracao/24)

    # Chave de controle para a verificação do índice mínimo de tempo
    chave = True

    # Acha os índices do tempo inicial e final considerados na visão local
    t_min = 0
    t_max = len(tempo)

    for i in range(len(tempo)):
        if tempo[i] >= -h and chave:
            t_min = i
            chave = False

        if tempo[i] >= h:
            t_max = i
            break
    
    # Corta a curva de luz
    t = tempo[t_min: t_max]
    f = fluxo[t_min: t_max]

    # Define o número de bins para a visão local
    n_bins = 201

    # Ditância entre cada janela
    lambda_ = int(len(f)/n_bins)
    if lambda_ == 0:
        lambda_ = 1
    # Largura do intervalo de tempo para 'binar'
    delta = lambda_ * 2

    # Tira a mediana dos valores do fluxo dentro da janela estabelecida
    m = [] # Designei 'm' para [fluxo] mediano
    for i in range(0, len(t), lambda_):
        m.append(np.median(f[i:i+delta]))

    # Faz o controle para que o array do fluxo tenha tamanho igual ao n_bins
    mm = int((len(m) - n_bins)/2) # Metade do valor que sobra entre len(m) e n_bins
    if mm < 0:              # Só copia os valores das extremidades caso o array seja menor que n_bin
        l_view = m
        while len(l_view) < n_bins:
            tam = len(l_view)
            l_view.insert(tam, l_view[tam-1])
            l_view.insert(0, l_view[0])
    elif mm == 0:
        l_view = m
    else:
        l_view = m[mm:len(m)-mm]

    # Garante que o array do fluxo tenha tamanho igual ao n_bins
    if len(l_view) < n_bins:
        i = 1
        while len(l_view) < n_bins:
            l_view = m[mm-i:len(m)-mm+i]
    if len(l_view) > n_bins:
        l_view = l_view[:n_bins]

    # Normaliza os valores do fluxo entre 0 e 1
    l_view = (l_view - np.min(l_view)) / (np.max(l_view) - np.min(l_view))

    return l_view


def gera_g_view(fluxo):
    # Define o número de bins
    n_bins = 2001

    # Ditância entre cada janela
    lambda_ = int(len(fluxo)/n_bins)
    # Largura do intervalo de tempo para 'binar'
    delta = lambda_ * 2

    # Tira a mediana dos valores do fluxo dentro da janela estabelecida
    m = [] # Designei 'm' para [fluxo] mediano
    for i in range(0, len(fluxo), lambda_):
        m.append(np.median(fluxo[i:i+delta]))

    # Faz o controle para que o array do fluxo tenha tamanho igual ao n_bins
    mm = int((len(m) - n_bins)/2) # Metade do valor que sobra entre len(m) e n_bins
    if mm < 0:              # Só copia os valores das extremidades caso o array seja menor que n_bin
        g_view = m
        while len(g_view) < n_bins:
            tam = len(g_view)
            g_view.insert(tam, g_view[tam-1])
            g_view.insert(0, g_view[0])
    elif mm == 0:
        g_view = m
    else:
        g_view = m[mm:len(m)-mm]

    # Garante que o array do fluxo tenha tamanho igual ao n_bins
    if len(g_view) < n_bins:
        i = 1
        while len(g_view) < n_bins:
            g_view = m[mm-i:len(m)-mm+i]
    if len(g_view) > n_bins:
        g_view = g_view[:n_bins]

    # Normaliza os valores do fluxo entre 0 e 1
    g_view = (g_view - np.min(g_view)) / (np.max(g_view) - np.min(g_view))

    return g_view