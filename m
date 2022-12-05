Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386666425D6
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 10:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiLEJcZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 04:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiLEJcX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 04:32:23 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEBE15800;
        Mon,  5 Dec 2022 01:32:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NQdcJ45NCz4f3p0b;
        Mon,  5 Dec 2022 17:32:16 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgAXwa+huo1jtoZiBg--.18919S3;
        Mon, 05 Dec 2022 17:32:19 +0800 (CST)
Subject: Re: [PATCH -next v2 8/9] block: fix null-pointer dereference in
 ioc_pd_init
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-9-linan122@huawei.com>
 <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
 <9ca2b7ab-7fd3-a9a3-12a6-021a78886b54@huaweicloud.com>
 <Y4h94m8QMPtS4xJV@slm.duckdns.org>
 <431dcb3f-4572-7fd0-9e5d-90b6c34d577c@huaweicloud.com>
 <Y4iCbuALBBGLODWI@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <96487803-12cc-a694-0099-784106596fd1@huaweicloud.com>
Date:   Mon, 5 Dec 2022 17:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4iCbuALBBGLODWI@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAXwa+huo1jtoZiBg--.18919S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17Ww4rJr4fJFyfJF13Arb_yoW5tFWrpa
        yagrnIy3yvgF4Dua1UJa18X3y2ka10krW3JrWrCrWayr429r1I9F1vyrZ0kFyfZF4DJr4Y
        qr1Fq398CF45Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun!

While reviewing rq_qos code, I found that there are some other possible
defects:

1) queue_lock is held to protect rq_qos_add() and rq_qos_del(), whlie
it's not held to protect rq_qos_exit(), which is absolutely not safe
because they can be called concurrently by configuring iocost and
removing device.
I'm thinking about holding the lock to fetch the list and reset
q->rq_qos first:

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 88f0fe7dcf54..271ad65eebd9 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -288,9 +288,15 @@ void rq_qos_wait(struct rq_wait *rqw, void 
*private_data,

  void rq_qos_exit(struct request_queue *q)
  {
-       while (q->rq_qos) {
-               struct rq_qos *rqos = q->rq_qos;
-               q->rq_qos = rqos->next;
+       struct rq_qos *rqos;
+
+       spin_lock_irq(&q->queue_lock);
+       rqos = q->rq_qos;
+       q->rq_qos = NULL;
+       spin_unlock_irq(&q->queue_lock);
+
+       while (rqos) {
                 rqos->ops->exit(rqos);
+               rqos = rqos->next;
         }
  }

2) rq_qos_add() can still succeed after rq_qos_exit() is done, which
will cause memory leak. Hence a checking is required beforing adding
to q->rq_qos. I'm thinking about flag QUEUE_FLAG_DYING first, but the
flag will not set if disk state is not marked GD_OWNS_QUEUE. Since
blk_unregister_queue() is called before rq_qos_exit(), use the queue
flag QUEUE_FLAG_REGISTERED should be OK.

For the current problem that device can be removed while initializing
, I'm thinking about some possible solutions:

Since bfq is initialized in elevator initialization, and others are
in queue initialization, such problem is only possible in iocost, hence
it make sense to fix it in iocost:

1) use open mutex to prevet concurrency, however, this will cause
that configuring iocost will block some other operations that is relied
on open_mutex.

@@ -2889,7 +2889,15 @@ static int blk_iocost_init(struct gendisk *disk)
         if (ret)
                 goto err_free_ioc;

+       mutex_lock(&disk->open_mutex);
+       if (!disk_live(disk)) {
+               mutex_unlock(&disk->open_mutex);
+               ret = -ENODEV;
+               goto err_del_qos;
+       }
+
         ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
+       mutex_unlock(&disk->open_mutex);
         if (ret)
                 goto err_del_qos;

2) like 1), the difference is that define a new mutex just in iocst.

3) Or is it better to fix it in the higher level? For example:
add a new restriction that blkcg_deactivate_policy() should be called
with blkcg_activate_policy() in pairs, and blkcg_deactivate_policy()
will wait for blkcg_activate_policy() to finish. Something like:

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ef4fef1af909..6266f702157f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1410,7 +1410,7 @@ int blkcg_activate_policy(struct request_queue *q,
         struct blkcg_gq *blkg, *pinned_blkg = NULL;
         int ret;

-       if (blkcg_policy_enabled(q, pol))
+       if (WARN_ON_ONCE(blkcg_policy_enabled(q, pol)))
                 return 0;

         if (queue_is_mq(q))
@@ -1477,6 +1477,8 @@ int blkcg_activate_policy(struct request_queue *q,
                 blkg_put(pinned_blkg);
         if (pd_prealloc)
                 pol->pd_free_fn(pd_prealloc);
+       if (!ret)
+               wake_up(q->policy_waitq);
         return ret;

  enomem:
@@ -1512,7 +1514,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
         struct blkcg_gq *blkg;

         if (!blkcg_policy_enabled(q, pol))
-               return;
+               wait_event(q->policy_waitq, blkcg_policy_enabled(q, pol));
    wait_event(q->xxx, blkcg_policy_enabled(q, pol));

