Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992DD6146E8
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 10:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiKAJkI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKAJjn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 05:39:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4FE19C0B;
        Tue,  1 Nov 2022 02:39:00 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1lMH5m6MzHvT0;
        Tue,  1 Nov 2022 17:38:35 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 17:38:53 +0800
Subject: Re: [PATCH v2 2/3] block: Correct comment for scale_cookie_change
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221018111240.22612-1-shikemeng@huawei.com>
 <20221018111240.22612-3-shikemeng@huawei.com>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <d92907aa-2e57-dd68-c6ce-b8065cd25770@huawei.com>
Date:   Tue, 1 Nov 2022 17:38:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221018111240.22612-3-shikemeng@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Friendly ping.

on 10/18/2022 7:12 PM, Kemeng Shi wrote:
> Default queue depth of iolatency_grp is unlimited, so we scale down
> quickly(once by half) in scale_cookie_change. Remove the "subtract
> 1/16th" part which is not the truth and add the actual way we
> scale down.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> ---
>  block/blk-iolatency.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index b24d7b788ba3..2c574f98c8d1 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -364,9 +364,11 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
>  }
>  
>  /*
> - * Change the queue depth of the iolatency_grp.  We add/subtract 1/16th of the
> + * Change the queue depth of the iolatency_grp.  We add 1/16th of the
>   * queue depth at a time so we don't get wild swings and hopefully dial in to
> - * fairer distribution of the overall queue depth.
> + * fairer distribution of the overall queue depth.  We halve the queue depth
> + * at a time so we can scale down queue depth quickly from default unlimited
> + * to target.
>   */
>  static void scale_change(struct iolatency_grp *iolat, bool up)
>  {
> 

-- 
Best wishes
Kemeng Shi
