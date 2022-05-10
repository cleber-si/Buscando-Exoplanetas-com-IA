import gerenciar_arqs as GA

import keras 
import numpy as np

from keras.layers import Input, Dense, Conv1D, MaxPooling1D, Concatenate, Flatten
from keras.models import Model


# Carrega dados gerais
g_treino_a, l_treino_a = GA.carrega_treino_aumentado()
g_val, l_val = GA.carrega_val()
g_teste, l_teste = GA.carrega_teste()


# 	Seleciona apenas os dados de fluxo e tempo
X_g_treino_a, X_l_treino_a, y_treino_a = GA.ajusta_dados(g_treino_a, l_treino_a)
X_g_val, X_l_val, y_val = GA.ajusta_dados(g_val, l_val)
X_g_teste, X_l_teste, y_teste = GA.ajusta_dados(g_teste, l_teste)


# 	Os converte para arrays numpy
X_g_treino_a_np = np.array(X_g_treino_a)
X_l_treino_a_np = np.array(X_l_treino_a)
y_treino_a = np.array(y_treino_a)

X_g_val_np = np.array(X_g_val)
X_l_val_np = np.array(X_l_val)
y_val = np.array(y_val)

X_g_teste_np = np.array(X_g_teste)
X_l_teste_np = np.array(X_l_teste)
y_teste = np.array(y_teste)


# Cria a Rede Neural Convolucional com a arquitetura descrita no artigo de Shallue & Vanderburg (2018)

# Lado da visão global
input_global = Input(shape=(2001,1))
x = Conv1D(16, 5, strides=1, activation='relu')(input_global)
x = Conv1D(16, 5, strides=1, activation='relu')(x)
x = MaxPooling1D(pool_size=5, strides=2)(x)
x = Conv1D(32, 5, strides=1, activation='relu')(x)
x = Conv1D(32, 5, strides=1, activation='relu')(x)
x = MaxPooling1D(pool_size=5, strides=2)(x)
x = Conv1D(64, 5, strides=1, activation='relu')(x)
x = Conv1D(64, 5, strides=1, activation='relu')(x)
x = MaxPooling1D(pool_size=5, strides=2)(x)
x = Conv1D(128, 5, strides=1, activation='relu')(x)
x = Conv1D(128, 5, strides=1, activation='relu')(x)
x = MaxPooling1D(pool_size=5, strides=2)(x)
x = Conv1D(256, 5, strides=1, activation='relu')(x)
x = Conv1D(256, 5, strides=1, activation='relu')(x)
x = MaxPooling1D(pool_size=5, strides=2)(x)

# Lado da visão local
input_local = Input(shape=(201,1))
y = Conv1D(16, 5, strides=1, activation='relu')(input_local)
y = Conv1D(16, 5, strides=1, activation='relu')(y)
y = MaxPooling1D(pool_size=7, strides=2)(y)
y = Conv1D(32, 5, strides=1, activation='relu')(y)
y = Conv1D(32, 5, strides=1, activation='relu')(y)
y = MaxPooling1D(pool_size=7, strides=2)(y)

# Mescla as camadas para uma arquitetura de Rede Neural Padrão
# 	É preciso deixá-la plana antes
xf = Flatten()(x)
yf = Flatten()(y)
# 	Concatena e cria as camadas
z = Concatenate()([xf,yf])
z = Dense(512, activation='relu')(z)
z = Dense(512, activation='relu')(z)
z = Dense(512, activation='relu')(z)
z = Dense(512, activation='relu')(z)

# Camada de output que retorna as probabilidades calculadas pela rede de cada classe
output = keras.layers.Dense(2, activation="softmax", name='saida')(z)


# Cria o modelo com base na arquitetura acima
modelo = Model(inputs=[input_global, input_local], outputs=output)

# Treina o modelo
history = modelo.fit((X_g_treino_a_np, X_l_treino_a_np), y_treino_a, epochs=15,
                    validation_data=((X_g_val_np, X_l_val_np), y_val))


# Salva o modelo em um local específico
modelo.save('selecione/o/local')