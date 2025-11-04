import random
from collections.abc import Generator, Sequence


def combina[T, U](A: Sequence[T], B: Sequence[U], k: int) -> Generator[tuple[T, U], None, None]:
    """Gera k combinações únicas entre elementos de A e B.
    Args:
        A (Sequence[T]): Primeira sequência de elementos.
        B (Sequence[U]): Segunda sequência de elementos.
        k (int): Número de combinações únicas a serem geradas.
    Yields:
        Generator[tuple[T, U], None, None]: Gerador de tuplas contendo combinações únicas.
    Raises:
        ValueError: Se k for maior que o número total de combinações possíveis.
    """
    m, n = len(A), len(B)
    total: int = m * n
    if k > total:
        raise ValueError(f"k ({k}) maior que total de combinações ({total})")

    escolhidos: list[int] = random.sample(range(total), k)
    for i in escolhidos:
        a: T = A[i // n]
        b: U = B[i % n]
        yield (a, b)
