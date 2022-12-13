Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37B64B48B
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 12:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiLMLzv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 06:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiLMLzM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 06:55:12 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BA5102D;
        Tue, 13 Dec 2022 03:55:08 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id s5so17314714edc.12;
        Tue, 13 Dec 2022 03:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XZuwJDjdEOaeQVTLvqRQVjwN4TdXZBL83KGKTvSzg4=;
        b=L/GSZDlisw1C6AaVYtkZxmCTgMnGTuaMW/+gdxF2Ece9GgVpj5Phh6FsOn1XyoWnL4
         W4Xl7CD5x4ZLqO7X2idv85tC1zXobWkPFsT+7FFvi7fL4TB7ipAhaUWc8jrPCI0UZ2V9
         iM0iHRhKlcL3Gnn/sGM8Nyx32/iZpsK+Vab8h3R2X4JyVQYWtf4io8bY/5z/07PFhUBc
         RjUT2QstDe74VVVNB+tWx0JCo0+/kbZbsZIbh8zaQHFn2kYclzbknTsJUHU0ylOnD0gN
         qN7UxDW2sqAGJV4F5cNGUL1JEJGt7u7QF+DUvBxny5N8vXffLG8LGXWC50aZifIBEZw1
         EfcA==
X-Gm-Message-State: ANoB5pl8J30FmOomWUcki9/JtYEATMOMuCWNpQ4E1qAjfmVlmHHn9sxi
        E7Hbb0n718I7cEYAHy8aDlWEOQNsYCM=
X-Google-Smtp-Source: AA0mqf60m7cS8CiO5ah/JqYwgVY4QRH8q62ebMpYronIkiSF598ZIpmlQOw+VZ5bD1tiNtuvCo914w==
X-Received: by 2002:a05:6402:4284:b0:45c:835c:eab7 with SMTP id g4-20020a056402428400b0045c835ceab7mr17743125edc.37.1670932506925;
        Tue, 13 Dec 2022 03:55:06 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id s9-20020a508d09000000b00462e1d8e914sm4883334eds.68.2022.12.13.03.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 03:55:06 -0800 (PST)
Message-ID: <4e74fc1d-1e27-282e-5942-4bc52ab2f7a3@kernel.org>
Date:   Tue, 13 Dec 2022 12:55:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] block/blk-iocost (gcc13): move large values to a new
 enum
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20221213112148.15235-1-jirislaby@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221213112148.15235-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 13. 12. 22, 12:21, Jiri Slaby (SUSE) wrote:
> Since gcc13, each member of an enum has the same type as the enum [1]. And
> that is inherited from its members. Provided:
>    VTIME_PER_SEC_SHIFT     = 37,
>    VTIME_PER_SEC           = 1LLU << VTIME_PER_SEC_SHIFT,
> the named type is unsigned long.
> 
> This generates warnings with gcc-13:
>    block/blk-iocost.c: In function 'ioc_weight_prfill':
>    block/blk-iocost.c:3037:37: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int'
> 
>    block/blk-iocost.c: In function 'ioc_weight_show':
>    block/blk-iocost.c:3047:34: error: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int'
> 
> So move the large VTIME values away to a separate enum, so that they
> don't affect other members. Move also VRATE ones as they depend on
> VTIME.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

NACK

I forgot to remove the previous "casts" patch and the warning still 
triggers with this v2 alone. Let me do a v3 after finding the root cause.

> Cc: Martin Liska <mliska@suse.cz>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: cgroups@vger.kernel.org
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
> 
> Notes:
>      [v2] move to a new enum
> 
>   block/blk-iocost.c | 48 ++++++++++++++++++++++++----------------------
>   1 file changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index d1bdc12deaa7..49d6e5aec3d5 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -233,29 +233,6 @@ enum {
>   	/* 1/64k is granular enough and can easily be handled w/ u32 */
>   	WEIGHT_ONE		= 1 << 16,
>   
> -	/*
> -	 * As vtime is used to calculate the cost of each IO, it needs to
> -	 * be fairly high precision.  For example, it should be able to
> -	 * represent the cost of a single page worth of discard with
> -	 * suffificient accuracy.  At the same time, it should be able to
> -	 * represent reasonably long enough durations to be useful and
> -	 * convenient during operation.
> -	 *
> -	 * 1s worth of vtime is 2^37.  This gives us both sub-nanosecond
> -	 * granularity and days of wrap-around time even at extreme vrates.
> -	 */
> -	VTIME_PER_SEC_SHIFT	= 37,
> -	VTIME_PER_SEC		= 1LLU << VTIME_PER_SEC_SHIFT,
> -	VTIME_PER_USEC		= VTIME_PER_SEC / USEC_PER_SEC,
> -	VTIME_PER_NSEC		= VTIME_PER_SEC / NSEC_PER_SEC,
> -
> -	/* bound vrate adjustments within two orders of magnitude */
> -	VRATE_MIN_PPM		= 10000,	/* 1% */
> -	VRATE_MAX_PPM		= 100000000,	/* 10000% */
> -
> -	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
> -	VRATE_CLAMP_ADJ_PCT	= 4,
> -
>   	/* if IOs end up waiting for requests, issue less */
>   	RQ_WAIT_BUSY_PCT	= 5,
>   
> @@ -310,6 +287,31 @@ enum {
>   	LCOEF_RANDIO_PAGES	= 4096,
>   };
>   
> +enum {
> +	/*
> +	 * As vtime is used to calculate the cost of each IO, it needs to
> +	 * be fairly high precision.  For example, it should be able to
> +	 * represent the cost of a single page worth of discard with
> +	 * suffificient accuracy.  At the same time, it should be able to
> +	 * represent reasonably long enough durations to be useful and
> +	 * convenient during operation.
> +	 *
> +	 * 1s worth of vtime is 2^37.  This gives us both sub-nanosecond
> +	 * granularity and days of wrap-around time even at extreme vrates.
> +	 */
> +	VTIME_PER_SEC_SHIFT	= 37,
> +	VTIME_PER_SEC		= 1LLU << VTIME_PER_SEC_SHIFT,
> +	VTIME_PER_USEC		= VTIME_PER_SEC / USEC_PER_SEC,
> +	VTIME_PER_NSEC		= VTIME_PER_SEC / NSEC_PER_SEC,
> +
> +	/* bound vrate adjustments within two orders of magnitude */
> +	VRATE_MIN_PPM		= 10000,	/* 1% */
> +	VRATE_MAX_PPM		= 100000000,	/* 10000% */
> +
> +	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
> +	VRATE_CLAMP_ADJ_PCT	= 4,
> +};
> +
>   enum ioc_running {
>   	IOC_IDLE,
>   	IOC_RUNNING,

-- 
js
suse labs

