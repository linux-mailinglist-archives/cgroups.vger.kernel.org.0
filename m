Return-Path: <cgroups+bounces-14431-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHaKCHVqoGk3jgQAu9opvQ
	(envelope-from <cgroups+bounces-14431-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:44:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0551A9062
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25F583282EC1
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372D407569;
	Thu, 26 Feb 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guLzeONK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB83F23D7
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119023; cv=none; b=E3SuEACppeAxe4CEoYHf7jj+8i/D3SM/MR8jZ9bN3oK/f80h8fmioWgg+F+1yH+HiQ+MsE1Ly56B0zYemZTw5rtOoKZOJBFx4n+Xlj+Oi9s3DEZDMYCVl1S2ePbsit3BTvLrdpzB8pc3DLCpcjZP+xsNtJGSSCNd3qSTJyaOuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119023; c=relaxed/simple;
	bh=ZfKOiFMxI1AUZBKl1/6wIBin5AjCjKFiRaNVEE4xNNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trcEltnmsBZOL/9vMo4tIc4ayLyLfJsMwXjZ4BpErXW5i0DCG9zqDLDTnSi5tcGWNBorzAfybro7VUj6U2BHX5RCrguSSPgf3j60MO+nXwW3BU0TaWHHAeL1YcEYH1SLMSkCH3DlS9iZFOwB4DoMY8Q1eIs0XQ6/jifYTtNliQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guLzeONK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC2EC2BCB5
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772119023;
	bh=ZfKOiFMxI1AUZBKl1/6wIBin5AjCjKFiRaNVEE4xNNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=guLzeONK+GX1ZARHuAjqp3AuE2ZdTLF6dUwHjGWqr0CGTuA/8UGt4lZwgoEMPHyuD
	 qePC21AEXifEckAy2ol1AVRj3G2VlF+9tr2bK4F9IsCZVU4eMM70LE/EEnJdBDigJw
	 2k3S/v7rthqdjmxXuXo2ZwBdlHTtUPjyvqbiCHRA9csnhkxroBeTXFvJfokEoIIxhr
	 +XdLsTeiH2xR1YqixOBrMJTM+uJvD4xFJsU82aNOaYHjDrV0ecMhIYpKF4ZQo9T9he
	 TE6+v7GMY9tQP0qI+CferBOZAYkmRwD62hEq5Yxp2XowQgcxpm3wqBL+BmimHplm/x
	 dw8YCccMFiW6w==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c0e2cbde1so2071375a12.0
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 07:17:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAA2khA45Dhw+8On2BOfr4Jw0LvmufuvbeWxAiHsMQxDn5TiNzFrbqi20Tv5ZJDy4By9GaDRmd@vger.kernel.org
X-Gm-Message-State: AOJu0YxT21zkH5+KinLkVOz4c/rs+lb2kOyV0oPIr5IN8ycIubMImIzz
	JKoGgzqTLr7uUaKjHj1Tlp5OEwzCwXKegH1MSyS06Z3X1I5pG/cMRaftJKX/3LutlaOq8Py8Iz9
	vwrTrqMeDSSssr3fPy41KbMtmjQ21lSU=
X-Received: by 2002:a17:907:6d1a:b0:b8f:ccab:a344 with SMTP id
 a640c23a62f3a-b908199ef63mr1373906866b.14.1772119021523; Thu, 26 Feb 2026
 07:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com> <aZ-R87JfacQ2gGq1@linux.dev>
In-Reply-To: <aZ-R87JfacQ2gGq1@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 26 Feb 2026 07:16:50 -0800
X-Gmail-Original-Message-ID: <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
X-Gm-Features: AaiRm51ckbGxYZpsUeJsgBHqqSKUBYiDeW5PPTyqteMx0y9DdmIndToJpPaCT48
Message-ID: <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com, 
	usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14431-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AD0551A9062
X-Rspamd-Action: no action

> > Did you measure the impact of making state_local atomic on the flush
> > path? It's a slow path but we've seen pain from it being too slow
> > before, because it extends the critical section of the rstat flush
> > lock.
>
> Qi, please measure the impact on flushing and if no impact then no need to do
> anything as I don't want anymore churn in this series.
>
> >
> > Can we keep this non-atomic and use mod_memcg_lruvec_state() here? It
> > will update the stat on the local counter and it will be added to
> > state_local in the flush path when needed. We can even force another
> > flush in reparent_state_local () after reparenting is completed, if we
> > want to avoid leaving a potentially large stat update pending, as it
> > can be missed by mem_cgroup_flush_stats_ratelimited().
> >
> > Same for reparent_memcg_state_local(), we can probably use mod_memcg_state()?
>
> Yosry, do you mind sending the patch you are thinking about over this series?

Honestly, I'd rather squash it into this patch if possible. It avoids
churn in the history (switch to atomics and back), and is arguably
simpler than checking for regressions in the flush path.

What I have in mind is the diff below (build tested only). Qi, would
you be able to test this? It applies directly on this patch in mm-new:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d82dbfcc28057..404565e80cbf3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -234,11 +234,18 @@ static inline void reparent_state_local(struct
mem_cgroup *memcg, struct mem_cgr
        if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
                return;

+       /*
+        * Reparent stats exposed non-hierarchically. Flush @memcg's
stats first to
+        * read its stats accurately , and conservatively flush @parent's stats
+        * after reparenting to avoid hiding a potentially large stat update
+        * (e.g. from callers of mem_cgroup_flush_stats_ratelimited()).
+        */
        __mem_cgroup_flush_stats(memcg, true);

-       /* The following counts are all non-hierarchical and need to
be reparented. */
        reparent_memcg1_state_local(memcg, parent);
        reparent_memcg1_lruvec_state_local(memcg, parent);
+
+       __mem_cgroup_flush_stats(parent, true);
 }
 #else
 static inline void reparent_state_local(struct mem_cgroup *memcg,
struct mem_cgroup *parent)
@@ -442,7 +449,7 @@ struct lruvec_stats {
        long state[NR_MEMCG_NODE_STAT_ITEMS];

        /* Non-hierarchical (CPU aggregated) state */
-       atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
+       long state_local[NR_MEMCG_NODE_STAT_ITEMS];

        /* Pending child counts during tree propagation */
        long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
@@ -485,7 +492,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
                return 0;

        pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-       x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
+       x = READ_ONCE(pn->lruvec_stats->state_local[i]);
 #ifdef CONFIG_SMP
        if (x < 0)
                x = 0;
@@ -493,6 +500,10 @@ unsigned long lruvec_page_state_local(struct
lruvec *lruvec,
        return x;
 }

+static void mod_memcg_lruvec_state(struct lruvec *lruvec,
+                                  enum node_stat_item idx,
+                                  int val);
+
 #ifdef CONFIG_MEMCG_V1
 void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
                                       struct mem_cgroup *parent, int idx)
@@ -506,12 +517,10 @@ void reparent_memcg_lruvec_state_local(struct
mem_cgroup *memcg,
        for_each_node(nid) {
                struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg,
NODE_DATA(nid));
                struct lruvec *parent_lruvec =
mem_cgroup_lruvec(parent, NODE_DATA(nid));
-               struct mem_cgroup_per_node *parent_pn;
                unsigned long value =
lruvec_page_state_local(child_lruvec, idx);

-               parent_pn = container_of(parent_lruvec, struct
mem_cgroup_per_node, lruvec);
-
-               atomic_long_add(value,
&(parent_pn->lruvec_stats->state_local[i]));
+               mod_memcg_lruvec_state(child_lruvec, idx, -value);
+               mod_memcg_lruvec_state(parent_lruvec, idx, value);
        }
 }
 #endif
