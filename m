Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B252E5B7EBD
	for <lists+cgroups@lfdr.de>; Wed, 14 Sep 2022 03:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiINBzX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Sep 2022 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiINBzS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Sep 2022 21:55:18 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800C476F1;
        Tue, 13 Sep 2022 18:55:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MS3Jd2Zk6z6R4xv;
        Wed, 14 Sep 2022 09:53:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXN_NCFjGB1DAw--.26821S3;
        Wed, 14 Sep 2022 09:55:13 +0800 (CST)
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Paolo Valente <paolo.valente@unimore.it>,
        Jan Kara <jack@suse.cz>
Cc:     cgroups@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220610021701.2347602-1-yukuai3@huawei.com>
 <20220610021701.2347602-4-yukuai3@huawei.com>
 <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
 <abdbb5db-e280-62f8-0670-536fcb8ec4d9@huaweicloud.com>
 <C2CF100A-9A7C-4300-9A70-1295BC939C66@unimore.it>
 <9b2d667f-6636-9347-08a1-8bd0aa2346f2@huaweicloud.com>
 <2f94f241-445f-1beb-c4a8-73f6efce5af2@huaweicloud.com>
 <55A07102-BE55-4606-9E32-64E884064FB9@unimore.it>
 <5cb0e5bc-feec-86d6-6f60-3c28ee625efd@huaweicloud.com>
 <D89DCF20-27D8-4F8F-B8B0-FD193FC4F18D@unimore.it>
 <e6b53794-f93f-92b2-1f45-35ae81a28a5c@huaweicloud.com>
 <F758A356-EE6B-4B7B-95E2-6414616C77E4@unimore.it>
 <5e0b44b4-46cc-b3c6-1d93-00a0a683eda8@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f89eb61b-7912-5916-1a12-039e32bebe70@huaweicloud.com>
Date:   Wed, 14 Sep 2022 09:55:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5e0b44b4-46cc-b3c6-1d93-00a0a683eda8@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXN_NCFjGB1DAw--.26821S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1xur1xtrWxCr13Zr1rCrg_yoWrJw1rpa
        y8Ga1Ykr4UJr12ywn7tr1UXryrt3y3Jr98Wr1DJryUCr1qvFn7KF42qr4Y9rZ7Xr4kWw17
        Xr4jqr97Zw1jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/09/07 9:16, Yu Kuai 写道:
> Hi, Paolo!
> 
> 在 2022/09/06 17:37, Paolo Valente 写道:
>>
>>
>>> Il giorno 26 ago 2022, alle ore 04:34, Yu Kuai 
>>> <yukuai1@huaweicloud.com> ha scritto:
>>>
>>> Hi, Paolo!
>>>
>>> 在 2022/08/25 22:59, Paolo Valente 写道:
>>>>> Il giorno 11 ago 2022, alle ore 03:19, Yu Kuai 
>>>>> <yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
>>>>>
>>>>> Hi, Paolo
>>>>>
>>>>> 在 2022/08/10 18:49, Paolo Valente 写道:
>>>>>>> Il giorno 27 lug 2022, alle ore 14:11, Yu Kuai 
>>>>>>> <yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha 
>>>>>>> scritto:
>>>>>>>
>>>>>>> Hi, Paolo
>>>>>>>
>>>>>> hi
>>>>>>> Are you still interested in this patchset?
>>>>>>>
>>>>>> Yes. Sorry for replying very late again.
>>>>>> Probably the last fix that you suggest is enough, but I'm a little 
>>>>>> bit
>>>>>> concerned that it may be a little hasty.  In fact, before this 
>>>>>> fix, we
>>>>>> exchanged several messages, and I didn't seem to be very good at
>>>>>> convincing you about the need to keep into account also in-service
>>>>>> I/O.  So, my question is: are you sure that now you have a
>>>>>
>>>>> I'm confused here, I'm pretty aware that in-service I/O(as said 
>>>>> pending
>>>>> requests is the patchset) should be counted, as you suggested in 
>>>>> v7, are
>>>>> you still thinking that the way in this patchset is problematic?
>>>>>
>>>>> I'll try to explain again that how to track is bfqq has pending 
>>>>> pending
>>>>> requests, please let me know if you still think there are some 
>>>>> problems:
>>>>>
>>>>> patch 1 support to track if bfqq has pending requests, it's
>>>>> done by setting the flag 'entity->in_groups_with_pending_reqs' when 
>>>>> the
>>>>> first request is inserted to bfqq, and it's cleared when the last
>>>>> request is completed. specifically the flag is set in
>>>>> bfq_add_bfqq_busy() when 'bfqq->dispatched' if false, and it's cleared
>>>>> both in bfq_completed_request() and bfq_del_bfqq_busy() when
>>>>> 'bfqq->diapatched' is false.
>>>>>
>>>> This general description seems correct to me. Have you already sent 
>>>> a new version of your patchset?
>>>
>>> It's glad that we finially on the same page here.
>>>
>>
>> Yep. Sorry for my chronicle delay.
> 
> Better late than never 😁
>>
>>> Please take a look at patch 1, which already impelement the above
>>> descriptions, it seems to me there is no need to send a new version
>>> for now. If you think there are still some other problems, please let
>>> me know.
>>>
>>
>> Patch 1 seems ok to me. I seem to have only one pending comment on 
>> this patch (3/4) instead. Let me paste previous stuff here for your 
>> convenience:
> That sounds good.
> 
>>
>>>>
>>>> -    /*
>>>> -     * Next function is invoked last, because it causes bfqq to be
>>>> -     * freed if the following holds: bfqq is not in service and
>>>> -     * has no dispatched request. DO NOT use bfqq after the next
>>>> -     * function invocation.
>>>> -     */
>>> I would really love it if you leave this comment.  I added it after
>>> suffering a lot for a nasty UAF.  Of course the first sentence may
>>> need to be adjusted if the code that precedes it is to be removed.
>>> Same as above, if this patch is applied, this function will be gone.

Hi, I'm curious while I'm trying to add the comment, before this
patchset, can bfqq be freed when bfq_weights_tree_remove is called?

bfq_completed_request
  bfqq->dispatched--
  if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq))
   bfq_weights_tree_remove(bfqd, bfqq);

  // continue to use bfqq

It seems to me this is problematic if so, because bfqq is used after
bfq_weights_tree_remove() is called.

Thanks,
Kuai

