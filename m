Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85C65E2B2
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 02:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjAEBxs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 20:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAEBxq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 20:53:46 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DF43A1F;
        Wed,  4 Jan 2023 17:53:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NnTyn4yxfz4f3mSC;
        Thu,  5 Jan 2023 09:53:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbCiLbZjBgh8BA--.64460S3;
        Thu, 05 Jan 2023 09:53:40 +0800 (CST)
Subject: Re: [PATCH v3 4/5] blk-iocost: fix divide by 0 error in calc_lcoefs()
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221226085859.2701195-1-yukuai1@huaweicloud.com>
 <20221226085859.2701195-5-yukuai1@huaweicloud.com>
 <Y7X1fFO4UP7QnwkC@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9b23b5a9-c730-1156-cd59-772f5559b4f7@huaweicloud.com>
Date:   Thu, 5 Jan 2023 09:53:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7X1fFO4UP7QnwkC@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbCiLbZjBgh8BA--.64460S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkZF17Jr18KrWxWw1DGFg_yoW8uw1xpr
        Wfu3W5uFnagrnrCFWIqF1IqFySvrs2qF10qw1xtwnIgry7Arn3K3Wqgw1jgrWkArWxJ3yF
        9ayIvry5uw1Yk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/05 5:54, Tejun Heo Ð´µÀ:
> On Mon, Dec 26, 2022 at 04:58:58PM +0800, Yu Kuai wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> echo max of u64 to cost.model can cause divide by 0 error.
>>
>>    # echo 8:0 rbps=18446744073709551615 > /sys/fs/cgroup/io.cost.model
>>
>>    divide error: 0000 [#1] PREEMPT SMP
>>    RIP: 0010:calc_lcoefs+0x4c/0xc0
>>    Call Trace:
>>     <TASK>
>>     ioc_refresh_params+0x2b3/0x4f0
>>     ioc_cost_model_write+0x3cb/0x4c0
>>     ? _copy_from_iter+0x6d/0x6c0
>>     ? kernfs_fop_write_iter+0xfc/0x270
>>     cgroup_file_write+0xa0/0x200
>>     kernfs_fop_write_iter+0x17d/0x270
>>     vfs_write+0x414/0x620
>>     ksys_write+0x73/0x160
>>     __x64_sys_write+0x1e/0x30
>>     do_syscall_64+0x35/0x80
>>     entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> calc_lcoefs() uses the input value of cost.model in DIV_ROUND_UP_ULL,
>> overflow would happen if bps plus IOC_PAGE_SIZE is greater than
>> ULLONG_MAX, it can cause divide by 0 error.
>>
>> Fix the problem by setting basecost
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-iocost.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index f8726e20da20..c6b39024117b 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -866,9 +866,13 @@ static void calc_lcoefs(u64 bps, u64 seqiops, u64 randiops,
>>   
>>   	*page = *seqio = *randio = 0;
>>   
>> -	if (bps)
>> -		*page = DIV64_U64_ROUND_UP(VTIME_PER_SEC,
>> -					   DIV_ROUND_UP_ULL(bps, IOC_PAGE_SIZE));
>> +	if (bps) {
>> +		if (bps >= U64_MAX - IOC_PAGE_SIZE)
>> +			*page = 1;
>> +		else
>> +			*page = DIV64_U64_ROUND_UP(VTIME_PER_SEC,
>> +					DIV_ROUND_UP_ULL(bps, IOC_PAGE_SIZE));
>> +	}
> 
> This is a nitpick but wouldn't something like the following be easier to
> understand?
> 
>          if (bps) {
>                  u64 bps_pages = DIV_ROUND_UP_ULL(bps, IOC_PAGE_SIZE);
> 
>                  if (bps_pages)
>                          *pages = DIV64_U64_ROUND_UP(VTIME_PER_SEC, bps_pages);
>                  else
>                          *pages = 1;
>          }
> 
Yes, I agree that this is better to understand. I'll send a new version.

Thanks,
Kuai

