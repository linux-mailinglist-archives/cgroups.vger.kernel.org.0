Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B257E48A52A
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 02:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbiAKBlE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 20:41:04 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31086 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244033AbiAKBlC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 20:41:02 -0500
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JXtbn6JNKz1FCYp;
        Tue, 11 Jan 2022 09:37:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 09:41:00 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 09:40:59 +0800
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
To:     <jack@suse.cz>, <tj@kernel.org>, <axboe@kernel.dk>,
        <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211231032354.793092-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <5696c767-8248-09a4-f04e-ac93138d30ef@huawei.com>
Date:   Tue, 11 Jan 2022 09:40:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211231032354.793092-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2021/12/31 11:23, Yu Kuai Ð´µÀ:
> Chagnes in v2:
>   - add comment in patch 2
>   - remove patch 4, since the problem do not exist.
> 
friendly ping ...
> Yu Kuai (3):
>    block, bfq: cleanup bfq_bfqq_to_bfqg()
>    block, bfq: avoid moving bfqq to it's parent bfqg
>    block, bfq: don't move oom_bfqq
> 
>   block/bfq-cgroup.c  | 16 +++++++++++++++-
>   block/bfq-iosched.c |  4 ++--
>   block/bfq-iosched.h |  1 -
>   block/bfq-wf2q.c    | 15 ---------------
>   4 files changed, 17 insertions(+), 19 deletions(-)
> 
