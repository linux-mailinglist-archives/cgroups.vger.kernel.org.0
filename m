Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F187779C6
	for <lists+cgroups@lfdr.de>; Thu, 10 Aug 2023 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHJNoK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Aug 2023 09:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjHJNoK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Aug 2023 09:44:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A01DE54;
        Thu, 10 Aug 2023 06:44:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RM7SH5XdRz4f3l84;
        Thu, 10 Aug 2023 21:43:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6me6dRkZCCLAQ--.21920S3;
        Thu, 10 Aug 2023 21:44:00 +0800 (CST)
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
To:     Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6637e6cd-20aa-110a-40ae-53ecd6eb4184@huaweicloud.com>
Date:   Thu, 10 Aug 2023 21:43:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6me6dRkZCCLAQ--.21920S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW7tFWrZFyDJw4rtF45GFg_yoW5GrW5p3
        93Wr4av3yUGrs7WF1kKws7ur15K3y8Kry7GF43AryrJr129rnIgF18ZF1F9FWxZrZ5Aan5
        KF1UArykKry5GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2023/08/10 11:51, Li Lingfeng Ð´µÀ:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
> a mutex named "init_mutex" in blk_iolatency_try_init for the race
> condition of initializing RQ_QOS_LATENCY.
> Now a new lock has been add to struct request_queue by commit a13bd91be223
> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
> held in blkg_conf_open_bdev before calling blk_iolatency_init.
> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
> remove it.
> 
> Since init_mutex has been removed, blk_iolatency_try_init can be
> open-coded back to iolatency_set_limit() like ioc_qos_write().
> 
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks,
Kuai
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>    v1->v2: open-code blk_iolatency_try_init()
>    v2->v3: add lockdep check
>   block/blk-iolatency.c | 35 +++++++++++------------------------
>   1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index fd5fec989e39..c16aef4be036 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -824,29 +824,6 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
>   	}
>   }
>   
> -static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
> -{
> -	static DEFINE_MUTEX(init_mutex);
> -	int ret;
> -
> -	ret = blkg_conf_open_bdev(ctx);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
> -	 * confuse iolat_rq_qos() test. Make the test and init atomic.
> -	 */
> -	mutex_lock(&init_mutex);
> -
> -	if (!iolat_rq_qos(ctx->bdev->bd_queue))
> -		ret = blk_iolatency_init(ctx->bdev->bd_disk);
> -
> -	mutex_unlock(&init_mutex);
> -
> -	return ret;
> -}
> -
>   static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
>   			     size_t nbytes, loff_t off)
>   {
> @@ -861,7 +838,17 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
>   
>   	blkg_conf_init(&ctx, buf);
>   
> -	ret = blk_iolatency_try_init(&ctx);
> +	ret = blkg_conf_open_bdev(&ctx);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
> +	 * confuse iolat_rq_qos() test. Make the test and init atomic.
> +	 */
> +	lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);
> +	if (!iolat_rq_qos(ctx.bdev->bd_queue))
> +		ret = blk_iolatency_init(ctx.bdev->bd_disk);
>   	if (ret)
>   		goto out;
>   
> 

