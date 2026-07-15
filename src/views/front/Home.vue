<template>
  <div style="min-height: 100vh">
    <div class="bg">
      <div style="width: 600px">
        <div style="text-align: center; color: #eee; font-size: 30px; margin-bottom: 20px">Good looks, great usability, and loads of fun – all right here</div>
        <div style="display: flex">
          <el-input v-model="name" size="medium" prefix-icon="el-icon-search" placeholder="Please enter product name keywords to search"></el-input>
          <el-button @click="$router.push({ path: '/front/search', query: { name: name } })" size="medium" type="primary" style="margin-left: 5px; background-color: #409EFF"><i class="el-icon-search"></i></el-button>
        </div>
      </div>
    </div>

    <div style="width: 70%; background-color: #fff; margin: 10px auto; padding: 20px; border-radius: 5px; position: relative">

      <el-button @click="$router.push('/front/addGoods')" style="position: absolute; top: 20px; right: -150px" size="medium" type="primary" plain>List Item</el-button>
      <el-button  @click="$router.push('/front/userHelp')" style="position: absolute; top: 70px; right: -150px" size="medium" type="primary" plain>Post Wanted</el-button>

      <div style="margin-bottom: 20px">
        <el-select v-model="category" size="medium" style="width: 200px" @change="loadGoods(1)">
          <el-option value="All"></el-option>
          <el-option v-for="item in categoryList" :key="item.id" :value="item.name"></el-option>
        </el-select>

        <el-select v-model="sort" size="medium" style="width: 200px; margin-left: 10px" @change="loadGoods(1)">
          <el-option value="Latest"></el-option>
          <el-option label="Trending" value="最热"></el-option>
        </el-select>
      </div>

      <div>
        <el-row :gutter="15">
          <el-col :span="6" v-for="item in goodsList" :key="item.id">
            <div style="margin-bottom: 20px" class="goods-item" @click="$router.push('/front/goodsDetail?id=' + item.id)">
              <img :src="item.img" alt="" style="width: 100%; display: block; height: 260px; margin-bottom: 10px; border-radius: 5px">
              <div style="font-size: 16px; height: 40px; color: #555; margin-bottom: 10px" class="line2 goods-name">{{ item.name }}</div>
              <div style="display: flex; align-items: baseline">
                <strong style="color: red; font-size: 24px">${{ item.price }}</strong>
                <span style="margin-left: 20px; color: #666">{{ item.readCount }} views</span>
                <span style="margin-left: 20px; color: #666">{{ item.likesCount }} likes</span>
              </div>
            </div>
          </el-col>
        </el-row>

        <div style="margin: 15px auto">
          <el-pagination
              background
              @current-change="handleCurrentChange"
              :current-page="pageNum"
              :page-sizes="[5, 10, 20]"
              :page-size="pageSize"
              layout="total, prev, pager, next"
              :total="total">
          </el-pagination>
        </div>
      </div>

    </div>

  </div>
</template>

<script>

export default {

  data() {
    return {
      categoryList: [],
      goodsList: [],  // All data
      pageNum: 1,   // Current page number
      pageSize: 12,  // Number of items displayed per page
      total: 0,
      category: 'All',
      sort: 'Latest',
      name: ''
    }
  },
  mounted() {
    this.loadCategory()
    this.loadGoods(1)
  },
  // methods: Define all click events and other functions for this page
  methods: {
    loadCategory() {
      this.$request.get('/category/selectAll').then(res => {
        this.categoryList = res.data || []
      })
    },
    loadGoods(pageNum) {  // Paginated search
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/goods/selectFrontPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          category: this.category === 'All' ? null : this.category,
          sort: this.sort
        }
      }).then(res => {
        if (res.code === '200') {
          this.goodsList = res.data?.list
          this.total = res.data?.total
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleCurrentChange(pageNum) {
      this.loadGoods(pageNum)
    },
  }
}
</script>

<style scoped>
.bg {
  height: 400px;
  background-image: url("@/assets/imgs/home.jpg");
  background-size: 100%;
  background-position-y: center;
  display: flex;
  align-items: center;
  justify-content: center;
}

.goods-item {
  cursor: pointer;
}
.goods-item img, .goods-name {
  transition: all .2s;
}
.goods-item:hover img {
  scale: 1.03;
}
.goods-item:hover .goods-name {
  color: #ec3d3d !important;
}
</style>