@@ -598,7 +607,7 @@ struct memcg_vmstats {
        unsigned long           events[NR_MEMCG_EVENTS];

        /* Non-hierarchical (CPU aggregated) page state & events */
-       atomic_long_t           state_local[MEMCG_VMSTAT_SIZE];
+       long                    state_local[MEMCG_VMSTAT_SIZE];
        unsigned long           events_local[NR_MEMCG_EVENTS];

        /* Pending child counts during tree propagation */
@@ -835,7 +844,7 @@ unsigned long memcg_page_state_local(struct
mem_cgroup *memcg, int idx)
        if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n",
__func__, idx))
                return 0;

-       x = atomic_long_read(&(memcg->vmstats->state_local[i]));
+       x = READ_ONCE(memcg->vmstats->state_local[i]);
 #ifdef CONFIG_SMP
        if (x < 0)
                x = 0;
@@ -852,7 +861,8 @@ void reparent_memcg_state_local(struct mem_cgroup *memcg,
        if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n",
__func__, idx))
                return;

-       atomic_long_add(value, &(parent->vmstats->state_local[i]));
+       mod_memcg_state(memcg, idx, -value);
+       mod_memcg_state(parent, idx, value);
 }
 #endif

@@ -4174,8 +4184,6 @@ struct aggregate_control {
        long *aggregate;
        /* pointer to the non-hierarchichal (CPU aggregated) counters */
        long *local;
-       /* pointer to the atomic non-hierarchichal (CPU aggregated) counters */
-       atomic_long_t *alocal;
        /* pointer to the pending child counters during tree propagation */
        long *pending;
        /* pointer to the parent's pending counters, could be NULL */
@@ -4213,12 +4221,8 @@ static void mem_cgroup_stat_aggregate(struct
aggregate_control *ac)
                }

                /* Aggregate counts on this level and propagate upwards */
-               if (delta_cpu) {
-                       if (ac->local)
-                               ac->local[i] += delta_cpu;
-                       else if (ac->alocal)
-                               atomic_long_add(delta_cpu, &(ac->alocal[i]));
-               }
+               if (delta_cpu)
+                       ac->local[i] += delta_cpu;

                if (delta) {
                        ac->aggregate[i] += delta;
@@ -4289,8 +4293,7 @@ static void mem_cgroup_css_rstat_flush(struct
cgroup_subsys_state *css, int cpu)

        ac = (struct aggregate_control) {
                .aggregate = memcg->vmstats->state,
-               .local = NULL,
-               .alocal = memcg->vmstats->state_local,
+               .local = memcg->vmstats->state_local,
                .pending = memcg->vmstats->state_pending,
                .ppending = parent ? parent->vmstats->state_pending : NULL,
                .cstat = statc->state,
@@ -4323,8 +4326,7 @@ static void mem_cgroup_css_rstat_flush(struct
cgroup_subsys_state *css, int cpu)

                ac = (struct aggregate_control) {
                        .aggregate = lstats->state,
-                       .local = NULL,
-                       .alocal = lstats->state_local,
+                       .local = lstats->state_local,
                        .pending = lstats->state_pending,
                        .ppending = plstats ? plstats->state_pending : NULL,
                        .cstat = lstatc->state,

