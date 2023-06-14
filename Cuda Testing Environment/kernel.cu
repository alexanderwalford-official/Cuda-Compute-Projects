// docs: https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <iostream>

__global__ void vectAdd(int* a, int* b, int* c) {
    int i = threadIdx.x;
    c[i] = a[i] + b[i];
}

__global__ void LinearSort(int* a, int* b) {
    int i = threadIdx.x;

    // TBA
}

void ComputeExampleA() {
    // arrys
    int a[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    int b[] = { 4, 5, 6, 7, 8, 9, 10, 11, 12 };
    int c[sizeof(a) / sizeof(int)] = { 0 };

    // create GPU pointers
    int* cudaA = 0;
    int* cudaB = 0;
    int* cudaC = 0;

    // alloc GPU mem
    cudaMalloc(&cudaA, sizeof(a));
    cudaMalloc(&cudaB, sizeof(b));
    cudaMalloc(&cudaC, sizeof(c));

    // cpy vects into GPU
    cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
    cudaMemcpy(cudaB, b, sizeof(b), cudaMemcpyHostToDevice);
    cudaMemcpy(cudaC, c, sizeof(c), cudaMemcpyHostToDevice);

    // grid size, block size
    vectAdd <<< 1, sizeof(a) / sizeof(int) >>>(cudaA, cudaB, cudaC);

    // cpy results from GPU, costly operation
    cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);

    std::cout << "Compute Example A: DONE \n";
    return;
}

void ComputeExampleB() {
    // let's give the GPU a linear sorting algorithm

    // pointers
    int* cudaA;
    int* cudaB;

    // arrys
    int starting_arr[] = {1, 4, 2, 5, 7, 1, 3, 7};
    int sorted_arr[sizeof(starting_arr)];

    // alloc GPU mem
    cudaMalloc(&cudaA, sizeof(starting_arr));
    cudaMalloc(&cudaB, sizeof(sorted_arr));

    // cpy into GPU mem
    cudaMemcpy(cudaA, starting_arr, sizeof(starting_arr), cudaMemcpyHostToDevice);
    cudaMemcpy(cudaB, sorted_arr, sizeof(sorted_arr), cudaMemcpyHostToDevice);

    // call sorting method on GPU
    LinearSort <<< 1, sizeof(starting_arr) / sizeof(int) >>>(cudaA, cudaB);

    // cpy results from GPU
    cudaMemcpy(sorted_arr, cudaB, sizeof(sorted_arr), cudaMemcpyDeviceToHost);

    std::cout << "Compute Example B: DONE \n";
    return;
}

int main()
{
    // disable / enable relevant methods here by commeting them in / out
    ComputeExampleA(); // addition example
    ComputeExampleB(); // linear sorting example
    return 0;
}
