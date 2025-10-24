# Gera dados com Faker para popular o Banco de Dados

## Modelo Relacional

    Empresa(nro, nome, nome_fantasia)

    -- Quantidade de usuários qtd_users é atributo derivado e requer atualização periódica
    Plataforma(nro, nome, qtd_users, empresa_fund, empresa_respo, data_fund)
        empresa_fund referencia Empresa(nro)
        empresa_respo referencia Empresa(nro)

    -- fator_conver é o fator de conversão para dólar
    Conversao(moeda, nome, fator_conver)


    Pais(DDI, nome, moeda)
        moeda referencia Conversao(moeda)

    Usuario(nick, email, data_nasc, telefone, end_postal, pais_residencia)
        pais_residencia referencia Pais(ddi)

    PlataformaUsuario(nro_plataforma, nick_usuario, nro_usuario)
        nro_plataforma referencia Plataforma(nro)
        nick_usuario referencia Usuario(nick)

    StreamerPais(nick_streamer, ddi_pais, nro_passaporte)
        nick_streamer referencia Usuario(nick)
        ddi_pais referencia Pais(ddi)

    EmpresaPais(nro_empresa, ddi_pais, id_nacional)

    -- Quantidade de visualizações qtd_visualizações é atributo derivado e requer atualização
    Canal(nome, tipo, data, desc, qtd_visualizacoes, nick_streamer, nro_plataforma)
        nro_plataforma referencia Plataforma(nro)
        nick_streamer referencia Usuario(nick)

    Patrocionio(nro_empresa, nome_canal, nro_plataforma, valor)
        nro_empresa referencia Empresa(nro)
        nome_canal, nro_plataforma referencia Canal(nome, nro_plataforma)

    NivelCanal(nome_canal, nro_plataforma, nivel, valor, gif)
        nome_canal, nro_plataforma referencia Canal(nome, nro_plataforma)

    Inscrição(nome_canal, nro_plataforma, nick_membro, nivel)
        nick_membro refrencia Usuario(nick)
        (nome_canal, nro_plataforma, nivel) referencia NivelCanal(nome_canal, nro_plataforma, nivel)

    -- Verificar a possibilidade do uso de identificador artificial (toda ou parte da chave)
    Video(nome_canal, nro_plataforma, titulo, dataH, tema, duracao, visu_simul, visu_total)
        (nome_canal, nro_plataforma) referencia Canal(nome, nro_plataforma)

    Participa(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_streamer)
        (nome_canal, nro_plataforma, titulo_video, dataH_video) referencia Video(nome_canal, nro_plataforma, titulo_video, dataH_video)
        nick_streamer referencia Usuario(nick)

    Comentario(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq, texto, dataH, coment_on)
        (nome_canal, nro_plataforma, titulo_video, dataH_video) referencia Video(nome_canal, nro_plataforma, titulo, dataH)
        nick_usuario referencia Usuario(nick)

    Doacao(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg, valor, status)
        (nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario) referencia Comentario(nome_canal, nro_plataforma, titulo_vide dataH_video, nick_usuario, seq)

    BitCoin(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao, TxID)
        (nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao) referencia Doacao(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)

    PayPal(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao, IdPayPal)
        (nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao) referencia Doacao(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)

    CartaoCredito(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao, nro, bandeira)
        (nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao) referencia Doacao(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)

    MecanismoPlat(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao, seq_plataforma)
        (nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao) referencia Doacao(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)
