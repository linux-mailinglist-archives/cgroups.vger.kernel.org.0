Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071CC59FCB8
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiHXOGd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 10:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiHXOGO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 10:06:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9098C89
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 07:06:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e21so17356220edc.7
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=WISgtRtj7XAbDMj5crexRB3gKRdBJedqKO8qGlTO7ac=;
        b=T3LH1lzO4KaEX4zn8CgVYuDuv1KauxJR+HLCXKEs3xkm360Emw4hVW/MuvafYZ6sl/
         3JPoNCsUwsH6+piwal7pIV4xPcGk8/LhMhEmlDsIW5wXG1GsuodbK5PAQMitAaN3SklC
         UDZ4VPj9lBpiLtgWK1EICxF2A+N21C/ZEJZAlVolTuMYN7KyxVC3LlArNy48s6WdarRN
         QM7u7L8czZFsRahByWnn++hZx6eXqbmVB8j1Vab8qkWaBUCGWKA7wqQqGZS8B2rDK/6s
         I50j59hZkbewhI7anqmsnrTDwIZg46TVpjej35gDcENEkxdo/tXAd8zJRfrcLqyBaNeq
         DT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WISgtRtj7XAbDMj5crexRB3gKRdBJedqKO8qGlTO7ac=;
        b=sY3DMa9gNI3hFcjEn2tJsW1jpVw+NdPKEXI15Xpj1Q8mthVr7D8Mm37ikieterhmSY
         jEtEVe/9DkCdm/5QFZQoF4bZY7aRILZIsHegEEPChZY7e4tHWrBcZeqU7H5OMf6qaO/g
         yY2/tecT3CBbMuolDQcmaDNtBd1BApudo7KjX5q73RbMuEUDYLxC7up7HBMWDZt/6biL
         aWQ4+fA1VDpIWvTcaywRBF5GfhxG0g/TM0aqRtrgIzUT+Q1x2iaRc+PJ4dLKS/O8OkjJ
         JouIMNNg2bSaUQDvLs1SwX2x0iZEILAjwg+eSoX/5C4ORwVjeuyAdfY8Y9h2YGahJxhT
         669A==
X-Gm-Message-State: ACgBeo1/ujJMm0ZdduEfxPl2qbp+oYaKC+Y+v15s+cqhe7q20i/dSiG+
        PRxh/ShHdLPnwYOH+JzDLSyZhw==
X-Google-Smtp-Source: AA6agR5yguLUR17cvPndc4QbDiWkEyiOKg4uGJnQ8vcfvPlTxDs7gcZCwbc7LsXL9nbmZwpGfFI8Ig==
X-Received: by 2002:a05:6402:f14:b0:447:7944:558 with SMTP id i20-20020a0564020f1400b0044779440558mr3068928eda.29.1661349969800;
        Wed, 24 Aug 2022 07:06:09 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:a4c0:2ca9:6d59:782b:fff3])
        by smtp.gmail.com with ESMTPSA id cz21-20020a0564021cb500b004465d1db765sm3103733edb.89.2022.08.24.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:06:09 -0700 (PDT)
Date:   Wed, 24 Aug 2022 10:06:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] sched/psi: optimize task switch inside shared
 cgroups again
Message-ID: <YwYwUIjAGHLtRGue@cmpxchg.org>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-6-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824081829.33748-6-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 24, 2022 at 04:18:24PM +0800, Chengming Zhou wrote:
> commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
> defer prev task sleep handling to psi_task_switch(), so we don't need
> to clear and set TSK_ONCPU state for common cgroups.
> 
>     A
>     |
>     B
>    / \
>   C   D
>  /     \
> prev   next
> 
> After that commit psi_task_switch() do:
> 1. psi_group_change(next, .set=TSK_ONCPU) for D
> 2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C
> 3. psi_group_change(prev, .clear=TSK_RUNNING) for B, A
> 
> But there is a limitation "prev->psi_flags == next->psi_flags" that
> if not satisfied, will make this cgroups optimization unusable for both
> sleep switch or running switch cases. For example:
> 
> prev->in_memstall != next->in_memstall when sleep switch:
> 1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
> 2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C, B, A
> 
> prev->in_memstall != next->in_memstall when running switch:
> 1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
> 2. psi_group_change(prev, .clear=TSK_ONCPU) for C, B, A
> 
> The reason why this limitation exist is that we consider a group is
> PSI_MEM_FULL if the CPU is actively reclaiming and nothing productive
> could run even if it were runnable. So when CPU curr changed from prev
> to next and their in_memstall status is different, we have to change
> PSI_MEM_FULL status for their common cgroups.
> 
> This patch remove this limitation by making psi_group_change() change
> PSI_MEM_FULL status depend on CPU curr->in_memstall status.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Hoo boy, that took me a second.


