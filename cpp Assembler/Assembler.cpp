#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <bitset>
using namespace std;

string instructionToBinary(const string& instruction) {
	static map<string, string> instructionMap = {
		{"NOP", "00000"},
		{"NOT", "00001"},
		{"NEG", "00010"},
		{"INC", "00011"},
		{"DEC", "00100"},
		{"OUT", "00101"},
		{"IN", "00110"},
		{"MOV", "00111"},
		{"SWAP", "01000"},
		{"ADD", "01001"},
		{"ADDI", "01010"},
		{"SUB", "01011"},
		{"SUBI", "01100"},
		{"AND", "01101"},
		{"OR", "01110"},
		{"XOR", "01111"},
		{"CMP", "10000"},
		{"PUSH", "10001"},
		{"POP", "10010"},
		{"LDM", "10011"},
		{"LDD", "10100"},
		{"STD", "10101"},
		{"PROTECT", "10110"},
		{"FREE", "10111"},
		{"JZ", "11000"},
		{"JMP", "11001"},
		{"CALL", "11010"},
		{"RET", "11011"},
		{"RTI", "11100"},
		{"INTERRUPT", "11101"},
		{"RESET", "11110"}
	};

	auto it = instructionMap.find(instruction);
	if (it != instructionMap.end()) {
		return it->second;
	}
	else {
		return ""; // Return empty string if instruction is not found
	}
}

string hexToBinary(const string& hexString) {
	string binaryString;
	for (char hexDigit : hexString) {
		switch (hexDigit) {
		case '0': binaryString += "0000"; break;
		case '1': binaryString += "0001"; break;
		case '2': binaryString += "0010"; break;
		case '3': binaryString += "0011"; break;
		case '4': binaryString += "0100"; break;
		case '5': binaryString += "0101"; break;
		case '6': binaryString += "0110"; break;
		case '7': binaryString += "0111"; break;
		case '8': binaryString += "1000"; break;
		case '9': binaryString += "1001"; break;
		case 'A': case 'a': binaryString += "1010"; break;
		case 'B': case 'b': binaryString += "1011"; break;
		case 'C': case 'c': binaryString += "1100"; break;
		case 'D': case 'd': binaryString += "1101"; break;
		case 'E': case 'e': binaryString += "1110"; break;
		case 'F': case 'f': binaryString += "1111"; break;
		default:
			cerr << "Invalid hexadecimal digit: " << hexDigit << endl;
			return "";
		}
	}
	return binaryString;
}

string binaryToHex(string binary) {
	// Padding the binary number to make its length multiple of 4
	int padding = 4 - (binary.length() % 4);
	if (padding != 4) {
		binary = string(padding, '0') + binary;
	}

	// Converting binary to hexadecimal
	string hex = "";
	for (size_t i = 0; i < binary.length(); i += 4) {
		string fourBits = binary.substr(i, 4);
		int decimal = bitset<4>(fourBits).to_ulong();
		if (decimal < 10) {
			hex += (char)(decimal + '0');
		}
		else {
			hex += (char)(decimal - 10 + 'A');
		}
	}
	return hex;
}

int hexToDecimal(string hex) {
	int decimal = 0;
	int base = 1; // Starting from rightmost digit

	// Iterate over the hexadecimal number from right to left
	for (int i = hex.length() - 1; i >= 0; i--) {
		// If the character is a digit, convert it to decimal and add to the result
		if (hex[i] >= '0' && hex[i] <= '9') {
			decimal += (hex[i] - '0') * base;
		}
		// If the character is an alphabet, convert it to decimal and add to the result
		else if (hex[i] >= 'A' && hex[i] <= 'F') {
			decimal += (hex[i] - 'A' + 10) * base;
		}
		base *= 16; // Move to the next position (i.e., increase the base)
	}
	return decimal;
}


string addBinaryStrings(string bin_str1, string bin_str2) {
	int carry = 0;
	string result = "";

	// Start from the rightmost digits of both strings
	int i = bin_str1.length() - 1;
	int j = bin_str2.length() - 1;

	// Iterate through both strings
	while (i >= 0 || j >= 0 || carry == 1) {
		// Compute sum of last digits and the carry
		int sum = carry;
		if (i >= 0)
			sum += bin_str1[i--] - '0';
		if (j >= 0)
			sum += bin_str2[j--] - '0';

		// Update carry for next calculation
		carry = sum / 2;

		// Append sum % 2 to result
		result = to_string(sum % 2) + result;
	}

	return result;
}


