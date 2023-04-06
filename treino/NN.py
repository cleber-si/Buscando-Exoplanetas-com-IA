import keras                            # Importa o Keras original
import keras_tuner as kt
import tensorflow as tf
from tensorflow import keras as krs     # Importa o Keras do TensorFlow
import numpy as np
import gerenciar_arqs as GA


# Carrega dados de treino aumentados
g_treino_a, l_treino_a = GA.carrega_treino_aumentado()
X_g_treino_a, X_l_treino_a, y_treino_a = GA.ajusta_dados(g_treino_a, l_treino_a)

X_g_treino_a_np = np.array(X_g_treino_a)
X_l_treino_a_np = np.array(X_l_treino_a)
y_treino_a = np.array(y_treino_a)


# Carrega dados de validação e teste
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


# Função para gerar a rede neural bifurcada e tunelar alguns de seus parâmetros
def modelo_builder(hp):
    # Camadas de entrada
    input_g = keras.layers.Input(shape=X_g_treino_a_np[0].shape, name = 'visao_global')
    input_l = keras.layers.Input(shape=X_l_treino_a_np[0].shape, name = 'visao_local')

    # Camadas para tratar a visão global separadamente
    #   Define o número de unidades para testar em cada camada
    hp_units_g1 = hp.Int('units_g1', min_value=20, max_value=420, step=20)
    hp_units_g2 = hp.Int('units_g2', min_value=20, max_value=420, step=20)
    hp_units_g3 = hp.Int('units_g3', min_value=20, max_value=420, step=20)
    hp_units_g4 = hp.Int('units_g4', min_value=20, max_value=420, step=20)
    #   Cria as camadas para os dados globais
    hidden_g_1 = keras.layers.Dense(units = hp_units_g1, activation="relu")(input_g)
    hidden_g_2 = keras.layers.Dense(units = hp_units_g2, activation="relu")(hidden_g_1)
    hidden_g_3 = keras.layers.Dense(units = hp_units_g3, activation="relu")(hidden_g_2)
    hidden_g_4 = keras.layers.Dense(units = hp_units_g4, activation="relu")(hidden_g_3)

    # Camadas para tratar a visão local separadamente
    #   Define o número de unidades para testar em cada camada
    hp_units_l1 = hp.Int('units_l1', min_value=10, max_value=230, step=20)
    hp_units_l2 = hp.Int('units_l2', min_value=10, max_value=230, step=20)
    hp_units_l3 = hp.Int('units_l3', min_value=10, max_value=230, step=20)
    #   Cria as camadas para os dados locais
    hidden_l_1 = keras.layers.Dense(units = hp_units_l1, activation="relu")(input_l)
    hidden_l_2 = keras.layers.Dense(units = hp_units_l2, activation="relu")(hidden_l_1)
    hidden_l_3 = keras.layers.Dense(units = hp_units_l3, activation="relu")(hidden_l_2)

    # Camada onde as visões convergem
    contat = keras.layers.concatenate([hidden_g_4, hidden_l_3])

    # Camada pra dar 'aquela checada'
    checada1 = keras.layers.Dense(5, activation="relu")(contat)
    checada2 = keras.layers.Dense(5, activation="relu")(checada1)

    # Camada de saída
    output = keras.layers.Dense(2, activation="softmax", name='saida')(checada2)


    # Tunela a taxa de aprendizagem
    hp_learning_rate = hp.Choice('learning_rate', values=[0.03, 1e-2, 1e-3])

    modelo = keras.Model(inputs=[input_g, input_l], outputs=[output])

    modelo.compile(optimizer = krs.optimizers.SGD(learning_rate=hp_learning_rate),
                    loss = keras.losses.SparseCategoricalCrossentropy(from_logits=True),
                    metrics=["accuracy"])

    return modelo


# Cria o modelo de tunelamento e salva seus arquivos na pasta 'my_dir6/teste_do_kt'
tuner = kt.Hyperband(modelo_builder,
                    objective = 'val_accuracy',
                    max_epochs = 25,
                    factor = 3,
                    directory = 'my_dir6',
                    project_name = 'teste_do_kt')

# Interrompe o treino com base no custo relativo à validação
stop_early = tf.keras.callbacks.EarlyStopping(monitor='val_loss', patience=5)


# Testa todas as combinações de hiperparâmetros dos valores indicados para análise
tuner.search((X_g_treino_a_np, X_l_treino_a_np), y_treino_a, epochs = 40,
            validation_data = ((X_g_val_np, X_l_val_np), y_val),
            callbacks = [stop_early])

# Obtém os hiperparâmetros otimizados
best_hps = tuner.get_best_hyperparameters(num_trials=1)[0]

print(f"""
A busca por hiperparâmetros está concluída. Resultados: \n
h_g_1: {best_hps.get('units_g1')} \n
h_g_2: {best_hps.get('units_g2')} \n
h_g_3: {best_hps.get('units_g3')} \n
h_g_4: {best_hps.get('units_g4')} \n \n
h_l_1: {best_hps.get('units_l1')} \n
h_l_2: {best_hps.get('units_l2')} \n
h_l_3: {best_hps.get('units_l3')} \n \n
Taxa de aprendizagem: {best_hps.get('learning_rate')}.
""")

