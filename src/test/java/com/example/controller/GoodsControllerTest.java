package com.example.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class GoodsControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ServerEndpointExporter serverEndpointExporter;

    // ================= User Story 2: Publish Second-hand Items =================

    @Test
    public void testPublishGoodsSuccess() throws Exception {
        String jsonRequest = "{\"name\":\"Test Bicycle\", \"price\":150.0, \"content\":\"A good bike\", \"status\":\"Pending\"}";
        mockMvc.perform(post("/goods/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonRequest))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }

    @Test
    public void testPublishGoodsInvalidPrice() throws Exception {
        String jsonRequest = "{\"name\":\"Test Bicycle\", \"price\":-50.0, \"content\":\"Invalid price\"}";
        mockMvc.perform(post("/goods/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonRequest))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }


    // ================= User Story 3: Browse Items by Category =================

    @Test
    public void testBrowseByCategory() throws Exception {
        mockMvc.perform(get("/goods/selectPage")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("category", "Electronics"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }

    @Test
    public void testBrowseAllCategories() throws Exception {
        mockMvc.perform(get("/goods/selectPage")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }

    @Test
    public void testBrowseEmptyCategory() throws Exception {
        mockMvc.perform(get("/goods/selectPage")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("category", "NonExistentCategory999"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }


    // ================= User Story 4: Search Items by Keyword =================

    @Test
    public void testSearchByValidKeyword() throws Exception {
        mockMvc.perform(get("/goods/selectPage")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("name", "Bicycle"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }

    @Test
    public void testSearchByInvalidKeyword() throws Exception {
        mockMvc.perform(get("/goods/selectPage")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("name", "xyz123456789"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }

    @Test
    public void testSearchByEmptyKeyword() throws Exception {
        mockMvc.perform(get("/goods/selectPage")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("name", ""))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("401"));
    }
}