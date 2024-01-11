Return-Path: <cgroups+bounces-1125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B283B82B533
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 20:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457B1282158
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA255C18;
	Thu, 11 Jan 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="LOJWXVEV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEDF55C0A
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7831ed13d39so424251085a.0
        for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705001292; x=1705606092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+qi7MD6q3W8+pUjVS0O2dTJ96sM/4HvoNFot/q7Uh0=;
        b=LOJWXVEV2ucQfbfD3SZb2dC3AB1OHtNRpXYyBSFwkoCBRwPos1vSI2gVR3W0Es7YaA
         5FAEJr/xjX/r6SjLp+3LHJRfQSEWbll1WKIQM13PgOv3CK1RE6c0jDob9+tXMLp2rUzQ
         mK0gEk3dQ7230riBNywPPF+nzJNXNggezoUob+KQ62m/KizWbZR/cCzFrLn401NujJSv
         O9ckVeD+ChSwC7NUr3xuKGXaK0/7FU1S1TIB0TtV7W98QAU2C/dB0LOEkKZ2tnoRqlYk
         9cPUPmxI+/nsZOQnYciTYBY70ifrWgNfFM95nUgj2JANKtyt0dSvR99DLbQT2CzkZvY5
         dI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705001292; x=1705606092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+qi7MD6q3W8+pUjVS0O2dTJ96sM/4HvoNFot/q7Uh0=;
        b=fYqhcMtb52vNS6fP+GwlsEcAmSVkacpUwz0fhwddVwph7yypucAAOX/gZMrbtW1Lnn
         VPoMveY+/qfW/LuK7Q+Rba50cPUAeP3dWtpy2d5JNMXPzKgVK7fDNAzox3qi6yCe84XH
         lWNhpI5RAeiMcHgI1antHAe7DKjJr1M4hN5cpu6e/M/p457o64lYkKohcN1Uw/P9mK7Q
         r3WA15BmX7kLj3wfshd3JsIilnn4yv9eS0bK4BA2cSYB9YwupCqnTQrj0K9+CVBKEZa6
         3v+2MhlUC0lRX7hlctjnXPZRUEmHDKZq2/+zjm7PTB2z9nfZDcfEYj0rwABkpfKZnL0R
         wYOg==
X-Gm-Message-State: AOJu0Ywe1nCuaivwiRm5JN7TBTZ+nDyMQnJ1vSIOvE29/dTgf9E9Q/pH
	tEl6W3K5Bjjt65aw/eACeTAKuHKwf++ghQ==
X-Google-Smtp-Source: AGHT+IFyX3xTWizP3R3FAeH0+OH2ehQEAC3O6C+6V4EQJvLdtdWP94DaIZPXJjMDMMjv+ghgBIYqXw==
X-Received: by 2002:ac8:5b8e:0:b0:429:cb93:94b4 with SMTP id a14-20020ac85b8e000000b00429cb9394b4mr67054qta.32.1705001292141;
        Thu, 11 Jan 2024 11:28:12 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id cn3-20020a05622a248300b00429c8ae9b94sm387630qtb.85.2024.01.11.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:28:11 -0800 (PST)
Date: Thu, 11 Jan 2024 14:28:07 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Message-ID: <20240111192807.GA424308@cmpxchg.org>
References: <20240111132902.389862-1-hannes@cmpxchg.org>
 <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaAsbwFP-ttYNwIe@P9FQF9L96D>

On Thu, Jan 11, 2024 at 09:59:11AM -0800, Roman Gushchin wrote:
> On Thu, Jan 11, 2024 at 08:29:02AM -0500, Johannes Weiner wrote:
> > While investigating hosts with high cgroup memory pressures, Tejun
> > found culprit zombie tasks that had were holding on to a lot of
> > memory, had SIGKILL pending, but were stuck in memory.high reclaim.
> > 
> > In the past, we used to always force-charge allocations from tasks
> > that were exiting in order to accelerate them dying and freeing up
> > their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
> > prohibit unconditional exceeding the limit of dying tasks"); it noted
> > that this can cause (userspace inducable) containment failures, so it
> > added a mandatory reclaim and OOM kill cycle before forcing charges.
> > At the time, memory.high enforcement was handled in the userspace
> > return path, which isn't reached by dying tasks, and so memory.high
> > was still never enforced by dying tasks.
> > 
> > When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
> > overcharges") added synchronous reclaim for memory.high, it added
> > unconditional memory.high enforcement for dying tasks as well. The
> > callstack shows that this path is where the zombie is stuck in.
> > 
> > We need to accelerate dying tasks getting past memory.high, but we
> > cannot do it quite the same way as we do for memory.max: memory.max is
> > enforced strictly, and tasks aren't allowed to move past it without
> > FIRST reclaiming and OOM killing if necessary. This ensures very small
> > levels of excess. With memory.high, though, enforcement happens lazily
> > after the charge, and OOM killing is never triggered. A lot of
> > concurrent threads could have pushed, or could actively be pushing,
> > the cgroup into excess. The dying task will enter reclaim on every
> > allocation attempt, with little hope of restoring balance.
> > 
> > To fix this, skip synchronous memory.high enforcement on dying tasks
> > altogether again. Update memory.high path documentation while at it.
> 
> It makes total sense to me.
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks

