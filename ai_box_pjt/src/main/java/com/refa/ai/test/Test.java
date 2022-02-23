package com.refa.ai.test;

import java.util.Arrays;

public class Test {
	public static void main(String args[]) {
		int[][] arr1 = new int[4][3];
		
		for (int i = 0; i < arr1.length; i++) {
			for (int j = 0; j < arr1[i].length; j++) {
				System.out.print(arr1[i][j] + " ");
			}
			System.out.println();
		}

		System.out.println();
		
		String[] strArr = {"hong", "kim", "park"};
		System.out.println(strArr[0].length());
	}
}
