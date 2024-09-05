Return-Path: <cgroups+bounces-4710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC496CBCC
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 02:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F921F277CD
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 00:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23673179A8;
	Thu,  5 Sep 2024 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLHhJAhB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBA168B1
	for <cgroups@vger.kernel.org>; Thu,  5 Sep 2024 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496318; cv=none; b=YRjYLb2wzA+k829lgkhriCe4bG/u9Vxl1ip9e/o7WHBXbbg2umnfHbMGh2NbaYgldb/Epub4X1ipGCR+t6f6e76W1vPRe/GyziaDD2ZhdYkRPGvfoLGFv4RBQUjih5FvNqGroTXmC1tLSmnIdEjfcu1vzeAqqEvHfsTTrI8uTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496318; c=relaxed/simple;
	bh=rNTFMsSf4ipv9IfY2q02hT078vD9+pCTekO9b6Df+h4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DKjx58kP9gd+X7A6LKnFmWQMA3nASHTAYfDO5YsJYGRyxbE/2kBJKrS/nny8JukaK3q5N5Ewy+oUS9T5/KUmC2J8reJTOrw5ctMH9x3Ms7kW4xL31ObZHnw9eBeUQh9lVuw9hELmG3/hfE+XxnxemjbgK7QktpZ3WLsjnICsqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLHhJAhB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cf546bbcffso289073a12.1
        for <cgroups@vger.kernel.org>; Wed, 04 Sep 2024 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496317; x=1726101117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFlJk+bdMFXrL5bkGb5l4QnCCI5p7k/K3Pj8oKz1txU=;
        b=aLHhJAhBI8aHQsrfn5T2wGgEdvoqYMAihfPSqMf7j71JfQQf95Qjhr9OUaPxkBNqm7
         bIbw2SWiHwkDTXHEiKVFfHT2XQXJVvNQE+fGpPR2eFoAG903g9rsECuXJ6xAda67ZdZO
         zwabj2j1YQGv7G7BNlScoTqGE9eWH7+3HKohzIGxvFa4iFjd2OO10G6AaaOh7xFwLkFk
         cvByu+MdmIhbg8+FLZ1oQl5qkcMw6gEq+Oq2VFFQSJIej0MBQ2g/gCdKqw/6JUauL2WH
         pPLcUeNJw5Vwxg4K6wEoK1KYQ0oycGwzWOUpuENJ+HeESptf9/nlwgCKLHwPvEPaH89w
         qnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496317; x=1726101117;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UFlJk+bdMFXrL5bkGb5l4QnCCI5p7k/K3Pj8oKz1txU=;
        b=OVBfz35fgCwNN4dkUTkP6EHThOxEdAbJQsDakthvxRGPrwYaVvLkdO7sWgLqOtqWru
         wMXdqec2W8mgBNS178/tjZbA74Un9Zz76ahbmjKQffjMPR5ou/fNpxyLQPAtY/QJC5Lh
         JdEja6enXoLaif0wMgaNC/c/wnoO7S5seGEfjotqdIDn5stYh8HXLadyJLtXSXD+z4ZA
         ppYn2EgwLnxoeJaQZ8LENyi0DUz/EO0+R/RYHNsrtE40+Bh7/n8CpY7bG0DxWjI0dvLR
         ZJ1ByLTtQP/fd156V+ja4Wm+GPp/GYhEqxorheaJhqjnGAMMwLcPKuiUFtkD05uSRiOr
         eiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHYt11t8Tui0bCfthgOWBdgLN1Alz2IUrNmRSO75JDO0wIs33HfEX+axEZVHqOLrxL0jDxmuI0@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhswkX6jJV7JkeZvPUEbCs7rfSzPzLP661kwRszHltDzLrQ0I
	JH61uX42F1rRA9gIzdWB88J7jCliXJ0MJKOZEcNgloKJU+tvnRWLAACeriON+O3qqmoWJ0+nxAL
	WAyfzeJXYCA==
X-Google-Smtp-Source: AGHT+IFCmyZz1oeuwdzh9ujb+lyKCdb7Lv33IMyUDlAfA9IgJETASTtABlliPQg/ISAiLVSGlddqDM0VzXnGuQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6a02:2385:b0:6c4:5b35:c986 with SMTP
 id 41be03b00d2f7-7d50176fca8mr4225a12.8.1725496316657; Wed, 04 Sep 2024
 17:31:56 -0700 (PDT)
Date: Thu,  5 Sep 2024 00:30:54 +0000
In-Reply-To: <20240905003058.1859929-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905003058.1859929-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905003058.1859929-6-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 5/5] mm: clean up mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	"T . J . Mercier" <tjmercier@google.com>, Hugh Dickins <hughd@google.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A clean up to make variable names more clear and to improve code
readability.

No functional change.

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
 mm/memcontrol.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ce5d066393c9..31db8467f19d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -989,8 +989,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *r=
oot,
 {
 	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css;
-	struct mem_cgroup *memcg;
-	struct mem_cgroup *pos =3D NULL;
+	struct mem_cgroup *pos;
+	struct mem_cgroup *next;
=20
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -1000,14 +1000,13 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
=20
 	rcu_read_lock();
 restart:
-	memcg =3D NULL;
+	next =3D NULL;
=20
 	if (reclaim) {
 		int gen;
-		struct mem_cgroup_per_node *mz;
+		int nid =3D reclaim->pgdat->node_id;
=20
-		mz =3D root->nodeinfo[reclaim->pgdat->node_id];
-		iter =3D &mz->iter;
+		iter =3D &root->nodeinfo[nid]->iter;
 		gen =3D atomic_read(&iter->generation);
=20
 		/*
@@ -1020,29 +1019,22 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
 			goto out_unlock;
=20
 		pos =3D READ_ONCE(iter->position);
-	} else if (prev) {
+	} else
 		pos =3D prev;
-	}
=20
 	css =3D pos ? &pos->css : NULL;
=20
-	for (;;) {
-		css =3D css_next_descendant_pre(css, &root->css);
-		if (!css) {
-			break;
-		}
-
+	while ((css =3D css_next_descendant_pre(css, &root->css))) {
 		/*
 		 * Verify the css and acquire a reference.  The root
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		if (css =3D=3D &root->css || css_tryget(css)) {
+		if (css =3D=3D &root->css || css_tryget(css))
 			break;
-		}
 	}
=20
-	memcg =3D mem_cgroup_from_css(css);
+	next =3D mem_cgroup_from_css(css);
=20
 	if (reclaim) {
 		/*
@@ -1050,13 +1042,13 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		if (cmpxchg(&iter->position, pos, memcg) !=3D pos) {
+		if (cmpxchg(&iter->position, pos, next) !=3D pos) {
 			if (css && css !=3D &root->css)
 				css_put(css);
 			goto restart;
 		}
=20
-		if (!memcg) {
+		if (!next) {
 			atomic_inc(&iter->generation);
=20
 			/*
@@ -1075,7 +1067,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup =
*root,
 	if (prev && prev !=3D root)
 		css_put(&prev->css);
=20
-	return memcg;
+	return next;
 }
=20
 /**
--=20
2.46.0.469.g59c65b2a67-goog


