Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BA46FC9B
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 09:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhLJIYI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 03:24:08 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32904 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhLJIYH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 03:24:07 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9P3P4MLLzccT6;
        Fri, 10 Dec 2021 16:20:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:20:31 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:20:30 +0800
Subject: Re: [PATCH RFC 0/9] support concurrent sync io for bfq on a specail
 occasion
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211127101132.486806-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <34aa698e-7e03-b60c-88a8-43097eb224d4@huawei.com>
Date:   Fri, 10 Dec 2021 16:20:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211127101132.486806-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/11/27 18:11, Yu Kuai wrote:
> Bfq can't handle sync io concurrently as long as the io are not issued
> from root group currently.
> 
> Previous patch set:
> https://lore.kernel.org/lkml/20211014014556.3597008-2-yukuai3@huawei.com/t/
> 
> During implemting the method mentioned by the above patch set, I found
> more problems that will block implemting concurrent sync io. The
> modifications of this patch set are as follows:
> 
> 1) count root group into 'num_groups_with_pending_reqs';
> 2) don't idle if 'num_groups_with_pending_reqs' is 1;
> 3) If the group doesn't have pending requests while it's child groups
> have pending requests, don't count the group.
> 4) Once the group doesn't have pending requests, decrease
> 'num_groups_with_pending_reqs' immediately. Don't delay to when all
> it's child groups don't have pending requests.
> 

friendly ping ...
> Noted that I just tested basic functionality of this patchset, and I
> think it's better to see if anyone have suggestions or better
> solutions.
> 
> Yu Kuai (9):
>    block, bfq: add new apis to iterate bfq entities
>    block, bfq: apply news apis where root group is not expected
>    block, bfq: handle the case when for_each_entity() access root group
>    block, bfq: count root group into 'num_groups_with_pending_reqs'
>    block, bfq: do not idle if only one cgroup is activated
>    block, bfq: only count group that the bfq_queue belongs to
>    block, bfq: record how many queues have pending requests in bfq_group
>    block, bfq: move forward __bfq_weights_tree_remove()
>    block, bfq: decrease 'num_groups_with_pending_reqs' earlier
> 
>   block/bfq-cgroup.c  |  3 +-
>   block/bfq-iosched.c | 92 +++++++++++++++++++++++----------------------
>   block/bfq-iosched.h | 41 +++++++++++++-------
>   block/bfq-wf2q.c    | 44 +++++++++++++++-------
>   4 files changed, 106 insertions(+), 74 deletions(-)
> 
