Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39F3DA9C7
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 19:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhG2RLp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhG2RLo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 13:11:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F05BC061765;
        Thu, 29 Jul 2021 10:11:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b6so11213627pji.4;
        Thu, 29 Jul 2021 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vwili5Ap3pl5QTQqz8bc1S7CjPVAgBWQMamZ9XQVdO4=;
        b=iT/gDga4Q09cV3tRMXD5HCdMqu54krFqAdGOn3IVbHrIUuIJKufh/9zsc2S76ZQQXR
         HFcSP8MMW8c2pLGKGrkHNFGTjmT6XcvFk7Ydam8QwwSxmGc2uUAUOBc7vgV94yksLCbm
         5g6jBi3tmExqgi5PtPz1If7SVyGOKnDFb7ShBegl1TRFWjUyJiz187mcVe9FGcEthtWE
         fio7y7AZ+6HJ4Xge03I++TWhDsyCynxfLIvLFd2Mw3Vyq2nR7/NdjdsOFtol/k9QcFP6
         WVWF8GQjsJtJB5gVq+KytIjw5niqWi7/Eh8F6QlDnTawp+qhc9z1hd6TqBvGzKCtUAAr
         1cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vwili5Ap3pl5QTQqz8bc1S7CjPVAgBWQMamZ9XQVdO4=;
        b=oPU3XYkXRSm4EIy8XUfBnOR8QyRJYSpgiLHD5fZwMuvPBDi1QwYmLxzyBzXUAZDMBw
         N+591Z9u/gkih/DQ+ylD017FnHEhRDG+Zf9kd/lN+0w7T7RzKVg07lxgKJsBTHR75b8e
         yFlSj3S+L8gjL53fUfIcOjidPsBvFF9KbOiYIqwz/nKKuixKkRfHqU3Q25ZEN5ocu07q
         9ZbWWTmzQkCdAvjxFCccWlHxrAGycC9SGqPkp9lXcK5Iu4OcQCZj8r3zsfJNNkICqewp
         t+CsBI1XMSjboN+65qsFMQKywlmXdW+A2iAcRi2IYCMvtlrWMG5Yodu5JcU8zMjgXSEm
         lvKg==
X-Gm-Message-State: AOAM533H0kAgRBDVIQWoyyspzfVt1U1JAPYfMmzhLMVVpeSgAEShlB8F
        v3naqlsDp39wVOgugQWh4Kw=
X-Google-Smtp-Source: ABdhPJyLj0LNatiDfmCRGU+euAPbCw3/KzESbb7ezYVlpBaMpmeSg59g33hAw1YtZBWYGNl1bnwQjg==
X-Received: by 2002:a63:7f48:: with SMTP id p8mr1758975pgn.184.1627578699815;
        Thu, 29 Jul 2021 10:11:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9699])
        by smtp.gmail.com with ESMTPSA id s50sm4205467pfw.212.2021.07.29.10.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:11:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 29 Jul 2021 07:11:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throtl: optimize IOPS throttle for large IO
 scenarios
Message-ID: <YQLhRrkZrmKTzfbP@mtj.duckdns.org>
References: <40915233274d31bb0659ff9f3be8900a5a0e81ba.1627462548.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40915233274d31bb0659ff9f3be8900a5a0e81ba.1627462548.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jul 28, 2021 at 05:01:41PM +0800, brookxu wrote:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index a11b3b5..86ff943 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -348,6 +348,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
>  		trace_block_split(split, (*bio)->bi_iter.bi_sector);
>  		submit_bio_noacct(*bio);
>  		*bio = split;
> +
> +		blk_throtl_recharge_bio(*bio);

Can you rename this blk_throtl_charge_bio_split()?

> @@ -524,6 +537,11 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
>  	tg->idletime_threshold = DFL_IDLE_THRESHOLD;
>  	tg->idletime_threshold_conf = DFL_IDLE_THRESHOLD;
>  
> +	atomic_set(&tg->io_split_cnt[0], 0);
> +	atomic_set(&tg->io_split_cnt[1], 0);
> +	atomic_set(&tg->last_io_split_cnt[0], 0);
> +	atomic_set(&tg->last_io_split_cnt[1], 0);

We likely don't need these. pd's zeroed on allocation.

> @@ -877,10 +900,19 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>  	else
>  		tg->bytes_disp[rw] = 0;
>  
> -	if (tg->io_disp[rw] >= io_trim)
> +	if (tg_io_disp(tg, rw) >= io_trim) {

Instead of checking this in multiple places, would it be simpler to transfer
the atomic counters to the existing counters whenever we enter blk-throtl
and leave the rest of the code as-is?

Thanks.

-- 
tejun
