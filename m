Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD20600519
	for <lists+cgroups@lfdr.de>; Mon, 17 Oct 2022 04:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJQCG6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Oct 2022 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJQCG5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Oct 2022 22:06:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560141D16;
        Sun, 16 Oct 2022 19:06:56 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKxd60MCzmVNq;
        Mon, 17 Oct 2022 10:02:13 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 10:06:54 +0800
Subject: Re: [PATCH 0/3] A few cleanup patches for blk-iolatency.c
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220929074055.30080-1-shikemeng@huawei.com>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <b25560e2-78ae-b501-ff2b-ad69fd5c0f49@huawei.com>
Date:   Mon, 17 Oct 2022 10:06:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20220929074055.30080-1-shikemeng@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Friendly ping ...

on 9/29/2022 3:40 PM, Kemeng Shi wrote:
> This series contains three cleanup patches to remove redundant check,
> correct comment and simplify struct iolatency_grp in blk-iolatency.c.
> 
> Kemeng Shi (3):
>   block: Remove redundant parent blkcg_gp check in check_scale_change
>   block: Correct comment for scale_cookie_change
>   block: Replace struct rq_depth with unsigned int in struct
>     iolatency_grp
> 
>  block/blk-iolatency.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 

-- 
Best wishes
Kemeng Shi
