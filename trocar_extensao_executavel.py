import os

def renomear_para_hifen(diretorio):
    renomeou = False
    for raiz, _, arquivos in os.walk(diretorio):
        for arquivo in arquivos:
            if arquivo.endswith(".bat"):
                novo_nome = arquivo[:-4] + "-bat"
                os.rename(os.path.join(raiz, arquivo),
                          os.path.join(raiz, novo_nome))
                print(f"Renomeado: {arquivo} -> {novo_nome}")
                renomeou = True
            elif arquivo.endswith(".sh"):
                novo_nome = arquivo[:-3] + "-sh"
                os.rename(os.path.join(raiz, arquivo),
                          os.path.join(raiz, novo_nome))
                print(f"Renomeado: {arquivo} -> {novo_nome}")
                renomeou = True

    return renomeou



def renomear_para_extensao(diretorio):
    renomeou = False
    for raiz, _, arquivos in os.walk(diretorio):
        for arquivo in arquivos:
            if arquivo.endswith("-bat"):
                novo_nome = arquivo[:-4] + ".bat"
                os.rename(os.path.join(raiz, arquivo),
                          os.path.join(raiz, novo_nome))
                print(f"Renomeado: {arquivo} -> {novo_nome}")
                renomeou = True
                
            elif arquivo.endswith("-sh"):
                novo_nome = arquivo[:-3] + ".sh"
                os.rename(os.path.join(raiz, arquivo),
                          os.path.join(raiz, novo_nome))
                print(f"Renomeado: {arquivo} -> {novo_nome}")
                renomeou = True
    return renomeou


def main():
    renomear_para_hifen("scripts/") or renomear_para_extensao("scripts/")

    
if __name__ == "__main__":
    main()

# Exemplo de uso:
# renomear_para_hifen("caminho/do/diretorio")