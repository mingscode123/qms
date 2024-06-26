package com.qms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@SpringBootApplication
public class QmsT2Application {

	public static void main(String[] args) {
		SpringApplication.run(QmsT2Application.class, args);
	}

}
