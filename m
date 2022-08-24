Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1C59F747
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiHXKS4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiHXKSy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 06:18:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCD575FEB
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 03:18:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h22so22324182ejk.4
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jYmWHg1umNQmTFAwHrCQ8H6AfC+tenyU3IxwvmYsyvo=;
        b=qfFFRs5A0nr5chGy5gZIGGb4C9QrEEKgXqfyx/fNmBO9DMO56woexl6r1J5hd6xkVl
         pLvfy0VeOa50Wh2l1jUgJ+098USlLXKqbAzbAzuiFxp99NBVU11ZvT/9TWP1SCroYNH6
         dMSlnl7vipOpaSRLvPVYtNwGW3xpuQyDPiH28ME27+igm2RkGKmX+bCJRp7CHYcM8goH
         Is5alYIwsk0mWIwD0OHL3dFsZqWJTnBf4Icxr3tJI7xGMK86gxIky2SAfYL4pMdJTRcq
         YLAzLYn54dy/EiDGWopEFP8angsfSlkFeMAazJLpWM1p7yNgDwORj2l/2sryFuDnhPWe
         9OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jYmWHg1umNQmTFAwHrCQ8H6AfC+tenyU3IxwvmYsyvo=;
        b=XRZEEqsmAMlBkRTc2upPRW6OeIGTqpRMx7bAKHMRcrNgcNOjBs9owfBMj2FaaaLONx
         FXg9A1aw2DUd8LS0lwrKtkgR+DrbXLYEqSUkrQmglHmcS68//hk2FhxBgNgSWP4iSj36
         nt2cKZ1Us77KrvM6E+ntPDnoT2eGBm4FLd3SIAQt7P9TdscQh5Yt9z+njSbHIOyYsHC1
         WWJvSVSDxzxZy6gx4F72YafhU5ddr8cxiHeekFZTGuV0esCu3s4UjPYeB60vm/7Pfbvl
         TaBA+I2bhtLNwNANuWL4xUaigRxcLrrEr8Bh09aU/n1XBxFTSsk9FY64kjALsLd+V36k
         Plfw==
X-Gm-Message-State: ACgBeo2x9mkMj2nDf8fBcPfAOOwxgBF1VvEEOICajOw+dL6WvuDW6sLH
        0u0rt+ElRBZjtKisPRRkcWCr+Q==
X-Google-Smtp-Source: AA6agR7KrEG4ut026LV0Mq54d8UpUznV2OMm471/Cdz0HVJekjcDeZXHFvdU2Ez10kvhxXYz6nrh/Q==
X-Received: by 2002:a17:907:6d8f:b0:73d:8416:908b with SMTP id sb15-20020a1709076d8f00b0073d8416908bmr2334903ejc.651.1661336330570;
        Wed, 24 Aug 2022 03:18:50 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:a4c0:2ca9:6d59:782b:fff3])
        by smtp.gmail.com with ESMTPSA id fb17-20020a1709073a1100b0072b32de7794sm963537ejc.70.2022.08.24.03.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 03:18:49 -0700 (PDT)
Date:   Wed, 24 Aug 2022 06:18:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] sched/psi: cache parent psi_group to speed up
 groups iterate
Message-ID: <YwX7CeeRDDAhV3UH@cmpxchg.org>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-10-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824081829.33748-10-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Chengming,

This looks generally good to me, but I have one comment:

