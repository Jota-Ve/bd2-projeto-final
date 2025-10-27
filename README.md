# Gera dados com Faker para popular o Banco de Dados

## Banco PostgreSQL
    USUÁRIO = "postgres"
    SENHA   = "sofisticada"

## Modelo Relacional

* **Empresa**(<u>nro</u>, nome, nome_fantasia)

<br>

* **Plataforma**(<u>nro</u>, nome, qtd_users, empresa_fund, empresa_respo, data_fund)
  * *-- Quantidade de usuários **qtd_users** é atributo derivado e **requer atualização periódica**.*
  * *empresa_fund **referencia Empresa**(nro)*
  * *empresa_respo **referencia Empresa**(nro)*

<br>

* **Conversao**(<u>moeda</u>, nome, fator_conver)
    * *-- fator_conver é o fator de conversão para dólar*

<br>

* **Pais**(<u>DDI</u>****, nome, moeda)
  * *moeda **referencia Conversao**(moeda)*

<br>

* **Usuario**(<u>nick</u>, email, data_nasc, telefone, end_postal, pais_residencia)
  * *pais_residencia **referencia Pais**(ddi)*

<br>

* **PlataformaUsuario**(<u>nro_plataforma, nick_usuario</u>, nro_usuario)
  * *nro_plataforma **referencia Plataforma**(nro)*
  * *nick_usuario **referencia Usuario**(nick)*

<br>

* **StreamerPais**(<u>nick_streamer, ddi_pais</u>, nro_passaporte)
  * *nick_streamer **referencia Usuario**(nick)*
  * *ddi_pais **referencia Pais**(ddi)*

<br>

* **EmpresaPais**(<u>nro_empresa, ddi_pais</u>, id_nacional)

<br>

* **Canal**(<u>nome</u>, tipo, data, desc, qtd_visualizacoes, nick_streamer, nro_plataforma)
  * -- Quantidade de visualizações **qtd_visualizações** é atributo derivado e **requer atualização**
  * *nro_plataforma **referencia Plataforma**(nro)*
  * *nick_streamer **referencia Usuario**(nick)*

<br>

* **Patrocionio**(<u>nro_empresa, nome_canal, nro_plataforma</u>, valor)
  * *nro_empresa **referencia Empresa**(nro)*
  * *nome_canal, nro_plataforma **referencia Canal**(nome, nro_plataforma)*

<br>

* **NivelCanal**(<u>nome_canal, nro_plataforma, nivel</u>, valor, gif)
  * *nome_canal, nro_plataforma **referencia Canal**(nome, nro_plataforma)*

<br>

* **Inscrição**(<u>nome_canal, nro_plataforma, nick_membro</u>, nivel)
  * *nick_membro refrencia **Usuario**(nick)*
  * *(nome_canal, nro_plataforma, nivel) referencia NivelCanal(nome_canal, nro_plataforma, nivel)*

<br>

* **Video**(<u>nome_canal, nro_plataforma, titulo, dataH</u>, tema, duracao, visu_simul, visu_total)
  * *-- Verificar a **possibilidade do uso de identificador artificial** (toda ou parte da chave)*
  * *(nome_canal, nro_plataforma) **referencia Canal**(nome, nro_plataforma)*

<br>

* **Participa**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_streamer</u>)
  * *(nome_canal, nro_plataforma, titulo_video, dataH_video) referencia Video(nome_canal, nro_plataforma, titulo_video, dataH_video)*
  * *nick_streamer **referencia Usuario**(nick)*

<br>

* **Comentario**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq</u>, texto, dataH, coment_on)
  * *(nome_canal, nro_plataforma, titulo_video, dataH_video) **referencia Video**(nome_canal, nro_plataforma, titulo, dataH)*
  * *nick_usuario **referencia Usuario**(nick)*

<br>

* **Doacao**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg, valor</u>, status)
  * *(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario)*
    * **referencia Comentario**(nome_canal, nro_plataforma, titulo_vide dataH_video, nick_usuario, seq)*

<br>

* **BitCoin**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, TxID)
  * *(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)*
    * **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)*

<br>

* **PayPal**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, IdPayPal)
  * *(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)*
    * **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)*

<br>

* **CartaoCredito**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, nro, bandeira)
  * *(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)*
    * **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)*

<br>

* **MecanismoPlat**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, seq_plataforma)
  * *(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)*
    * **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)*
