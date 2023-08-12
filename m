Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132AA779DFE
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHLHxs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Aug 2023 03:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHLHxr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Aug 2023 03:53:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7A51BE6;
        Sat, 12 Aug 2023 00:53:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RNCbG0ZyFz4f3pC2;
        Sat, 12 Aug 2023 15:53:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qiIOtdkIy0XAg--.34377S3;
        Sat, 12 Aug 2023 15:53:46 +0800 (CST)
Subject: Re: [PATCH 1/1] blk-throttle: fix throttle configuring not effective
To:     zhuxiaohui <zhuxiaohui400@gmail.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, zhuxiaohui <zhuxiaohui.400@bytedance.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230812072116.42321-1-zhuxiaohui.400@bytedance.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5ba76f5e-9b02-13c8-c2a3-b15fe016261d@huaweicloud.com>
Date:   Sat, 12 Aug 2023 15:53:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230812072116.42321-1-zhuxiaohui.400@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qiIOtdkIy0XAg--.34377S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4rGrW5tw4kCw1Duw1kuFg_yoW5XFW3pF
        yjkrs5Cw4qqFnxG3ZxZ3ZxAay5Xw48JrW8JrZFyry5AF13C3sxGFyUJr1Fkay0kF97Wr4k
        tw1jqr9rGa17uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/08/12 15:21, zhuxiaohui Ð´µÀ:
> when updating block throttle limit with persistence and stable io
> pressure, especially a relative high io pressure, fio test e.g.,
> there may never be a change to start a new slice, and carryover_ios &
> carryover_bytes will not be cleared.
> 
> As a result, when reconfiguring block throttle limit, we can notice that
> the actual iops and throughput is a random value far away from what is
> set
> 
> So we need to update carryover value when dispatching bio

I don't understand, not clear carryover_bytes/ios is what expected, and
how can they affect actual bandwith/iops.

Can you give a example how you tested and why current calculation is not
correct?

Thanks,
Kuai

> 
> Signed-off-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>
> ---
>   block/blk-throttle.c | 26 ++++++++++++++++++++++++++
>   block/blk-throttle.h |  4 ++--
>   2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7397ff199d66..13c9d87a7201 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -821,6 +821,30 @@ static void tg_update_carryover(struct throtl_grp *tg)
>   		   tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
>   }
>   
> +static void tg_charge_carryover(struct throtl_grp *tg, struct bio *bio)
> +{
> +	bool rw = bio_data_dir(bio);
> +
> +	if (unlikely(tg->carryover_bytes[rw])) {
> +		unsigned int bio_size = throtl_bio_data_size(bio);
> +		unsigned int carryout_size = abs(tg->carryover_bytes[rw]);
> +
> +		carryout_size = min(carryout_size, bio_size);
> +
> +		if (tg->carryover_bytes[rw] < 0)
> +			tg->carryover_bytes[rw] += carryout_size;
> +		else
> +			tg->carryover_bytes[rw] -= carryout_size;
> +	}
> +
> +	if (unlikely(tg->carryover_ios[rw])) {
> +		if (tg->carryover_ios[rw] < 0)
> +			tg->carryover_ios[rw] += 1;
> +		else
> +			tg->carryover_ios[rw] -= 1;
> +	}
> +}
> +
>   static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
>   				 u32 iops_limit)
>   {
> @@ -965,6 +989,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>   
>   	tg->io_disp[rw]++;
>   	tg->last_io_disp[rw]++;
> +
> +	tg_charge_carryover(tg, bio);
>   }
>   
>   /**
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index d1ccbfe9f797..8f1642becb23 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -127,8 +127,8 @@ struct throtl_grp {
>   	 * bytes/ios are waited already in previous configuration, and they will
>   	 * be used to calculate wait time under new configuration.
>   	 */
> -	uint64_t carryover_bytes[2];
> -	unsigned int carryover_ios[2];
> +	int64_t carryover_bytes[2];
> +	int carryover_ios[2];
>   
>   	unsigned long last_check_time;
>   
> 

