Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DF63501A
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 07:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiKWGJS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 01:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKWGJS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 01:09:18 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83540F1F;
        Tue, 22 Nov 2022 22:09:17 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH9fv2FgHzHtgm;
        Wed, 23 Nov 2022 14:08:39 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 14:09:15 +0800
Subject: Re: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221018121932.10792-1-shikemeng@huawei.com>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <5ae7f0a0-8540-bbfe-2fe7-b18fc071ae1c@huawei.com>
Date:   Wed, 23 Nov 2022 14:09:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221018121932.10792-1-shikemeng@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Friendly ping

on 10/18/2022 8:19 PM, Kemeng Shi wrote:
> This series contain a few patch to correct comment, correct trace of
> vtime_rate and so on. More detail can be found in the respective
> changelogs.
> 
> ---
> v2:
>  Thanks Tejun for review and comment!
>  Add Acked-by tag from Tejun.
>  Correct description in patch 3/5 and 4/5.
>  Drop "blk-iocost: Avoid to call current_hweight_max if iocg->inuse
> == iocg->active"
>  Drop "blk-iocost: Remove redundant initialization of struct ioc_gq"
>  Drop "blk-iocost: Get ioc_now inside weight_updated"
> ---
> 
> Kemeng Shi (5):
>   blk-iocost: Fix typo in comment
>   blk-iocost: Reset vtime_base_rate in ioc_refresh_params
>   blk-iocost: Trace vtime_base_rate instead of vtime_rate
>   blk-iocost: Remove vrate member in struct ioc_now
>   blk-iocost: Correct comment in blk_iocost_init
> 
>  block/blk-iocost.c            | 16 +++++++++-------
>  include/trace/events/iocost.h |  4 ++--
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 

-- 
Best wishes
Kemeng Shi