> However if tasks can stuck for a long time in the "high reclaim" state,
> shouldn't we also handle the case when tasks are being killed during the
> reclaim? E. g. something like this (completely untested):

Yes, that's probably a good idea.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c4c422c81f93..9f971fc6aae8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2465,6 +2465,9 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>                     READ_ONCE(memcg->memory.high))
>                         continue;
> 
> +               if (task_is_dying())
> +                       break;
> +
>                 memcg_memory_event(memcg, MEMCG_HIGH);
> 
>                 psi_memstall_enter(&pflags);

I think we can skip this one. The loop is for traversing from the
charging cgroup to the one that has memory.high set and breached, and
then reclaim it. It's not expected to run multiple reclaims.

> @@ -2645,6 +2648,9 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>         current->memcg_nr_pages_over_high = 0;
> 
>  retry_reclaim:
> +       if (task_is_dying())
> +               return;
> +
>         /*
>          * The allocating task should reclaim at least the batch size, but for
>          * subsequent retries we only want to do what's necessary to prevent oom

Yeah this is the better place for this check.

How about this?

---

From 6124a13cb073f5ff06b9c1309505bc937d65d6e5 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 11 Jan 2024 07:18:47 -0500
Subject: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high

While investigating hosts with high cgroup memory pressures, Tejun
found culprit zombie tasks that had were holding on to a lot of
memory, had SIGKILL pending, but were stuck in memory.high reclaim.

In the past, we used to always force-charge allocations from tasks
that were exiting in order to accelerate them dying and freeing up
their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
prohibit unconditional exceeding the limit of dying tasks"); it noted
that this can cause (userspace inducable) containment failures, so it
added a mandatory reclaim and OOM kill cycle before forcing charges.
At the time, memory.high enforcement was handled in the userspace
return path, which isn't reached by dying tasks, and so memory.high
was still never enforced by dying tasks.

When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
overcharges") added synchronous reclaim for memory.high, it added
unconditional memory.high enforcement for dying tasks as well. The
callstack shows that this path is where the zombie is stuck in.

We need to accelerate dying tasks getting past memory.high, but we
cannot do it quite the same way as we do for memory.max: memory.max is
enforced strictly, and tasks aren't allowed to move past it without
FIRST reclaiming and OOM killing if necessary. This ensures very small
levels of excess. With memory.high, though, enforcement happens lazily
after the charge, and OOM killing is never triggered. A lot of
concurrent threads could have pushed, or could actively be pushing,
the cgroup into excess. The dying task will enter reclaim on every
allocation attempt, with little hope of restoring balance.

To fix this, skip synchronous memory.high enforcement on dying tasks
altogether again. Update memory.high path documentation while at it.

Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 73692cd8c142..7be7a2f4e536 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2603,8 +2603,9 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 }
 
 /*
- * Scheduled by try_charge() to be executed from the userland return path
- * and reclaims memory over the high limit.
+ * Reclaims memory over the high limit. Called directly from
+ * try_charge() (context permitting), as well as from the userland
+ * return path where reclaim is always able to block.
  */
 void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
@@ -2623,6 +2624,17 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	current->memcg_nr_pages_over_high = 0;
 
 retry_reclaim:
+	/*
+	 * Bail if the task is already exiting. Unlike memory.max,
+	 * memory.high enforcement isn't as strict, and there is no
+	 * OOM killer involved, which means the excess could already
+	 * be much bigger (and still growing) than it could for
+	 * memory.max; the dying task could get stuck in fruitless
+	 * reclaim for a long time, which isn't desirable.
+	 */
+	if (task_is_dying())
+		goto out;
+
 	/*
 	 * The allocating task should reclaim at least the batch size, but for
 	 * subsequent retries we only want to do what's necessary to prevent oom
@@ -2673,6 +2685,9 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	}
 
 	/*
+	 * Reclaim didn't manage to push usage below the limit, slow
+	 * this allocating task down.
+	 *
 	 * If we exit early, we're guaranteed to die (since
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
 	 * need to account for any ill-begotten jiffies to pay them off later.
@@ -2867,11 +2882,17 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
 
+	/*
+	 * Reclaim is set up above to be called from the userland
+	 * return path. But also attempt synchronous reclaim to avoid
+	 * excessive overrun while the task is still inside the
+	 * kernel. If this is successful, the return path will see it
+	 * when it rechecks the overage and simply bail out.
+	 */
 	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
 	    !(current->flags & PF_MEMALLOC) &&
-	    gfpflags_allow_blocking(gfp_mask)) {
+	    gfpflags_allow_blocking(gfp_mask))
 		mem_cgroup_handle_over_high(gfp_mask);
-	}
 	return 0;
 }
 
-- 
2.43.0


