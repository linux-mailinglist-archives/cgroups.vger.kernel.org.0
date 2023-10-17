Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD847CB880
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 04:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjJQCif (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 22:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQCie (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 22:38:34 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4C6F1;
        Mon, 16 Oct 2023 19:38:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S8dSy2db9z4f3jYm;
        Tue, 17 Oct 2023 10:38:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt2i8y1loZirDA--.57978S3;
        Tue, 17 Oct 2023 10:38:27 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Khazhy Kumykov <khazhy@chromium.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Li Nan <linan666@huaweicloud.com>,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
 <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com>
 <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com>
 <20231008113602.GB24726@redhat.com>
 <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
 <e9165cd0-9c9d-1d1a-1c5b-402556a1a31f@huaweicloud.com>
 <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bdba4f58-1adf-32ab-5f5a-0fbb1a2ae6c2@huaweicloud.com>
Date:   Tue, 17 Oct 2023 10:38:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt2i8y1loZirDA--.57978S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyrJr4UuryUWr48tF4kXrb_yoW5Aw1fpr
        WfKF1a9r43Xas7tF1Iyw1jqFyvvrWkGry5XFWUZ34Yya93KFy7CFW7JrWY9w17Xa4kWw1U
        Jw4DKF9xArn0v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/10/17 4:06, Khazhy Kumykov 写道:
> On Sun, Oct 15, 2023 at 6:47 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/10/14 5:51, Khazhy Kumykov 写道:
>>> Looking at the generic mul_u64_u64_div_u64 impl, it doesn't handle
>>> overflow of the final result either, as far as I can tell. So while on
>>> x86 we get a DE, on non-x86 we just get the wrong result.
>>>
>>> (Aside: after 8d6bbaada2e0 ("blk-throttle: prevent overflow while
>>> calculating wait time"), setting a very-high bps_limit would probably
>>> also cause this crash, no?)
>>>
>>> Would it be possible to have a "check_mul_u64_u64_div_u64_overflow()",
>>> where if the result doesn't fit in u64, we indicate (and let the
>>> caller choose what to do? Here we should just return U64_MAX)?
>>>
>>> Absent that, maybe we can take inspiration from the generic
>>> mul_u64_u64_div_u64? (Forgive the paste)
>>>
>>>    static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
>>>    {
>>> +       /* Final result probably won't fit in u64 */
>>> +       if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
>>
>> I'm not sure, but this condition looks necessary, but doesn't look
>> sufficient, for example, jiffy_elapsed cound be greater than HZ, while
>> ilog2(jiffy_elapsed) is equal to ilog2(HZ).
> I believe 62 is correct, although admittedly it's less "intuitive"
> than the check in mul_u64_u64_div_u64()....
> 
> The result overflows if log2(A * B / C) >= 64, so we want to ensure that:
> log2(A) + log2(B) - log2(C) < 64
> 
> Given that:
> ilog2(A) <= log2(A) < ilog2(A) + 1  // truncation defn
> It follows that:
> -log2(A) <= -ilog2(A)  // Inverse rule
> log2(A) - 1 < ilog2(A)
> 
> Starting from:
> ilog2(A) + ilog2(B) - ilog2(C) <= X
> 
> We can show:
> (log2(A) - 1) + (log2(B) - 1) + (-log2(C)) < ilog2(A) + ilog2(B) +
> (-ilog2(C)) // strict inequality here since the substitutions for A
> and B terms are strictly less
> (log2(A) - 1) + (log2(B) - 1) + (-log2(C)) < X
> log2(A) + log2(B) - log2(C) < X + 2
> 
> So for X = 62, log2(A) + log2(B) - log2(C) < 64 must be true, and we
> must be safe from overflow.
> 
> So... by converse, if ilog2(A) + ilog2(B) - ilog2(C) > 62, we cannot
> guarantee that the result will not overflow - thus we bail out.
> 
> // end math

Thanks for the explanation, I understand that, so the problem is that
if the above condition(>62) match, the result may not overflow, but
U64_MAX is returned here, this is not correct but I guess this doesn't
matter in real word, it's impossible that user will issue more than
1<<63 bytes IO in an extended slice.

I'm good with this fix with some comments.

Thanks,
Kuai

> 
> It /is/ less exact than your proposal (sufficient, but not necessary),
> but saves an extra 128bit mul.
> 
> I mostly just want us to pick /something/, since 6.6-rc and the LTSs
> with the patch in question are busted currently. :)
> 
> 
> 
>>
>> Thanks,
>> Kuai
>>
>>> +               return U64_MAX;
>>>           return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>>>    }
>>>
>>> .
>>>
>>
> 
> .
> 

