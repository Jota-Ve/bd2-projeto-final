--
-- Views (5)
--
    -- Facilitar conversão de moeda para USD em consultas
    -- DROP VIEW IF EXISTS public.vw_usuario_conversao CASCADE;
    CREATE MATERIALIZED VIEW public.vw_usuario_conversao AS
        SELECT 
            u.nick AS nick_usuario,
            cvs.fator_conver AS fator_conver
        FROM
            public.usuario u 
        JOIN
            public.pais p ON p.id = u.id_pais_resid
        JOIN
            public.conversao cvs ON cvs.id = p.id_conversao;

    -- DROP MATERIALIZED VIEW public.vw_faturamento_inscricao_USD 
    CREATE MATERIALIZED VIEW public.vw_faturamento_inscricao_USD AS
        SELECT 
            i.nro_plataforma,
            i.nome_canal,
            SUM(nc.valor * ucvs.fator_conver) AS valor_USD
        FROM
            inscricao i
        JOIN
            nivel_canal nc ON nc.nivel = i.nivel
        JOIN
            public.vw_usuario_conversao ucvs ON ucvs.nick_usuario = i.nick_membro
        GROUP BY
            i.nro_plataforma,
            i.nome_canal;


    -- 1. Streamer Info with Aggregated Stats
    -- CREATE OR REPLACE VIEW public.vw_streamer_info AS
    --     SELECT
    --         u.nick,
    --         u.id_pais_resid,
    --         COUNT(DISTINCT c.nome) AS total_canais,
    --         COALESCE(SUM(c.qtd_visualizacoes), 0) AS total_visualizacoes_canais
    --     FROM
    --         public.usuario u
    --     LEFT JOIN
    --         public.canal c ON u.nick = c.nick_streamer
    --     GROUP BY
    --         u.nick, u.id_pais_resid;

    -- 2. Canal Stats (Views, Subs, Sponsorship Value)
    -- CREATE OR REPLACE VIEW public.vw_canal_stats AS
    --     SELECT
    --         c.nro_plataforma,
    --         c.nome AS nome_canal,
    --         c.qtd_visualizacoes,
    --         COUNT(DISTINCT i.nick_membro) AS total_inscritos,
    --         COALESCE(SUM(p.valor), 0) AS valor_total_patrocinios
    --     FROM
    --         public.canal c
    --     LEFT JOIN
    --         public.inscricao i ON c.nro_plataforma = i.nro_plataforma AND c.nome = i.nome_canal
    --     LEFT JOIN
    --         public.patrocinio p ON c.nro_plataforma = p.nro_plataforma AND c.nome = p.nome_canal
    --     GROUP BY
    --         c.nro_plataforma, c.nome, c.qtd_visualizacoes;

    -- 3. Video Engagement
    -- CREATE OR REPLACE VIEW public.vw_video_engagement AS
    --     SELECT
    --         v.nro_plataforma,
    --         v.id_video,
    --         v.titulo,
    --         v.visu_total,
    --         COUNT(DISTINCT cm.seq_comentario) AS total_comentarios,
    --         COALESCE(SUM(d.valor), 0) AS total_doacoes
    --     FROM
    --         public.video v
    --     LEFT JOIN
    --         public.comentario cm ON v.nro_plataforma = cm.nro_plataforma AND v.id_video = cm.id_video
    --     LEFT JOIN
    --         public.doacao d ON cm.nro_plataforma = d.nro_plataforma AND cm.id_video = d.id_video AND cm.seq_comentario = d.seq_comentario
    --     GROUP BY
    --         v.nro_plataforma, v.id_video, v.titulo, v.visu_total;

    -- 4. Top Donors
    -- CREATE OR REPLACE VIEW public.vw_top_donors AS
    --     SELECT
    --         u.nick,
    --         u.id_pais_resid,
    --         COUNT(*) AS qtd_doacoes,
    --         SUM(d.valor) AS total_doado
    --     FROM
    --         public.usuario u
    --     JOIN
    --         public.comentario c ON u.nick = c.nick_usuario
    --     JOIN
    --         public.doacao d ON c.nro_plataforma = d.nro_plataforma AND c.id_video = d.id_video AND c.seq_comentario = d.seq_comentario
    --     GROUP BY
    --         u.nick, u.id_pais_resid
    --     ORDER BY
    --         total_doado DESC;

    -- -- 5. Platform Growth
    -- CREATE OR REPLACE VIEW public.vw_platform_growth AS
    --     SELECT
    --         p.nro,
    --         p.nome,
    --         p.qtd_users,
    --         COUNT(DISTINCT c.nome) AS qtd_canais,
    --         COUNT(DISTINCT v.id_video) AS qtd_videos
    --     FROM
    --         public.plataforma p
    --     LEFT JOIN
    --         public.canal c ON p.nro = c.nro_plataforma
    --     LEFT JOIN
    --         public.video v ON c.nro_plataforma = v.nro_plataforma AND c.nome = v.nome_canal
    --     GROUP BY
    --         p.nro, p.nome, p.qtd_users;

