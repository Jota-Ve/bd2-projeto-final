BEGIN;

-- ID em usuario
ALTER TABLE public.usuario
  ADD COLUMN IF NOT EXISTS id_usuario BIGINT GENERATED ALWAYS AS IDENTITY;

-- Adicionar colunas fk nas filhas
ALTER TABLE IF EXISTS public.plataforma_usuario ADD COLUMN IF NOT EXISTS id_usuario_fk BIGINT;
ALTER TABLE IF EXISTS public.streamer_pais    ADD COLUMN IF NOT EXISTS id_usuario_fk BIGINT;
ALTER TABLE IF EXISTS public.canal           ADD COLUMN IF NOT EXISTS id_usuario_fk BIGINT;
ALTER TABLE IF EXISTS public.participa       ADD COLUMN IF NOT EXISTS id_usuario_fk BIGINT;
ALTER TABLE IF EXISTS public.comentario      ADD COLUMN IF NOT EXISTS id_usuario_fk BIGINT;

-- popular colunas filhas via JOIN
UPDATE public.plataforma_usuario pu
SET id_usuario_fk = u.id_usuario
FROM public.usuario u
WHERE pu.nick_usuario = u.nick;

UPDATE public.streamer_pais sp
SET id_usuario_fk = u.id_usuario
FROM public.usuario u
WHERE sp.nick_streamer = u.nick;

UPDATE public.canal c
SET id_usuario_fk = u.id_usuario
FROM public.usuario u
WHERE c.nick_streamer = u.nick;

UPDATE public.participa p
SET id_usuario_fk = u.id_usuario
FROM public.usuario u
WHERE p.nick_streamer = u.nick;

UPDATE public.comentario cm
SET id_usuario_fk = u.id_usuario
FROM public.usuario u
WHERE cm.nick_usuario = u.nick;

-- ID em conversao
ALTER TABLE public.conversao
  ADD COLUMN IF NOT EXISTS id_conversao BIGINT GENERATED ALWAYS AS IDENTITY;

ALTER TABLE IF EXISTS public.pais ADD COLUMN IF NOT EXISTS id_conversao_fk BIGINT;

-- popular colunas filhas via JOIN

UPDATE public.pais p
SET id_conversao_fk = c.id_conversao
FROM public.conversao c
WHERE p.moeda = c.moeda;

COMMIT;
