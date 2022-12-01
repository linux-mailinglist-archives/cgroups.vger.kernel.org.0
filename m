Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4663E708
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 02:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLABUB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 20:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLABUA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 20:20:00 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092890750;
        Wed, 30 Nov 2022 17:19:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NMyt13bVGz4f3v5L;
        Thu,  1 Dec 2022 09:19:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdY6AYhj1APHBQ--.30576S3;
        Thu, 01 Dec 2022 09:19:56 +0800 (CST)
Subject: Re: [PATCH -next v2 9/9] blk-iocost: fix walk_list corruption
To:     Tejun Heo <tj@kernel.org>, Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-10-linan122@huawei.com>
 <Y4fEKZy4rTE5rG/5@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c028dd77-cabf-edd6-c893-8ee24762ac8c@huaweicloud.com>
Date:   Thu, 1 Dec 2022 09:19:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4fEKZy4rTE5rG/5@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdY6AYhj1APHBQ--.30576S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryruF43Cr4DuFyktw13urg_yoW5Jw1DpF
        WfKFZ0krWjqr12k3W0q3ZIqF1Sya10qr18JrWfWr1Fya4akw13J3WvkF48GFyDZrWxJrWa
        qF10g3s8JrWjyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/12/01 4:59, Tejun Heo Ð´µÀ:
> On Wed, Nov 30, 2022 at 09:21:56PM +0800, Li Nan wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our test report a problem:
>>
>> ------------[ cut here ]------------
>> list_del corruption. next->prev should be ffff888127e0c4b0, but was ffff888127e090b0
>> WARNING: CPU: 2 PID: 3117789 at lib/list_debug.c:62 __list_del_entry_valid+0x119/0x130
>> RIP: 0010:__list_del_entry_valid+0x119/0x130
>> RIP: 0010:__list_del_entry_valid+0x119/0x130
>> Call Trace:
>>   <IRQ>
>>   iocg_flush_stat.isra.0+0x11e/0x230
>>   ? ioc_rqos_done+0x230/0x230
>>   ? ioc_now+0x14f/0x180
>>   ioc_timer_fn+0x569/0x1640
>>
>> We haven't reporduced it yet, but we think this is due to parent iocg is
>> freed before child iocg, and then in ioc_timer_fn, walk_list is
>> corrupted.
>>
>> 1) Remove child cgroup can concurrent with remove parent cgroup, and
>> ioc_pd_free for parent iocg can be called before child iocg. This can be
>> fixed by moving the handle of walk_list to ioc_pd_offline, since that
>> offline from child is ensured to be called before parent.
> 
> Which you already did in a previous patch, right?

yes, this is already did in patch 7.

> 
>> 2) ioc_pd_free can be triggered from both removing device and removing
>> cgroup, this patch fix the problem by deleting timer before deactivating
>> policy, so that free parent iocg first in this case won't matter.
> 
> Okay, so, yeah, css's pin parents but blkg's don't. I think the right thing
> to do here is making sure that a child blkg pins its parent (and eventually
> ioc).

Ok, I can try to do that.

> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   block/blk-iocost.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 710cf63a1643..d2b873908f88 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -2813,13 +2813,14 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
>>   {
>>   	struct ioc *ioc = rqos_to_ioc(rqos);
>>   
>> +	del_timer_sync(&ioc->timer);
>> +
>>   	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
>>   
>>   	spin_lock_irq(&ioc->lock);
>>   	ioc->running = IOC_STOP;
>>   	spin_unlock_irq(&ioc->lock);
>>   
>> -	del_timer_sync(&ioc->timer);
> 
> I don't about this workaround. Let's fix properly?

Ok, and by the way, is there any reason to delete timer after
deactivate policy? This seems a litter wreid to me.

Thanks,
Kuai
> 

