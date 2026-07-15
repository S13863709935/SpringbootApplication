package com.example.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ServerEndpointExporter serverEndpointExporter;

    // ================= User Story 1: Account Registration & Login =================

    // Test Case 1 (Happy Path): Successful Login
    @Test
    public void testLoginSuccess() throws Exception {
        String jsonRequest = "{\"username\":\"admin\", \"password\":\"admin\", \"role\":\"ADMIN\"}";

        mockMvc.perform(post("/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonRequest))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("200"));
    }

    // Test Case 2 (Negative Path): Incorrect Password
    @Test
    public void testLoginWrongPassword() throws Exception {
        String jsonRequest = "{\"username\":\"admin\", \"password\":\"wrong_pass\", \"role\":\"ADMIN\"}";

        mockMvc.perform(post("/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonRequest))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(org.hamcrest.Matchers.not("200")));
    }

    // Test Case 3 (Edge Case): Empty Credentials
    @Test
    public void testLoginEmptyFields() throws Exception {
        String jsonRequest = "{\"username\":\"\", \"password\":\"\"}";

        mockMvc.perform(post("/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonRequest))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(org.hamcrest.Matchers.not("200")));
    }

    // ================= User Story 10: Save/Favorite Items =================

    // Test Case 15 (Negative Path): Attempt to favorite without login
    @Test
    public void testFavoriteWithoutLogin() throws Exception {
        String jsonRequest = "{\"goodsId\": 1}";

        mockMvc.perform(post("/collect/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonRequest))
                .andExpect(jsonPath("$.code").value("401"));
    }
}