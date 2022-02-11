Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C94B256D
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 13:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiBKMNv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 07:13:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiBKMNu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 07:13:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B62B42
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 04:13:48 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so22467588eje.10
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 04:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZFYLN+S6IkbZKtWQGnLOGDHtfELHim7rgW7KJNl2oA=;
        b=GgzQiLfzSmdOrEWpzLCjSq3QC0hcb9rDCloigLalwdcFW/g9GKJ3a3Z0+28hLH8wbK
         xp8IGtFCVCVQSyA9ZhpEaqrHjiShC/ZCizU4JmHjIzZ1F66JmvkQELHdJPnjFBAkJI3Q
         hXYU9/IjNZR9rTRX5wDuSaFBFFg905KXUmqWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZFYLN+S6IkbZKtWQGnLOGDHtfELHim7rgW7KJNl2oA=;
        b=ZUzdTrfU/GZFsy7b/G2flvxmY8lVlMlGVV9g9mC/zJH1OFWC4nWbuQHfMZkMRRRZUS
         p7pPANhCDbfmt5A1NvzLDyVq06BKXK25TiZb630XZ0mi2B6Puoj+FfrG7z2ZKRK3WFUF
         Sr3sFZZ4cyFN4nDKLnrI10keGHRIvyzkAUaLEnjuU2scg3PwJm/oj9NzCTnD6k4DRv2V
         4VcvJFm/VgnsGJ44ZBaTDwfVCcBq6Ebk+pQMXLyd5H2Vrb1Qw14Gk2vwdL7o+zCLvnNS
         IRRxezdNVm52VLaXZSzR6c5S893sodXpt60BhBJ670ee2dPDmu8DLtlne3RoxJOF+cCI
         A+Ig==
X-Gm-Message-State: AOAM532M74CYmkOvM/y2IU2bq71HcgN4v1oJFCb755GF2nCS6eZDRD3c
        6f6DKtseFi9cIBeeapzUdMnwAg==
X-Google-Smtp-Source: ABdhPJyRtqUrUs+M3S+hu6tQUEiRGJ5QkqmMDrFjSkY5y8JkhDvsNhfxzQOQjlNJnDEFjbBJjNU4UA==
X-Received: by 2002:a17:906:3b42:: with SMTP id h2mr1147665ejf.647.1644581626601;
        Fri, 11 Feb 2022 04:13:46 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:bc0d])
        by smtp.gmail.com with ESMTPSA id i22sm5828777ejx.128.2022.02.11.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:13:45 -0800 (PST)
Date:   Fri, 11 Feb 2022 12:13:45 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] memcg: synchronously enforce memory.high for
 large overcharges
Message-ID: <YgZS+YijLo0/WmEd@chrisdown.name>
References: <20220211064917.2028469-1-shakeelb@google.com>
 <20220211064917.2028469-5-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220211064917.2028469-5-shakeelb@google.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Shakeel Butt writes:
>The high limit is used to throttle the workload without invoking the
>oom-killer. Recently we tried to use the high limit to right size our
>internal workloads. More specifically dynamically adjusting the limits
>of the workload without letting the workload get oom-killed. However due
>to the limitation of the implementation of high limit enforcement, we
>observed the mechanism fails for some real workloads.
>
>The high limit is enforced on return-to-userspace i.e. the kernel let
>the usage goes over the limit and when the execution returns to
>userspace, the high reclaim is triggered and the process can get
>throttled as well. However this mechanism fails for workloads which do
>large allocations in a single kernel entry e.g. applications that
>mlock() a large chunk of memory in a single syscall. Such applications
>bypass the high limit and can trigger the oom-killer.
>
>To make high limit enforcement more robust, this patch makes the limit
>enforcement synchronous only if the accumulated overcharge becomes
>larger than MEMCG_CHARGE_BATCH. So, most of the allocations would still
>be throttled on the return-to-userspace path but only the extreme
>allocations which accumulates large amount of overcharge without
>returning to the userspace will be throttled synchronously. The value
>MEMCG_CHARGE_BATCH is a bit arbitrary but most of other places in the
>memcg codebase uses this constant therefore for now uses the same one.

Note that mem_cgroup_handle_over_high() has its own allocator throttling grace 
period, where it bails out if the penalty to apply is less than 10ms. The 
reclaim will still happen, though. So throttling might not happen even for 
roughly MEMCG_CHARGE_BATCH-sized allocations, depending on the overall size of 
the cgroup and its protection.

>Signed-off-by: Shakeel Butt <shakeelb@google.com>
>---
>Changes since v1:
>- Based on Roman's comment simply the sync enforcement and only target
>  the extreme cases.
>
> mm/memcontrol.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index 292b0b99a2c7..0da4be4798e7 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -2703,6 +2703,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> 		}
> 	} while ((memcg = parent_mem_cgroup(memcg)));
>
>+	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
>+	    !(current->flags & PF_MEMALLOC) &&
>+	    gfpflags_allow_blocking(gfp_mask)) {
>+		mem_cgroup_handle_over_high();

Thanks, I was going to comment on v1 that I prefer to keep the implementation 
of mem_cgroup_handle_over_high if possible since we know that the mechanism has 
been safe in production over the past few years.

One question I have is about throttling. It looks like this new 
mem_cgroup_handle_over_high callsite may mean that throttling is invoked more 
than once on a misbehaving workload that's failing to reclaim since the 
throttling could be invoked both here and in return to userspace, right? That 
might not be a problem, but we should think about the implications of that, 
especially in relation to MEMCG_MAX_HIGH_DELAY_JIFFIES.

Maybe we should record if throttling happened previously and avoid doing it 
again for this entry into kernelspace? Not certain that's the right answer, but 
we should think about what the new semantics should be.

>+	}
> 	return 0;
> }
>
>-- 
>2.35.1.265.g69c8d7142f-goog
>
