import numpy as np
import gerenciar_arqs as GA
from joblib import dump


# Carrega os dados para treino
g_treino, l_treino = GA.carrega_treino()
X_g_treino, X_l_treino, y_treino = GA.ajusta_dados(g_treino, l_treino)

X_g_treino_np = np.array(X_g_treino)
X_l_treino_np = np.array(X_l_treino)
y_treino = np.array(y_treino)

# Carrega os dados aumentados para treino
g_treino_a, l_treino_a = GA.carrega_treino_aumentado()
X_g_treino_a, X_l_treino_a, y_treino_a = GA.ajusta_dados(g_treino_a, l_treino_a)

X_g_treino_a_np = np.array(X_g_treino_a)
X_l_treino_a_np = np.array(X_l_treino_a)
y_treino_a = np.array(y_treino_a)

# Concatena X_g com X_l
X_treino = [np.concatenate([X_g_treino_np[i],X_l_treino_np[i]]) for i in range(len(X_g_treino_np))]
X_treino_a = [np.concatenate([X_g_treino_a_np[i],X_l_treino_a_np[i]]) for i in range(len(X_g_treino_a_np))]


from sklearn.linear_model import SGDClassifier

# Treina o modelo com os dados padrão
sgd_clf = SGDClassifier(loss='log', random_state = 23)

sgd_clf.fit(X_treino, y_treino)
#y_pred = sgd_clf.pred(X_teste)    # ---> Necessário carregar os dados de teste

# Treina o modelo com os dados aumentados
sgd_clf_A = SGDClassifier(loss='log', random_state = 23)

sgd_clf_A.fit(X_treino_a, y_treino_a)


# Local para salvar os modelos
salva_arq = "/home/caminho/da/pasta/modelos"

#   Cria a pasta para armazenar os arquivos salvos caso não exista.
if not os.path.exists(salva_arq):
    os.makedirs(salva_arq)

# Salva o primeiro modelo
salva_ML_arq = salva_arq + "/sgd_clf.joblib"
dump(sgd_clf, salva_ML_arq)

# Salva o segundo modelo
salva_ML_arq = salva_arq + "/sgd_clf_A.joblib"
dump(sgd_clf_A, salva_ML_arq)
