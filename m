Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32D5268A2
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383130AbiEMRkr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383141AbiEMRko (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:40:44 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9937016;
        Fri, 13 May 2022 10:40:43 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id p3so7165319qvi.7;
        Fri, 13 May 2022 10:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MZPDNReCfpGOB46frlHXLcrwoU/2JHKCaMINteeNS58=;
        b=afEXoGfpoxSKjkcaEEGsTKVHodun2p9dkUAy0iJ6s18T2CqWXUB74ERilAYOJLLZN1
         e5iYqjHdBmB7XFIPMCfZJOZvR62oRil+h1qs14wGeof12rwzEiDQixpyLsOQKwPftWqv
         oLo75Y5IISC3/7IWru7mSuB3mns2uTLkQ1ZNYYflo61m719yRweKxoX3366BzN+C2ER9
         QNGIk+MCwJWTRSMG8DNvSPvzRI9FHNQDbX6lZtfYJQD1XI9kTetpQwWd6QNhePaJmDAf
         FDloEYy251sgDdps+64YZn3DP8cBbtnkfj4ucGTtyTZbzUn4PuHe+LEJM/+VD+2jKwqm
         RpFw==
X-Gm-Message-State: AOAM531whnONAOQKUE0dIn7owHsX6b5hRirIVPYZQEPhg9Hs2J3sqZBJ
        YNQKSECtEH2NuG/BN20tbD4=
X-Google-Smtp-Source: ABdhPJzp7kF41QYLvl7mWpcQEP8IwMsLosXZMY7YCtTDaXVD4DMh7jSdnT14/vWxbkpYN3ZvbpIWhg==
X-Received: by 2002:ad4:5bc1:0:b0:42c:3700:a6df with SMTP id t1-20020ad45bc1000000b0042c3700a6dfmr5395752qvt.94.1652463642530;
        Fri, 13 May 2022 10:40:42 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-119.fbsv.net. [2a03:2880:20ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id y68-20020a37af47000000b0069fc13ce1f3sm1723568qke.36.2022.05.13.10.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:40:42 -0700 (PDT)
Date:   Fri, 13 May 2022 10:40:40 -0700
From:   David Vernet <void@manifault.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        tj@kernel.org, Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 1/4] selftests: memcg: Fix compilation
Message-ID: <20220513174040.x5fgcla3q3cqkeck@dev0025.ash9.facebook.com>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-2-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513171811.730-2-mkoutny@suse.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 07:18:08PM +0200, Michal Koutný wrote:
> This fixes mis-applied changes from commit 72b1e03aa725 ("cgroup:
> account for memory_localevents in test_memcg_oom_group_leaf_events()").
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 25 +++++++++++--------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 6ab94317c87b..4958b42201a9 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1241,7 +1241,16 @@ static int test_memcg_oom_group_leaf_events(const char *root)
>  	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
>  		goto cleanup;
>  
> -	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
> +	parent_oom_events = cg_read_key_long(
> +			parent, "memory.events", "oom_kill ");
> +	/*
> +	 * If memory_localevents is not enabled (the default), the parent should
> +	 * count OOM events in its children groups. Otherwise, it should not
> +	 * have observed any events.
> +	 */
> +	if (has_localevents && parent_oom_events != 0)
> +		goto cleanup;
> +	else if (!has_localevents && parent_oom_events <= 0)
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;
> @@ -1349,20 +1358,14 @@ static int test_memcg_oom_group_score_events(const char *root)
>  	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
>  		goto cleanup;
>  
> -	parent_oom_events = cg_read_key_long(
> -			parent, "memory.events", "oom_kill ");
> -	/*
> -	 * If memory_localevents is not enabled (the default), the parent should
> -	 * count OOM events in its children groups. Otherwise, it should not
> -	 * have observed any events.
> -	 */
> -	if ((has_localevents && parent_oom_events == 0) ||
> -	     parent_oom_events > 0)
> -		ret = KSFT_PASS;
> +	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 3)
> +		FAIL(cleanup);
>  
>  	if (kill(safe_pid, SIGKILL))
>  		goto cleanup;
>  
> +	ret = KSFT_PASS;
> +
>  cleanup:
>  	if (memcg)
>  		cg_destroy(memcg);
> -- 
> 2.35.3
> 

Thanks for the fix, Michal.

Reviewed-by: David Vernet <void@manifault.com>
