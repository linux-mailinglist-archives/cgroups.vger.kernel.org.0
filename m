Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B242956A
	for <lists+cgroups@lfdr.de>; Mon, 11 Oct 2021 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhJKRTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhJKRTB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 13:19:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2BBC061570;
        Mon, 11 Oct 2021 10:17:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v11so11418288pgb.8;
        Mon, 11 Oct 2021 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=47MxuwjdGXsg6hhuLv8z6fw88ymx9GeX72SLuyGJTok=;
        b=a4RrVVdJ7cUmlCzggWQlfbsOGdWJ2MPLEG7CalU7wsqMn5r+DmcveNvP/dyXMNR51w
         JtU8Ih35Ce+uEy4ncY5JylViwvaU0igXgKz2jaopbXllKs4Y/NmCftllt9Er3ysq5hxH
         VPtWr48EAAqhK7X9th7UFB+LRnFN9m99A2smY07IoxO7ZFdPJ7mXc6Pu3qkj4fBcKTyb
         2Iv2hIOIVZVA3TbxCeJx5383kucVuJsrJ2aavndyzcUgCH8omLECpFhzAfSfBEBllQwh
         97IPyg91TL5MFJMujwLsnFD+T4IWTukC9iJ8bqhU/7D+IlUe2KDpBVFaOCk696vZlb+a
         SsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=47MxuwjdGXsg6hhuLv8z6fw88ymx9GeX72SLuyGJTok=;
        b=wTJlpTDD5BlXbcIpM5sO91NcjsgMe+tay+GusB4elj5i+pEMKu4cjxGEeamMKs2kbQ
         xHh/FNxrHvl0NistqwgcxOv8md481QPx6EjgprBHwR2yPlZ9Ldfmyc3kTMo8cZkZIGL/
         B3z/J65vkT3Xf/3jOOCoJ0SwiI5ApEQECtq4Bcz0h/zYD0m7dDUd2ivFjgU5XsykRo6i
         QZdFkx2vok9b1zBTT1ATi1erPMRlFDaJsyzAo/9qYdWV/sOLf1KfDFeU2vL2bkCTc7zx
         IlipuvKzZ8FQpHSOzl1XXfYbPpzH36jXXZCPEcnC5NBX5BvjP2k8Ot10K5NCW32odYaf
         XUKA==
X-Gm-Message-State: AOAM531WPpmYZtBIA5FpGcWBSoUMPgmZLjx7Enu1Yd57b8f4L2QgM9eC
        gjrQoKEFZ3BJSV4I0M3c9AAVR9feZ3olzA==
X-Google-Smtp-Source: ABdhPJy4J5tHxXt2W+6L6flmSpcpqk/tYiffWv9S20Ntu0LHmWDZ6NMtBsRppjjWJ3+Z9290lnG3tw==
X-Received: by 2002:a63:2b8c:: with SMTP id r134mr18907749pgr.420.1633972620892;
        Mon, 11 Oct 2021 10:17:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u193sm8743444pgc.34.2021.10.11.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:17:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Oct 2021 07:16:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] blk-cgroup: check blkcg policy is enabled in
 blkg_create()
Message-ID: <YWRxi2OaIHhG9rOc@slm.duckdns.org>
References: <20211008072720.797814-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008072720.797814-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 08, 2021 at 03:27:20PM +0800, Yu Kuai wrote:
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index eb48090eefce..00e1d97621ea 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -226,6 +226,20 @@ struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
>  }
>  EXPORT_SYMBOL_GPL(blkg_lookup_slowpath);
>  
> +static void blkg_check_pd(struct request_queue *q, struct blkcg_gq *blkg)
> +{
> +	int i;
> +
> +	for (i = 0; i < BLKCG_MAX_POLS; i++) {
> +		struct blkcg_policy *pol = blkcg_policy[i];
> +
> +		if (blkg->pd[i] && !blkcg_policy_enabled(q, pol)) {
> +			pol->pd_free_fn(blkg->pd[i]);
> +			blkg->pd[i] = NULL;
> +		}
> +	}
> +}
> +
>  /*
>   * If @new_blkg is %NULL, this function tries to allocate a new one as
>   * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
> @@ -252,6 +266,9 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  		goto err_free_blkg;
>  	}
>  
> +	if (new_blkg)
> +		blkg_check_pd(q, new_blkg);
> +

Can't this happen the other way around too? ie. Linking a pd which doesn't
have an entry for a policy which got enabled inbetween? And what if an
existing policy was de-registered and another policy got the policy id
inbetween? I think the correct solution here would be synchronizing alloc -
create blocks against policy deactivation rather than trying to patch an
allocated blkg later. Deactivation being a really slow path, there are
plenty of options. The main challenge would making it difficult to make
mistakes with, I guess.

Thanks.

-- 
tejun
