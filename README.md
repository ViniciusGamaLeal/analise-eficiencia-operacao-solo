Eficiência Operacional de Solo: análise de atrasos

Projeto de portfólio em análise de dados. Investiga onde, quando e por que ocorrem atrasos na operação de solo de um aeroporto, usando MySQL para consultar os dados e Power BI para visualizá-los.

Dados 100% fictícios. O conjunto de dados é sintético (companhia e voos inventados), gerado com apoio de IA, e foi criado para demonstrar o método de análise. Os resultados não representam nenhuma operação real.


Perguntas de negócio
Qual turno atrasa mais?
Em quais horários os atrasos se concentram?
Quais causas mais pesam nos atrasos?
Equipe desfalcada está associada a mais atrasos?
Ferramentas
MySQL / MySQL Workbench: criação do banco, JOIN, GROUP BY, CASE WHEN, funções de data e hora
Power BI Desktop: modelagem (relações entre tabelas), medidas e colunas calculadas em DAX, visuais e segmentação de dados
Os dados

45 dias de operação, 960 voos, em 4 tabelas relacionadas:

Tabela	Conteúdo
voos	data, horário previsto, destino, tipo de aeronave, turno
operacao_solo	tempo de solo planejado e real, atraso em minutos, causa
escala_turno	funcionários necessários, presentes e ausências por turno
causas_atraso	tabela de códigos das causas

Definições usadas: voo atrasado = atraso maior que 10 minutos. Equipe desfalcada = funcionários presentes menores que os necessários.

Principais resultados
38,96% dos voos tiveram atraso acima de 10 minutos.
Turno: Manhã 41,9%, Tarde 39,3% e Noite 29,9% de voos atrasados.
Horário: os atrasos se concentram entre 6h e 9h e entre 17h e 20h, os horários de maior movimento.
Causas: a falta de equipe de solo foi a causa que mais consumiu tempo, com 2.602 minutos (cerca de um terço do total). A manutenção é rara, mas tem o maior atraso médio por ocorrência (31,2 min).
Equipe: com equipe desfalcada, 45,8% dos voos atrasaram, contra 22,6% com equipe completa. O atraso médio foi de 9,6 min contra 5,2 min.
Limitações e cuidados
Associação não é causa. Os dados mostram que atrasos e equipe desfalcada andam juntos, mas isso não prova que um cause o outro.
Definição ampla de "desfalcada". Cerca de 70% dos voos caem nessa categoria, porque basta faltar uma pessoa. Uma análise mais fina separaria por tamanho do desfalque.
Amostras pequenas. Algumas horas da madrugada têm poucos voos, então suas médias são pouco confiáveis.
Dados simulados. Os padrões foram definidos na geração dos dados.
Como reproduzir
Instale o MySQL Server e o MySQL Workbench.
Execute sql/01_criar_banco_e_dados.sql para criar o banco portfolio_aeroporto com todos os dados.
Execute as consultas de sql/02_consultas_analise.sql, uma por vez.
Abra dashboard/Dashboard-Operacao-Solo.pbix no Power BI Desktop. Os CSVs estão em data/, caso precise recarregar a fonte.
Estrutura do repositório
├── README.md
├── data/        # CSVs dos dados fictícios
├── sql/         # criação do banco e consultas de análise
├── dashboard/   # arquivo .pbix e versão em PDF
└── images/      # print do dashboard
Aprendizados
Modelagem de dados com relações entre 4 tabelas
Diferença entre medida (calculada conforme o filtro) e coluna calculada (fixa por linha) em DAX
A importância de checar os resultados do Power BI contra as consultas em SQL
Apresentar limitações da análise junto com os resultados
Autor

Vinicius da Gama Leal: estudante de Análise e Desenvolvimento de Sistemas, com experiência em operações aeroportuárias. (https://www.linkedin.com/in/viniciusdagamaleal)
