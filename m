Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177268F7DC
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBHTPR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 14:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHTPQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 14:15:16 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E79253E76
        for <cgroups@vger.kernel.org>; Wed,  8 Feb 2023 11:15:14 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id k28so12131284qve.5
        for <cgroups@vger.kernel.org>; Wed, 08 Feb 2023 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lruqI717GEqwSqhIRWVJHYQvXYTXBA2SnOdHTnWZ0Hc=;
        b=IA5Ku2U10160DCh0OY6jBF0v6JMjNFPl5SHCV2Gd8RxQK0iWl+/G70px3kmh/K5Kd0
         vUlYWWHKGnQG4d2DrtJJYAur+MYTJLuj0NpnAntBKLuNo/pVBromJcAe5QL+yZSHIBvg
         DewxvkaQNlcdyWXTPkFsLzDWotOFqaN4TADBCtGxp9TlxoZxWTTWO2W4fsrEqpVfRrsH
         6euXxZuD3zSaRvIQz/3a3I7Dux/WrkpjlMCVroaKO4F5KbvIqrHtaTsmOJ7koysbnRQL
         umlnq7KV3CC0w0dTKMsS8vmPENmTqy3nzNW2hFUo6+Pcz2Qo2EUbGuUE/tbvaYtmNLxA
         62Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lruqI717GEqwSqhIRWVJHYQvXYTXBA2SnOdHTnWZ0Hc=;
        b=zmEhHfziRX0+CbFUiP90TX069tVL57faBgOTWQnSNjrOUNlxRK1RSlLt+UjmEgHgoY
         BgbBp2veiKRHFdkUTpC4Hf0CXQVixN/o9DR3sw0NbGeuAYP73Zzx05P0Z7cyzlnqst/j
         DfytCgTypRJMrzAmaQnPcxaHcu8Xfy2Z52mfUygoHYLH2UiXq6lTmfYcyQfyR1eY2PF8
         pLLcOqhuvEPAJrZavu85sclZNbE8hai5GloYz/9qm//8Wxdp6Ik+BhS7puAbcRssRdUx
         9xy1IsMNcD16JTa+y4kI8VvJ9u44O/tfekW/Ryizx+nx+nvPxUz16AQnf+F+hUsDuVze
         HvEQ==
X-Gm-Message-State: AO0yUKWQnNUUoxNZGESTVXCfIZFurc2QD+BUNeP6uIdXgZ2x9WdvvUnk
        XaO8Wo3OQxaOhR38W4x4oN4ziQ==
X-Google-Smtp-Source: AK7set/ug93/lcMmFyKXX+hm1DeqdqpfPD8fu48O3VpIbU3k9PDD6/N7LwiYtjC2V501KXN1AgZYSw==
X-Received: by 2002:a05:6214:29ec:b0:56c:183f:49bb with SMTP id jv12-20020a05621429ec00b0056c183f49bbmr6066780qvb.11.1675883713342;
        Wed, 08 Feb 2023 11:15:13 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id d18-20020a05620a241200b007068b49b8absm12433314qkn.62.2023.02.08.11.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:15:12 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:15:12 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
Message-ID: <Y+P0wLTdZcOPiKPZ@cmpxchg.org>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-3-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208161654.99556-3-ryncsn@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 09, 2023 at 12:16:54AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> psi_group->parent has the same hierarchy as the cgroup it's in.
> So just iterate through cgroup instead.
> 
> By adjusting the iteration logic, save some space in psi_group
> struct, and the performance is actually better. I see a measurable
> performance gain using mmtests/perfpipe:
> 
> (AVG of 100 test, ops/sec, the higher the better)
> KVM guest on a i7-9700:
>         psi=0         root cgroup   5 levels of cgroup
> Before: 59221         55352         47821
> After:  60100         56036         50884
> 
> KVM guest on a Ryzen 9 5900HX:
>         psi=0         root cgroup   5 levels of cgroup
> Before: 144566        138919        128888
> After:  145812        139580        133514
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Kairui Song <ryncsn@gmail.com>

