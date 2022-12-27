Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1A656776
	for <lists+cgroups@lfdr.de>; Tue, 27 Dec 2022 07:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiL0GJt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Dec 2022 01:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiL0GJs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Dec 2022 01:09:48 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C61029;
        Mon, 26 Dec 2022 22:09:46 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nh44M3nnSz4f3mWF;
        Tue, 27 Dec 2022 14:09:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgCHpzEkjKpjE0o7Ag--.25751S3;
        Tue, 27 Dec 2022 14:09:42 +0800 (CST)
Subject: Re: [PATCH RFC] block, bfq: switch 'bfqg->ref' to use atomic refcount
 apis
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221227031541.2595647-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ba5e74a6-b3de-844d-16b8-84eb429c7058@huaweicloud.com>
Date:   Tue, 27 Dec 2022 14:09:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221227031541.2595647-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHpzEkjKpjE0o7Ag--.25751S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rKryxGFWUKF47Cry7GFg_yoW8urW7pF
        n0gFy5Jw1rJr18WF17J3WUXry8Jw4rCry8K3y8Xwnayry3Xwnag3Z0yrWrJ34IvF93Arsr
        ZF1YgayDCr1IvFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jan!

ÔÚ 2022/12/27 11:15, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The updating of 'bfqg->ref' should be protected by 'bfqd->lock', however,
> during code review, we found that bfq_pd_free() update 'bfqg->ref'
> without holding the lock, which is problematic:
> 
> 1) bfq_pd_free() triggered by removing cgroup is called asynchronously;
> 2) bfqq will grab bfqg reference, and exit bfqq will drop the reference,
> which can concurrenty with 1).
> 
> Unfortunately, 'bfqd->lock' can't be held here because 'bfqd' might already
> be freed in bfq_pd_free(). Fix the problem by using atomic refcount apis.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/bfq-cgroup.c  | 8 +++-----
>   block/bfq-iosched.h | 2 +-
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 1b2829e99dad..aa9c4f02e3a3 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -316,14 +316,12 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
>   
>   static void bfqg_get(struct bfq_group *bfqg)
>   {
> -	bfqg->ref++;
> +	refcount_inc(&bfqg->ref);
>   }
>   
>   static void bfqg_put(struct bfq_group *bfqg)
>   {
> -	bfqg->ref--;
> -
> -	if (bfqg->ref == 0)
> +	if (refcount_dec_and_test(bfqg->ref))
Sorry that here should be '&bfqg->ref'.

Anyway, I'll wait for you, and send a new version if you think this
patch make sense.

Thanks,
Kuai

>   		kfree(bfqg);
>   }
>   
> @@ -530,7 +528,7 @@ static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, struct request_queue *q,
>   	}
>   
>   	/* see comments in bfq_bic_update_cgroup for why refcounting */
> -	bfqg_get(bfqg);
> +	refcount_set(&bfqg->ref, 1);
>   	return &bfqg->pd;
>   }
>   
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 41aa151ccc22..466e4865ace6 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -928,7 +928,7 @@ struct bfq_group {
>   	char blkg_path[128];
>   
>   	/* reference counter (see comments in bfq_bic_update_cgroup) */
> -	int ref;
> +	refcount_t ref;
>   	/* Is bfq_group still online? */
>   	bool online;
>   
> 

