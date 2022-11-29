Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6A63B84B
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 03:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiK2C7y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 21:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiK2C7x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 21:59:53 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76243303F3;
        Mon, 28 Nov 2022 18:59:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NLnB93p4Xz4f3pFr;
        Tue, 29 Nov 2022 10:59:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgAH_qyidYVjPcsKBQ--.9176S3;
        Tue, 29 Nov 2022 10:59:48 +0800 (CST)
Subject: Re: [PATCH v2] blk-iocost: fix shift-out-of-bounds in
 iocg_hick_delay()
To:     Li Jinlin <lijinlin3@huawei.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuzhiqiang26@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221128030413.882998-1-lijinlin3@huawei.com>
 <Y4US2vFmR4pnw08Z@slm.duckdns.org>
 <bbc5e21f-9e77-41bb-5763-36bd905b52a0@huaweicloud.com>
 <2830bd58-0f53-fa54-58e5-e87225b1fdf1@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5489e3c5-30ad-d7af-c329-40c93d9a1b62@huaweicloud.com>
Date:   Tue, 29 Nov 2022 10:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2830bd58-0f53-fa54-58e5-e87225b1fdf1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAH_qyidYVjPcsKBQ--.9176S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xtw18Zr4kuF4UtrWUJwb_yoW8Zryrpr
        95GFyUJrW5Xr1xCr18tr1UZry5tr17Jw1DCr1rAF18JrW8Jr1YgF48Xr1q9F1UArs5JF18
        JF15GF1DZry7JF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2022/11/29 10:49, Li Jinlin 写道:
> 
> 
> On 2022/11/29 9:14, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/11/29 3:58, Tejun Heo 写道:
>>> On Mon, Nov 28, 2022 at 11:04:13AM +0800, Li Jinlin wrote:
>>>>        /* calculate the current delay in effect - 1/2 every second */
>>>>        tdelta = now->now - iocg->delay_at;
>>>>        if (iocg->delay)
>>>> -        delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
>>>> +        delay = iocg->delay >>
>>>> +            min_t(u64, div64_u64(tdelta, USEC_PER_SEC), 63);
>>>
>>> I replied earlier but the right thing to do here is setting delay to 0 if
>>> the shift is >= 64.
>>
>> Perhaps following change will make more sense?
>>
>> @@ -1322,18 +1323,19 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
>>   {
>>          struct ioc *ioc = iocg->ioc;
>>          struct blkcg_gq *blkg = iocg_to_blkg(iocg);
>> -       u64 tdelta, delay, new_delay;
>> +       u64 delay = 0;
>> +       u64 new_delay;
>>          s64 vover, vover_pct;
>>          u32 hwa;
>>
>>          lockdep_assert_held(&iocg->waitq.lock);
>>
>>          /* calculate the current delay in effect - 1/2 every second */
>> -       tdelta = now->now - iocg->delay_at;
>> -       if (iocg->delay)
>> +       if (iocg->delay && now->now > iocg->delay_at) {
>> +               u64 tdelta = now->now - iocg->delay_at;
>> +
>>                  delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
>> -       else
>> -               delay = 0;
>> +       }
>>
> I think "now->now > iocg->delay_at" is unnecessary, it is almost inevitable.

 From what I see, following can only happen if now->now < iocg->delay_at:

"shift exponent 18446744073709"

Or something else triggers it?

Thanks,
Kuai

