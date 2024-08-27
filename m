Return-Path: <cgroups+bounces-4523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B66961A46
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE781F24844
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C51D54F3;
	Tue, 27 Aug 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luT5wC9r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E31D47DB
	for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800308; cv=none; b=AdilGptUMY4cHxTYBS3MbGKpFYKDvqIe7u7gFELNI5A4uEnod0PkHWYstXULWDDe9RmUl+V8xqn4A/J/4HjROq6Gd8qIXycjKSDpfvUFKn7iby5vbVyvjnb8Ym0npyODY5LQ0I874VrjiMK2g4H4COcvpWJFDzgOZePcf11VHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800308; c=relaxed/simple;
	bh=S1S4yqh1NPYayJ940lwvzrOEw1UTdu7vbQmz11c0RI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rus+cQbhd4Iinvu4/zSFQA8m2dUyPf/7OvEX3LgTv/+VC4+YyniEaWZ5nmSc/bhblxNDJWDfNVajtLHo0Ar21McLi+qRhmrSkw3QgKdaxkWU2Y39/i6shRhIzws70PtlVlQ6QnjJjtowDHxuLXfbzgMw2uyliRYexfDdyOD+UsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luT5wC9r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b46a237b48so127400947b3.1
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800305; x=1725405105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GW/USJCjupc34zRwCQ9bHi7JmQHKfEiUl9nNlR9x2Hk=;
        b=luT5wC9rusx55XedaPAqa6mzDF7BZkeOjKEdIuYEyh7Hl+XCek1cBvOp0PZxyrUFFV
         X7orzv/4LbKeiUkg5qiT7AEQc//+XRIUA3oP4SOFi1qcZkWeCzj+NRsBeTY0Duy9FXz5
         TrdNIS/gAoLkhnz9y3BjZJkN1DZnKKFlyEuaISFAE39uy5q1SdC+oFL9L0n98DjHe4F3
         g6LEc47Mm55gQdXoAs2U8TJ3uLLKTVAmPny5bHoIwpDhguDltDxQmnEAknyWR0mRrL2R
         VrAhupptcJZvuQVxwmdFaMWcgm9Om7UYN9fn1rmKNECJ089kfGQNGwFeHc67J2NAeApi
         +vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800305; x=1725405105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW/USJCjupc34zRwCQ9bHi7JmQHKfEiUl9nNlR9x2Hk=;
        b=WsEKur05X1mYC4nInWy6d1+kenpq8wx1VmsO+hQtB/rritKjAYOxzJyHGJBm4zQp4H
         6Ni16GpgoFvHr5E/guwv04rwugxS37XxAMwdUwxEta2JA8sXWoBx3eahoriSkrV6DN1m
         zzMNFnXBLFPEsIMXzZd7Nde84uUfpUO12iw6Cg+S/sJBM2vVvwiMxiTDhsLLL+9cBS6g
         XyS3ED13zEQKA9sHxaLUxC0MbuWl7gq7C84MRORibRVPL0LkkHBQmaexKhdxnsf1Tpsr
         gVjHEAvXvl1eD1RLVB0F39dKvpZvPZnBahdQF4s58V0zYUJD7E50lywyqhcsfnKu41tn
         +htg==
X-Forwarded-Encrypted: i=1; AJvYcCU+qdCG9/cmO1PER2uJesiRlkA87mD5gLIK7DWWnd4w50ZDosrJVynr/4Ul1smTQgX6zRcoq7+V@vger.kernel.org
X-Gm-Message-State: AOJu0YycEEPgStpJhlUgvfVYqsV122GFhwhM3/z1xkfjQ70RjJ0zd0d1
	YOzc4CH0qy4mSSQRuAbnqruHLAOvVC6JRxvEkKbXtXtJh0L9OpKr7eG1D+MaIftM5GWs4HrFqNA
	LdYi6gdY8HA==
X-Google-Smtp-Source: AGHT+IF1yp8ipyeMEvESYLh84If45Gfi4ptWiqS2P4CUd5/mGA60SGsDPudut6D5G0yZlYICuZUQrkeSqUZvzQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:690c:46c3:b0:69a:536:afd3 with SMTP
 id 00721157ae682-6d172052874mr2467b3.5.1724800304855; Tue, 27 Aug 2024
 16:11:44 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:41 +0000
In-Reply-To: <20240827230753.2073580-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals raced
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, if multiple reclaimers raced on the same position, the
reclaimers which detect the race will still reclaim from the same memcg.
Instead, the reclaimers which detect the race should move on to the next
memcg in the hierarchy.

So, in the case where multiple traversals race, jump back to the start
of the mem_cgroup_iter() function to find the next memcg in the
hierarchy to reclaim from.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/memcontrol.c            | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fe05fdb92779..2ef94c74847d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -57,7 +57,7 @@ enum memcg_memory_event {
 
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
-	unsigned int generation;
+	int generation;
 };
 
 #ifdef CONFIG_MEMCG
@@ -78,7 +78,7 @@ struct lruvec_stats;
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup *position;
 	/* scan generation, increased every round-trip */
-	unsigned int generation;
+	atomic_t generation;
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 51b194a4c375..33bd379c738b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -986,7 +986,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
 	struct mem_cgroup_reclaim_iter *iter;
-	struct cgroup_subsys_state *css = NULL;
+	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg = NULL;
 	struct mem_cgroup *pos = NULL;
 
@@ -999,18 +999,20 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	rcu_read_lock();
 restart:
 	if (reclaim) {
+		int gen;
 		struct mem_cgroup_per_node *mz;
 
 		mz = root->nodeinfo[reclaim->pgdat->node_id];
 		iter = &mz->iter;
+		gen = atomic_read(&iter->generation);
 
 		/*
 		 * On start, join the current reclaim iteration cycle.
 		 * Exit when a concurrent walker completes it.
 		 */
 		if (!prev)
-			reclaim->generation = iter->generation;
-		else if (reclaim->generation != iter->generation)
+			reclaim->generation = gen;
+		else if (reclaim->generation != gen)
 			goto out_unlock;
 
 		pos = READ_ONCE(iter->position);
@@ -1018,8 +1020,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		pos = prev;
 	}
 
-	if (pos)
-		css = &pos->css;
+	css = pos ? &pos->css : NULL;
 
 	for (;;) {
 		css = css_next_descendant_pre(css, &root->css);
@@ -1033,21 +1034,26 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * and kicking, and don't take an extra reference.
 		 */
 		if (css == &root->css || css_tryget(css)) {
-			memcg = mem_cgroup_from_css(css);
 			break;
 		}
 	}
 
+	memcg = mem_cgroup_from_css(css);
+
 	if (reclaim) {
 		/*
 		 * The position could have already been updated by a competing
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		(void)cmpxchg(&iter->position, pos, memcg);
+		if (cmpxchg(&iter->position, pos, memcg) != pos) {
+			if (css && css != &root->css)
+				css_put(css);
+			goto restart;
+		}
 
 		if (!memcg) {
-			iter->generation++;
+			atomic_inc(&iter->generation);
 
 			/*
 			 * Reclaimers share the hierarchy walk, and a
-- 
2.46.0.295.g3b9ea8a38a-goog


