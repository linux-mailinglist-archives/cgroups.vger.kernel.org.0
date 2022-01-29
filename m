Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B654A2B35
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 03:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352136AbiA2CFj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 21:05:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:31254 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352147AbiA2CF3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 21:05:29 -0500
Received: from kwepemi100020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JlyLq1kfLzbk83;
        Sat, 29 Jan 2022 10:04:35 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100020.china.huawei.com (7.221.188.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 10:05:27 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 10:05:26 +0800
Subject: Re: [PATCH v3 0/3] block, bfq: minor cleanup and fix
To:     Jens Axboe <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
 <7cb40388-02e9-712a-6a40-ccabd5605880@kernel.dk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9ed6bf05-4c31-eef1-1736-65915e55eb8e@huawei.com>
Date:   Sat, 29 Jan 2022 10:05:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7cb40388-02e9-712a-6a40-ccabd5605880@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/01/29 9:51, Jens Axboe 写道:
> On 1/28/22 6:59 PM, Yu Kuai wrote:
>> Changes in v3:
>>   - fix a clerical error in patch 2
>>
>> Chagnes in v2:
>>   - add comment in patch 2
>>   - remove patch 4, since the problem do not exist.
>>
>> Yu Kuai (3):
>>    block, bfq: cleanup bfq_bfqq_to_bfqg()
>>    block, bfq: avoid moving bfqq to it's parent bfqg
>>    block, bfq: don't move oom_bfqq
>>
>>   block/bfq-cgroup.c  | 16 +++++++++++++++-
>>   block/bfq-iosched.c |  4 ++--
>>   block/bfq-iosched.h |  1 -
>>   block/bfq-wf2q.c    | 15 ---------------
>>   4 files changed, 17 insertions(+), 19 deletions(-)
> 
> I'm not even looking at this until you tell me that:
> 
> a) you've actually compiled this one. which, btw, I can't believe
>     needs mentioning, particularly when you had enough time to keep
>     pinging about this patchset.
> 
> b) it's actually be run. last one was clearly not.
> 
Hi,

I compiled and tested the patchset locally in a different version,
v4.19 specifically. However, after I decide to send them to mainline,
I made such clerical mistake and forgot to check the patches.

My sincerely apologize again...
Kuai
