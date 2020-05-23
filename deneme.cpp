#include <iostream>
#include <stdio.h>
using namespace std;

int main()
{
	cout << "1000x1000 Double Speedup : " <<  4.401 / 3.034 << endl;
	cout << "1000x1000 Float Speedup : " <<  3.201 / 2.842 << endl;

	cout << "2000x2000 Double Speedup : " <<  49.659 / 18.058 << endl;
	cout << "2000x2000 Float Speedup : " <<  44.849 / 16.579 << endl;

	cout << "3000x3000 Double Speedup : " <<  191.264 / 56.934 << endl;
	cout << "3000x3000 Float Speedup : " <<  162.554 / 50.853 << endl;

	cout << "4000x4000 Double Speedup : " <<  507.023 / 133.903 << endl;
	cout << "4000x4000 Float Speedup : " <<  399.968 / 117.217 << endl;

	cout << "5000x5000 Double Speedup : " <<  1083.273 / 285.241 << endl;
	cout << "5000x5000 Float Speedup : " <<  818.047 / 232.087 << endl;

	return 0;
}