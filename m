Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0601E48E641
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiANIZi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 03:25:38 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35840 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiANIXk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 03:23:40 -0500
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZvSK1lpXzccXY;
        Fri, 14 Jan 2022 16:22:57 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 14 Jan 2022 16:23:37 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 16:23:37 +0800
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <jack@suse.cz>, <tj@kernel.org>, <axboe@kernel.dk>,
        <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211231032354.793092-1-yukuai3@huawei.com>
 <5696c767-8248-09a4-f04e-ac93138d30ef@huawei.com>
Message-ID: <1cdb99ba-ed52-c755-fec4-86ee5f9bc61d@huawei.com>
Date:   Fri, 14 Jan 2022 16:23:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5696c767-8248-09a4-f04e-ac93138d30ef@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/01/11 9:40, yukuai (C) 写道:
> 在 2021/12/31 11:23, Yu Kuai 写道:
>> Chagnes in v2:
>>   - add comment in patch 2
>>   - remove patch 4, since the problem do not exist.
>>
> friendly ping ...

Hi, Jens

Can this patchset be applied?

Thanks
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
