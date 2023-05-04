Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB336F62DB
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 04:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEDCQz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 22:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDCQy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 22:16:54 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8285E46;
        Wed,  3 May 2023 19:16:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBcrZ6qljz4f3kkT;
        Thu,  4 May 2023 10:16:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+PFVNkbfYOIA--.38432S3;
        Thu, 04 May 2023 10:16:48 +0800 (CST)
Subject: Re: [PATCH for-6.4/block] block/rq_qos: protect rq_qos apis with a
 new lock
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, hch@lst.de,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230414084008.2085155-1-yukuai1@huaweicloud.com>
 <dde18143-b3bf-e493-c10a-5ffd2d8b772a@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <20340af6-a59f-6efd-eaa2-472276487203@huaweicloud.com>
Date:   Thu, 4 May 2023 10:16:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dde18143-b3bf-e493-c10a-5ffd2d8b772a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+PFVNkbfYOIA--.38432S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW3JFy8Kr1UWFW8GF1rZwb_yoW3Kr4xpa
        1kKrW3ArWF9r1kW3WUGw4UXry7Jr4UK3WDJr48XFyayr47Ar1jqF18Zr1qgr48Ar4kJr48
        Jr4UXrnrZr1UGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/04/23 16:15, Yu Kuai 写道:
> Hi,
> 
> 在 2023/04/14 16:40, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> commit 50e34d78815e ("block: disable the elevator int del_gendisk")
>> move rq_qos_exit() from disk_release() to del_gendisk(), this will
>> introduce some problems:
>>
>> 1) If rq_qos_add() is triggered by enabling iocost/iolatency through
>>     cgroupfs, then it can concurrent with del_gendisk(), it's not safe to
>>     write 'q->rq_qos' concurrently.
>>
>> 2) Activate cgroup policy that is relied on rq_qos will call
>>     rq_qos_add() and blkcg_activate_policy(), and if rq_qos_exit() is
>>     called in the middle, null-ptr-dereference will be triggered in
>>     blkcg_activate_policy().
>>
>> 3) blkg_conf_open_bdev() can call blkdev_get_no_open() first to find the
>>     disk, then if rq_qos_exit() from del_gendisk() is done before
>>     rq_qos_add(), then memory will be leaked.
>>
>> This patch add a new disk level mutex 'rq_qos_mutex':
>>
>> 1) The lock will protect rq_qos_exit() directly.
>>
>> 2) For wbt that doesn't relied on blk-cgroup, rq_qos_add() can only be
>>     called from disk initialization for now because wbt can't be
>>     destructed until rq_qos_exit(), so it's safe not to protect wbt for
>>     now. Hoever, in case that rq_qos dynamically destruction is supported
>>     in the furture, this patch also protect rq_qos_add() from wbt_init()
>>     directly, this is enough because blk-sysfs already synchronize
>>     writers with disk removal.
>>
>> 3) For iocost and iolatency, in order to synchronize disk removal and
>>     cgroup configuration, the lock is held after blkdev_get_no_open()
>>     from blkg_conf_open_bdev(), and is released in blkg_conf_exit().
>>     In order to fix the above memory leak, disk_live() is checked after
>>     holding the new lock.
>>
> 
> Friendly ping ...

