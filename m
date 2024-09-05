Return-Path: <cgroups+bounces-4709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0696CBCA
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 02:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E23A28A669
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 00:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640EC15E86;
	Thu,  5 Sep 2024 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bcd8t2hv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3312B82
	for <cgroups@vger.kernel.org>; Thu,  5 Sep 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496317; cv=none; b=UAS6tmVucjiAqHTT2DHkvO+Hb+bQcAipJQ3LrkTTO2CsuGANNxwtbLx+8qhooQUUr14l7661luC9oOE+aJhWLo6uIVcG5KkA6JisR5EwiG7KS+GPn4sjyGTAP7TVB985HSD0LPkqV9rasf1D1m9OSCoVvXFT2rpVRen1eYk69eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496317; c=relaxed/simple;
	bh=tNdPgcpIqADtqnC02rHoIq3VZI89MnwpugBq5dQEs0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jDRzhmVAXZXIknGR+oVveOsWP0NaS1C4m7WUNRGjHBR17nv/0US71sz1K1GzdBC3UDf34fexvX6iYeYYsX97e6nXrKekgaN1BsTO5eTp7MO8csB8w01v3ILTCrCqJmxU+zgHhOp2H8gCGPpWvkbLzUP8IzIXzn2vNAHOhlI0fJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bcd8t2hv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7cd9ac1fa89so286038a12.1
        for <cgroups@vger.kernel.org>; Wed, 04 Sep 2024 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496315; x=1726101115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+NIQ3hruAHgC9xMj3fhofnWDiiLf7+Cp7wyaHwiSJ4=;
        b=Bcd8t2hv6uy7PvHGY8hp73vQwhNH7Nw9dAP8Wv4NcGSnB+GU+fcl1f0BrnoNqhLqiz
         n84PTlQ7aXAFMfdHpCyyx8h6l4Wsl4hkHoE7jBK+g3JY+c6bYieKX4dbmI3D1jIX3cTK
         bJoAVcoWVsUjPK0AITkN430mvWFVVATHMlAF9TYtgdzY3IFvaKR8q2ToRHXRD2909aLs
         4Rlg2mrQAboAUsA9P4fRWczdXwgFyRJbhdoutOzi6VXBJddLlDgHGbcSfM1yFNTHE1yi
         rXTiZzrsslhOZrlZ8CktFn6IAyRbymNienNK0qU9SOS9K2v7tSSotB5AIi31GgbQHELX
         S3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496315; x=1726101115;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+NIQ3hruAHgC9xMj3fhofnWDiiLf7+Cp7wyaHwiSJ4=;
        b=dUun4XIy0+zZuQWeZ/ceKSpA3i4nP2Vtca50Hk9rVGf06IhJlems9p8ZdgHpzcNonM
         BmWNsgPzwI7xejBCF1dA56Qcf685Y3rbWiEZRHzB8tk9aEcFGgMgoPaPyQ2+4VK8H9U1
         X+FGby8w+OK8+dfDEdIYv/Pd4lqGFABUL+cFoOvEA6qeqOKxaFN1YwNGX5omtQ5ShwFZ
         blr1gwFEDx5jRRGdJ9X975CkT3pUlWrvVpZnpliYbCk4RbTlXn8EvYCyPIgEHaXnVb9J
         v/U1pMPOcYsdmVSUKNq2dACaIWvaWfE5XuaQiTK//h5LvOUbv5PW5xGkUG2Uib0+amUR
         XxUg==
X-Forwarded-Encrypted: i=1; AJvYcCVCYT7hMgnV5Q1lDjhkC4KMmAu7MQaID6y9FV+r59JSTUOT7kqrLl8KsNIHzAwa1tZ4pHdhcWY0@vger.kernel.org
X-Gm-Message-State: AOJu0YwnhdStsa0fPLCtxLrK9hvDK7Mqgipac5QyGpAuOkjg64X9tKh0
	OkKLG58pLk11S+vF6I3hRJzxwYOeItO9zJfd7ca/CD0aZ7m45w9j4ZuTo4npoHWAenyAiwDXT9/
	V9kOnk8UxbA==
