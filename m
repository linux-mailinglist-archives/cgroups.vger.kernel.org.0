Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D869E167
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjBUNhD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 08:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUNhC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 08:37:02 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0581F23334;
        Tue, 21 Feb 2023 05:37:00 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLgLY60p7z4f3jLy;
        Tue, 21 Feb 2023 21:36:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiD2yPRjJ5HKDg--.22816S3;
        Tue, 21 Feb 2023 21:36:55 +0800 (CST)
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, paolo.valente@linaro.org,
        shinichiro.kawasaki@wdc.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230113094410.2907223-1-yukuai3@huawei.com>
 <ca9fefd4-7109-042c-3b25-9eb795141145@huaweicloud.com>
 <3e8c8567-f41d-66ae-0633-dcdbed007228@applied-asynchrony.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cb420c07-8143-2ff7-f6eb-57f9d9fda5aa@huaweicloud.com>
Date:   Tue, 21 Feb 2023 21:36:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3e8c8567-f41d-66ae-0633-dcdbed007228@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiD2yPRjJ5HKDg--.22816S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15ZrWxZw4UXFWUtFWDurg_yoW8CFy8pF
        s2gF4YgryUJFykWr1Ut3WjqFyrtr4rJ34DKryjq3WxZry3Jr1IgF1j9rs09ryvqrWrGw47
        ury5C3y3Zr1jg37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/02/21 18:19, Holger Hoffstätte 写道:
> On 2023-02-21 08:04, Yu Kuai wrote:
>> Hi, Jens
>>
>> 在 2023/01/13 17:44, Yu Kuai 写道:
>>> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 
>>> 'bfqq->bic'"),
>>> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
>>> bic->bfqq will be freed first, and bic_set_bfqq() is called with the 
>>> freed
>>> bic->bfqq.
>>>
>>> Fix the problem by always freeing bfqq after bic_set_bfqq().
>>>
>>> Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
>>> Reported-and-tested-by: Shinichiro Kawasaki 
>>> <shinichiro.kawasaki@wdc.com>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/bfq-cgroup.c  | 2 +-
>>>   block/bfq-iosched.c | 4 +++-
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>>> index a6e8da5f5cfd..feb13ac25557 100644
>>> --- a/block/bfq-cgroup.c
>>> +++ b/block/bfq-cgroup.c
>>> @@ -749,8 +749,8 @@ static void bfq_sync_bfqq_move(struct bfq_data 
>>> *bfqd,
>>>            * old cgroup.
>>>            */
>>>           bfq_put_cooperator(sync_bfqq);
>>> -        bfq_release_process_ref(bfqd, sync_bfqq);
>>>           bic_set_bfqq(bic, NULL, true, act_idx);
>>> +        bfq_release_process_ref(bfqd, sync_bfqq);
>>>       }
>>>   }
>>>
>>
>> It seems this change is missed in GIT PULL for-6.3. I'll send a seperate
>> patch to fix this...
>>
> 
> It was already applied in time for 6.2 as 
> b600de2d7d3a16f9007fad1bdae82a3951a26af2
> and also already merged to 6.1-stable.

Yes, 6.2 and 6.1 doesn't have such problem because bfq_sync_bfqq_move()
doesn't exist. The problem only exist in master branch currently.

Thanks,
Kuai
> 
> cheers
> Holger
> 
> .
> 

