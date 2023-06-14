
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>


int main()
{
    int a[] = { 1, 2 ,3 };
    int b[] = { 4, 5, 6 };
    int c[sizeof(a) / sizeof(int)] = { 0 };

    int* cudaA = 0;
    int* cudaB = 0;
    int* cudaC = 0;

    cudaMalloc(&cudaA, sizeof(a));
    cudaMalloc(&cudaB, sizeof(b));
    cudaMalloc(&cudaC, sizeof(c));

    for (int i = 0; i < sizeof(c) / sizeof(int); i++) {
        c[i] = a[i] + b[i];
    }

    printf("Compiled on GPU.");

    return;
}