X-Google-Smtp-Source: AGHT+IFE9E8HfCvWJ7p3tjF6dU79+RYxA1wZ2PaXCVQ7+B7BuvDX9ZOeiHESUdZETs6+j99tFDtqjKU0xWP7eQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a63:1c16:0:b0:7cd:8558:9151 with SMTP id
 41be03b00d2f7-7d4c1094218mr69531a12.10.1725496314864; Wed, 04 Sep 2024
 17:31:54 -0700 (PDT)
Date: Thu,  5 Sep 2024 00:30:53 +0000
In-Reply-To: <20240905003058.1859929-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905003058.1859929-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905003058.1859929-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 4/5] mm: restart if multiple traversals raced
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	"T . J . Mercier" <tjmercier@google.com>, Hugh Dickins <hughd@google.com>, Kinsey Ho <kinseyho@google.com>, 
	syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, if multiple reclaimers raced on the same position, the
reclaimers which detect the race will still reclaim from the same memcg.
Instead, the reclaimers which detect the race should move on to the next
memcg in the hierarchy.

So, in the case where multiple traversals race, jump back to the start
of the mem_cgroup_iter() function to find the next memcg in the
hierarchy to reclaim from.

Reported-by: syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/000000000000817cf10620e20d33@google.com/
Signed-off-by: Kinsey Ho <kinseyho@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Hugh Dickins <hughd@google.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/memcontrol.c            | 26 +++++++++++++++++---------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fe05fdb92779..2ef94c74847d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -57,7 +57,7 @@ enum memcg_memory_event {
=20
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
-	unsigned int generation;
+	int generation;
 };
=20
 #ifdef CONFIG_MEMCG
@@ -78,7 +78,7 @@ struct lruvec_stats;
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup *position;
 	/* scan generation, increased every round-trip */
-	unsigned int generation;
+	atomic_t generation;
 };
=20
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c24ef6a106e0..ce5d066393c9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -988,8 +988,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *r=
oot,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
 	struct mem_cgroup_reclaim_iter *iter;
-	struct cgroup_subsys_state *css =3D NULL;
-	struct mem_cgroup *memcg =3D NULL;
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg;
 	struct mem_cgroup *pos =3D NULL;
=20
 	if (mem_cgroup_disabled())
@@ -1000,19 +1000,23 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
=20
 	rcu_read_lock();
 restart:
+	memcg =3D NULL;
+
 	if (reclaim) {
+		int gen;
 		struct mem_cgroup_per_node *mz;
=20
 		mz =3D root->nodeinfo[reclaim->pgdat->node_id];
 		iter =3D &mz->iter;
+		gen =3D atomic_read(&iter->generation);
=20
 		/*
 		 * On start, join the current reclaim iteration cycle.
 		 * Exit when a concurrent walker completes it.
 		 */
 		if (!prev)
-			reclaim->generation =3D iter->generation;
-		else if (reclaim->generation !=3D iter->generation)
+			reclaim->generation =3D gen;
+		else if (reclaim->generation !=3D gen)
 			goto out_unlock;
=20
 		pos =3D READ_ONCE(iter->position);
@@ -1020,8 +1024,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup =
*root,
 		pos =3D prev;
 	}
=20
-	if (pos)
-		css =3D &pos->css;
+	css =3D pos ? &pos->css : NULL;
=20
 	for (;;) {
 		css =3D css_next_descendant_pre(css, &root->css);
@@ -1035,21 +1038,26 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
 		 * and kicking, and don't take an extra reference.
 		 */
 		if (css =3D=3D &root->css || css_tryget(css)) {
-			memcg =3D mem_cgroup_from_css(css);
 			break;
 		}
 	}
=20
+	memcg =3D mem_cgroup_from_css(css);
+
 	if (reclaim) {
 		/*
 		 * The position could have already been updated by a competing
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		(void)cmpxchg(&iter->position, pos, memcg);
+		if (cmpxchg(&iter->position, pos, memcg) !=3D pos) {
+			if (css && css !=3D &root->css)
+				css_put(css);
+			goto restart;
+		}
=20
 		if (!memcg) {
-			iter->generation++;
+			atomic_inc(&iter->generation);
=20
 			/*
 			 * Reclaimers share the hierarchy walk, and a
--=20
2.46.0.469.g59c65b2a67-goog


