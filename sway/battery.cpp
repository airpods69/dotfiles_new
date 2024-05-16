#include <iostream>

int main() {
	system("acpi >> bat.txt");
	system("cat ~/.config/i3/bat.txt");
	return 0;
}
