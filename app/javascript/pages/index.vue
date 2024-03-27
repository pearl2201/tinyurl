<script>
import axios from 'axios';
export default ({
    data() {
        return ({
            originUrl: '',
            shortPath: '',
            validateMsg: '',
            errorMsg: '',
            loading: false,
            submited: false,
        })
    },
    computed: {
        baseUrl(){
            return window.location.origin
        }
    },
    methods: {
        validateInput(url) {
            // refer http://www.cnblogs.com/554006164/archive/2009/06/16/1504160.html
            var urlRegex = "^((https|http)?://)"
                + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184  
                + "|" // 允许IP和DOMAIN（域名） 
                + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.  
                + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名  
                + "[a-z]{2,6})" // first level domain- .com or .museum  
                + "(:[0-9]{1,4})?" // 端口- :80  
                + "((/?)|" // a slash isn't required if there is no file name  
                + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$"
            var re = new RegExp(urlRegex)
            if (re.test(url)) {
                console.log('url ', url, ' is validate')
                return true
            }
            console.log('url ', url, ' is not validate')
            return false
        },
        async submit(){
            this.submited = true
            if (this.originUrl == "") {
                this.validateMsg = "please input correct url";
                return;
            }
            if (!this.validateInput(this.originUrl)) {
                this.validateMsg = "your input url is not validate!";
                console.log(this.validateMsg != '' && this.submited)
                return;
            }
            this.errorMsg = ''
            this.validateMsg = ''
            try {
                const { data } = await axios.post("/api/v1/shorten", {
                    originUrl: this.originUrl
                })
                if (data.success)
                {
                    this.shortPath = data.data.shortPath
                }else
                {
                    this.errorMsg = data.error
                }
            }
            catch (error) {
                this.errorMsg = error.message
            }
            console.log(this.validateMsg)
        }
    }
})
</script>

<template>
    <main class="container">
        <section class="section is-large">
            <form>
                <div class="field">
                    <label class="label">Url</label>
                    <div class="control has-icons-left has-icons-right">
                        <input class="input " :class="{ 'is-danger': validateMsg != '' && submited }" type="text" placeholder="Text input"
                            v-model="originUrl">
                        <span class="icon is-small is-left">
                            <i class="fas fa-user"></i>
                        </span>
                        <span class="icon is-small is-right">
                            <i class="fas fa-check"></i>
                        </span>
                    </div>
                    <p class="help is-danger" v-show=" validateMsg ">{{ validateMsg }}</p>
                </div>
                <button class="button" @click.prevent=" submit ">Submit</button>
            </form>
        </section>
        <div class="notification" v-show="shortPath">
            Your url is {{baseUrl}}/n/{{ shortPath }} <span class="icon is-small is-right ml-2"><i class="fas fa-copy">Copy</i></span>
        </div>
    </main>
    <footer>

    </footer>
</template>