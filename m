Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9846462517
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhK2WfX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 17:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhK2We7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 17:34:59 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E5C03AA35;
        Mon, 29 Nov 2021 10:19:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p18so12827410plf.13;
        Mon, 29 Nov 2021 10:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQZmy4cGScvJRiDlRHVd4gzuHUav0YqXgvVm+3n0P84=;
        b=d+idyvNHakWhb7W1cxj73/tcSGYR8+qLm/NoDZ5ro8n/DN2vzjKEcrinrJ7bGnxsxr
         ATXdS+Yuj/kLjB3k/3WmB6m8jR6+CPKUNX7CaL8NTFh4SFSYZVEbfTYN6oQaBXmGiYYn
         /YFwxy+i9nc1fgZiycYoZ8J02PptokM9xDCHIrMYX9gw/ivMB9Kksq3D2tc3Y+GcZd0N
         gpR63e1UH/iJGTfuLblGo9mB95uJIPLfhQQ3RD9jLogaPJps05xd+48YX2DJPkLXsyWA
         p7bOLMTIxKdL4DtGjELnyNkYcqi6hiKHx521vudwlewk105i33Dj1kJRUqexxOpG6GJx
         3N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nQZmy4cGScvJRiDlRHVd4gzuHUav0YqXgvVm+3n0P84=;
        b=T6khnYSbATvnRy8YB6LN91bLwYHcDxFgq+im1z2hEHtrQvGg78xCaFWaDS3+hToNTf
         oEJdzrN7RfVrXVN/nUsmUm4i/Kq3XDB9Nuo1LU9rcFf63w3VZbah7C+IIQ4+6U/rWm95
         oXjTT6pGNg3ALo9NvYGIoFYX7drGaif+Tu3LIGKCk5l0pT7raCMzNObgz12PbCYMZ6gU
         U1+BrFHZsSU2W0ijALN2iJ2+6aC057s8dVvvSngxoghaFRkbrEnOU1GWZYatt6uwcuLA
         kwHXq4NpmY4T9+pMbZWDAtaVdxPbaTLVefvmHnIvmcL0BjTEbO1npZ7UVm3IsA6w+zJw
         0jcA==
X-Gm-Message-State: AOAM532rr2UVtV0KAduyaJaVZbPZUSuddyNPQFRGzDRFW1x+bSZiI+Z1
        +rD1M5qauz99tWpGWMRdZMc=
X-Google-Smtp-Source: ABdhPJyvtHz/445hnKl3EGzHXHqBM5YNV/8eO0nxOvmV8HzDYz0ncry4gmJxh1n1KeYP2g7jf09mWQ==
X-Received: by 2002:a17:90b:4c02:: with SMTP id na2mr26447pjb.94.1638209960962;
        Mon, 29 Nov 2021 10:19:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l4sm19518598pfc.121.2021.11.29.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:19:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 29 Nov 2021 08:19:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, deng.changcheng@zte.com.cn
Subject: Re: [PATCH v2] block: Use div64_ul instead of do_div
Message-ID: <YaUZpZYI71K66Zka@slm.duckdns.org>
References: <20211117010358.158313-1-deng.changcheng@zte.com.cn>
 <20211118034033.163550-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118034033.163550-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 18, 2021 at 03:40:33AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  block/blk-throttle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 39bb6e68a9a2..2db635d66617 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1903,7 +1903,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
>  
>  	if (tg->bps[READ][LIMIT_LOW]) {
>  		bps = tg->last_bytes_disp[READ] * HZ;
> -		do_div(bps, elapsed_time);
> +		bps = div64_ul(bps, elapsed_time);

Yeah, the divisor is ulong for whatever reason but the thing is in jiffies.
I have a hard time imagining it overflowing 32bit. I'm not sure how useful
this patch is.

-- 
tejun
