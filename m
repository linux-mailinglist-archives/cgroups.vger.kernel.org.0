Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3924942DF2C
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhJNQd5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhJNQdz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 12:33:55 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF87C061570
        for <cgroups@vger.kernel.org>; Thu, 14 Oct 2021 09:31:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id t79-20020a627852000000b0044d0ecd9f7aso3730856pfc.13
        for <cgroups@vger.kernel.org>; Thu, 14 Oct 2021 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=5c2jin9rhCwDmbScWWGB5EKaPi0t1d9qwSSLJb9JZsg=;
        b=I3cPTF8SIEgtc1ITsYhyR4jjKtKaIy5AuU9x5dsANrtt1TFE8Pt9H2bU2qV8pZP0Y+
         iW5cOuNg86tSRYu6pNhMdMY+Q8lxtPwRKVUGYUsPK1C2KrAuWc7J4aSPvVpZksupkqSC
         JBCn2hrqSeMWclLfLWz1CTneP6GO3TyKg0EvNIvg+lJENLbrmcbE5S/paSMIxNr9SR5C
         Fw+ueGSjfyi/rSu4HCn05sX4bLasZnsx0wPVYmQN/BwQWIJPb9I/UAbY1bsb+U5oxggi
         2kWwq+I56+jD+Ri8j1dSPUhr8bLDHdElkJLfAuB01MPNYY/2wdSnC/XNJWPTtddJGzxP
         inqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=5c2jin9rhCwDmbScWWGB5EKaPi0t1d9qwSSLJb9JZsg=;
        b=DS2bl3pJvc1qwInWmXRR/YgmOTBCPUtkVwkIivZWgMvR0mk/56LIQIRECbdUHQq+li
         pd5DZrfc4Xi5dA41q72aL9Qj8jdEnYMRmzl2vfUqc9/mJgaqyrG1+2LolGU4e6RAQZ7q
         qrLsY30VXV2Y1OBRGRoeNeZrIQk495un3pzciu+EPFGQnxIfC+ejK5xBCxjcbd8hgK9I
         1yLKMjstCFWJHsqdZ7Z8IRlO6TtVpj5HRTs2IhzSABiNFNxePBa6YvFx52xTmtqYDrhJ
         7YLrWz8Y/8CgWSkFoggbESLgFa+KPypJ3eFJKRdzmxwBdB2kJ1WaKDaEHgPaFJfbRt+s
         mjLg==
X-Gm-Message-State: AOAM530xJNZUoJ1Wa10tNfZH7JEKVgBk+smW7K0gSP/7TxP9AmBVBscv
        HlQAY8SLTVLJ6zrL3rVOZC9akFN9qbS8fQ==
X-Google-Smtp-Source: ABdhPJxRIXRMCwer0BvBdvx2N4tlaAHogR0iHWRFwfxx3NpF7T0YCYX8pjCygN5hvbDrYS0jkzj80NxjzTig6g==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:1581:9ea1:b658:109a])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:1b49:: with SMTP id
 nv9mr7143561pjb.134.1634229110217; Thu, 14 Oct 2021 09:31:50 -0700 (PDT)
Date:   Thu, 14 Oct 2021 09:31:46 -0700
In-Reply-To: <20211013180130.GB22036@blackbody.suse.cz>
Message-Id: <20211014163146.2177266-1-shakeelb@google.com>
Mime-Version: 1.0
References: <20211013180130.GB22036@blackbody.suse.cz>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH v2 1/2] memcg: flush stats only if updated
From:   Shakeel Butt <shakeelb@google.com>
To:     mkoutny@suse.com
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Wed, Oct 13, 2021 at 11:01 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> On Fri, Oct 01, 2021 at 12:00:39PM -0700, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > In this patch we kept the stats update codepath very minimal and let th=
e
> > stats reader side to flush the stats only when the updates are over a
> > specific threshold. =C2=A0For now the threshold is (nr_cpus * CHARGE_BA=
TCH).
>
> BTW, a noob question -- are the updates always single page sized?
>
> This is motivated by apples vs oranges comparison since the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_cpus * MEMCG_CHARGE_BATCH
> suggests what could the expected error be in pages (bytes). But it's most=
ly
> wrong since: a) uncertain single-page updates, b) various counter
> updates summed together. I wonder whether the formula can serve to
> provide at least some (upper) estimate.
>

Thanks for your review. This forces me to think more on this because each
update does not necessarily be a single page sized update e.g. adding a hug=
epage
to an LRU.

Though I think the error is time bounded by 2 seconds but in those 2 second=
s
mathematically the error can be large. What do you think of the following
change? It will bound the error better within the 2 seconds window.



From e87a36eedd02b0d10d8f66f83833bd6e2bae17b8 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 14 Oct 2021 08:49:06 -0700
Subject: [PATCH] Better bounds on the stats error

---
 mm/memcontrol.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f1d9c028897..e5d5c850a521 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -626,14 +626,20 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_=
tree_per_node *mctz)
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork)=
;
 static DEFINE_SPINLOCK(stats_flush_lock);
-static DEFINE_PER_CPU(unsigned int, stats_updates);
+static DEFINE_PER_CPU(int, stats_diff);
 static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
=20
-static inline void memcg_rstat_updated(struct mem_cgroup *memcg)
+static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
+	unsigned int x;
+
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
-	if (!(__this_cpu_inc_return(stats_updates) % MEMCG_CHARGE_BATCH))
-		atomic_inc(&stats_flush_threshold);
+
+	x =3D abs(__this_cpu_add_return(stats_diff, val));
+	if (x > MEMCG_CHARGE_BATCH) {
+		atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
+		__this_cpu_write(stats_diff, 0);
+	}
 }
=20
 static void __mem_cgroup_flush_stats(void)
@@ -672,7 +678,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int id=
x, int val)
 		return;
=20
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
-	memcg_rstat_updated(memcg);
+	memcg_rstat_updated(memcg, val);
 }
=20
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -705,7 +711,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
=20
-	memcg_rstat_updated(memcg);
+	memcg_rstat_updated(memcg, val);
 }
=20
 /**
@@ -807,7 +813,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enu=
m vm_event_item idx,
 		return;
=20
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
-	memcg_rstat_updated(memcg);
+	memcg_rstat_updated(memcg, val);
 }
=20
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
--=20
2.33.0.882.g93a45727a2-goog