--
-- Indices (5)
--    
    -- DROP INDEX idx_doacao_status;
    CREATE INDEX idx_doacao_status
    ON public.doacao 
    USING btree(status);

    -- DROP INDEX idx_doacao_status_validos;
    CREATE INDEX idx_doacao_status_validos
    ON public.doacao ((status<> 'recusado'));

    CREATE INDEX idx_comentario_nick_usuario
    ON comentario USING hash(nick_usuario);

    -- v.nro_plataforma, v.nome_canal


--
-- Triggers
--

    -- 1. Update Plataforma.qtd_users
    CREATE OR REPLACE FUNCTION public.fn_update_qtd_users() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            UPDATE public.plataforma SET qtd_users = qtd_users + 1 WHERE nro = NEW.nro_plataforma;
        ELSIF (TG_OP = 'DELETE') THEN
            UPDATE public.plataforma SET qtd_users = qtd_users - 1 WHERE nro = OLD.nro_plataforma;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE TRIGGER trg_update_qtd_users
    AFTER INSERT OR DELETE ON public.plataforma_usuario
    FOR EACH ROW EXECUTE FUNCTION public.fn_update_qtd_users();

    -- 2. Update Canal.qtd_visualizacoes (when video views update)
    CREATE OR REPLACE FUNCTION public.fn_update_qtd_visualizacoes() RETURNS TRIGGER AS $$
    BEGIN
        UPDATE public.canal
        SET qtd_visualizacoes = (
            SELECT COALESCE(SUM(visu_total), 0)
            FROM public.video
            WHERE nro_plataforma = NEW.nro_plataforma AND nome_canal = NEW.nome_canal
        )
        WHERE nro_plataforma = NEW.nro_plataforma AND nome = NEW.nome_canal;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE TRIGGER trg_update_qtd_visualizacoes
    AFTER UPDATE OF visu_total OR INSERT OR DELETE ON public.video
    FOR EACH ROW EXECUTE FUNCTION public.fn_update_qtd_visualizacoes();

    -- 3. Update Canal.qtd_videos_postados
    CREATE OR REPLACE FUNCTION public.fn_update_qtd_videos() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            UPDATE public.canal SET qtd_videos_postados = qtd_videos_postados + 1
            WHERE nro_plataforma = NEW.nro_plataforma AND nome = NEW.nome_canal;
        ELSIF (TG_OP = 'DELETE') THEN
            UPDATE public.canal SET qtd_videos_postados = qtd_videos_postados - 1
            WHERE nro_plataforma = OLD.nro_plataforma AND nome = OLD.nome_canal;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE TRIGGER trg_update_qtd_videos
    AFTER INSERT OR DELETE ON public.video
    FOR EACH ROW EXECUTE FUNCTION public.fn_update_qtd_videos();