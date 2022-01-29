Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF8A4A2B07
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 02:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiA2Bmr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 20:42:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:31251 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbiA2Bmr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 20:42:47 -0500
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jlxrc3gk2zbk3y;
        Sat, 29 Jan 2022 09:41:52 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 09:42:44 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 09:42:44 +0800
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
To:     Jens Axboe <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <yi.zhang@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20211231032354.793092-1-yukuai3@huawei.com>
 <164338111974.263985.3933987922467783334.b4-ty@kernel.dk>
 <2579c500-549f-ff04-d1e1-6cf3db10b428@kernel.dk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <8f0d2f92-96c5-f2c4-daa4-f2a59bd885a2@huawei.com>
Date:   Sat, 29 Jan 2022 09:42:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2579c500-549f-ff04-d1e1-6cf3db10b428@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/01/29 3:27, Jens Axboe 写道:
> On 1/28/22 7:45 AM, Jens Axboe wrote:
>> On Fri, 31 Dec 2021 11:23:51 +0800, Yu Kuai wrote:
>>> Chagnes in v2:
>>>   - add comment in patch 2
>>>   - remove patch 4, since the problem do not exist.
>>>
>>> Yu Kuai (3):
>>>    block, bfq: cleanup bfq_bfqq_to_bfqg()
>>>    block, bfq: avoid moving bfqq to it's parent bfqg
>>>    block, bfq: don't move oom_bfqq
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/3] block, bfq: cleanup bfq_bfqq_to_bfqg()
>>        commit: a9c77f6ec0b566439182a10b64dd3e60a0408849
>> [2/3] block, bfq: avoid moving bfqq to it's parent bfqg
>>        commit: 36ad7fe0ec7485ee435f7a40452c7a58598779d4
>> [3/3] block, bfq: don't move oom_bfqq
>>        commit: a0b98e6fba18a40aa9672cc3e0abf980456f3ae6
> 
> For all those pings, this patchset sure didn't see a lot of compiles:
> 
> block/bfq-cgroup.c: In function ‘bfq_bfqq_move’:
> block/bfq-cgroup.c:648:40: error: implicit declaration of function ‘bfq_group’; did you mean ‘bfqq_group’? [-Werror=implicit-function-declaration]
>    648 |         struct bfq_group *old_parent = bfq_group(bfqq);
>        |                                        ^~~~~~~~~
>        |                                        bfqq_group
> block/bfq-cgroup.c:648:40: error: initialization of ‘struct bfq_group *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> cc1: all warnings being treated as errors
> make[1]: *** [scripts/Makefile.build:288: block/bfq-cgroup.o] Error 1
> make: *** [Makefile:1831: block] Error 2
> 
> Dropped.
> 

Hi,

I'm sincerely sorry for this, I do forget to compiles this patchset,
and let this stupid clerical error exposure to you...

I'll send anothor version of patch 2.

Thanks,
Kuai
