Return-Path: <cgroups+bounces-6207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA60A142CC
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 21:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E73A1265
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69024233552;
	Thu, 16 Jan 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN+iTzpo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101114AD2B;
	Thu, 16 Jan 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058062; cv=none; b=ijheJftcCYvhHmMRu++AB54H3uq3giqkcThOG+zknr3vTntx3wFK0vcohHqhRIMHrFoCJhGV4sAKXNokfEdzq/MZhzL4fuUJXyBnqniDCAgvU1F87U5wv6vrij0059yih+Gz9CLnbJjseEv0ByoO6Q3KD3IiGxrwaa5ftliogEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058062; c=relaxed/simple;
	bh=diETxsMBKb/3FYBYzT6vRNkUl5LCyvy4qd80Yk7EGmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1xhnFw4LUo843zadnlPZckTsbkGiCQDp9k8YiThwr2maw/FS56bGvlwLAYsktF6izkwtR0tyjx+kHNXitYQz4SOMlIKH/WSVvoY1HyUYgarC+K7FZzHEnTJrNu790ZWQ26jtnqhFF7l5fz8QPN4E/RyI6lvTlE7+ej+j0zBf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN+iTzpo; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e46ebe19368so2195360276.0;
        Thu, 16 Jan 2025 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737058059; x=1737662859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMzocZGufmY08ORRryuT3l3f/0QKdj5Gq8ab9u9GUIU=;
        b=LN+iTzpo5772JLl3xTHYgQnhjo4En7sfIfzdt7z2ll+nhSCMb0qhCC5jUkwysa+fLe
         PYaqyfBX6xOU3CgFCvFbBN6RYJv/GWiq7QkyPUv9X7VWtJOpE3soErlkPoyi15gtvviz
         pMV0Mnyy+V3P6a/lQJMkJ+UhvFb5wYSsGqrX1H9Hg6iwhjB9byjQubhpHx49hyZ5LwBi
         sCGPlDWd2i38c9RWiuSzMwuoonGmd95qFw7b2V9Pa2RAlljW++SXRycMq88cl5936pZo
         BbdiJcLrvaeyf64BuAxQlAUhtxFt7nJZzDAAZO5z1th7qfjiWmo/8bvVTadFGraTcgOG
         zOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058059; x=1737662859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMzocZGufmY08ORRryuT3l3f/0QKdj5Gq8ab9u9GUIU=;
        b=mqtmSQ3If+HY3VaGSyeItl+kOUAK9gVRucesLli/PdTBVk52ALzXJx6dfT9W51uLfv
         lFx0l8/5X9O551yICfYpGj5lX/ufuPR2BEGJ2uCNqIq37YiPhhT8OnGnpz+CE9SdQb2R
         8S/P4hvS1PbbcF8PCf1N2rOOg+tJ/Xip2dlSe+HDbIJk//4HCu1Y6YdPuSwcTzHxgaMd
         m4vPG/FL2rBhdenPIPLzPwf0tJiXOuQ+fXLkpd0dO2e+Bu/XOx/FnWDBlOQJzU2+8mK1
         JBwjRYqlvj+YX5FXCzwg4beEk+HnRNm3vMsWNB8rdFBoajC2YgO0UIWLpM/sEUvFuJxm
         1dPA==
X-Forwarded-Encrypted: i=1; AJvYcCX0FXOC+LsMLjuSG+D5psIBa1PubsTjuweYlr5sgWV9f/Mqm/kpNE12v6x3HWnE9tyXk4tJLuX2Fg==@vger.kernel.org, AJvYcCXl448WXn6OIy36cP0L3t/TaKPXDpArmF4F2TfsWeF/nnBBC53gG3gunwLgvQlfIQE5ur8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH53ruiGYLoyHTuHgSE1u4mmi2cLenIUZdcGLPy+01S67AQD5H
	j+DKxnW5RVR8o3bHMZtHXJ+ytCK9QsTePPP97i5K4GuCFhCU1ARN
X-Gm-Gg: ASbGncv479r8hFdMMO4ldTw/MNs5yldmOvxcKEDF3FiIvuzVkzs4IbfRXxTHtX4tfMu
	zLKLfNoZHgxLH0gozDKhwuqAkBWHtkN+KrFCJ0WrVq2GMs6gOn6MegQ3dtNa47w3JsXtHX2MpMa
	WB5oGvfs4RRqf1YjR14JwwIfhgyPzQxaIF+aELaww6lBYtX22luCipodJrHpclQ2vk4xYHBi2qt
	mRAhxWITaz8Azd4AZhLlrmw8rrFlTwt1V06CgW5QNXGiuWzgqNX9FU=
X-Google-Smtp-Source: AGHT+IElAOjOznvnPvhDbeipx3/9fXEkL2L8b0Or+haAxTNXi+6R4va6QdSxmB3SVSM9UpUWzjq9nA==
X-Received: by 2002:a05:690c:f0c:b0:6ec:b74d:a013 with SMTP id 00721157ae682-6f531245e89mr305922467b3.19.1737058059236;
        Thu, 16 Jan 2025 12:07:39 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63fd397sm1761737b3.36.2025.01.16.12.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:07:38 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	joshua.hahnjy@gmail.com,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 4/7] memcg: Use trylock to access memcg stock_lock.