Awesome!

A few comments below:

> @@ -858,15 +858,34 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
>  }
>  
> -static inline struct psi_group *task_psi_group(struct task_struct *task)
> +static inline struct psi_group *psi_iter_first(struct task_struct *task, void **iter)

Please name these psi_groups_first() and psi_groups_next().

>  #ifdef CONFIG_CGROUPS
> -	if (static_branch_likely(&psi_cgroups_enabled))
> -		return cgroup_psi(task_dfl_cgroup(task));
> +	if (static_branch_likely(&psi_cgroups_enabled)) {
> +		struct cgroup *cgroup = task_dfl_cgroup(task);
> +
> +		*iter = cgroup_parent(cgroup);
> +		return cgroup_psi(cgroup);
> +	}
>  #endif
>  	return &psi_system;
>  }
>  
> +static inline struct psi_group *psi_iter_next(void **iter)
> +{
> +#ifdef CONFIG_CGROUPS
> +	if (static_branch_likely(&psi_cgroups_enabled)) {
> +		struct cgroup *cgroup = *iter;
> +
> +		if (cgroup) {
> +			*iter = cgroup_parent(cgroup);
> +			return cgroup_psi(cgroup);
> +		}
> +	}
> +#endif
> +	return NULL;
> +}

> @@ -886,6 +905,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>  {
>  	int cpu = task_cpu(task);
>  	struct psi_group *group;
> +	void *iter;
>  	u64 now;
>  
>  	if (!task->pid)
> @@ -895,16 +915,17 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>  
>  	now = cpu_clock(cpu);
>  
> -	group = task_psi_group(task);
> +	group = psi_iter_first(task, &iter);
>  	do {
>  		psi_group_change(group, cpu, clear, set, now, true);
> -	} while ((group = group->parent));
> +	} while ((group = psi_iter_next(&iter)));
>  }
>  
>  void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		     bool sleep)
>  {
>  	struct psi_group *group, *common = NULL;
> +	void *iter;
>  	int cpu = task_cpu(prev);
>  	u64 now = cpu_clock(cpu);

Please add @iter at the end to keep line length sorting.

> @@ -915,7 +936,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 * ancestors with @prev, those will already have @prev's
>  		 * TSK_ONCPU bit set, and we can stop the iteration there.
>  		 */
> -		group = task_psi_group(next);
> +		group = psi_iter_first(prev, &iter);
>  		do {
>  			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
>  			    PSI_ONCPU) {
> @@ -924,7 +945,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  			}
>  
>  			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
> -		} while ((group = group->parent));
> +		} while ((group = psi_iter_next(&iter)));
>  	}
>  
>  	if (prev->pid) {
> @@ -957,12 +978,12 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  
>  		psi_flags_change(prev, clear, set);
>  
> -		group = task_psi_group(prev);
> +		group = psi_iter_first(prev, &iter);
>  		do {
>  			if (group == common)
>  				break;
>  			psi_group_change(group, cpu, clear, set, now, wake_clock);
> -		} while ((group = group->parent));
> +		} while ((group = psi_iter_next(&iter)));
>  
>  		/*
>  		 * TSK_ONCPU is handled up to the common ancestor. If there are
> @@ -972,7 +993,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 */
>  		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
>  			clear &= ~TSK_ONCPU;
> -			for (; group; group = group->parent)
> +			for (; group; group = psi_iter_next(&iter))
>  				psi_group_change(group, cpu, clear, set, now, wake_clock);
>  		}
>  	}
> @@ -983,6 +1004,7 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
>  {
>  	int cpu = task_cpu(task);
>  	struct psi_group *group;
> +	void *iter;
>  	struct psi_group_cpu *groupc;
>  	u64 now;

Ditto. You can move @groupc in the same patch.

Otherwise, this looks good to me. Please add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