Friendly ping ...
> 
> Thanks,
> Kuai
>> Fixes: 50e34d78815e ("block: disable the elevator int del_gendisk")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-cgroup.c     |  9 +++++++++
>>   block/blk-core.c       |  1 +
>>   block/blk-rq-qos.c     | 20 ++++++--------------
>>   block/blk-wbt.c        |  2 ++
>>   include/linux/blkdev.h |  1 +
>>   5 files changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 1c1ebeb51003..0d79d864ecb1 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -705,6 +705,13 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
>>           return -ENODEV;
>>       }
>> +    mutex_lock(&bdev->bd_queue->rq_qos_mutex);
>> +    if (!disk_live(bdev->bd_disk)) {
>> +        blkdev_put_no_open(bdev);
>> +        mutex_unlock(&bdev->bd_queue->rq_qos_mutex);
>> +        return -ENODEV;
>> +    }
>> +
>>       ctx->body = input;
>>       ctx->bdev = bdev;
>>       return 0;
>> @@ -849,6 +856,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
>>    */
>>   void blkg_conf_exit(struct blkg_conf_ctx *ctx)
>>       __releases(&ctx->bdev->bd_queue->queue_lock)
>> +    __releases(&ctx->bdev->bd_queue->rq_qos_mutex)
>>   {
>>       if (ctx->blkg) {
>>           spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
>> @@ -856,6 +864,7 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
>>       }
>>       if (ctx->bdev) {
>> +        mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
>>           blkdev_put_no_open(ctx->bdev);
>>           ctx->body = NULL;
>>           ctx->bdev = NULL;
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 269765d16cfd..fc7f902bdf5b 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -420,6 +420,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>>       mutex_init(&q->debugfs_mutex);
>>       mutex_init(&q->sysfs_lock);
>>       mutex_init(&q->sysfs_dir_lock);
>> +    mutex_init(&q->rq_qos_mutex);
>>       spin_lock_init(&q->queue_lock);
>>       init_waitqueue_head(&q->mq_freeze_wq);
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index d8cc820a365e..167be74df4ee 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -288,11 +288,13 @@ void rq_qos_wait(struct rq_wait *rqw, void 
>> *private_data,
>>   void rq_qos_exit(struct request_queue *q)
>>   {
>> +    mutex_lock(&q->rq_qos_mutex);
>>       while (q->rq_qos) {
>>           struct rq_qos *rqos = q->rq_qos;
>>           q->rq_qos = rqos->next;
>>           rqos->ops->exit(rqos);
>>       }
>> +    mutex_unlock(&q->rq_qos_mutex);
>>   }
>>   int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum 
>> rq_qos_id id,
>> @@ -300,6 +302,8 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk 
>> *disk, enum rq_qos_id id,
>>   {
>>       struct request_queue *q = disk->queue;
>> +    lockdep_assert_held(&q->rq_qos_mutex);
>> +
>>       rqos->disk = disk;
>>       rqos->id = id;
>>       rqos->ops = ops;
>> @@ -307,18 +311,13 @@ int rq_qos_add(struct rq_qos *rqos, struct 
>> gendisk *disk, enum rq_qos_id id,
>>       /*
>>        * No IO can be in-flight when adding rqos, so freeze queue, which
>>        * is fine since we only support rq_qos for blk-mq queue.
>> -     *
>> -     * Reuse ->queue_lock for protecting against other concurrent
>> -     * rq_qos adding/deleting
>>        */
>>       blk_mq_freeze_queue(q);
>> -    spin_lock_irq(&q->queue_lock);
>>       if (rq_qos_id(q, rqos->id))
>>           goto ebusy;
>>       rqos->next = q->rq_qos;
>>       q->rq_qos = rqos;
>> -    spin_unlock_irq(&q->queue_lock);
>>       blk_mq_unfreeze_queue(q);
>> @@ -330,7 +329,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk 
>> *disk, enum rq_qos_id id,
>>       return 0;
>>   ebusy:
>> -    spin_unlock_irq(&q->queue_lock);
>>       blk_mq_unfreeze_queue(q);
>>       return -EBUSY;
>>   }
>> @@ -340,21 +338,15 @@ void rq_qos_del(struct rq_qos *rqos)
>>       struct request_queue *q = rqos->disk->queue;
>>       struct rq_qos **cur;
>> -    /*
>> -     * See comment in rq_qos_add() about freezing queue & using
>> -     * ->queue_lock.
>> -     */
>> -    blk_mq_freeze_queue(q);
>> +    lockdep_assert_held(&q->rq_qos_mutex);
>> -    spin_lock_irq(&q->queue_lock);
>> +    blk_mq_freeze_queue(q);
>>       for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
>>           if (*cur == rqos) {
>>               *cur = rqos->next;
>>               break;
>>           }
>>       }
>> -    spin_unlock_irq(&q->queue_lock);
>> -
>>       blk_mq_unfreeze_queue(q);
>>       mutex_lock(&q->debugfs_mutex);
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index e49a48684532..53bf5aa6f9ad 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -942,7 +942,9 @@ int wbt_init(struct gendisk *disk)
>>       /*
>>        * Assign rwb and add the stats callback.
>>        */
>> +    mutex_lock(&q->rq_qos_mutex);
>>       ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
>> +    mutex_unlock(&q->rq_qos_mutex);
>>       if (ret)
>>           goto err_free;
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 6ede578dfbc6..17774f55743e 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -395,6 +395,7 @@ struct request_queue {
>>       struct blk_queue_stats    *stats;
>>       struct rq_qos        *rq_qos;
>> +    struct mutex        rq_qos_mutex;
>>       const struct blk_mq_ops    *mq_ops;
>>
> 
> .
> 

