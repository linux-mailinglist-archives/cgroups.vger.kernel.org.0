Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4A387FF9
	for <lists+cgroups@lfdr.de>; Tue, 18 May 2021 20:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhERSyo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 May 2021 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351686AbhERSyo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 May 2021 14:54:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF165C061573;
        Tue, 18 May 2021 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oSWP8vajmc6Gi5h6aBbsbC+8taP14EjR7xZIHx+2buM=; b=qXZncWhEP2ILcY0hl8axexb1Wq
        A+7qQtZ89fXZpzBeF8z3a6dQluFMortMkxyupWV793d4136Z2Ic52KxLsCadqQ13NvM+tgVZbg3Ub
        9IQ9kD4ZHcrwl/LnPibA8AQctV0b9V9npgVvc5LYJsjDOAjjKM32hZDT0Aa/uchVFT5qPWfulYa5C
        9DGpI/EdJco3CRTDVUI7ARElCTc941jl+d4K9jeRqZVdTKNlQwN2ILFP3InKrGaq8Ab0aOMQ/0EnF
        fOAaeoPDvExwg5QeACwbNy4O2AWLTREb4PCM6ITckSAdW/Z9zQfRhcqLqPrsegYEms24nrDRL3s3S
        oSGDyTKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lj4pp-001exu-1F; Tue, 18 May 2021 18:52:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B584980E54; Tue, 18 May 2021 20:52:51 +0200 (CEST)
Date:   Tue, 18 May 2021 20:52:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        minchan@kernel.org, corbet@lwn.net, bristot@redhat.com,
        paulmck@kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de, macro@orcam.me.uk,
        viresh.kumar@linaro.org, mike.kravetz@oracle.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <20210518185251.GI5618@worktop.programming.kicks-ass.net>
References: <20210518020200.1790058-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518020200.1790058-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 17, 2021 at 07:02:00PM -0700, Suren Baghdasaryan wrote:

> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3cff41f..4b8e72640ac9 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -148,6 +148,7 @@
>  static int psi_bug __read_mostly;
>  
>  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> +DEFINE_STATIC_KEY_FALSE(psi_cgroups_disabled);

I'm thinking the whole thing will be easier/clearer when you make this:

DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);

>  
>  #ifdef CONFIG_PSI_DEFAULT_DISABLED
>  static bool psi_enable;
> @@ -211,6 +212,9 @@ void __init psi_init(void)
>  		return;
>  	}
>  
> +	if (!cgroup_psi_enabled())
> +		static_branch_enable(&psi_cgroups_disabled);

	if (!cgroup_psi_enabled())
		static_branch_disable(&psi_cgroups_enabled);

> +
>  	psi_period = jiffies_to_nsecs(PSI_FREQ);
>  	group_init(&psi_system);
>  }
> @@ -744,23 +748,23 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  
>  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>  {
> +	if (*iter == &psi_system)
> +		return NULL;
> +
>  #ifdef CONFIG_CGROUPS
> +	if (!static_branch_likely(&psi_cgroups_disabled)) {

	if (static_branch_likely(&psi_cgroups_enabled)) {

> +		struct cgroup *cgroup = NULL;
>  
> +		if (!*iter)
> +			cgroup = task->cgroups->dfl_cgrp;
> +		else
> +			cgroup = cgroup_parent(*iter);
>  
> +		if (cgroup && cgroup_parent(cgroup)) {
> +			*iter = cgroup;
> +			return cgroup_psi(cgroup);
> +		}
>  	}
>  #endif
>  	*iter = &psi_system;
>  	return &psi_system;

But yes, very nice.
