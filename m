Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4E652B98
	for <lists+cgroups@lfdr.de>; Wed, 21 Dec 2022 03:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiLUCs3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 21:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLUCs2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 21:48:28 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6475FF8;
        Tue, 20 Dec 2022 18:48:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NcHtq18mDz4f3k6H;
        Wed, 21 Dec 2022 10:48:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX9zHzc6JjgyDjAA--.18550S3;
        Wed, 21 Dec 2022 10:48:21 +0800 (CST)
Subject: Re: [PATCH -next 0/4] blk-cgroup: synchronize del_gendisk() with
 configuring cgroup policy
To:     Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
 <Y6DP3aOSad8+D1yY@slm.duckdns.org>
 <e01daffe-a3e3-8bf2-40ee-192a9e70d911@huaweicloud.com>
 <Y6HcWiJbaWjN3jlt@slm.duckdns.org>
 <c2fecf04-6e9e-25a1-f14c-47862837cc54@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ebfd3d01-9fd1-3453-6cf5-05e8540359c7@huaweicloud.com>
Date:   Wed, 21 Dec 2022 10:48:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c2fecf04-6e9e-25a1-f14c-47862837cc54@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX9zHzc6JjgyDjAA--.18550S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF43tw4DWr1kXF4fJrW3trb_yoW8ArW7pF
        9IgF93A3yqvw1v939Fkr1xZFWFgw4DW3y5Jr43W3s3Z3yqv3sYgr47ArZ5uF1fZF4kGF4Y
        va15t398Jr48Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2022/12/21 9:10, Yu Kuai 写道:
> Hi,
> 
> 在 2022/12/21 0:01, Tejun Heo 写道:
>> Hello,
>>
>> On Tue, Dec 20, 2022 at 05:19:12PM +0800, Yu Kuai wrote:
>>> Yes, that sounds good. BTW, queue_lock is also used to protect
>>> pd_alloc_fn/pd_init_fn，and we found that blkcg_activate_policy() is
>>> problematic:
>>>
>>> blkcg_activate_policy
>>>   spin_lock_irq(&q->queue_lock);
>>>   list_for_each_entry_reverse(blkg, &q->blkg_list
>>>    pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN,...) -> failed
>>>
>>>    spin_unlock_irq(&q->queue_lock);
>>>    // release queue_lock here is problematic, this will cause
>>> pd_offline_fn called without pd_init_fn.
>>>    pd_alloc_fn(__GFP_NOWARN,...)
>>
>> So, if a blkg is destroyed while a policy is being activated, right?
> Yes, remove cgroup can race with this, for bfq null pointer deference
> will be triggered in bfq_pd_offline().

BTW, We just found that pd_online_fn() is missed in
blkcg_activate_policy()... Currently this is not a problem because only
bl-throttle implement it, and blk-throttle is activated while creating
blkg.

Thanks,
Kuai
> 
>>
>>> If we are using a mutex to protect rq_qos ops, it seems the right thing
>>> to do do also using the mutex to protect blkcg_policy ops, and this
>>> problem can be fixed because mutex can be held to alloc memroy with
>>> GFP_KERNEL. What do you think?
>>
>> One worry is that switching to mutex can be more headache due to destroy
>> path synchronization. Another approach would be using a per-blkg flag to
>> track whether a blkg has been initialized.
> I think perhaps you mean per blkg_policy_data flag? per blkg flag should
> not work in this case.
> 
> Thanks,
> Kuai
>>
>> Thanks.
>>
> 
> .
> 

