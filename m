Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF8661BE3
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 02:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjAIBcy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Jan 2023 20:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjAIBcx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Jan 2023 20:32:53 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7AB86E;
        Sun,  8 Jan 2023 17:32:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NqxJs70Wzz4f3nTc;
        Mon,  9 Jan 2023 09:32:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbC+brtjXdp4BQ--.42807S3;
        Mon, 09 Jan 2023 09:32:48 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
 <Y7iCId3pnEnLqY8G@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
Date:   Mon, 9 Jan 2023 09:32:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7iCId3pnEnLqY8G@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbC+brtjXdp4BQ--.42807S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrCF4xXw1DCFy8tr4fZrb_yoW5Ww1rpF
        WfK3W5urs2kr97KFnrK3W8WFyFvrZ8JFW5t393Wr9Iyr1Dur1IkrW7trZ8uFyrXFs3CF4S
        vr4rAry8AF1DAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/01/07 4:18, Tejun Heo 写道:
> On Fri, Jan 06, 2023 at 09:08:45AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/01/06 2:32, Tejun Heo 写道:
>>> On Thu, Jan 05, 2023 at 09:14:07AM +0800, Yu Kuai wrote:
>>>> 1) is related to blkg, while 2) is not, hence refcnting from blkg can't
>>>> fix the problem. refcnting from blkcg_policy_data should be ok, but I
>>>> see that bfq already has the similar refcnting, while other policy
>>>> doesn't require such refcnting.
>>>
>>> Hmm... taking a step back, wouldn't this be solved by moving the first part
>>> of ioc_pd_free() to pd_offline_fn()? The ordering is strictly defined there,
>>> right?
>>>
>>
>> Moving first part to pd_offline_fn() has some requirements, like what I
>> did in the other thread:
>>
>> iocg can be activated again after pd_offline_fn(), which is possible
>> because bio can be dispatched when cgroup is removed. I tried to avoid
>> that by:
>>
>> 1) dispatch all throttled bio io ioc_pd_offline()
>> 2) don't throttle bio after ioc_pd_offline()
>>
>> However, you already disagreed with that. 😔
> 
> Okay, I was completely wrong while I was replying to your original patch.
> Should have looked at the code closer, my apologies.
> 
> What I missed is that pd_offline doesn't happen when the cgroup goes
> offline. Please take a look at the following two commits:
> 
>   59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
>   d866dbf61787 ("blkcg: rename blkcg->cgwb_refcnt to ->online_pin and always use it")
> 

These two commits are applied for three years, I don't check the details
yet but they seem can't guarantee that no io will be handled by
rq_qos_throttle() after pd_offline_fn(), because I just reproduced this
in another problem:

f02be9002c48 ("block, bfq: fix null pointer dereference in bfq_bio_bfqg()")

User thread can issue async io, and io can be throttled by
blk-throttle(not writeback), then user thread can exit and cgroup can be
removed before such io is dispatched to rq_qos_throttle.

> After the above two commits, ->pd_offline_fn() is called only after all
> possible writebacks are complete, so it shouldn't allow mass escapes to
> root. With writebacks out of the picture, it might be that there can be no
> further IOs once ->pd_offline_fn() is called too as there can be no tasks
> left in it and no dirty pages, but best to confirm that.
> 
> So, yeah, the original approach you took should work although I'm not sure
> the patches that you added to make offline blkg to bypass are necessary
> (that also contributed to my assumption that there will be more IOs on those
> blkg's). Have you seen more IOs coming down the pipeline after offline? If
> so, can you dump some backtraces and see where they're coming from?

Currently I'm sure such IOs can come from blk-throttle, and I'm not sure
yet but I also suspect io_uring can do this.

Thanks,
Kuai

