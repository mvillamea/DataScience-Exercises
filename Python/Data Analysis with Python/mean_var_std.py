"""Create a function named calculate() in mean_var_std.py that uses Numpy to output the mean,
variance, standard deviation, max, min, and sum of the rows, columns, and elements in a 3 x 3 matrix.
The input of the function should be a list containing 9 digits.
The function should convert the list into a 3 x 3 Numpy array, and then return a dictionary containing the mean,
variance, standard deviation, max, min, and sum along both axes and for the flattened matrix."""

import numpy as np

def transform_into_matrix(list):
    """makes a 3x3 matrix with a list
    where the columns are the elements
    of the list grouped by three"""
    row_1 = []
    row_2 = []
    row_3 = []
    for i in range(len(list)//3):
        row_1 = row_1.__add__([list[i*3]])
    for i in range(len(list)//3):
        row_2 = row_2.__add__([list[i*3+1]])
    for i in range(len(list)//3):
        row_3 = row_3.__add__([list[i*3+2]])
    matrix = np.array([row_1, row_2, row_3])
    return matrix


def check_length(list):
    """Checks if the list
    has 9 digits"""
    if len(list)!=9:
        raise ValueError('List must contain nine numbers.')


def calculate(lista):
    check_length(lista)
    matrix = transform_into_matrix(lista)
    calculations = {'mean': [list(matrix.mean(axis=1)), list(matrix.mean(axis=0)), np.mean(matrix)],
                    'variance': [list(matrix.var(axis=1)), list(matrix.var(axis=0)), np.var(matrix)],
                    'standard deviation': [list(matrix.std(axis=1)), list(matrix.std(axis=0)), np.std(matrix)],
                    'max': [list(matrix.max(axis=1)), list(matrix.max(axis=0)), np.max(matrix)],
                    'min': [list(matrix.min(axis=1)), list(matrix.min(axis=0)), np.min(matrix)],
                    'sum': [list(matrix.sum(axis=1)), list(matrix.sum(axis=0)), np.sum(matrix)]
                    }

    return calculations


