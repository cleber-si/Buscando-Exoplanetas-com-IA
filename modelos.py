import numpy as np
import notebook_ML_aux as aux
import pickle  # Para salvar os arquivos

# Para plotar figuras mais bonitas
import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.rc('axes', labelsize=14)
mpl.rc('xtick', labelsize=12)
mpl.rc('ytick', labelsize=12)
plt.rcParams["figure.figsize"] = (16,8)
plt.rcParams.update({'font.size': 10})

# ---------------------------------------------------------------

salva_arq = "/insira/o/caminho" 

def carrega_treino():
    salva_arq = "/insira/o/caminho" 

    arq_X_treino = "/X_treino.pickle"
    arq_y_treino_b = "/y_treino_b.pickle"
    
    with open(salva_arq + arq_X_treino, "rb+") as arquivo:
        X_treino = [pickle.load(arquivo)]

    with open(salva_arq + arq_y_treino_b, "rb+") as arquivo:
        y_treino_b = pickle.load(arquivo)
        
    return X_treino, y_treino_b

X_treino, y_treino_b = carrega_treino()

# ----------------------------------------------------------------
""" 
def plot_precision_vs_recall(precisions, recalls):
    plt.plot(recalls, precisions, "b-", linewidth=2)
    plt.xlabel("Recall", fontsize=16)
    plt.ylabel("Precisão", fontsize=16)
    plt.axis([0, 1, 0, 1])
    plt.grid(True)

def plot_roc_curve(fpr, tpr, label=None):
    plt.plot(fpr, tpr, linewidth=2, label=label)
    plt.plot([0, 1], [0, 1], 'k--') # dashed diagonal
    plt.axis([0, 1, 0, 1])                                    # Not shown in the book
    plt.xlabel('Taxa de Falsos Positivos (Fall-Out)', fontsize=16) # Not shown
    plt.ylabel('Taxa de Positivos Verdadeiros (Recall)', fontsize=16)    # Not shown
    plt.grid(True)
 """
# ----------------------------------------------------------------

from sklearn.model_selection import cross_val_predict
from sklearn.metrics import precision_recall_curve
from sklearn.metrics import roc_curve


# SGD
from sklearn.linear_model import SGDClassifier
sgd_clf = SGDClassifier(random_state = 23)
y_scores_SGD = cross_val_predict(sgd_clf, X_treino, y_treino_b, cv=3,
                             method="decision_function")
precisions_SGD, recalls_SGD, _ = precision_recall_curve(y_treino_b, y_scores_SGD)
fpr_SGD, tpr_SGD, _ = roc_curve(y_treino_b, y_scores_SGD)


# [y_scores, precisions, recalls, fpr, tpr]
results_SGD = [y_scores_SGD, precisions_SGD, recalls_SGD, fpr_SGD, tpr_SGD]

# Strings com os locais onde devem ser salvos os arquivos
arq_results_SGD = "/results_SGD.pickle"

# Salva as curvas de luz globais
with open(salva_arq + arq_results_SGD, "wb") as saida:
    pickle.dump(results_SGD, saida)
    print('results_SGD armazenado com sucesso.')

""" 
# Random Forest
from sklearn.ensemble import RandomForestClassifier
forest_clf = RandomForestClassifier(n_estimators=100, random_state=23)
y_probas_forest = cross_val_predict(forest_clf, X_treino, y_treino_b, cv=3,
                                    method="predict_proba")
y_scores_forest = y_probas_forest[:, 1] # score = proba of positive class
fpr_forest, tpr_forest, thresholds_forest = roc_curve(y_treino_b, y_scores_forest)


plot_precision_vs_recall(precisions_SGD, recalls_SGD)
plt.show()

# ----------------------------------------

# Random Forest

plt.plot(fpr_SGD, tpr_SGD, "b:", linewidth=2, label="SGD")
plot_roc_curve(fpr_forest, tpr_forest, "Random Forest")
plt.grid(True)
plt.legend(loc="lower right", fontsize=16)
plt.show()

 """