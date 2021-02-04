#include <iostream>
using namespace std;
int MAX_SIZE=100;

int CheckSumPossibility(int num, int arr[], int arraySize);

int main(){
	int arraySize;
	int arr[MAX_SIZE];
	int num;
	int returnVal;
	cout<<"Enter the array size: ";
	cin >> arraySize;
	cout<<"Enter the total: ";
	cin >> num;
	for(int i = 0; i < arraySize; ++i){
		cin >> arr[i];
	}
	returnVal = CheckSumPossibility(num,arr,arraySize);
	if(returnVal == 1){
		cout << "Possible!" << endl;
	}
	else
		cout << "Not possible!" << endl;
		
	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////
int CheckSumPossibility(int num, int arr[], int arraySize){
	if (num == 0){
        return 1; 	
	}
    if (arraySize == 0){
        return 0;
	}
	return CheckSumPossibility(num, arr, arraySize - 1) 
					|| CheckSumPossibility(num - arr[arraySize - 1], arr, arraySize - 1);
}
//////////////////////////////////////////////////////////////////////////////////////////
