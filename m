Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D663E1C8
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiK3UWm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiK3UWU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:22:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFD91363;
        Wed, 30 Nov 2022 12:20:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so3451087pjg.1;
        Wed, 30 Nov 2022 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFED/2oaWzSQkBiwKASIUwgMFRRJ9B92EdLcPu53GAI=;
        b=A/uWTQh20hD7NILSrZcskkGI/NGv6GGEFIw80L8MRSrUAHpXVNqlkWFiSWqB0+UDLP
         PY/XPC6I3tQCv3X8dJRmADc7BoIeZ/tfq2XEwaSrA9MeI2qqF50nQHCv8BbB9+7fLOoG
         rotPGrDQAyRCRDD/OnAhKbvGWYPUQyLbg+Q3RpD0gFJkaPBAi0kDEaDvi8OGy3yaaWds
         0PwlOMFUINg4txG221xgYjRvaiRs4TrssssmMtXpj5ajS6RJfNt7XSYkLSSoyFXTARXG
         3Uv7CkXTXHgDOdQP3eISdvq1BKZnSCKQm13+QpiJC4iBrZ1W8veVE4d/v57d3SSfShRg
         o00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFED/2oaWzSQkBiwKASIUwgMFRRJ9B92EdLcPu53GAI=;
        b=hZQwC0K+Ak+KETE4XKiQ4Jx30PEpbSJiTh8WeX284lWmBCuIcjp3yYP7TYzmvDcdL6
         ecInXKMY7xmjjALTcs8m6qa5dvatrFlxjt19w9oxjWisLIk6EhZGLQFyTu0GhsOFU6/V
         qf96Xp2Xd7rB25R7kmQ80dv1raFyErWYCt8ARIWA4VpAHvo/aMUgWahI6bRJkgFDX158
         6xvmoVa1zViSaDP7y8iP9Joozdc/JfE96MVDHzh2YZNYaLx9jBEh9x2WndUh3X8MT1QU
         F4kFcKtsk4DYw8eAZs4+DxxG8Vg2zxAXkWIfY9xJFW9gBqUEFgj+JDo49mhS/ZNavo+Z
         jkIQ==
X-Gm-Message-State: ANoB5pmDllQ1vXsAaKmEoncLdNFT3XwnRM9JVxAzrciHVt9en18j4tVn
        zWZP2wwzyMEWJ9n7jxycsN8=
X-Google-Smtp-Source: AA0mqf6I4T6W9QB2zmyYwJDrRrJq901onJPem6CZ6/buB/9vEInAt+nPRs7mbfxAzVDGhkXN5+wTJQ==
X-Received: by 2002:a17:90a:5d08:b0:218:770c:9a40 with SMTP id s8-20020a17090a5d0800b00218770c9a40mr49845287pji.158.1669839616969;
        Wed, 30 Nov 2022 12:20:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00176a2d23d1asm1914493pla.56.2022.11.30.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:20:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:20:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 5/9] blk-iocost: fix divide by 0 error in
 calc_lcoefs()
Message-ID: <Y4e6/wdNvZmV1c9Y@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-6-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-6-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:52PM +0800, Li Nan wrote:
> echo max of u64 to cost.model can cause divide by 0 error.
> 
>   # echo 8:0 rbps=18446744073709551615 > /sys/fs/cgroup/io.cost.model
> 
>   divide error: 0000 [#1] PREEMPT SMP
>   RIP: 0010:calc_lcoefs+0x4c/0xc0
>   Call Trace:
>    <TASK>
>    ioc_refresh_params+0x2b3/0x4f0
>    ioc_cost_model_write+0x3cb/0x4c0
>    ? _copy_from_iter+0x6d/0x6c0
>    ? kernfs_fop_write_iter+0xfc/0x270
>    cgroup_file_write+0xa0/0x200
>    kernfs_fop_write_iter+0x17d/0x270
>    vfs_write+0x414/0x620
>    ksys_write+0x73/0x160
>    __x64_sys_write+0x1e/0x30
>    do_syscall_64+0x35/0x80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> calc_lcoefs() uses the input value of cost.model in DIV_ROUND_UP_ULL,
> overflow would happen if bps plus IOC_PAGE_SIZE is greater than
> ULLONG_MAX, it can cause divide by 0 error.I_LCOEF_MAX is introduced to
> prevent it.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-iocost.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 3a96cd557c47..f4a754b9d10f 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -306,6 +306,9 @@ enum {
>  	IOC_PAGE_SIZE		= 1 << IOC_PAGE_SHIFT,
>  	IOC_SECT_TO_PAGE_SHIFT	= IOC_PAGE_SHIFT - SECTOR_SHIFT,
>  
> +	/* avoid overflow */
> +	I_LCOEF_MAX		= ULLONG_MAX - IOC_PAGE_SIZE,
> +
>  	/* if apart further than 16M, consider randio for linear model */
>  	LCOEF_RANDIO_PAGES	= 4096,
>  };
> @@ -3431,6 +3434,8 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>  			goto out_unlock;
>  		}
>  
> +		if (v > I_LCOEF_MAX)
> +			goto out_unlock;

This is kinda round-about. Can you just make calc_lcoefs to not divide by
zero (e.g. just make it 1 if zero)?

Thanks.

-- 
tejun
