# Principal
import numpy as np
import gerenciar_arqs as GA
import os
from joblib import load, dump

# Modelo
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import GridSearchCV

# Métricas
from sklearn.metrics import precision_recall_curve
from sklearn.metrics import roc_curve
from sklearn.metrics import auc


# Carrega Arquivos
g_val, l_val = GA.carrega_val()
g_teste, l_teste = GA.carrega_teste()

X_g_val, X_l_val, y_val = GA.ajusta_dados(g_val, l_val)
X_g_teste, X_l_teste, y_teste = GA.ajusta_dados(g_teste, l_teste)

X_g_val_np = np.array(X_g_val)
X_g_teste_np = np.array(X_g_teste)

X_l_val_np = np.array(X_l_val)
X_l_teste_np = np.array(X_l_teste)

y_val = np.array(y_val)
y_teste = np.array(y_teste)


# Carrega dados de treino aumentados
g_treino_a, l_treino_a = GA.carrega_treino_aumentado()
X_g_treino_a, X_l_treino_a, y_treino_a = GA.ajusta_dados(g_treino_a, l_treino_a)

X_g_treino_a_np = np.array(X_g_treino_a)
X_l_treino_a_np = np.array(X_l_treino_a)
y_treino_a = np.array(y_treino_a)


# Prepara arrays
X_treino_a = [np.concatenate([X_g_treino_a_np[i],X_l_treino_a_np[i]]) for i in range(len(X_g_treino_a_np))]
X_val = [np.concatenate([X_g_val_np[i],X_l_val_np[i]]) for i in range(len(X_g_val_np))]
X_teste = [np.concatenate([X_g_teste_np[i],X_l_teste_np[i]]) for i in range(len(X_g_teste_np))]


# Parâmetros para testar
param_grid = [
    {
        'bootstrap': [True, False],
        'n_estimators': [30, 100, 300],
        'max_features': [10, np.sqrt(len(X_treino_a)), 100, 200]
    }
]


# Inicia o classificador
forest_clf_A = RandomForestClassifier()

# Prepara a busca
grid_search = GridSearchCV(forest_clf_A, param_grid, cv=5,
                           scoring='roc_auc',
                           return_train_score=True)

# Treina o classificador com diferentes configurações de hiperparâmetros
grid_search.fit(X_treino_a, y_treino_a)

# Imprime a melhor configuração de hiperparâmetros testados
'''
No meu teste, obtive {'bootstrap': False, 'max_features': 200, 'n_estimators': 300}.
'''
print(grid_search.best_params_)


# Treina o modelo com os melhores hiperparâmetros
forest_clf_ajustado = RandomForestClassifier(n_estimators = 300,
                                             random_state = 23,
                                             bootstrap = False,
                                             max_features = 200)

# Local para salvar os modelos
salva_arq = "/home/caminho/da/pasta/modelos"

#   Cria a pasta para armazenar os arquivos salvos caso não exista.
if not os.path.exists(salva_arq):
    os.makedirs(salva_arq)

# Salva o modelo
salva_ML_arq = salva_arq + "/forest_clf_AM.joblib"
dump(forest_clf_ajustado, salva_ML_arq)
