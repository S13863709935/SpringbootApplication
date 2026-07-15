<template>
  <div style="width: 50%; margin: 10px auto">
    <div style="margin-bottom: 10px">
      <el-input v-model="title" placeholder="Search by title keywords" style="width: 300px; margin-right: 10px" clearable></el-input>
      <el-button type="primary" @click="load(1)">Search</el-button>
    </div>
    <div class="card" v-for="item in tableData" :key="item.id" style="margin-bottom: 5px; display: flex; grid-gap: 10px">
      <img :src="item.avatar" alt="" style="width: 50px; height: 50px; display: block; border-radius: 50%">
      <div style="flex: 1">
        <div style="margin-bottom: 5px">
          <strong style="margin-right: 5px">{{ item.title }}</strong>
          <el-tag type="danger" v-if="item.solved === '未解决'">Unresolved</el-tag>
          <el-tag type="success" v-if="item.solved === '已解决'">Resolved</el-tag>
        </div>
        <div style="color: #888;"><span style="margin-right: 20px">{{ item.userName }}</span>  <span>{{ item.time }}</span></div>

        <div style="margin: 15px 0">
          <el-image :preview-src-list="[item.img]" :src="item.img" alt="" style="width: 200px"></el-image>
        </div>
        <div v-html="item.content" style="margin: 15px 0"></div>
        <div style="margin-bottom: 15px">
          <el-button type="primary" @click="handleCommentShow(item)">Expand / Collapse Comments</el-button>
        </div>
        <div v-if="item.showComment">
          <Comment :fid="item.id" module="help" />
        </div>
      </div>
    </div>

    <div style="margin: 15px auto" v-if="total > 0">
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
</template>

<script>
import Comment from "@/components/Comment";
export default {
  name: "Help",
  components: {Comment},
  data() {
    return {
      tableData: [],  // All data
      pageNum: 1,   // Current page number
      pageSize: 5,  // Number of items displayed per page
      total: 0,
      title: ''
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    handleCommentShow(help) {
      this.$set(help, 'showComment', !help.showComment)
    },
    load(pageNum) {  // Paginated search
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/help/selectFrontPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title
        }
      }).then(res => {
        if (res.code === '200') {
          this.tableData = res.data?.list
          this.total = res.data?.total
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped>

</style>