On Wed, Aug 24, 2022 at 04:18:28PM +0800, Chengming Zhou wrote:
> @@ -772,30 +772,18 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
>  }
>  
> -static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> +static inline struct psi_group *task_psi_group(struct task_struct *task)
>  {
> -	if (*iter == &psi_system)
> -		return NULL;
> -
>  #ifdef CONFIG_CGROUPS
> -	if (static_branch_likely(&psi_cgroups_enabled)) {
> -		struct cgroup *cgroup = NULL;
> -
> -		if (!*iter)
> -			cgroup = task->cgroups->dfl_cgrp;
> -		else
> -			cgroup = cgroup_parent(*iter);
> -
> -		if (cgroup && cgroup_parent(cgroup)) {
> -			*iter = cgroup;
> -			return cgroup_psi(cgroup);
> -		}
> -	}
> +	if (static_branch_likely(&psi_cgroups_enabled))
> +		return cgroup_psi(task_dfl_cgroup(task));
>  #endif
> -	*iter = &psi_system;
>  	return &psi_system;
>  }
>  
> +#define for_each_psi_group(group) \
> +	for (; group; group = group->parent)

It would be better to open-code this. It's hiding that it's walking
ancestors, and the name and single parameter suggest it's walking some
global list - not that the parameter is iterator AND starting point.

This makes for particularly obscure code in the discontiguous loops in
psi_task_switch():

	group = task_psi_group(task);
	for_each_psi_group(group)
		if (group == common)
			break;
	/* This looks like a second full loop: */
	for_each_psi_group(group)
		...

>  static void psi_flags_change(struct task_struct *task, int clear, int set)
>  {
>  	if (((task->psi_flags & set) ||
> @@ -815,7 +803,6 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>  {
>  	int cpu = task_cpu(task);
>  	struct psi_group *group;
> -	void *iter = NULL;
>  	u64 now;
>  
>  	if (!task->pid)
> @@ -825,7 +812,8 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>  
>  	now = cpu_clock(cpu);
>  
> -	while ((group = iterate_groups(task, &iter)))
> +	group = task_psi_group(task);
> +	for_each_psi_group(group)
>  		psi_group_change(group, cpu, clear, set, now, true);

task_psi_group() is never NULL, so this should be a do-while loop:

	group = task_psi_group(task);
	do {
		psi_group_change(group, cpu, clear, set, now, true);
	} while ((group = group->parent));

> @@ -834,7 +822,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  {
>  	struct psi_group *group, *common = NULL;
>  	int cpu = task_cpu(prev);
> -	void *iter;
>  	u64 now = cpu_clock(cpu);
>  
>  	if (next->pid) {
> @@ -845,8 +832,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 * we reach the first common ancestor. Iterate @next's
>  		 * ancestors only until we encounter @prev's ONCPU.
>  		 */
> -		iter = NULL;
> -		while ((group = iterate_groups(next, &iter))) {
> +		group = task_psi_group(next);
> +		for_each_psi_group(group) {

Ditto.

>  			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
>  			    PSI_ONCPU) {
>  				common = group;
> @@ -887,9 +874,12 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  
>  		psi_flags_change(prev, clear, set);
>  
> -		iter = NULL;
> -		while ((group = iterate_groups(prev, &iter)) && group != common)
> +		group = task_psi_group(prev);
> +		for_each_psi_group(group) {
> +			if (group == common)
> +				break;

Ditto.

>  			psi_group_change(group, cpu, clear, set, now, wake_clock);
> +		}
>  
>  		/*
>  		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
> @@ -897,7 +887,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 */
>  		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
>  			clear &= ~TSK_ONCPU;
> -			for (; group; group = iterate_groups(prev, &iter))
> +			for_each_psi_group(group)
>  				psi_group_change(group, cpu, clear, set, now, wake_clock);

This can stay as is, group may already be NULL here.

> @@ -907,7 +897,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  void psi_account_irqtime(struct task_struct *task, u32 delta)
>  {
>  	int cpu = task_cpu(task);
> -	void *iter = NULL;
>  	struct psi_group *group;
>  	struct psi_group_cpu *groupc;
>  	u64 now;
> @@ -917,7 +906,8 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
>  
>  	now = cpu_clock(cpu);
>  
> -	while ((group = iterate_groups(task, &iter))) {
> +	group = task_psi_group(task);
> +	for_each_psi_group(group) {
>  		groupc = per_cpu_ptr(group->pcpu, cpu);

do-while again.

With that,
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
