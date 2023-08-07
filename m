Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDBD771A1E
	for <lists+cgroups@lfdr.de>; Mon,  7 Aug 2023 08:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjHGGSv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Aug 2023 02:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjHGGSv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Aug 2023 02:18:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A780F9;
        Sun,  6 Aug 2023 23:18:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RK5jw3Kdnz4f3m75;
        Mon,  7 Aug 2023 14:18:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6nDjNBkPbGEAA--.29196S3;
        Mon, 07 Aug 2023 14:18:45 +0800 (CST)
Subject: Re: [PATCH -next] block: remove init_mutex in blk_iolatency_try_init
To:     Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230804113659.3816877-1-lilingfeng@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7436e5af-f32c-6eea-7b25-d416c414f3c5@huaweicloud.com>
Date:   Mon, 7 Aug 2023 14:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230804113659.3816877-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6nDjNBkPbGEAA--.29196S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW5AF4DAFyxXF45ur1UGFg_yoW8WF1xpa
        y0gFnFy3yjgrs7WF48Kw1fur10g3ykKFy7GF4rCFy5GrnF9r1agF1ruF1FgrW8urZ3Aan0
        qF4UXryvk345G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUOyCJDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2023/08/04 19:36, Li Lingfeng Ð´µÀ:
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

LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   block/blk-iolatency.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index fd5fec989e39..8fbd6bc96acb 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -826,7 +826,6 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
>   
>   static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
>   {
> -	static DEFINE_MUTEX(init_mutex);
>   	int ret;
>   
>   	ret = blkg_conf_open_bdev(ctx);
> @@ -837,13 +836,9 @@ static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
>   	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
>   	 * confuse iolat_rq_qos() test. Make the test and init atomic.
>   	 */
> -	mutex_lock(&init_mutex);
> -
>   	if (!iolat_rq_qos(ctx->bdev->bd_queue))
>   		ret = blk_iolatency_init(ctx->bdev->bd_disk);
>   
> -	mutex_unlock(&init_mutex);
> -
>   	return ret;
>   }
>   
> 

