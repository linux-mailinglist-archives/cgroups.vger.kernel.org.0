Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A649F674
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiA1Jfq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 04:35:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35882 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiA1Jfp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 04:35:45 -0500
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JlXNp4gCdzcck2;
        Fri, 28 Jan 2022 17:34:50 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 17:35:42 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 17:35:41 +0800
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <jack@suse.cz>, <tj@kernel.org>, <axboe@kernel.dk>,
        <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211231032354.793092-1-yukuai3@huawei.com>
 <a461cdbd-e1f3-0083-cd96-b69837334b19@huawei.com>
Message-ID: <a6c3696b-467c-0ea7-141c-714a9a1b7ba4@huawei.com>
Date:   Fri, 28 Jan 2022 17:35:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a461cdbd-e1f3-0083-cd96-b69837334b19@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/01/24 11:46, yukuai (C) 写道:
> 在 2021/12/31 11:23, Yu Kuai 写道:
>> Chagnes in v2:
>>   - add comment in patch 2
>>   - remove patch 4, since the problem do not exist.
>>
>> Yu Kuai (3):
>>    block, bfq: cleanup bfq_bfqq_to_bfqg()
>>    block, bfq: avoid moving bfqq to it's parent bfqg
>>    block, bfq: don't move oom_bfqq
>>
>>   block/bfq-cgroup.c  | 16 +++++++++++++++-
>>   block/bfq-iosched.c |  4 ++--
>>   block/bfq-iosched.h |  1 -
>>   block/bfq-wf2q.c    | 15 ---------------
>>   4 files changed, 17 insertions(+), 19 deletions(-)
>>
> Hi, jens
> 
> Now that with acked-by Paolo, can you please applied this pathset?
friendly ping ...
> 
> Thanks,
> Kuai
