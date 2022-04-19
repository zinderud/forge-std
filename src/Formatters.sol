pragma solidity >00.8.13 <0.9.0;

import "memmove/RefArray.sol";

type Csv is bytes32;

using CsvLib for Csv global;

enum ColumnDataType {
	BYTES,
	FIXED_BYTES,
	STRING,
	UINT,
	INT,
}

library CsvLib {
	using RefArrayLib for Array;

	function newCsv(uint16 columnsHint, uint16 rowsHint) internal pure returns (Csv csv) {
		Array csv = RefArrayLib.newArray(columnsHint);
		for (uint256 i; i < columnsHint; i++) {
			Array column = RefArrayLib.newArray(rowsHint);
			csv.push(column);
		}
		Array headerArray = RefArrayLib.newArray(columnsHint);
		Array dataTypes = RefArrayLib.newArray(columnsHint);
		csv = join(headerArray, dataTypes, csv);
	}

	function join(Array header, Array dataTypes, Array csv) internal pure returns (Csv csv) {
		csv = Csv.wrap(bytes32(
			uint256(Array.unwrap(header)) << 192
			| uint256(Array.unwrap(dataTypes)) << 128
			| uint256(Array.unwrap(csv))
		));
	}

	function split(Csv self) internal pure returns (Array headers, Array dataTypes, Array csv) {
		headers = Array.wrap(bytes32(uint256(Csv.unwrap(csv)) >> 192));
		dataTypes = Array.wrap(bytes32(uint256(Csv.unwrap(csv)) << 64 >> 192));
		csv = Array.wrap(bytes32(uint256(Csv.unwrap(csv)) << 128 >> 128));
	}

	function headersArray(Csv self) internal pure returns (Array arr) {
		(arr, , ) = split(self);
	}

	function getColumnByName(Csv self, string memory headerName) internal pure returns (bool found, Array arr) {
		(Array headers, Array dataTypes, Array csv) = split(self);
		uint256 numHeaders = headers.length();
		for (uint256 i; i < numHeaders; i++) {
			if (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b))) {
				arr = csv.get(i);
				found = true;
				break;
			}
		}
	}

	function getColumnByIndex(Csv self, uint256 index) internal pure returns (Array arr) {
		(Array headers, Array dataTypes, Array csv) = split(self);
		arr = csv.get(index);
	}

	function addColumn(Csv self, string memory headerName, ColumnDataType dataType) internal pure {
		// add a header
		(Array headers, Array dataTypes, Array csv) = split(self);
		headers.push(asPtr(headerName));
		dataTypes.push(dataType);
		// if more headers than columns, add a new column
		if (headers.length() > csv.length()) {
			csv.push(RefArrayLib.newArray(1));
		}
	}

	function addColumn(Csv self, uint256 index, ColumnDataType dataType) internal pure {
		// add a header
		(Array headers, Array dataTypes, Array csv) = split(self);
		headers.push(index);

		// add a datatype for column
		dataTypes.push(dataType);

		// if more headers than columns, add a new column
		if (headers.length() > csv.length()) {
			csv.push(RefArrayLib.newArray(1));
		}
	}

	function addRowItem(Csv self, string memory headerName, bytes32 item, ColumnDataType dataType) internal pure {
		(bool found, Array column) = getColumnByName(self, headerName);
		if (!found) {
			addColumn(self, headerName, dataType);
			(found, column) = getColumnByName(self, headerName);
		}
		column.push(item);
	}

	function addRowItem(Csv self, string memory headerName, bytes32 item) internal pure {
		addRowItem(self, headerName, item, ColumnDataType.FIXED_BYTES);
	}

	function addRowItem(Csv self, string memory headerName, uint256 item) internal pure {
		addRowItem(self, headerName, bytes32(item), ColumnDataType.UINT);
	}

	function addRowItem(Csv self, string memory headerName, string memory item) internal pure {
		addRowItem(self, headerName, asPtr(item), ColumnDataType.STRING);
	}

	function addRowItem(Csv self, string memory headerName, bytes memory item) internal pure {
		addRowItem(self, headerName, asPtr(item), ColumnDataType.BYTES);
	}

	function addRowItem(Csv self, uint256 index, bytes32 item) internal pure {
		Array column = getColumnByIndex(self, index);
		column.push(item);
	}

	function addRowItem(Csv self, uint256 index, bytes32 item) internal pure {
		addRowItem(self, index, item);
	}

	function addRowItem(Csv self, uint256 index, uint256 item) internal pure {
		addRowItem(self, index, bytes32(item));
	}

	function addRowItem(Csv self, uint256 index, string memory item) internal pure {
		addRowItem(self, index, asPtr(item));
	}

	function addRowItem(Csv self, uint256 index, bytes memory item) internal pure {
		addRowItem(self, index, asPtr(item));
	}

	function setFullColumn(Csv self, string memory headerName, uint256[] memory item) internal pure {
		(bool found, Array column) = getColumnByName(self, headerName);
		if (!found) {
			addColumn(self, headerName, ColumnDataType.UINT);
			(found, column) = getColumnByName(self, headerName);
		}
		uint256 ctr = 0;
		
		// overwrite items
		while (column.length() > item.length) {
			column.unsafe_set(ctr, item[ctr]);
			ctr++;
		}

		// add remaining items
		for (; ctr < item.length; ctr++) {
			column.push(item[ctr]);
		}
	}

	function setFullColumn(Csv self, string memory headerName, int256[] memory item) internal pure {
		(bool found, Array column) = getColumnByName(self, headerName);
		if (!found) {
			addColumn(self, headerName, ColumnDataType.INT);
			(found, column) = getColumnByName(self, headerName);
		}
		uint256 ctr = 0;
		
		// overwrite items
		while (column.length() > item.length) {
			column.unsafe_set(ctr, item[ctr]);
			ctr++;
		}

		// add remaining items
		for (; ctr < item.length; ctr++) {
			column.push(item[ctr]);
		}
	}

	function setFullColumn(Csv self, string memory headerName, string[] memory item) internal pure {
		(bool found, Array column) = getColumnByName(self, headerName);
		if (!found) {
			addColumn(self, headerName, ColumnDataType.STRING);
			(found, column) = getColumnByName(self, headerName);
		}
		uint256 ctr = 0;
		
		// overwrite items
		while (column.length() > item.length) {
			column.unsafe_set(ctr, item[ctr]);
			ctr++;
		}

		// add remaining items
		for (; ctr < item.length; ctr++) {
			column.push(item[ctr]);
		}
	}

	function setFullColumn(Csv self, string memory headerName, bytes[] memory item) internal pure {
		(bool found, Array column) = getColumnByName(self, headerName);
		if (!found) {
			addColumn(self, headerName, ColumnDataType.BYTES);
			(found, column) = getColumnByName(self, headerName);
		}
		uint256 ctr = 0;
		
		// overwrite items
		while (column.length() > item.length) {
			column.unsafe_set(ctr, item[ctr]);
			ctr++;
		}

		// add remaining items
		for (; ctr < item.length; ctr++) {
			column.push(item[ctr]);
		}
	}

	function setFullColumn(Csv self, string memory headerName, bytes32[] memory item) internal pure {
		(bool found, Array column) = getColumnByName(self, headerName);
		if (!found) {
			addColumn(self, headerName, ColumnDataType.FIXED_BYTES);
			(found, column) = getColumnByName(self, headerName);
		}
		uint256 ctr = 0;
		
		// overwrite items
		while (column.length() > item.length) {
			column.unsafe_set(ctr, item[ctr]);
			ctr++;
		}

		// add remaining items
		for (; ctr < item.length; ctr++) {
			column.push(item[ctr]);
		}
	}

	function format(Csv self) internal pure returns (string memory csv) {
		uint256 maxR = maxRow(self);
		for (uint256 i; i < maxR; i++) {
			csv = abi.encodePacked(csv, formatRow(self, i));
		}
	}

	function formatRow(Csv self, uint256 rowIndex) internal pure returns (string memory row) {
		(Array headers, Array dataTypes, Array csv) = split(self);

		uint256 columns = csv.length();
		for (uint256 columnIndex; columnIndex < columns; columnIndex++) {
			ColumnDataType dataType = dataTypes.get(columnIndex);
			if (hasItem(csv, columnIndex, rowIndex)) {
				if (dataType == ColumnDataType.STRING || dataType == ColumnDataType.BYTES) {
					row = abi.encodePacked(row, fromPtr(getItem(csv, columnIndex, rowIndex)), columnIndex == columns - 1 ? '\n' : ','))
				} else if (dataType == ColumnDataType.INT) {
					int256 item = int256(getItem(csv, columnIndex, rowIndex));
					// string memory negativeSign = item < 0 ? '-' : '';
					row = abi.encodePacked(row, item, columnIndex == columns - 1 ? '\n' : ','))
				} else {
					row = abi.encodePacked(row, getItem(csv, columnIndex, rowIndex), columnIndex == columns - 1 ? '\n' : ','))
				}
			} else {
				row = abi.encodePacked(row, columnIndex == columns - 1 ? '\n' : ',');
			}
		}
	}

	function maxRow(Csv self) internal pure returns (uint256 maxLen) {
		(Array headers, Array dataTypes, Array csv) = split(self);
		uint256 columns = csv.length();
		for (uint256 columnIndex; columnIndex < columns; columnIndex++) {
			uint256 columnLen = Array.wrap(bytes32(csv.get(columnIndex))).length();
			if (columnLen > maxLen) {
				maxLen = columnLen;
			}
		}
	}

	function hasItem(Array csv, uint256 columnIndex, uint256 rowIndex) internal pure returns (bool) {
		return Array.wrap(bytes32(csv.get(columnIndex)).length() > rowIndex;
	}

	function getItem(Array csv, uint256 columnIndex, uint256 rowIndex) internal pure returns (uint256) {
		return Array.wrap(bytes32(csv.get(columnIndex)).get(rowIndex);
	}

	function asPtr(string memory f) internal pure returns (uint256 ptr) {
		assembly ("memory-safe") {
			ptr := f
		}
	}

	function asPtr(bytes memory f) internal pure returns (uint256 ptr) {
		assembly ("memory-safe") {
			ptr := f
		}
	}

	function fromPtr(uint256 ptr) internal pure returns (string memory f) {
		assembly ("memory-safe") {
			f := ptr
		}
	}

	function fromPtr(uint256 ptr) internal pure returns (bytes memory f) {
		assembly ("memory-safe") {
			f := ptr
		}
	}
}