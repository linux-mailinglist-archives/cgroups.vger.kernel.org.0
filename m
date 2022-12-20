Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406EE651D10
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 10:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiLTJTU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 04:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiLTJTT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 04:19:19 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5179FE3;
        Tue, 20 Dec 2022 01:19:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NbrcH5FcQz4f3pG0;
        Tue, 20 Dec 2022 17:19:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7MQfqFjEZfHAA--.28932S3;
        Tue, 20 Dec 2022 17:19:14 +0800 (CST)
Subject: Re: [PATCH -next 0/4] blk-cgroup: synchronize del_gendisk() with
 configuring cgroup policy
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
 <Y6DP3aOSad8+D1yY@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e01daffe-a3e3-8bf2-40ee-192a9e70d911@huaweicloud.com>
Date:   Tue, 20 Dec 2022 17:19:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y6DP3aOSad8+D1yY@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7MQfqFjEZfHAA--.28932S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWUAF15Aw4UZw17ur1UGFg_yoW8uFW8pF
        WagrnxZ3yDtrZ7ZrnIgr1xAFySgw4rW345tFW5Gr9xAr4j9rn0va1xAFWxuF4xXrsrGr4S
        qFW8J398Cr1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/12/20 4:55, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Sat, Dec 17, 2022 at 11:09:04AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> iocost is initialized when it's configured the first time, and iocost
>> initializing can race with del_gendisk(), which will cause null pointer
>> dereference:
>>
>> t1				t2
>> ioc_qos_write
>>   blk_iocost_init
>>    rq_qos_add
>>    				del_gendisk
>>    				 rq_qos_exit
>>    				 //iocost is removed from q->roqs
>>    blkcg_activate_policy
>>     pd_init_fn
>>      ioc_pd_init
>>       ioc = q_to_ioc(blkg->q)
>>       //can't find iocost and return null
>>
>> And iolatency is about to switch to the same lazy initialization.
>>
>> This patchset fix this problem by synchronize rq_qos_add() and
>> blkcg_activate_policy() with rq_qos_exit().
> 
> So, the patchset seems a bit overly complicated to me. What do you think
> about the following?
> 
> * These init/exit paths are super cold path, just protecting them with a
>    global mutex is probably enough. If we encounter a scalability problem,
>    it's easy to fix down the line.
> 
> * If we're synchronizing this with a mutex anyway, no need to grab the
>    queue_lock, right? rq_qos_add/del/exit() can all just hold the mutex.
> 
> * And we can keep the state tracking within rq_qos. When rq_qos_exit() is
>    called, mark it so that future adds will fail - be that a special ->next
>    value a queue flag or whatever.

Yes, that sounds good. BTW, queue_lock is also used to protect
pd_alloc_fn/pd_init_fn£¬and we found that blkcg_activate_policy() is
problematic:

blkcg_activate_policy
  spin_lock_irq(&q->queue_lock);
  list_for_each_entry_reverse(blkg, &q->blkg_list
   pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN,...) -> failed

   spin_unlock_irq(&q->queue_lock);
   // release queue_lock here is problematic, this will cause
pd_offline_fn called without pd_init_fn.
   pd_alloc_fn(__GFP_NOWARN,...)

If we are using a mutex to protect rq_qos ops, it seems the right thing
to do do also using the mutex to protect blkcg_policy ops, and this
problem can be fixed because mutex can be held to alloc memroy with
GFP_KERNEL. What do you think?

Thanks,
Kuai
> 
> Thanks.
> 

