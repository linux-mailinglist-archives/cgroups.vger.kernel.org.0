Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57D708EBD
	for <lists+cgroups@lfdr.de>; Fri, 19 May 2023 06:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjESEQf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 May 2023 00:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjESEQb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 May 2023 00:16:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F1E7F
        for <cgroups@vger.kernel.org>; Thu, 18 May 2023 21:16:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3578c25bso72831b3a.3
        for <cgroups@vger.kernel.org>; Thu, 18 May 2023 21:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684469763; x=1687061763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+1GUC3Yam0K9EDsvFQ9GSyTFpfzCRIN9846sNrHODE=;
        b=inMXzVIm8okKpiM3pIDom7XfUcukiWakU2TIFKWCt3gTHbS5lgLvn0BVw60XvNf3GV
         AbBKNivSG6q8fOuiPhcQx/4p3n4J13fyXSkOroeEYGfIekVdFwv1+BHuKnbYpqjckORo
         RRS1lpUrmuwoiCgUFa7Lcm2wzUB+q2ooRYahH9YQ4/6CsYdT1BQomzPU0U8O7Nh2drz7
         P0Q1ginbXEFw8sG4JlQHX7H8xEmT+889zwzYW0OKYc47Hpmz2U185ceInUt3pKjWpdY9
         GNZdTF1DKBm3Fh6vXTWXInGVVpJ1wxjJLRoDTCb2Juf36QsudV1iwBvLqtUFhvr+zMCM
         HVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469763; x=1687061763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S+1GUC3Yam0K9EDsvFQ9GSyTFpfzCRIN9846sNrHODE=;
        b=DgR3tivfOxcIKqbd+iphbpQi4Vq1jKAXjQB/3vpm4pEO6x5awvWJ0TaVwtjrJCoNMD
         yjzvZVSx87E7HUWKkTDjolLexTpx8sOYTnQG+HQIgtgIcwowmwSM4oEp5eeKvUmd5TJ3
         SQNlkzvcpl5rUQizPCTr6PceKTpTGDZ9mIGCYUg53J/B2ZCUE3P+y7gPTDBIeC/CMzcd
         j6rn5SrlqWEaXFVfI8Y6qu4JRHZSkwR08lLck1SKMCKu9b/ZjF1fCsuZKmr5pf6OlDBn
         Svv/5hk/1dKFq42w/wflqcogq1c4Os2ViyZvq9kP1S+PKArBn+FEXNWX7ZN1uz19Bu50
         0OyQ==
X-Gm-Message-State: AC+VfDwiGCm/rle8MvV2PldoEb5qRCQLbTUYTIvh8u7ruYOzSaAawEDn
        X2qY7k16z0tYi4RXLHNYgu3Vrg==
X-Google-Smtp-Source: ACHHUZ4O6v1LuKd/mdFBywzU/zXmVGtnk0INhbO1xdG1dNVyO2V6z2ZveX1TjJMk6x0oYQYNMFGYTA==
X-Received: by 2002:a05:6a00:2e87:b0:636:f899:46a0 with SMTP id fd7-20020a056a002e8700b00636f89946a0mr1922756pfb.15.1684469763365;
        Thu, 18 May 2023 21:16:03 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79104000000b0063b89300347sm2129940pfh.142.2023.05.18.21.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 21:16:02 -0700 (PDT)
Message-ID: <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
Date:   Fri, 19 May 2023 12:15:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] cgroup: rstat: Simplified cgroup_base_stat_flush() update
 last_bstat logic
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518124142.57644-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230518124142.57644-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/5/18 Hao Jia wrote:
> In cgroup_base_stat_flush() function, {rstatc, cgrp}->last_bstat
> needs to be updated to the current {rstatc, cgrp}->bstat, directly
> assigning values instead of adding the last value to delta.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>   kernel/cgroup/rstat.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 9c4c55228567..3e5c4c1c92c6 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -376,14 +376,14 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
>   	/* propagate percpu delta to global */
>   	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);  *(1)*
>   	cgroup_base_stat_add(&cgrp->bstat, &delta);
> -	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
> +	rstatc->last_bstat = rstatc->bstat;		    *(2)*

Some things are wrong, the value of rstatc->bstat at (1) and (2) may not 
be the same, rstatc->bstat may be updated on other cpu. Sorry for the noise.

>   
>   	/* propagate global delta to parent (unless that's root) */
>   	if (cgroup_parent(parent)) {
>   		delta = cgrp->bstat;
>   		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
>   		cgroup_base_stat_add(&parent->bstat, &delta);
> -		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
> +		cgrp->last_bstat = cgrp->bstat;
>   	}
>   }
>   

Maybe something like this?


In cgroup_base_stat_flush() function, {rstatc, cgrp}->last_bstat
needs to be updated to the current {rstatc, cgrp}->bstat after the
calculation.

For the rstatc->last_bstat case, rstatc->bstat may be updated on other
cpus during our calculation, resulting in inconsistent rstatc->bstat
statistics for the two reads. So we use the temporary variable @cur to
record the read statc->bstat statistics, and use @cur to update
rstatc->last_bstat.

For the cgrp->last_bstat case, we already hold cgroup_rstat_lock, so
cgrp->bstat will not change during the calculation process, and it can
be directly used to update cgrp->last_bstat.

It is better for us to assign directly instead of using
cgroup_base_stat_add() to update {rstatc, cgrp}->last_bstat.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
  kernel/cgroup/rstat.c | 9 +++++----
  1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9c4c55228567..17a6a1fcc2d4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -360,7 +360,7 @@ static void cgroup_base_stat_flush(struct cgroup 
*cgrp, int cpu)
  {
  	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
  	struct cgroup *parent = cgroup_parent(cgrp);
-	struct cgroup_base_stat delta;
+	struct cgroup_base_stat delta, cur;
  	unsigned seq;

  	/* Root-level stats are sourced from system-wide CPU stats */
@@ -370,20 +370,21 @@ static void cgroup_base_stat_flush(struct cgroup 
*cgrp, int cpu)
  	/* fetch the current per-cpu values */
  	do {
  		seq = __u64_stats_fetch_begin(&rstatc->bsync);
-		delta = rstatc->bstat;
+		cur = rstatc->bstat;
  	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));

  	/* propagate percpu delta to global */
+	delta = cur;
  	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
  	cgroup_base_stat_add(&cgrp->bstat, &delta);
-	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
+	rstatc->last_bstat = cur;

  	/* propagate global delta to parent (unless that's root) */
  	if (cgroup_parent(parent)) {
  		delta = cgrp->bstat;
  		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
  		cgroup_base_stat_add(&parent->bstat, &delta);
-		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
+		cgrp->last_bstat = cgrp->bstat;
  	}
  }

