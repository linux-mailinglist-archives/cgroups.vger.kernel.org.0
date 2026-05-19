Return-Path: <cgroups+bounces-16087-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HMSEYWBDGpPigUAu9opvQ
	(envelope-from <cgroups+bounces-16087-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:28:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985EA581720
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333CC31A91AC
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1803546DB;
	Tue, 19 May 2026 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQ5CvUbf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB3315D3B
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203679; cv=pass; b=J5RU/e/PyFD8oJXdA4MUtYoGbb63i6r4jLywpdk+AIWPZMFvcWkr6XpeCZUamYkP7DEgWT4+uwtAiEFpqPMt3QeTFF2Vo80g/ABtsH448ybXPaqRGNw654p9ar6iciZX2S91040cFxx4krHdVwTxSNNif5hATQyo+kxTFq5wWoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203679; c=relaxed/simple;
	bh=GA0PQI75UOoRCcf99QZgF7SfyEX7OGS+zH+EEW8i5Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAiOhLawARTbH0ef1gYtkEdQFskyCvkGMnZpbbF+9jqEZUcSD2YJFihAMPJW6dx/088m9XaPtGEO5XLVB9BIjGEjpNREq7Jc0KcVY3XOR59eKXxDuEjd1/jhX+CdoEXl/kI8gy+CLCYFnuJCVIHQ5grD9dP2uK5Y/5l6DauOqDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kQ5CvUbf; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so8116650a12.0
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 08:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779203676; cv=none;
        d=google.com; s=arc-20240605;
        b=dSlA5j/VPFD8+u4YZzoBrCliv+IIet8Dmd9kyoh/QOju6IKaxqbfg6/jA9mXEwA1lw
         cO2tmVPic5cRoZALxyksQt0jn7weKr/eG7sknEFjjxZPO9M12jWNIovtwB0F4R7gNyjz
         QpoQYVE2tJ3Sbhbn1BfJoTbdxh9F7RjPmkxRdKTJUtx5IzQer9uosnYHc4WTp8MVWZiD
         qwhqBwiB2WV5eOi5xPYVd39GsLRMhlF7Rsyc7FsvuC06MS8gYh/MIA+9LiKzTPE3sAE7
         LE7Cg6059u7C0dINf1m+lqiuyecZhu87SUkeVYDg4k4x3chTmkUfTWZpqiiycN2lhdes
         CkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nl5pzXfqmREJgLa9QCh8fbDY+oJd7AG8p4ttgoLV1Ys=;
        fh=ABSx6mv4RCuVV0A708xwWIuIf2w64fg8FN6bvqegefA=;
        b=getZSnEPnp5fRO6as4nzPCISl6pf/BwvBJAY1YVNqo2IEpfOMsBQmXPvo+OLvJpfu8
         UICCoX6Ca+cDxOx+0EzSeIaxqLRs9wT1Xk9awcLkyh7crztBX8srZwZSEN7YNGcM/+bX
         Mnr0gM5arso1C+EczmTjkqV7ENWenjWjrwv69tZPnH/w07rUGEJpDcEOXyS5j7NCLQKl
         FoMbfFs4+g2iIVSHBXYRP0liNeGppcbvBD7daOc2ak6zF/droS4dqeV/THRVxA3Xe3ca
         dQuGpz9od52BjO7fxS4SJglzL5OLPqzVD0n3498nGEpPgqWnUJLQOnlhE9wvAha/Jn12
         fKoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779203676; x=1779808476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl5pzXfqmREJgLa9QCh8fbDY+oJd7AG8p4ttgoLV1Ys=;
        b=kQ5CvUbfByUI5hBga3Ye1LFlI0A6XFhC3cHPJXmAg6B+O0rDMBn62/3GP8L9+G/5A1
         U5oPMtTwIXpK/H2dHItyoxhoTBLz2tpLSAV/V2kYSezd8zw6bXcxu/odSVYeewVtrktf
         lQ43tat250QwGXNrzTpv40ZhKD435rkhI1ahb+47OdVMDA8mk9qO3cX1K0oTkzLRFY2B
         iinRffwQfidL8oFEgCz/A7L4KSjzj3rvDJhEUjsFDulfv20Bd5oo2kv/mWTjxKsTKwIw
         jAcIR0ZCaREpjBXsxWgz7M+qX3OJxWTRCvQjThvruyAKqRIThAdquoQZAcwMUduBzg68
         OAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203676; x=1779808476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl5pzXfqmREJgLa9QCh8fbDY+oJd7AG8p4ttgoLV1Ys=;
        b=pK9ZFBnGIgvPMwn6NVkcUm1oDv9giQ9ozm26gy5Gc6fG/hjPl1bPkQFb8mSuo1iIUZ
         vvxeR7NcR0jc4TmcaCLY57lsud2Rsp0tuE3WPlmlyEzwJLlsxXuv/9OZitHBAFOxt8Nn
         0FUUcWWMdWakS/dd5J1bGfE+ddJT4CjbGi3Sw2NA/4ECplMcrnfkmc+/vDQbpyHbXWUp
         MtkTVcNpVEA6umql+09xZXvquLa+E8o+AitFHuOqYy48mwts8EndMgDki1d1wxFHDlFh
         Kj6dc9sJK/dLj8muPC9DssthRb1ERsxVvWFIauYZymk5gfdQjiiaDSRgnNs6fbqcpb0O
         8fEA==
X-Forwarded-Encrypted: i=1; AFNElJ/hVrJMTBF2O90dBOjK4HmWsw7Ansulm3trRzMXQyj7H7835L1Zy6biwoENBBAKVqnRQplJwxCH@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8KN1TIeJtBJktKrqRlVBaWsZU6DCevKZ8aJBZ7VBj8eBVk6i
	AxUXHeCNIPPUPgfqfeYmMHJamdSBwcRGoGJVljEga03zfP5tTRjQ6jCsOyVJhI6wjTUOCyG4kQ4
	yI/d5KDellLwmihLuI8DjzEbDTpnf6wue5GFpUwPh/Q==
X-Gm-Gg: Acq92OHPZsX60k94Mpkg6Z6QGOCwIwXs1sPZSty/LDf91OeT9xwq05Tup4eM3ha/D9x
	aVj8Q14EHHpi/fHfm+FNVwNIP1TRETeFTdLgEN9tx4qdjLJI5B86S1Kvor9+6XSJaAPcXqPNLTC
	uaOXfyNVsPIPzRCh7vjuN0Ax1j2Z1iVH2vlISRFMRF1ght7LzmlukSvOS/cFjs7y8Hl0JCZf79g
	l4TNGWUis5rYuOXWEHw0kB0wadXrivwNq2jYPHI+/wHwrrmVzpBZR/Pr4ojaMjlmMuEnGNwSf9L
	PnujHW7kqQgplqbWLXOihGXUcbwNgCvqHv5V
X-Received: by 2002:a17:907:c714:b0:bcf:9dd2:f79e with SMTP id
 a640c23a62f3a-bd517964d82mr1193318866b.29.1779203675686; Tue, 19 May 2026
 08:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.057634261@infradead.org>
In-Reply-To: <20260511120628.057634261@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 19 May 2026 17:14:22 +0200
X-Gm-Features: AVHnY4JK1SqRt6L1UhvDQnTKPdNUwnoUf7sUCXtnmZaAcDJau7we7w-I9JKpBiQ
Message-ID: <CAKfTPtC3wbJYRSwT5CjGRC68WmXLgf9EaOSdC=37BVPu_4Gk0w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] sched: Remove sched_class::pick_next_task()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16087-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linaro.org:email,linaro.org:dkim];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: 985EA581720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 11 May 2026 at 14:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The reason for pick_next_task_fair() is the put/set optimization that
> avoids touching the common ancestors. However, it is possible to
> implement this in the put_prev_task() and set_next_task() calls as
> used in put_prev_set_next_task().
>
> Notably, put_prev_set_next_task() is the only site that:
>
>  - calls put_prev_task() with a .next argument;
>  - calls set_next_task() with .first = true.
>
> This means that put_prev_task() can determine the common hierarchy and
> stop there, and then set_next_task() can terminate where put_prev_task
> stopped.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Hackbench results on my Arm64 dev machine stay similars with patch 8
and 9 (unlike patch 10)

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/core.c  |   27 +++------
>  kernel/sched/fair.c  |  139 +++++++++++++++++----------------------------------
>  kernel/sched/sched.h |   14 -----
>  3 files changed, 57 insertions(+), 123 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5980,16 +5980,15 @@ __pick_next_task(struct rq *rq, struct t
>         if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
>                    rq->nr_running == rq->cfs.h_nr_queued)) {
>
> -               p = pick_next_task_fair(rq, prev, rf);
> +               p = pick_task_fair(rq, rf);
>                 if (unlikely(p == RETRY_TASK))
>                         goto restart;
>
>                 /* Assume the next prioritized class is idle_sched_class */
> -               if (!p) {
> +               if (!p)
>                         p = pick_task_idle(rq, rf);
> -                       put_prev_set_next_task(rq, prev, p);
> -               }
>
> +               put_prev_set_next_task(rq, prev, p);
>                 return p;
>         }
>
> @@ -5997,20 +5996,12 @@ __pick_next_task(struct rq *rq, struct t
>         prev_balance(rq, prev, rf);
>
>         for_each_active_class(class) {
> -               if (class->pick_next_task) {
> -                       p = class->pick_next_task(rq, prev, rf);
> -                       if (unlikely(p == RETRY_TASK))
> -                               goto restart;
> -                       if (p)
> -                               return p;
> -               } else {
> -                       p = class->pick_task(rq, rf);
> -                       if (unlikely(p == RETRY_TASK))
> -                               goto restart;
> -                       if (p) {
> -                               put_prev_set_next_task(rq, prev, p);
> -                               return p;
> -                       }
> +               p = class->pick_task(rq, rf);
> +               if (unlikely(p == RETRY_TASK))
> +                       goto restart;
> +               if (p) {
> +                       put_prev_set_next_task(rq, prev, p);
> +                       return p;
>                 }
>         }
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9214,7 +9214,7 @@ static void wakeup_preempt_fair(struct r
>         resched_curr_lazy(rq);
>  }
>
> -static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
> +struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
>         __must_hold(__rq_lockp(rq))
>  {
>         struct sched_entity *se;
> @@ -9257,72 +9257,6 @@ static struct task_struct *pick_task_fai
>         return NULL;
>  }
>
> -static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
> -static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
> -
> -struct task_struct *
> -pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> -       __must_hold(__rq_lockp(rq))
> -{
> -       struct sched_entity *se;
> -       struct task_struct *p;
> -
> -       p = pick_task_fair(rq, rf);
> -       if (unlikely(p == RETRY_TASK))
> -               return p;
> -       if (!p)
> -               return p;
> -       se = &p->se;
> -
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -       if (prev->sched_class != &fair_sched_class)
> -               goto simple;
> -
> -       __put_prev_set_next_dl_server(rq, prev, p);
> -
> -       /*
> -        * Because of the set_next_buddy() in dequeue_task_fair() it is rather
> -        * likely that a next task is from the same cgroup as the current.
> -        *
> -        * Therefore attempt to avoid putting and setting the entire cgroup
> -        * hierarchy, only change the part that actually changes.
> -        *
> -        * Since we haven't yet done put_prev_entity and if the selected task
> -        * is a different task than we started out with, try and touch the
> -        * least amount of cfs_rqs.
> -        */
> -       if (prev != p) {
> -               struct sched_entity *pse = &prev->se;
> -               struct cfs_rq *cfs_rq;
> -
> -               while (!(cfs_rq = is_same_group(se, pse))) {
> -                       int se_depth = se->depth;
> -                       int pse_depth = pse->depth;
> -
> -                       if (se_depth <= pse_depth) {
> -                               put_prev_entity(cfs_rq_of(pse), pse);
> -                               pse = parent_entity(pse);
> -                       }
> -                       if (se_depth >= pse_depth) {
> -                               set_next_entity(cfs_rq_of(se), se, true);
> -                               se = parent_entity(se);
> -                       }
> -               }
> -
> -               put_prev_entity(cfs_rq, pse);
> -               set_next_entity(cfs_rq, se, true);
> -
> -               __set_next_task_fair(rq, p, true);
> -       }
> -
> -       return p;
> -
> -simple:
> -#endif /* CONFIG_FAIR_GROUP_SCHED */
> -       put_prev_set_next_task(rq, prev, p);
> -       return p;
> -}
> -
>  static struct task_struct *
>  fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
>         __must_hold(__rq_lockp(dl_se->rq))
> @@ -9346,10 +9280,33 @@ static void put_prev_task_fair(struct rq
>  {
>         struct sched_entity *se = &prev->se;
>         struct cfs_rq *cfs_rq;
> +       struct sched_entity *nse = NULL;
>
> -       for_each_sched_entity(se) {
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +       if (next && next->sched_class == &fair_sched_class)
> +               nse = &next->se;
> +#endif
> +
> +       while (se) {
>                 cfs_rq = cfs_rq_of(se);
> -               put_prev_entity(cfs_rq, se);
> +               if (!nse || cfs_rq->curr)
> +                       put_prev_entity(cfs_rq, se);
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +               if (nse) {
> +                       if (is_same_group(se, nse))
> +                               break;
> +
> +                       int d = nse->depth - se->depth;
> +                       if (d >= 0) {
> +                               /* nse has equal or greater depth, ascend */
> +                               nse = parent_entity(nse);
> +                               /* if nse is the deeper, do not ascend se */
> +                               if (d > 0)
> +                                       continue;
> +                       }
> +               }
> +#endif
> +               se = parent_entity(se);
>         }
>  }
>
> @@ -13896,10 +13853,30 @@ static void switched_to_fair(struct rq *
>         }
>  }
>
> -static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> +/*
> + * Account for a task changing its policy or group.
> + *
> + * This routine is mostly called to set cfs_rq->curr field when a task
> + * migrates between groups/classes.
> + */
> +static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>  {
>         struct sched_entity *se = &p->se;
>
> +       for_each_sched_entity(se) {
> +               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +               if (IS_ENABLED(CONFIG_FAIR_GROUP_SCHED) &&
> +                   first && cfs_rq->curr)
> +                       break;
> +
> +               set_next_entity(cfs_rq, se, first);
> +               /* ensure bandwidth has been allocated on our new cfs_rq */
> +               account_cfs_rq_runtime(cfs_rq, 0);
> +       }
> +
> +       se = &p->se;
> +
>         if (task_on_rq_queued(p)) {
>                 /*
>                  * Move the next running task to the front of the list, so our
> @@ -13919,27 +13896,6 @@ static void __set_next_task_fair(struct
>         sched_fair_update_stop_tick(rq, p);
>  }
>
> -/*
> - * Account for a task changing its policy or group.
> - *
> - * This routine is mostly called to set cfs_rq->curr field when a task
> - * migrates between groups/classes.
> - */
> -static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> -{
> -       struct sched_entity *se = &p->se;
> -
> -       for_each_sched_entity(se) {
> -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -
> -               set_next_entity(cfs_rq, se, first);
> -               /* ensure bandwidth has been allocated on our new cfs_rq */
> -               account_cfs_rq_runtime(cfs_rq, 0);
> -       }
> -
> -       __set_next_task_fair(rq, p, first);
> -}
> -
>  void init_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>         cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> @@ -14251,7 +14207,6 @@ DEFINE_SCHED_CLASS(fair) = {
>         .wakeup_preempt         = wakeup_preempt_fair,
>
>         .pick_task              = pick_task_fair,
> -       .pick_next_task         = pick_next_task_fair,
>         .put_prev_task          = put_prev_task_fair,
>         .set_next_task          = set_next_task_fair,
>
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2555,17 +2555,6 @@ struct sched_class {
>          * schedule/pick_next_task: rq->lock
>          */
>         struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
> -       /*
> -        * Optional! When implemented pick_next_task() should be equivalent to:
> -        *
> -        *   next = pick_task();
> -        *   if (next) {
> -        *       put_prev_task(prev);
> -        *       set_next_task_first(next);
> -        *   }
> -        */
> -       struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
> -                                             struct rq_flags *rf);
>
>         /*
>          * sched_change:
> @@ -2789,8 +2778,7 @@ static inline bool sched_fair_runnable(s
>         return rq->cfs.nr_queued > 0;
>  }
>
> -extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev,
> -                                              struct rq_flags *rf);
> +extern struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf);
>  extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
>
>  #define SCA_CHECK              0x01
>
>

