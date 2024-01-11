Return-Path: <cgroups+bounces-1117-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3EA82B006
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57091C22383
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2793B19C;
	Thu, 11 Jan 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuO2exKd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED23B18E
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28ab7ae504so517654866b.3
        for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704981343; x=1705586143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVA4NmmNPtGFBnjZWLvrWQGRTcfx1eMiIXON9laEFLY=;
        b=uuO2exKdTolLhiCsFETLaetUG07y+7CZt1I7S7swEGmSjtUJ7VPL05nzyKSfn5c9Ae
         nAZ38WVCrWN3S0N1dXtpfSh6MfdJKQda4xynJogKl+rcSD+uppfwY8xWvZENNQiJz83I
         svk56NIzs5aqopp+iJOdIZn5m6CRAbT+ufoEBpW6exqC+MesTZph6opd+G3boFw+N3bi
         F7B98GU9xjnZbJoDnyZT8/Nb+L65ukGtRhdFE5D82bmP3kK+7Y1nCE4cDMOqiUJ6apJh
         21wtQ7hKFM5Fh2VrGQcsQ01LuqDM0kkroNKpnEwpSAi1D/qdsJRKtwr+K6xdtBQPJls8
         L+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704981343; x=1705586143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVA4NmmNPtGFBnjZWLvrWQGRTcfx1eMiIXON9laEFLY=;
        b=NBT5u/3fL0MdCvBf6e8y5pfu51p8RmwUJXvnG9Lm69mgBS3dBvHXcyznqBHJ3kcJhF
         ogDqvg+Uh02CDO9tUOzaS3AmksZ4uycRbn5ZkSlNkIAjMutx0PY50iQxXn1bd9DvPaEp
         OFmBrRxnE095X/9gChaUP/vDoGyZPXzJowORW79ImvHTN7YwbIZDfQJKE8ezEpV4bPjZ
         KaDFZii58el++YC/cwCIZDsruAF35E8x0yqThxSplUhvbjGNHNoOs3fI/i8lZxXW51j9
         nsJByq/8DctB4pDjhugq3VbN5TmgEZCT7TM9VUwuyNsAWjYlRa88hIpiZ3VzQeMYMadU
         nEQw==
X-Gm-Message-State: AOJu0Yx+0xcCuXmsTDQa81ladFMZa/b27KQH76gEo2Pf+4lSdxr0LJ2+
	2Vg1TW6XHJKTte8illaNbDR4jf1Hwq8tFw2ogmzNyZnKHgpF
X-Google-Smtp-Source: AGHT+IFLOuLsEieCehNfJDu1ITPLkb+W8yWLt2Hsnb2a5qq4o4Rntl1N2/uxgEed+2QkffQcXCdnECkwz6Rps5T4rlc=
X-Received: by 2002:a17:907:1b26:b0:a27:fa1b:def4 with SMTP id
 mp38-20020a1709071b2600b00a27fa1bdef4mr1052460ejc.17.1704981342595; Thu, 11
 Jan 2024 05:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111132902.389862-1-hannes@cmpxchg.org>
In-Reply-To: <20240111132902.389862-1-hannes@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 11 Jan 2024 05:55:04 -0800
Message-ID: <CAJD7tkaepp1xP4LX9gTWYU8dzQGxnUnsMD_gFmRqCj0rHTTO7g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 5:29=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> While investigating hosts with high cgroup memory pressures, Tejun
> found culprit zombie tasks that had were holding on to a lot of
> memory, had SIGKILL pending, but were stuck in memory.high reclaim.
>
> In the past, we used to always force-charge allocations from tasks
> that were exiting in order to accelerate them dying and freeing up
> their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
> prohibit unconditional exceeding the limit of dying tasks"); it noted
> that this can cause (userspace inducable) containment failures, so it
> added a mandatory reclaim and OOM kill cycle before forcing charges.
> At the time, memory.high enforcement was handled in the userspace
> return path, which isn't reached by dying tasks, and so memory.high
> was still never enforced by dying tasks.
>
> When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
> overcharges") added synchronous reclaim for memory.high, it added
> unconditional memory.high enforcement for dying tasks as well. The
> callstack shows that this path is where the zombie is stuck in.
>
> We need to accelerate dying tasks getting past memory.high, but we
> cannot do it quite the same way as we do for memory.max: memory.max is
> enforced strictly, and tasks aren't allowed to move past it without
> FIRST reclaiming and OOM killing if necessary. This ensures very small
> levels of excess. With memory.high, though, enforcement happens lazily
> after the charge, and OOM killing is never triggered. A lot of
> concurrent threads could have pushed, or could actively be pushing,
> the cgroup into excess. The dying task will enter reclaim on every
> allocation attempt, with little hope of restoring balance.
>
> To fix this, skip synchronous memory.high enforcement on dying tasks
> altogether again. Update memory.high path documentation while at it.
>
> Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large =
overcharges")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

LGTM with a couple of nits below:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/memcontrol.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 73692cd8c142..aca879995022 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2603,8 +2603,9 @@ static unsigned long calculate_high_delay(struct me=
m_cgroup *memcg,
>  }
>
>  /*
> - * Scheduled by try_charge() to be executed from the userland return pat=
h
> - * and reclaims memory over the high limit.
> + * Reclaims memory over the high limit. Called directly from
> + * try_charge() when possible, but also scheduled to be called from
> + * the userland return path where reclaim is always able to block.
>   */

nit: The term "scheduled" here is deceptive imo, it makes me think of
queue_work() and friends, when it is directly called from
resume_user_mode_work(). Can we change the terminology to "called from
the userland return path" or directly reference
resume_user_mode_work() instead? Same applies to the added comment
below in try_charge_memcg().

nit: "when possible" is not entirely accurate, it makes it seem like
we call mem_cgroup_handle_over_high() whenever we can (which means
gfpflags_allow_blocking() imo). We actually choose not to call it in
some situations, and this patch is adding one such situation. So
perhaps "when possible and desirable" or just "when appropriate".

>  void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  {
> @@ -2673,6 +2674,9 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>         }
>
>         /*
> +        * Reclaim didn't manage to push usage below the limit, slow
> +        * this allocating task down.
> +        *
>          * If we exit early, we're guaranteed to die (since
>          * schedule_timeout_killable sets TASK_KILLABLE). This means we d=
on't
>          * need to account for any ill-begotten jiffies to pay them off l=
ater.
> @@ -2867,8 +2871,22 @@ static int try_charge_memcg(struct mem_cgroup *mem=
cg, gfp_t gfp_mask,
>                 }
>         } while ((memcg =3D parent_mem_cgroup(memcg)));
>
> +       /*
> +        * Reclaim is scheduled for the userland return path already,
> +        * but also attempt synchronous reclaim to avoid excessive
> +        * overrun while the task is still inside the kernel. If this
> +        * is successful, the return path will see it when it rechecks
> +        * the overage, and simply bail out.
> +        *
> +        * Skip if the task is already dying, though. Unlike
> +        * memory.max, memory.high enforcement isn't as strict, and
> +        * there is no OOM killer involved, which means the excess
> +        * could already be much bigger (and still growing) than it
> +        * could for memory.max; the dying task could get stuck in
> +        * fruitless reclaim for a long time, which isn't desirable.
> +        */
>         if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
> -           !(current->flags & PF_MEMALLOC) &&
> +           !(current->flags & PF_MEMALLOC) && !task_is_dying() &&
>             gfpflags_allow_blocking(gfp_mask)) {
>                 mem_cgroup_handle_over_high(gfp_mask);
>         }
> --
> 2.43.0
>
>

