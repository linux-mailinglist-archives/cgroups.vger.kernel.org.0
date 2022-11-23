Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09D6368B7
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiKWS0x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiKWS0o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:26:44 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FE65875;
        Wed, 23 Nov 2022 10:26:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso2573652pjq.5;
        Wed, 23 Nov 2022 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4as57wCvzop8813r3sliHAbaPmxH6ev1auHMwbNdJIo=;
        b=q5rmbKCsyxcX9QqNlu0c2EogSV6OPZ0rXgI0AWmUGlsn6T2cqXAl7igKciAlxyJ5ro
         GQh8tLG5VsdJgCYuyHiFuBPZbLx5qiYLxP11cqxAkaoivBXcaEMcD3Fl0SJwdjeJ0Kzm
         P2LbtGrMKAStFpoQhjZgkgoJ5P4A77HKfdBacxMCDQWLQZ4fOu9vujP2Tkw865riEvVy
         kHIaGkczm4l3CNWEB9lp2GUJgJvNiCmw/XEPl1vmtqklW3PHH6z8Xm1wiiUML/Jt8usc
         h+iAm8CYHS0m8fD9auKC9g62A6VYQL2l1AIM67SSjQ4nlVnwYPgVl3m8nqSRQCGCSgrR
         Ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4as57wCvzop8813r3sliHAbaPmxH6ev1auHMwbNdJIo=;
        b=Wl3slUTpfql25muK33pdj35BhtBAB/nA7SqQ+eNCvVUkj+6k5VJS6rrvVptZHxhR4X
         mLMDkHtePUmlkicLhbftHxdqwtyRAsYNtDm90X8J6x8ObPaYabHrnOD3iIoUYi2tRSHB
         KFfJR6UEtCAPZXvSi6vgoyRVZ2DD8usE2floVa5RoZDdHjvbIwOOWZ89EtBeSDOGjzse
         1NLQ2cIdAk2zeLpO6vNvF4eynCy2OkF0Tbg2YX7FEcCYX55/NQINoQhePT85gA+ipXaQ
         1X419QyHW8mS/sGwliCtn7u+GDGVRtpg4AKko8EOGknEJxE7aSsZYN9T6LOkx5RSJmr0
         tZnA==
X-Gm-Message-State: ANoB5pmUgdiMVu1voNDR5zO8dE7X6o9uVWEXHgzIayR7vxjAje9aCsQT
        cmfOITT6kkQ//Gz3NGPPNRM=
X-Google-Smtp-Source: AA0mqf5xSyp/bZfSLwjBIn16APOxfb0kLIirC8uO3+PhiyCUyGEssHaxtO/NL6Yqh9yhIJw2uTXPnA==
X-Received: by 2002:a17:903:25cb:b0:172:f722:8402 with SMTP id jc11-20020a17090325cb00b00172f7228402mr9899111plb.122.1669227998982;
        Wed, 23 Nov 2022 10:26:38 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902694400b001891ea4d133sm7761660plt.12.2022.11.23.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:26:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:26:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] blk-throttle: simpfy low limit reached check in
 throtl_tg_can_upgrade
Message-ID: <Y35l3cRfYNgCzBgC@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-6-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-6-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:55PM +0800, Kemeng Shi wrote:
> -static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
> +static bool throtl_tg_reach_low_limit(struct throtl_grp *tg, int rw)
>  {
>  	struct throtl_service_queue *sq = &tg->service_queue;
> -	bool read_limit, write_limit;
> +	bool limit = tg->bps[rw][LIMIT_LOW] || tg->iops[rw][LIMIT_LOW];
>  
>  	/*
>  	 * if cgroup reaches low limit (if low limit is 0, the cgroup always
>  	 * reaches), it's ok to upgrade to next limit
>  	 */
> -	read_limit = tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW];
> -	write_limit = tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW];
> -	if (!read_limit && !write_limit)
> -		return true;
> -	if (read_limit && sq->nr_queued[READ] &&
> -	    (!write_limit || sq->nr_queued[WRITE]))
> -		return true;
> -	if (write_limit && sq->nr_queued[WRITE] &&
> -	    (!read_limit || sq->nr_queued[READ]))
> +	return !limit || sq->nr_queued[rw].
> +}
> +
> +static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
> +{
> +	if (throtl_tg_reach_low_limit(tg, READ) &&
> +	    throtl_tg_reach_low_limit(tg, WRITE))

Are the conditions being checked actually equivalent? If so, can you
explicitly explain that these are equivalent conditions? If not, what are we
changing exactly?

Thanks.

-- 
tejun
