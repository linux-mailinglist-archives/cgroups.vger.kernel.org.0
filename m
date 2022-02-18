Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE444BB429
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 09:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiBRIa2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 03:30:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiBRIa1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 03:30:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C6217044;
        Fri, 18 Feb 2022 00:30:09 -0800 (PST)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0Px70DkxzbkbG;
        Fri, 18 Feb 2022 16:28:59 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 16:30:06 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 16:30:06 +0800
Subject: Re: [PATCH v3 0/3] block, bfq: minor cleanup and fix
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     <paolo.valente@linaro.org>, <jack@suse.cz>,
        <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
 <7cb40388-02e9-712a-6a40-ccabd5605880@kernel.dk>
 <9ed6bf05-4c31-eef1-1736-65915e55eb8e@huawei.com>
 <0215f548-5d5f-107d-9c8e-3a802a51e00f@huawei.com>
Message-ID: <040c3568-50c4-5f5a-08c4-fb182cbcd2a7@huawei.com>
Date:   Fri, 18 Feb 2022 16:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0215f548-5d5f-107d-9c8e-3a802a51e00f@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

friendly ping ...

在 2022/02/10 19:46, yukuai (C) 写道:
> 在 2022/01/29 10:05, yukuai (C) 写道:
>> 在 2022/01/29 9:51, Jens Axboe 写道:
>>> On 1/28/22 6:59 PM, Yu Kuai wrote:
>>>> Changes in v3:
>>>>   - fix a clerical error in patch 2
>>>>
>>>> Chagnes in v2:
>>>>   - add comment in patch 2
>>>>   - remove patch 4, since the problem do not exist.
>>>>
>>>> Yu Kuai (3):
>>>>    block, bfq: cleanup bfq_bfqq_to_bfqg()
>>>>    block, bfq: avoid moving bfqq to it's parent bfqg
>>>>    block, bfq: don't move oom_bfqq
>>>>
>>>>   block/bfq-cgroup.c  | 16 +++++++++++++++-
>>>>   block/bfq-iosched.c |  4 ++--
>>>>   block/bfq-iosched.h |  1 -
>>>>   block/bfq-wf2q.c    | 15 ---------------
>>>>   4 files changed, 17 insertions(+), 19 deletions(-)
>>>
>>> I'm not even looking at this until you tell me that:
>>>
>>> a) you've actually compiled this one. which, btw, I can't believe
>>>     needs mentioning, particularly when you had enough time to keep
>>>     pinging about this patchset.
>>>
>>> b) it's actually be run. last one was clearly not.
>>>
>> Hi,
>>
>> I compiled and tested the patchset locally in a different version,
>> v4.19 specifically. However, after I decide to send them to mainline,
>> I made such clerical mistake and forgot to check the patches.
>>
>> My sincerely apologize again...
>> Kuai
> 
> Hi, Jens
> 
> Can you please apply this patch this time?
> 
> Thanks,
> Kuai
