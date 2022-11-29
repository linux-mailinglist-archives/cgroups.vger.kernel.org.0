Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2063B937
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 05:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiK2Eww (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 23:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiK2Ews (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 23:52:48 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA756440;
        Mon, 28 Nov 2022 20:52:43 -0800 (PST)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLqgl0VP7zRpSZ;
        Tue, 29 Nov 2022 12:52:03 +0800 (CST)
Received: from [10.174.179.2] (10.174.179.2) by canpemm500008.china.huawei.com
 (7.192.105.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 12:52:41 +0800
Message-ID: <7b447dcb-6009-31e1-8bf6-05b1cdb28b01@huawei.com>
Date:   Tue, 29 Nov 2022 12:52:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH v2] blk-iocost: fix shift-out-of-bounds in
 iocg_hick_delay()
To:     Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221128030413.882998-1-lijinlin3@huawei.com>
 <Y4US2vFmR4pnw08Z@slm.duckdns.org>
 <bbc5e21f-9e77-41bb-5763-36bd905b52a0@huaweicloud.com>
 <2830bd58-0f53-fa54-58e5-e87225b1fdf1@huawei.com>
 <5489e3c5-30ad-d7af-c329-40c93d9a1b62@huaweicloud.com>
From:   Li Jinlin <lijinlin3@huawei.com>
In-Reply-To: <5489e3c5-30ad-d7af-c329-40c93d9a1b62@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2022/11/29 10:59, Yu Kuai wrote:
> Hi,
> 
> 在 2022/11/29 10:49, Li Jinlin 写道:
>>
>>
>> On 2022/11/29 9:14, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2022/11/29 3:58, Tejun Heo 写道:
>>>> On Mon, Nov 28, 2022 at 11:04:13AM +0800, Li Jinlin wrote:
>>>>>        /* calculate the current delay in effect - 1/2 every second */
>>>>>        tdelta = now->now - iocg->delay_at;
>>>>>        if (iocg->delay)
>>>>> -        delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
>>>>> +        delay = iocg->delay >>
>>>>> +            min_t(u64, div64_u64(tdelta, USEC_PER_SEC), 63);
>>>>
>>>> I replied earlier but the right thing to do here is setting delay to 0 if
>>>> the shift is >= 64.
>>>
>>> Perhaps following change will make more sense?
>>>
>>> @@ -1322,18 +1323,19 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
>>>   {
>>>          struct ioc *ioc = iocg->ioc;
>>>          struct blkcg_gq *blkg = iocg_to_blkg(iocg);
>>> -       u64 tdelta, delay, new_delay;
>>> +       u64 delay = 0;
>>> +       u64 new_delay;
>>>          s64 vover, vover_pct;
>>>          u32 hwa;
>>>
>>>          lockdep_assert_held(&iocg->waitq.lock);
>>>
>>>          /* calculate the current delay in effect - 1/2 every second */
>>> -       tdelta = now->now - iocg->delay_at;
>>> -       if (iocg->delay)
>>> +       if (iocg->delay && now->now > iocg->delay_at) {
>>> +               u64 tdelta = now->now - iocg->delay_at;
>>> +
>>>                  delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
>>> -       else
>>> -               delay = 0;
>>> +       }
>>>
>> I think "now->now > iocg->delay_at" is unnecessary, it is almost inevitable.
> 
> From what I see, following can only happen if now->now < iocg->delay_at:
> 
> "shift exponent 18446744073709"
> 
You are right. 

But I didn't see any ubsan reported at now->now - iocg->delay_at. 
Need to confirm this.

Jinlin
Thanks.

> Or something else triggers it?
> 
> Thanks,
> Kuai
> 
