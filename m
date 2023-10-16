Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65A7C9CFD
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 03:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJPBrI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 Oct 2023 21:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPBrH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 Oct 2023 21:47:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94601A9;
        Sun, 15 Oct 2023 18:47:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S80Mz6W1Gz4f3kp1;
        Mon, 16 Oct 2023 09:46:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd0TlixlP1JPDA--.33169S3;
        Mon, 16 Oct 2023 09:47:01 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Khazhy Kumykov <khazhy@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Li Nan <linan666@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
 <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com>
 <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com>
 <20231008113602.GB24726@redhat.com>
 <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e9165cd0-9c9d-1d1a-1c5b-402556a1a31f@huaweicloud.com>
Date:   Mon, 16 Oct 2023 09:46:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd0TlixlP1JPDA--.33169S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4xAFWkWr1DZF17tF48Xrb_yoW8JrWxpF
        WIgw12vrs0qas7JF1Iyw1jvF1UZFZrGFy5J3yDC34qvas5G3s7GF17CrZ0yr47X348Wa1r
        JwnIyF9rArnFqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/10/14 5:51, Khazhy Kumykov 写道:
> Looking at the generic mul_u64_u64_div_u64 impl, it doesn't handle
> overflow of the final result either, as far as I can tell. So while on
> x86 we get a DE, on non-x86 we just get the wrong result.
> 
> (Aside: after 8d6bbaada2e0 ("blk-throttle: prevent overflow while
> calculating wait time"), setting a very-high bps_limit would probably
> also cause this crash, no?)
> 
> Would it be possible to have a "check_mul_u64_u64_div_u64_overflow()",
> where if the result doesn't fit in u64, we indicate (and let the
> caller choose what to do? Here we should just return U64_MAX)?
> 
> Absent that, maybe we can take inspiration from the generic
> mul_u64_u64_div_u64? (Forgive the paste)
> 
>   static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
>   {
> +       /* Final result probably won't fit in u64 */
> +       if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)

I'm not sure, but this condition looks necessary, but doesn't look
sufficient, for example, jiffy_elapsed cound be greater than HZ, while
ilog2(jiffy_elapsed) is equal to ilog2(HZ).

Thanks,
Kuai

> +               return U64_MAX;
>          return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>   }
> 
> .
> 

