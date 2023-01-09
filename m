Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83D8661C04
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 02:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjAIBiT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Jan 2023 20:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjAIBiS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Jan 2023 20:38:18 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A4BE39;
        Sun,  8 Jan 2023 17:38:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NqxR15n7qz4f49JP;
        Mon,  9 Jan 2023 09:38:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLP_b7tjGBp5BQ--.9981S3;
        Mon, 09 Jan 2023 09:38:08 +0800 (CST)
Subject: Re: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect
 rq_qos apis
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-4-yukuai1@huaweicloud.com>
 <Y7XyIzGptuqO8EAt@slm.duckdns.org> <Y7YZnM/nqb0gxOei@slm.duckdns.org>
 <df2f7a60-467f-08ce-2a3e-1dc7853424aa@huaweicloud.com>
 <Y7cYKdOwSlfHtj7t@slm.duckdns.org>
 <ef55a0f1-d3c2-3979-963e-2fa10ba3c2ff@huaweicloud.com>
 <Y7hnH9GT6D469Vuu@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <31e57528-39a5-84ed-8ea0-5c61bab00541@huaweicloud.com>
Date:   Mon, 9 Jan 2023 09:38:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7hnH9GT6D469Vuu@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLP_b7tjGBp5BQ--.9981S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWkGw1xWryUXF17Wr1Utrb_yoW5Zr4xpr
        WDCa92yF4DKr15ZasFvF4fC3WUtw4vg3y5Jrn5GF1Iy3sF9rn7Xrs2qF4j9FWvywsFka1I
        vrWUta15C3sxuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/07 2:23, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Fri, Jan 06, 2023 at 09:33:26AM +0800, Yu Kuai wrote:
>>> wbt's lazy init is tied to one of the block device sysfs files, right? So,
>>> it *should* already be protected against device removal.
>>
>> That seems not true, I don't think q->sysfs_lock can protect that,
>> consider that queue_wb_lat_store() doesn't check if del_gendisk() is
>> called or not:
>>
>> t1: wbt lazy init		t2: remove device
>> queue_attr_store
>> 				del_gendisk
>> 				blk_unregister_queue
>> 				 mutex_lock(&q->sysfs_lock)
>> 			         ...
>> 				 mutex_unlock(&q->sysfs_lock);
>> 				rq_qos_exit
>>   mutex_lock(&q->sysfs_lock);
>>    queue_wb_lat_store
>>    wbt_init
>>     rq_qos_add
>>   mutex_unlock(&q->sysfs_lock);
> 
> So, it's not sysfs_lock but sysfs file deletion. When a kernfs, which backs
> sysfs, file is removed, it disables future operations and drains all
> inflight ones before returning, so you remove the interface files before
> cleaning up the object that it interacts with, you don't have to worry about
> racing against file operations as none can be in flight at that point.

Ok, thanks for explanation, I'll look into this and try to find out how
this works.

> 
>> I tried to comfirm that by adding following delay:
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 93d9e9c9a6ea..101c33cb0a2b 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/blktrace_api.h>
>>   #include <linux/blk-mq.h>
>>   #include <linux/debugfs.h>
>> +#include <linux/delay.h>
>>
>>   #include "blk.h"
>>   #include "blk-mq.h"
>> @@ -734,6 +735,8 @@ queue_attr_store(struct kobject *kobj, struct attribute
>> *attr,
>>          if (!entry->store)
>>                  return -EIO;
>>
>> +       msleep(10000);
>> +
>>          mutex_lock(&q->sysfs_lock);
>>          res = entry->store(q, page, length);
>>          mutex_unlock(&q->sysfs_lock);
>>
>> And then do the following test:
>>
>> 1) echo 10000 > /sys/block/sdb/queue/wbt_lat_usec &
>> 2) echo 1 > /sys/block/sda/device/delete
>>
>> Then, following bug is triggered:
>>
>> [   51.923642] BUG: unable to handle page fault for address:
>> ffffffffffffffed
>> [   51.924294] #PF: supervisor read access in kernel mode
>> [   51.924773] #PF: error_code(0x0000) - not-present page
>> [   51.925252] PGD 1820b067 P4D 1820b067 PUD 1820d067 PMD 0
>> [   51.925754] Oops: 0000 [#1] PREEMPT SMP
>> [   51.926123] CPU: 1 PID: 539 Comm: bash Tainted: G        W
>> 6.2.0-rc1-next-202212267
>> [   51.927124] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> ?-20190727_073836-b4
>> [   51.928334] RIP: 0010:__rq_qos_issue+0x30/0x60
> 
> This indicates that we aren't getting the destruction order right. It could
> be that there are other reasons why the ordering is like this and we might
> have to synchronize separately.
> 
> Sorry that I've been asking you to go round and round but block device
> add/remove paths have always been really tricky and we wanna avoid adding
> more complications if at all possible. Can you see why the device is being
> destroyed before the queue attr is removed?

Of course, I'll glad to help, I'll let you know if I have any progress.

Thanks,
Kuai

