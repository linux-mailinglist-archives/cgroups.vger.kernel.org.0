Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5275E602304
	for <lists+cgroups@lfdr.de>; Tue, 18 Oct 2022 06:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJREAU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Oct 2022 00:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJREAT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Oct 2022 00:00:19 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DE34A114;
        Mon, 17 Oct 2022 21:00:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ms0SY0S6tz6PmS9;
        Tue, 18 Oct 2022 11:57:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCX0DDFJE5jY80kAA--.32294S3;
        Tue, 18 Oct 2022 12:00:07 +0800 (CST)
Subject: Re: [patch v11 0/6] support concurrent sync io for bfq on a specail
 occasion
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
 <29348B39-94AE-4D76-BD2E-B759056264B6@linaro.org>
 <011d479f-644f-0013-40bf-664b62f93bec@huaweicloud.com>
 <A9D22DB6-6481-46BA-9D4C-5A828D19CB61@linaro.org>
 <bcd07062-5a3b-563e-fb2d-2fa8e4c8bba5@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <82f1e969-742d-d3c3-63ca-961c755b5c35@huaweicloud.com>
Date:   Tue, 18 Oct 2022 12:00:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bcd07062-5a3b-563e-fb2d-2fa8e4c8bba5@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX0DDFJE5jY80kAA--.32294S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fWF13Kw13CryUuFWDXFb_yoWruw4rpw
        1fJF43CryUGr1S9ry3Kw1Uta45tw48Jw1UXr45Xa18ur1qvr1jqr4xZrW0gryDZrWxGr12
        qr1UJr1xur1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Paolo

在 2022/10/11 17:36, Yu Kuai 写道:
>>>> Your patches seem ok to me now (thanks for you contribution and, 
>>>> above all, for your patience). I have only a high-level concern: 
>>>> what do you mean when you say that service guarantees are still 
>>>> preserved? What test did you run exactly? This point is very 
>>>> important to me. I'd like to see some convincing test with 
>>>> differentiated weights. In case you don't have other tools for 
>>>> executing such tests quickly, you may want to use the 
>>>> bandwidth-latency test in my simple S benchmark suite (for which I'm 
>>>> willing to help).
>>>
>>> Is there any test that you wish me to try?
>>>
>>> By the way, I think for the case that multiple groups are activaced, (
>>> specifically num_groups_with_pendind_rqs > 1), io path in bfq is the
>>> same with or without this patchset.
> 
> I just ran the test for one time, result is a liiter inconsistent, do
> you think it's in the normal fluctuation range?

I rerun the manually test for 5 times, here is the average result:

without this patchset / with this patchset:

| --------------- | ------------- | ------------ | -------------- | 
------------- | -------------- |
| cg1 weight      | 10            | 20           | 30             | 40 
          | 50             |
| cg2 weight      | 90            | 80           | 70             | 60 
          | 50             |
| cg1 bw MiB/s    | 21.4 / 21.74  | 42.72 / 46.6 | 63.82 / 61.52  | 
94.74 / 90.92 | 140 / 138.2    |
| cg2 bw MiB/s    | 197.2 / 197.4 | 182 / 181.2  | 171.2 / 173.44 | 162 
/ 156.8   | 138.6 / 137.04 |
| cg2 bw / cg1 bw | 9.22 / 9.08   | 4.26 / 3.89  | 2.68 / 2.82    | 1.71 
/ 1.72   | 0.99 / 0.99    |

> 
> test script:
> fio -filename=/dev/nullb0 -ioengine=libaio -ioscheduler=bfq -jumjobs=1 
> -iodepth=64 -direct=1 -bs=4k -rw=randread -runtime=60 -name=test
> 
> without this patchset:
> |                 |      |      |      |      |      |
> | --------------- | ---- | ---- | ---- | ---- | ---- |
> | cg1 weight      | 10   | 20   | 30   | 40   | 50   |
> | cg2 weight      | 90   | 80   | 70   | 60   | 50   |
> | cg1 bw MiB/s    | 25.8 | 51.0 | 80.1 | 90.5 | 138  |
> | cg2 bw MiB/s    | 193  | 179  | 162  | 127  | 136  |
> | cg2 bw / cg1 bw | 7.48 | 3.51 | 2.02 | 1.40 | 0.98 |
> 
> with this patchset
> |                 |      |      |      |      |      |
> | --------------- | ---- | ---- | ---- | ---- | ---- |
> | cg1 weight      | 10   | 20   | 30   | 40   | 50   |
> | cg2 weight      | 90   | 80   | 70   | 60   | 50   |
> | cg1 bw MiB/s    | 21.5 | 43.9 | 62.7 | 87.4 | 136  |
> | cg2 bw MiB/s    | 195  | 185  | 173  | 138  | 141  |
> | cg2 bw / cg1 bw | 9.07 | 4.21 | 2.75 | 1.57 | 0.96 |
>>>
>>
>> The tests cases you mentioned are ok for me (whatever tool or personal
>> code you use to run them).  Just show me your results with and without
>> your patchset applied.
>>
>> Thanks,
>> Paolo
>>
>>> Thanks,
>>> Kuai
>>>> Thanks,
>>>> Paolo
>>>>> Previous versions:
>>>>> RFC: 
>>>>> https://lore.kernel.org/all/20211127101132.486806-1-yukuai3@huawei.com/ 
>>>>>
>>>>> v1: 
>>>>> https://lore.kernel.org/all/20220305091205.4188398-1-yukuai3@huawei.com/ 
>>>>>
>>>>> v2: 
>>>>> https://lore.kernel.org/all/20220416093753.3054696-1-yukuai3@huawei.com/ 
>>>>>
>>>>> v3: 
>>>>> https://lore.kernel.org/all/20220427124722.48465-1-yukuai3@huawei.com/
>>>>> v4: 
>>>>> https://lore.kernel.org/all/20220428111907.3635820-1-yukuai3@huawei.com/ 
>>>>>
>>>>> v5: 
>>>>> https://lore.kernel.org/all/20220428120837.3737765-1-yukuai3@huawei.com/ 
>>>>>
>>>>> v6: 
>>>>> https://lore.kernel.org/all/20220523131818.2798712-1-yukuai3@huawei.com/ 
>>>>>
>>>>> v7: 
>>>>> https://lore.kernel.org/all/20220528095020.186970-1-yukuai3@huawei.com/ 
>>>>>
>>>>>
>>>>>
>>>>> Yu Kuai (6):
>>>>>   block, bfq: support to track if bfqq has pending requests
>>>>>   block, bfq: record how many queues have pending requests
>>>>>   block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
>>>>>   block, bfq: do not idle if only one group is activated
>>>>>   block, bfq: cleanup bfq_weights_tree add/remove apis
>>>>>   block, bfq: cleanup __bfq_weights_tree_remove()
>>>>>
>>>>> block/bfq-cgroup.c  | 10 +++++++
>>>>> block/bfq-iosched.c | 71 +++++++--------------------------------------
>>>>> block/bfq-iosched.h | 30 +++++++++----------
>>>>> block/bfq-wf2q.c    | 69 ++++++++++++++++++++++++++-----------------
>>>>> 4 files changed, 76 insertions(+), 104 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.31.1
>>>>>
>>>> .
>>
>> .
>>
> 
> .
> 

