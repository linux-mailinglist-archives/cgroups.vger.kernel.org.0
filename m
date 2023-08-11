Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61121778946
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjHKIxv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 04:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHKIxu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 04:53:50 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C7EE75;
        Fri, 11 Aug 2023 01:53:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMcyy1LxDz4f491F;
        Fri, 11 Aug 2023 16:53:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6kY99VkE9TKAQ--.25192S3;
        Fri, 11 Aug 2023 16:53:46 +0800 (CST)
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <6637e6cd-20aa-110a-40ae-53ecd6eb4184@huaweicloud.com>
 <d4050f7e-d491-c111-3e26-160e7d5a4208@huaweicloud.com>
 <dtobag743cbzb3rxzldu36wszqtnbayz2grpyj2cctptfybtt3@66ico6n2clrr>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <60dbff4b-d823-5dc9-ff8e-36648ddf7207@huaweicloud.com>
Date:   Fri, 11 Aug 2023 16:53:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dtobag743cbzb3rxzldu36wszqtnbayz2grpyj2cctptfybtt3@66ico6n2clrr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6kY99VkE9TKAQ--.25192S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw13Kr1fJw18ZFW5XryftFb_yoW8JrW8pa
        yxKrnrArZYgFn7Xas7GF48Z3yak3yrGrWUCrW5X34SyrZru340vF18tF4UK34fZF1fCr4I
        qr1YqFZ8Gr1rC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/08/11 16:23, Michal Koutný 写道:
> On Fri, Aug 11, 2023 at 09:44:55AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>> Now that this problem doesn't exist, I think it's ok just to remove this
>> comment.
> 
> Why doesn't the problem exist now?
> IIUC, it does but it's prevented thanks to outer synchronization via
> rq_qos_mutex. Hence the comment clarifies why is the lockdep_assert
> placed here.
> 

Yes, it'm implemented in the upper layer that rq_qos_add() and
blkcg_activate_policy() should be atmoic, and currently there is no
comments for that.

Perhaps it's better to add some comments like following in rq_qos_add()
instead?

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 167be74df4ee..8e8c597ea01b 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -302,6 +302,11 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk 
*disk, enum rq_qos_id id,
  {
         struct request_queue *q = disk->queue;

+       /*
+        * If rq_qos is used with cgroup policy, and cgroup policy can be
+        * initialized through cgroupfs, 'rq_qos_mutex' should be held
+        * untill blkcg_activate_policy() is done after this function 
return.
+        */
         lockdep_assert_held(&q->rq_qos_mutex);

         rqos->disk = disk;

> 
> Michal
> 

