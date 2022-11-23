Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380FB635011
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 07:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiKWGIq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 01:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiKWGIa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 01:08:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA5F60A9;
        Tue, 22 Nov 2022 22:07:20 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH9cn2thWzRpF7;
        Wed, 23 Nov 2022 14:06:49 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 14:07:18 +0800
Subject: Re: [PATCH v2] blk-cgroup: Fix typo in comment
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221013141659.24032-1-shikemeng@huawei.com>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <c8bc1792-7a54-260e-4c07-66b2ea02d925@huawei.com>
Date:   Wed, 23 Nov 2022 14:07:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221013141659.24032-1-shikemeng@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

on 10/13/2022 10:16 PM, Kemeng Shi wrote:
> Replace assocating with associating.
> Replace intiailized with initialized.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
> Changes in v2:
>  -based on current mainline code
>  -add acked-by
> 
>  block/blk-cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 6a5c849ee061..4c4bc874bd95 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -577,7 +577,7 @@ EXPORT_SYMBOL_GPL(blkcg_print_blkgs);
>   * @pd: policy private data of interest
>   * @v: value to print
>   *
> - * Print @v to @sf for the device assocaited with @pd.
> + * Print @v to @sf for the device associated with @pd.
>   */
>  u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
>  {
> @@ -765,7 +765,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
>  
>  /**
>   * blkg_conf_finish - finish up per-blkg config update
> - * @ctx: blkg_conf_ctx intiailized by blkg_conf_prep()
> + * @ctx: blkg_conf_ctx initialized by blkg_conf_prep()
>   *
>   * Finish up after per-blkg config update.  This function must be paired
>   * with blkg_conf_prep().
> 

-- 
Best wishes
Kemeng Shi
