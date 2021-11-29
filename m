Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F434627CB
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 00:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhK2XKf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 18:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhK2XJx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 18:09:53 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0151C03AA25;
        Mon, 29 Nov 2021 10:16:53 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g18so17779289pfk.5;
        Mon, 29 Nov 2021 10:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U/lV8E1L2sRsBwRPS+If7j1bCTz7XAKccet53yRJUbM=;
        b=E/V2jd5RtTT4t+mQMJCGTXfQJ5vhNpgk9p5ctLDOVJ2smfpN9GfGuTsgwFgP6gSR4q
         9isZVjEZ4A6h4kyVfNn0GB8jbgo1EFcyVyIrmGH9jWdFfwTgQcbIcQMtYYM8tPZJKoIN
         ZhNbUdFhmq4JZv4Om/B9nwLYWZabIjp+QtpSpnm7HYDTrwAPg9dqulgC13L61gpdYkVI
         HOR82Zo6pY5INibMkwItuLjQ0tlA+qEp21FDsrc0acq1oJb8nNKruIARFunKoJ56rMu4
         FfXc4XbveK3z2cLWl9LX+SiG6pC72bGbLrz6Q/OY0//UcVQqTcNeyxDXYQQL5P68KvRH
         OCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=U/lV8E1L2sRsBwRPS+If7j1bCTz7XAKccet53yRJUbM=;
        b=cFN0SWmsVMlsr3AwCtAkATdFyU98UN69LKu/Bn0fOYCio0/3z5LBkVdGmBUWp+tIGw
         G+tG3Nt/9jN3erlBr0eO+QArg22qzC9EHTvS7gXGHt5EExj918XilhVeABISYidVUD7g
         IsgQidN30twv9Xe+gh/pgpaw2x8bEDcQ1Fhryi+dg8tfUGSlMLmbDgbgSjr9Uo1glB7q
         aRmAVPZZEgSDrF6dzOn9T+hyvoFkEodBSFwVJhj2/6s4Ica74zupY6Bvt24BmqJp9Nkf
         49m2zFJSjvWrafg01376qnuqvVtIeHglnK10YoWQT/RZAgIc8/yxqiQln8+jM2kCW6rP
         /X0A==
X-Gm-Message-State: AOAM530MKqdCiZnlWltYFY1q47U/40QgjZGCTAwrEAlRRp+IaYU1Ci60
        Qm2oGy0L1s3ELecGsV7PI2QZwLupU0lN1w==
X-Google-Smtp-Source: ABdhPJyjw0DqgX3V+/kqLgS46RggjIjDjIjz1Z1EXIzQIKoG9/8p67gg4EJRQI20HFPRJMOpCuAOlw==
X-Received: by 2002:aa7:870d:0:b0:49f:e41d:4f8d with SMTP id b13-20020aa7870d000000b0049fe41d4f8dmr42145998pfo.16.1638209813407;
        Mon, 29 Nov 2021 10:16:53 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nn4sm22937pjb.38.2021.11.29.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:16:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 29 Nov 2021 08:16:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] blk-throttle: Set BIO_THROTTLED when bio has been
 throttled
Message-ID: <YaUZExR6v8IdZUeM@slm.duckdns.org>
References: <20211118131551.810931-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118131551.810931-1-qiulaibin@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Nov 18, 2021 at 09:15:51PM +0800, Laibin Qiu wrote:
> 1.In current process, all bio will set the BIO_THROTTLED flag
> after __blk_throtl_bio().
> 
> 2.If bio needs to be throttled, it will start the timer and
> stop submit bio directly. Bio will submit in blk_throtl_dispatch_work_fn()
> when the timer expires. But in the current process, if bio is throttled.
> The BIO_THROTTLED will be set to bio after timer start. If the bio
> has been completed, it may cause use-after-free.
> 
> Fix this by move BIO_THROTTLED set before timer set.

Have you tried reproducing and confirming the above in any way?

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 39bb6e68a9a2..ddfbff4465d5 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2149,6 +2149,7 @@ bool __blk_throtl_bio(struct bio *bio)
>  	td->nr_queued[rw]++;
>  	throtl_add_bio_tg(bio, qn, tg);
>  	throttled = true;
> +	bio_set_flag(bio, BIO_THROTTLED);
>  
>  	/*
>  	 * Update @tg's dispatch time and force schedule dispatch if @tg
> @@ -2163,7 +2164,6 @@ bool __blk_throtl_bio(struct bio *bio)
>  
>  out_unlock:
>  	spin_unlock_irq(&q->queue_lock);
> -	bio_set_flag(bio, BIO_THROTTLED);

Because it seems wrong in two ways:

* This function is called synchronously on the issue path. The bio isn't
  seen by the queue and device driver yet and nothing can race to issue it
  before this function returns.

* Now we're not setting BIO_THROTTLED when we're taking a different return
  path through the out_unlock label and risks calling back into blk_throtl
  again on the same bio.

In general, if you think you spotted an issue, please try to trigger it in
however way possible to confirm that the issue is real.

Thanks.

-- 
tejun
