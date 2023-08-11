Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A03778511
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 03:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHKBpB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Aug 2023 21:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHKBpB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Aug 2023 21:45:01 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4703C10D;
        Thu, 10 Aug 2023 18:45:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RMRS64FN1z4f3kj0;
        Fri, 11 Aug 2023 09:44:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qiXktVknRezAQ--.22898S3;
        Fri, 11 Aug 2023 09:44:57 +0800 (CST)
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <6637e6cd-20aa-110a-40ae-53ecd6eb4184@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d4050f7e-d491-c111-3e26-160e7d5a4208@huaweicloud.com>
Date:   Fri, 11 Aug 2023 09:44:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6637e6cd-20aa-110a-40ae-53ecd6eb4184@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qiXktVknRezAQ--.22898S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UuFyfZr48AFyxXw1UJrb_yoW5tw1UpF
        n3WrW7u3yUGrs3XF18Kw18uryUt3y8Ka4UGr1rZFy5JrsF9FyYgF1UZFnYgFW8ZrWkAFs5
        Jr1UXr97uF15JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/08/10 21:43, Yu Kuai 写道:
> 在 2023/08/10 11:51, Li Lingfeng 写道:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
>> a mutex named "init_mutex" in blk_iolatency_try_init for the race
>> condition of initializing RQ_QOS_LATENCY.
>> Now a new lock has been add to struct request_queue by commit 
>> a13bd91be223
>> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
>> held in blkg_conf_open_bdev before calling blk_iolatency_init.
>> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
>> remove it.
>>
>> Since init_mutex has been removed, blk_iolatency_try_init can be
>> open-coded back to iolatency_set_limit() like ioc_qos_write().
>>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Thanks,
> Kuai
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>    v1->v2: open-code blk_iolatency_try_init()
>>    v2->v3: add lockdep check
>>   block/blk-iolatency.c | 35 +++++++++++------------------------
>>   1 file changed, 11 insertions(+), 24 deletions(-)
>>
>> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
>> index fd5fec989e39..c16aef4be036 100644
>> --- a/block/blk-iolatency.c
>> +++ b/block/blk-iolatency.c
>> @@ -824,29 +824,6 @@ static void iolatency_clear_scaling(struct 
>> blkcg_gq *blkg)
>>       }
>>   }
>> -static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
>> -{
>> -    static DEFINE_MUTEX(init_mutex);
>> -    int ret;
>> -
>> -    ret = blkg_conf_open_bdev(ctx);
>> -    if (ret)
>> -        return ret;
>> -
>> -    /*
>> -     * blk_iolatency_init() may fail after rq_qos_add() succeeds 
>> which can
>> -     * confuse iolat_rq_qos() test. Make the test and init atomic.
>> -     */
>> -    mutex_lock(&init_mutex);
>> -
>> -    if (!iolat_rq_qos(ctx->bdev->bd_queue))
>> -        ret = blk_iolatency_init(ctx->bdev->bd_disk);
>> -
>> -    mutex_unlock(&init_mutex);
>> -
>> -    return ret;
>> -}
>> -
>>   static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char 
>> *buf,
>>                    size_t nbytes, loff_t off)
>>   {
>> @@ -861,7 +838,17 @@ static ssize_t iolatency_set_limit(struct 
>> kernfs_open_file *of, char *buf,
>>       blkg_conf_init(&ctx, buf);
>> -    ret = blk_iolatency_try_init(&ctx);
>> +    ret = blkg_conf_open_bdev(&ctx);
>> +    if (ret)
>> +        goto out;
>> +
>> +    /*
>> +     * blk_iolatency_init() may fail after rq_qos_add() succeeds 
>> which can
>> +     * confuse iolat_rq_qos() test. Make the test and init atomic.
>> +     */

The original mutex and above comments is used to avoid the problem that
blk_iolatency_init() is not atomic:

t1:			t2:
if (!iolat_rq_qos)
// not exist
  blk_iolatency_init
   rq_qos_add
   blkcg_activate_policy
   // failed
			if (!iolat_rq_qos)
			// now exist
   rq_qos_del
			...
			// continue while rq_qos is deleted

Now that this problem doesn't exist, I think it's ok just to remove this
comment.

Thanks,
Kuai

>> +    lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);
>> +    if (!iolat_rq_qos(ctx.bdev->bd_queue))
>> +        ret = blk_iolatency_init(ctx.bdev->bd_disk);
>>       if (ret)
>>           goto out;
>>
> 
> .
> 