int countCommas(const string& str) {
	int count = 0;
	for (char ch : str) {
		if (ch == ',') {
			count++;
		}
	}
	return count;
}


int main()
{
	ifstream file("code.txt");

	// Check if the file is opened successfully
	if (!file.is_open()) {
		cerr << "Failed to open the file." << endl;
		return 1;
	}


	vector<string> lines;

	// Read text from the file line by line and store in the vector
	string line;
	while (getline(file, line)) {
		lines.push_back(line);
	}

	file.close();




	ofstream outFile("output.mem");


	outFile << "//memory data file (do not edit the following line - required for mem load use)" << endl;
	outFile << "//instance=/instruction_cache/RAM" << endl;
	outFile << "//format=mti addressradix=d dataradix=b version=1.0 wordsperline=1" << endl;
	outFile << " " << endl;

	size_t i = 0;

	if (lines[0] == ".org 0")
	{
		i = i + 2;

		string value = lines[1];
		value = hexToBinary(value);
		//value = addBinaryStrings(value, "100");
		if (value.length() != 32)
		{
			value.insert(0, 32 - value.length(), '0');
		}
		outFile << (" " + to_string(0) + ": " + value.substr(16, 16)) << endl;
		outFile << (" " + to_string(1) + ": " + value.substr(0, 16)) << endl;

	}
	else
	{
		outFile << (" " + to_string(0) + ": " + "0000000000000000") << endl; 
		outFile << (" " + to_string(1) + ": " + "0000000000000000") << endl;
		
	}

	if (lines[2] == ".org 2")
	{
		i = i + 2;

		string value = lines[3];
		value = hexToBinary(value);
		//value = addBinaryStrings(value, "100");
		if (value.length() != 32)
		{
			value.insert(0, 32 - value.length(), '0');
		}
		outFile << (" " + to_string(2) + ": " + value.substr(16, 16)) << endl;
		outFile << (" " + to_string(3) + ": " + value.substr(0, 16)) << endl;
	}
	else
	{
		outFile << (" " + to_string(2) + ": " + "0000000000000000") << endl;
		outFile << (" " + to_string(3) + ": " + "0000000000000000") << endl;
	}


	int linecount = 4;

	for (i; i < lines.size(); ++i)
	{
		string binaryInstruction;
		string OPcode;
		int commaCount = countCommas(lines[i]);
		int dst;
		int src1;
		int src2;
		string dstc;
		string src1c;
		string src2c;






		int spacePos = lines[i].find(' ');

		if (spacePos == string::npos)
		{
			OPcode = lines[i];
			dstc = "000";
			src1c = "000";
			src2c = "000";

		}
		else if (commaCount == 0)
		{
			OPcode = lines[i].substr(0, spacePos);
			dst = lines[i][spacePos + 2] - '0';   //find source 1 register
			dstc = bitset<3>(dst).to_string();
			src1c = dstc;
			src2c = dstc;

			if (OPcode == ".org")
			{
				string address = lines[i].substr(5, lines[i].length() - 5);
				address = hexToBinary(address);
				//address = addBinaryStrings(address, "100");
				address = binaryToHex(address);
				linecount = hexToDecimal(address);
				continue;
			}
			
		}
		else if (commaCount == 1)
		{
			OPcode = lines[i].substr(0, spacePos);
			src2c = "000";
			dst = lines[i][spacePos + 2] - '0';   //find source 1 register
			dstc = bitset<3>(dst).to_string();
			src1 = lines[i][spacePos + 5] - '0';   //find source 2 register
			src1c = bitset<3>(src1).to_string();
		}
		else if (commaCount == 2)
		{
			dst = lines[i][spacePos + 2] - '0';   //find source 1 register
			dstc = bitset<3>(dst).to_string();
			src1 = lines[i][spacePos + 5] - '0';   //find source 2 register
			src1c = bitset<3>(src1).to_string();
			src2 = lines[i][spacePos + 8] - '0';   //find destination register
			src2c = bitset<3>(src2).to_string();
			OPcode = lines[i].substr(0, spacePos);  // Retrieve substring until the space position
		}


		if (linecount >= 10)
		{
			binaryInstruction = to_string(linecount) + ": " + instructionToBinary(OPcode) + src1c + src2c + dstc + "00";
			linecount++;
		}
		else
		{
			binaryInstruction = " " + to_string(linecount) + ": " + instructionToBinary(OPcode) + src1c + src2c + dstc + "00";
			linecount++;

		}



		if (OPcode == "SUBI" || OPcode == "ADDI")
		{
			string immediate = lines[i].substr(11, lines[i].length() - 11);
			immediate = hexToBinary(immediate); // we need to concatnate zeroes to left of this
			int L = 16 - immediate.length();
			if (immediate.length() != 16)
			{
				for (int i = 0; i <L; i++)
				{
					immediate = "0" + immediate;
				}
			}
			outFile << binaryInstruction << endl;
			if (linecount >= 10)
			{

				outFile << (to_string(linecount) + ": " + immediate) << endl;
				linecount++;
			}
			else
			{
				outFile << (" " + to_string(linecount) + ": " + immediate) << endl;
				linecount++;
			}
		}
		else if (OPcode == "LDM")
		{
			string immediate = lines[i].substr(7, 4);
			immediate = hexToBinary(immediate);
			int F = 16 - immediate.length();
			if (immediate.length() != 16)
			{
				for (int i = 0; i < F; i++)
				{
					immediate = "0" + immediate;
				}
			}
			outFile << binaryInstruction << endl;
			if (linecount >= 10)
			{
				outFile << (to_string(linecount) + ": " + immediate) << endl;
				linecount++;

			}
			else
			{
				outFile << (" " + to_string(linecount) + ": " + immediate) << endl;
				linecount++;
			}
		}
		else if (OPcode == "CMP" || OPcode == "PROTECT" || OPcode == "FREE")
		{
			binaryInstruction = instructionToBinary(OPcode) + dstc + src1c + src2c + "00";
			if (linecount >= 10)
			{
				outFile << to_string(linecount - 1) + ": " + binaryInstruction << endl;
			}
			else
			{
				outFile << " " + to_string(linecount - 1) + ": " + binaryInstruction << endl;
			}
		}
		else if (OPcode == "LDD" || OPcode == "STD")
		{
			int bracketPosition = lines[i].find("(");
			string EA = lines[i].substr(7, bracketPosition - 7); //should be until open backet
			src1 = lines[i][bracketPosition + 2] - '0';
			binaryInstruction = instructionToBinary(OPcode) + bitset<3>(src1).to_string() + src2c + dstc + "00";
			EA = hexToBinary(EA);
			int S = 16 - EA.length();
			if (EA.length() != 16)
			{
				for (int i = 0; i < S; i++)
				{
					EA = "0" + EA;
				}
			}
			if (linecount >= 10)
			{
				outFile << to_string(linecount - 1) + ": " + binaryInstruction << endl;
				outFile << to_string(linecount) + ": " + EA << endl;
				linecount++;

			}
			else
			{
				outFile << " " + to_string(linecount - 1) + ": " + binaryInstruction << endl;
				outFile << " " + to_string(linecount) + ": " + EA << endl;
				linecount++;

			}

		}
		else
		{
			outFile << binaryInstruction << endl;
		}

	}

	//if (lines.size() != 4294967296)
	//{
	//	for (int i = lines.size() ; i < 32;i++)
	//	{
	//		if (linecount >= 10)
	//		{
	//			outFile << to_string(linecount ) + ": " + "XXXXXXXXXXXXXXXX" << endl;
	//			linecount++;

	//		}
	//		else
	//		{
	//			outFile << " " + to_string(linecount ) + ": " + "XXXXXXXXXXXXXXXX" << endl;
	//			linecount++;

	//		}
	//	}
	//}

	outFile.close();

	return 0;
}

//format :  Add R1,R2,R3
// No spaces
//change(d) instruction cache in vhdl to have mem file in order