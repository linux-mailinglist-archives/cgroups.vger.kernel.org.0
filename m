Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107BB59BA7D
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiHVHo5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 03:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiHVHok (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 03:44:40 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24ADEA6;
        Mon, 22 Aug 2022 00:44:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MB48b1lGyz6TBgr;
        Mon, 22 Aug 2022 15:42:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgCXzrraMwNjLnbBAg--.13909S3;
        Mon, 22 Aug 2022 15:44:27 +0800 (CST)
Subject: Re: [PATCH v7 1/9] blk-throttle: fix that io throttle can only work
 for single bio
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-2-yukuai1@huaweicloud.com>
 <Yvvx+/d2+OMROUOe@slm.duckdns.org>
 <712e0f29-94ba-d3d3-ce21-cba4d6092008@huaweicloud.com>
 <Yv0qbDR+cxKeZ3nD@slm.duckdns.org>
 <83c8b253-2ebb-5af6-8ce1-6dc3b84cf182@huaweicloud.com>
 <b1791e41-4945-a0d8-8067-3841ce10fddd@huaweicloud.com>
 <YwMvgN0YxNvkC1gm@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8792d3f5-c07f-e080-ae29-b13d0f583f82@huaweicloud.com>
Date:   Mon, 22 Aug 2022 15:44:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YwMvgN0YxNvkC1gm@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCXzrraMwNjLnbBAg--.13909S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr45KF4UKrWfCr45Ww13CFg_yoW8KFWkpF
        4I9wnYkrsrtrs29a9IqFsF9FyfJ3ykGFW5CFy5J3yfAFsrKryqyryxX34FvFnI9rZ8Ga9F
        vr48K3s3Gw45ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

ÔÚ 2022/08/22 15:25, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Mon, Aug 22, 2022 at 11:06:44AM +0800, Yu Kuai wrote:
>> While implementing the new method, I found that there seems to be a
>> misunderstanding here, the code seems to try to add flag to split bio
>> so that it won't be throttled again for bps limit, however:
>>
>> 1) for blk throttle, split bio is issued directly and will never be
>> throttled again, while orignal bio will go through throttle path again.
>> 2) if cloned bio is directed to a new disk, the flag is cleared anyway.
> 
> Doesn't that make the current code correct then? But you were seeing
> incorrect behaviors, right?

According to the commit message in commit 111be8839817 ("block-throttle:
avoid double charge"):

If the bio is cloned/split, we copy the flag to new bio too to avoid a
double charge.

Which make me think the split bio will be resubmitted, and after
implementing the new solution, I found that test result is not as
expected. After spending sometime figuring out what is wrong, I found
that split bio will be dispatched directly from caller, while orignal
bio will be resubmitted.

I guess commit 111be8839817 made a mistake, however, there should be
no problem because orignal bio is flagged already, and it's handled
correctly.

Anyway, I removed the code in __bio_clone() and check flag in
__bio_split_to_limits in my patch:
--- a/block/bio.c
+++ b/block/bio.c
@@ -760,8 +760,6 @@ EXPORT_SYMBOL(bio_put);
  static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
  {
         bio_set_flag(bio, BIO_CLONED);
-       if (bio_flagged(bio_src, BIO_THROTTLED))
-               bio_set_flag(bio, BIO_THROTTLED);
         bio->bi_ioprio = bio_src->bi_ioprio;
         bio->bi_iter = bio_src->bi_iter;

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ff04e9290715..10330bb038ca 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -358,6 +358,13 @@ struct bio *__bio_split_to_limits(struct bio *bio, 
struct queue_limits *lim,
                 blkcg_bio_issue_init(split);
                 bio_chain(split, bio);
                 trace_block_split(split, bio->bi_iter.bi_sector);
+
+               /*
+                * original bio will be resubmited and throttled again, 
clear
+                * the iops flag so that it can be count again for iops 
limit.
+                */
+               if (bio_flagged(bio, BIO_IOPS_THROTTLED))
+                       bio_clear_flag(bio, BIO_IOPS_THROTTLED);
                 submit_bio_noacct(bio);
                 return split;
         }


> 
> Thanks.
> 

