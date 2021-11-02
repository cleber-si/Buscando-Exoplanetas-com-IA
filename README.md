# Buscando Exoplanetas com Inteligência Artificial

Algoritmos para o tratamento de curvas de luz e treinamento de modelos de Machine Learning para a detecção automatizada de exoplanetas.

---

# Autoria

* Cleber Silva: [@cleber-si](https://github.com/cleber-si)

**NOTA: **Este projeto usa ou se baseia em algoritmos originalmente escritos por Chris Shallue ([@cshallue](http://github.com/cshallue)), no trabalho

Shallue, C. J., & Vanderburg, A. (2018). Identifying Exoplanets with Deep Learning: A Five-planet Resonant Chain around Kepler-80 and an Eighth Planet around Kepler-90. *The Astronomical Journal*, 155(2), 94.

Texto completo disponível em [*The Astronomical Journal*](http://iopscience.iop.org/article/10.3847/1538-3881/aa9e09/meta).

---

# Passo a Passo

---

## Obtendo os Dados do Kepler

### Dados Pré-Processados

Você pode encontrar os dados pré-processados por mim, pronto para o treino, na pasta `data/dados_ML`. Com esses dados, você pode ir direto para o [Treino do Modelo](##treino-do-modelo). Se preferir, pode ler as próximas seções para entender o processo de download e tratamento dos dados.

### Download dos Dados

Para ter acesso aos arquivos de interesse para este trabalho, o primeiro passo é baixar a lista de TCEs com seus respectivos "labels" que vão compor o nosso dataset. O download da tabela DR24 TCE no formato `.csv` pode ser feito pelo [NASA Exoplanet Archive](https://exoplanetarchive.ipac.caltech.edu/cgi-bin/TblView/nph-tblView?app=ExoTbls&config=q1_q17_dr24_tce).

As colunas que vamos precisar são:

* `rowid`: ID inteiro da linha na tabela TCE.
* `kepid`: ID Kepler da estrela-alvo.
* `tce_plnt_num`: Número de TCEs dentro da estrela alvo.
* `tce_period`: Período do evento detectado, em dias.
* `tce_time0bk`: O tempo correspondente ao centro do primeiro evento detectado em _Barycentric Julian Day_ (BJD) menos um deslocamento constante de 2.454.833,0 dias.
* `tce_duration`: Duração do evento detectado, em horas.
* `av_training_set`: Label do conjunto de treinamento dado pelo Autovetter; um de PC (candidato a planeta), AFP (falso positivo astrofísico), NTP (fenômeno de não-transitório), UNK (desconhecido).

Essa é uma tabela com as especificações que precisamos das curvas de luz, mas não são as curvas de luz, de fato. Podemos fazer o download das mesmas no [Mikulski Archive for Space Telescopes](http://archive.stsci.edu;pub/kepler/lightcurves). Lá temos acesso a **todos** os dados do Kepler, o que corresponde a mais de 3 milhões de arquivos. Queremos aqui apenas as curvas de luz associadas com as que temos informações na tabela DR24. Para baixar apenas essas curvas, siga esses passos:

**NOTA: ** Embora estejamos apenas baixando um subconjunto de todo o conjunto de dados do Kepler, os arquivos baixados pelo script a seguir ocupam cerca de **90 GB**.

```bash
# Nome do arquivo que contém o arquivo CSV dos TCEs no dataset.
ARQUVO_CSV="${HOME}/dr24_tce.csv"

# Diretório para armazenar as curvas de luz do Kepler baixadas.
KEPLER_PASTA="${HOME}/kepler/"

# Gera um script bash que baixa as curvas de luz do Kepler no dataset.
python data/generate_download_script.py \
  --kepler_csv_file=${ARQUVO_CSV} \
  --download_dir=${KEPLER_PASTA}

# Executa o script de download para baixar as curvas de luz do Kepler.
./get_kepler.sh
```

A linha final deve ser algo como: `Finished downloading 12669 Kepler targets to ${ARQUVO_CSV}`. (Esse número pode variar em algumas poucas unidades).

---

## O Pipeline e Preparação dos Dados

Apesar de usar os mesmos algoritmos do **Shallue**, a minha abordagem tem algumas diferenças, especialmente na questão do salvamento dos arquivos e seus respectivos formatos. Essa abordagem é menos otimizada, mas é mais acessível para estudantes que não são familiarizados com o mar de informações e métodos do [TensorFlow](https://www.tensorflow.org/), usado no código do **Shallue**.

Inicialmente declaramos o local da pasta onde estão os dados do Kepler e o local do arquivo `.csv` da nossa tabela de TCEs. Como existem muitos arquivos na pasta dos dados do Kepler, faremos os tratamentos por partes. Para isso, criei 15 pastas diferentes, nomeadas com o padrão `kepler_n`, onde `n` é um número inteiro que vai de 1 até 15. Cada pasta dessa possue oito das subpastas encontradas na pasta `kepler` original, com seus respectivos conteúdos (ver explicação abaixo sobre a estrutura das pastas e arquivos). O processo será o mesmo para todas as partes, mas salvaremos os produtos desses tratamentos em pastas separadas para mantermos uma boa organização. Por conta disso, deveremos atribuir manualmente o número `n` da pasta (e do processo) que estamos trabalhando à variável `pasta`, logo no começo do código. Também é possível fazer todo o processamento de uma única vez utilizando simplesmente a parta original `kepler`, mas por questões de logística farei esse tratamento por partes.

Uma vez estabelecido isso, o código fará todo o processamento automaticamente. Abaixo darei uma breve descrição do que ele faz.

### Leitura de Arquivos

#### Códigos do Arquivo `pipeline.py`

O código verifica se o local da pasta onde serão salvos os produtos do processamento existe e, caso não existam, cria a pasta. Toda a árvore de arquivos na pasta principal onde foram baixados os dados de interesse do Kepler seguem a estrutura padrão do [Mikulski Archive for Space Telescopes](http://archive.stsci.edu;pub/kepler/lightcurves). A pasta `kepler` possui pastas (120 neste caso) nomeadas com quatro dígitos. Esses são os quatro primeiros dígitos do `kepler_id` de uma dada estrela. Cada pasta dessa possui subpastas nomeadas com os `kepler_id` completo de uma estrela, em que cada os quarto primeiro dígitos são todos comuns. Por exemplo, na pasta `kepler/0008` estão contidas as pastas `000892667` e `000892772`. Nessas subpastas estão todos os arquivos `.fits` referentes àquela estrela. A nomenclatura desses arquivos também seguem um padrão, dado por

`keplr{kep_id}-{prefixo_do_quarter}_{tipo}.fits` ,

onde:

* `kep_id` é o id do Kepler preenchido à esquerda com zeros até o comprimento 9;
* `prefixo_do_quarter` faz referência ao quarter do que aquele arquivo engloba;
* `tipo` pode ser `llc` (curva de luz de longa cadência [_long cadence light curve_]) ou `slc` (curva de luz de curta cadência [_short cadence light curve_]).

O código faz a leitura de todos esses arquivos e armazena as localizações das pastas e dos arquivos, além de armazenar também uma lista com todos os `kepler_id` presentes no array `IDs`.

Em seguida, abrimos o arquivo `dr24_tce.csv` como um dataframe do Pandas, na variável `tabela_tce`, e fazemos uma filtragem dos dados. Ao baixar esse arquivo, tive que fazer algumas manipulações manuais, como remover algumas colunas desnecessárias para os propósitos deste trabalho e adicionar uma coluna nomeada por `rowid` (que não consegui baixar por pelo [NASA Exoplanet Archive](https://exoplanetarchive.ipac.caltech.edu/cgi-bin/TblView/nph-tblView?app=ExoTbls&config=q1_q17_dr24_tce)), para que cada linha tivesse sua devida identificação. Fiz isso com um gerenciador de planilhas. Nesse processo, ao carregar o dataframe, o Pandas detectou três colunas não nomeadas e vazias, que foram excluídas nesse processo de filtragem. Além disso, todas as linhas que tivessem um `kepid` que não constasse na lista `IDs` foram removidas. Todas as linhas que tivessem `labels` diferentes de `PC`, `AFP` ou `NTP` foram removidas.

Finalmente, todos os tempos e todos os fluxos de todos os arquivos da pasta `kepler_n`.

### Execução Principal

É aqui onde a mágica acontece e, portanto, é o processo mais demorado.

Nosso objetivo é gerar duas representações da curva de luz: uma local e uma global. Criamos então dois arrays, um para cada representação. Além disso, algumas curvas de luz não serão compatíveis com os processos do pipeline por uma série de fatores. Felizmente, não são muitas curvas que darão problemas e podemos descartar essas curvas sem muito prejuízo nos treinos dos modelos. Tomei então o cuidado de armazenar os logs dos erros em um arquivo de texto para consultas futuras, a fim de aprimorar o pipeline.

O código então faz uma iteração nas linhas da `tabela_tce` e inicia os processamentos tais quais como descritos no artigo do **Shallue**. Não acho que seja uma boa prática fazer iterações em dataframes do Pandas, especialmente por conta da performance pobre que isso acarreta, mas é uma opção mais imediata para esta primeira versão do trabalho e melhorarei isso no futuro.

Inicialmente o algoritmo faz a remoção as variabilidades de baixa frequência e achata a curva de luz com a função `processar_curva_luz`, depois faz-se um "fold" nos dados do fluxo e garante que os mesmos esteja organizados em ordem cronológica (pois estamos tratando de séries temporais) com a função `phase_fold_and_sort_light_curve`. Em seguida são geradas os dados de fluxo para as curvas globais e locais já tratadas. Armazenei então o `kepid` e o `label` de cada curva nas primeira e segunda posições do array atual, respectivamente. Os detalhes teóricos desses processos estão no artigo base deste trabalho e também serão discutidos no meu TCC. Cada curva global e local foi adicionada em um dos arrays maiores, `g_views` ou `l_views`. Esses arrays foram salvos em um arquivo binário de formato `.pickle`. 

#### Códigos do Arquivo `arq_ML.py`

No caso do método de tratamento por partes, é necessário ainda um passo adicional para a junção dos dados. Cada um dos `n` processos gerou dois arquivos `g_views_n` e `l_views_n`, então é preciso mesclar esses arquivos em um arquivo só para cada caso: `g_views` ou `l_views`. 

Com os arquivos `g_views.pickle` e `l_views.pickle`, o último passo é gerar os arquivos de treino (globais e locais), de validação (globais e locais) e de teste (globais e locais). Este último passo é um interlúdio entre o tratamento do dos dados e a ciência de dados que estamos prestes a fazer. Da ciência de dados, sabemos que é [importante embaralhar os dados](https://datascience.stackexchange.com/questions/24511/why-should-the-data-be-shuffled-for-machine-learning-tasks) para treinarmos os modelos, e já fazemos isso aqui. Como os dados globais e locais são referentes a um dado `kepid`, não podemos embaralhar `g_views` e `l_views` separadamente. É necessário que esses arrays sejam embaralhados de tal forma que ambas as curvas globais e locais da posição x antes do embaralhamento ocupem a posição y após o embaralhamento. Isso nos poupará trabalho ao implementarmos modelos onde o uso de ambas as visões globais e locais é necessário. Para isso, "zipei" os dois arrays com o comando `zip`, embaralhei essa estrutura e "devolvi" os arrays global e local para as suas respectivas variáveis.

Com os dados devidamente embaralhados, podemos então fazer a divisão dos mesmos da seguinte forma:

* 80% dos TCEs serão destinados para o treino dos modelos;
* 10% dos TCEs serão destinados para a validação dos modelos;
* 10% dos TCEs serão destinados para o teste dos modelos.

O código salva então, na pasta designada para tal, o conteúdo dos arrays `g_treino`, ` l_treino`, `g_val`, `l_val`, `g_teste` e `l_teste` em arquivos binários `.pickle` com seus mesmos nomes.

---

## Treino do Modelo

Em desenvolvimento.

---

# Setup

## Pacotes Necessários

* **NumPy** ([instruções](https://docs.scipy.org/doc/numpy/user/install.html))
* **Pandas** ([instruções](http://pandas.pydata.org/pandas-docs/stable/install.html))
* Mais em breve.

---

# Citação

Em desenvolvimento.

---