Way back when PSI_MEM_FULL was accounted from the timer tick, task
switching could simply iterate next and prev to the common ancestor to
update TSK_ONCPU and be done.

Then memstall ticks were replaced with checking curr->in_memstall
directly in psi_group_change(). That meant that now if the task switch
was between a memstall and a !memstall task, we had to iterate through
the common ancestors at least ONCE to fix up their state_masks.

We added the identical_state filter to make sure the common ancestor
elimination was skipped in that case. It seems that was always a
little too eager, because it caused us to walk the common ancestors
*twice* instead of the required once: the iteration for next could
have stopped at the common ancestor; prev could have updated TSK_ONCPU
up to the common ancestor, then finish to the root without changing
any flags, just to get the new curr->in_memstall into the state_masks.

This patch recognizes this and makes it so that we walk to the root
exactly once if state_mask needs updating.


Unless I missed anything, would you mind adding this to the changelog?

I'm not quite sure how 4117cebf1a9f ("psi: Optimize task switch inside
shared cgroups") fits into the picture. That optimized the sleep case,
but the sleep case never had the common ancestor optimization (the dq
would have already cleared TSK_ONCPU up to the root). Let me know if I
am mistaken.

AFAICS I can see, this patch here is simply catching up on a missed
optimization that could have been done in 7fae6c8171d2 ("psi: Use
ONCPU state tracking machinery to detect reclaim") directly already.

So I think it all makes sense. I have just two notes on the diff:

> @@ -820,8 +820,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  	u64 now = cpu_clock(cpu);
>  
>  	if (next->pid) {
> -		bool identical_state;
> -
>  		psi_flags_change(next, 0, TSK_ONCPU);
>  		/*
>  		 * When switching between tasks that have an identical
> @@ -829,11 +827,9 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 * we reach the first common ancestor. Iterate @next's
>  		 * ancestors only until we encounter @prev's ONCPU.
>  		 */

The comment is rather stale now. Could you change it to this?

		/*
		 * Set TSK_ONCPU on @next's cgroups. If @next shares any
		 * ancestors with @prev, those will already have @prev's
		 * TSK_ONCPU bit set, and we can stop the iteration there.
		 */

> -		identical_state = prev->psi_flags == next->psi_flags;
>  		iter = NULL;
>  		while ((group = iterate_groups(next, &iter))) {
> -			if (identical_state &&
> -			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
> +			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
>  				common = group;
>  				break;
>  			}
> @@ -880,7 +876,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
>  		 * with dequeuing too, finish that for the rest of the hierarchy.
>  		 */
> -		if (sleep) {
> +		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
>  			clear &= ~TSK_ONCPU;
>  			for (; group; group = iterate_groups(prev, &iter))
>  				psi_group_change(group, cpu, clear, set, now, wake_clock);

Okay, this computes too. But it is somewhat special-cased, without
explaining why the memstall state in particular matters. Instead of
focusing on the exceptions though, can we just generalize this a bit?

		/*
		 * TSK_ONCPU is handled up to the common ancestor. If there are
		 * any other differences between the two tasks (e.g. prev goes
		 * to sleep, or only one task is memstall), finish propagating
		 * those differences all the way up to the root.
		 */
		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
			clear &= ~TSK_ONCPU;
			for (; group; group = iterate_groups(prev, &iter))
				psi_group_change(group, cpu, clear, set, now, wake_clock);
		}

Thanks
Johannes