Date: Thu, 16 Jan 2025 12:07:28 -0800
Message-ID: <20250116200736.1258733-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAADnVQLEfjETi+L3PXwTz7i+MnT4FT1ohoAL555N_Mdhd+vqBg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 Jan 2025 18:22:28 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Jan 15, 2025 at 4:12 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Jan 14, 2025 at 06:17:43PM -0800, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Teach memcg to operate under trylock conditions when spinning locks
> > > cannot be used.
> > >
> > > local_trylock might fail and this would lead to charge cache bypass if
> > > the calling context doesn't allow spinning (gfpflags_allow_spinning).
> > > In those cases charge the memcg counter directly and fail early if
> > > that is not possible. This might cause a pre-mature charge failing
> > > but it will allow an opportunistic charging that is safe from
> > > try_alloc_pages path.
> > >
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
> > > @@ -1851,7 +1856,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> > >  {
> > >       unsigned long flags;
> > >
> > > -     local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > +     if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > > +             /*
> > > +              * In case of unlikely failure to lock percpu stock_lock
> > > +              * uncharge memcg directly.
> > > +              */
> > > +             mem_cgroup_cancel_charge(memcg, nr_pages);
> >
> > mem_cgroup_cancel_charge() has been removed by a patch in mm-tree. Maybe
> > we can either revive mem_cgroup_cancel_charge() or simply inline it
> > here.
> 
> Ouch.
> 
> this one?
> https://lore.kernel.org/all/20241211203951.764733-4-joshua.hahnjy@gmail.com/
> 
> Joshua,
> 
> could you hold on to that clean up?
> Or leave mem_cgroup_cancel_charge() in place ?

Hi Alexei,

Yes, that makes sense to me. The goal of the patch was to remove the
last users and remove it, but if there are users of the function, I
don't think the patch makes any sense : -)

Have a great day!
Joshua



Hi Andrew,

I think that the patch was moved into mm-stable earlier this week.
I was wondering if it would be possible to revert the patch and
replace it with this one below. The only difference is that I leave
mem_cgroup_cancel_charge untouched in this version.

I'm also not sure if this is the best way to send the revised patch.
Please let me know if there is another way I should do this to make
it easiest for you!

Thank you for your time!
Joshua

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d1ee98dc3a38..c8d0554e5490 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -620,8 +620,6 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		page_counter_read(&memcg->memory);
 }

-void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
-
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);

 /**
@@ -646,9 +644,6 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }

-int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
-		long nr_pages);
-
 int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);

 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
@@ -1137,23 +1132,12 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 	return false;
 }

-static inline void mem_cgroup_commit_charge(struct folio *folio,
-		struct mem_cgroup *memcg)
-{
-}
-
 static inline int mem_cgroup_charge(struct folio *folio,
 		struct mm_struct *mm, gfp_t gfp)
 {
 	return 0;
 }

-static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
-		gfp_t gfp, long nr_pages)
-{
-	return 0;
-}
-
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dd171bdf1bcc..aeff2af8d722 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2402,18 +2402,6 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }

-/**
- * mem_cgroup_commit_charge - commit a previously successful try_charge().
- * @folio: folio to commit the charge to.
- * @memcg: memcg previously charged.
- */
-void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
-{
-	css_get(&memcg->css);
-	commit_charge(folio, memcg);
-	memcg1_commit_charge(folio, memcg);
-}
-
 static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
 				       struct pglist_data *pgdat,
 				       enum node_stat_item idx, int nr)
@@ -4501,7 +4489,9 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	if (ret)
 		goto out;

-	mem_cgroup_commit_charge(folio, memcg);
+	css_get(&memcg->css);
+	commit_charge(folio, memcg);
+	memcg1_commit_charge(folio, memcg);
 out:
 	return ret;
 }
@@ -4527,40 +4517,6 @@ bool memcg_accounts_hugetlb(void)
 #endif
 }

-/**
- * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
- * @memcg: memcg to charge.
- * @gfp: reclaim mode.
- * @nr_pages: number of pages to charge.
- *
- * This function is called when allocating a huge page folio to determine if
- * the memcg has the capacity for it. It does not commit the charge yet,
- * as the hugetlb folio itself has not been obtained from the hugetlb pool.
- *
- * Once we have obtained the hugetlb folio, we can call
- * mem_cgroup_commit_charge() to commit the charge. If we fail to obtain the
- * folio, we should instead call mem_cgroup_cancel_charge() to undo the effect
- * of try_charge().
- *
- * Returns 0 on success. Otherwise, an error code is returned.
- */
-int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
-			long nr_pages)
-{
-	/*
-	 * If hugetlb memcg charging is not enabled, do not fail hugetlb allocation,
-	 * but do not attempt to commit charge later (or cancel on error) either.
-	 */
-	if (mem_cgroup_disabled() || !memcg ||
-		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
-		return -EOPNOTSUPP;
-
-	if (try_charge(memcg, gfp, nr_pages))
-		return -ENOMEM;
-
-	return 0;
-}
-
 int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
 {
 	struct mem_cgroup *memcg = get_mem_cgroup_from_current();

