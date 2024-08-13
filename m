Return-Path: <cgroups+bounces-4242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02D950E22
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 22:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA8C1C233DB
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9512F1AAE35;
	Tue, 13 Aug 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldb639jd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC521AAE22
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582084; cv=none; b=i1wHMRL0q1JjDaqQ5MyyRPnf8nSaMFovZL9Q22ocorlya2cQiBLw/eHed2lKUfxaSp63w8KTBL1y94N7gveuEuaHk8iUB1VAFR8O36KV1MEhuSDLkoof0tTzBajHyP16wrMEoBewdhdYbRCa+mSw4E6KyZrlh6HfkP8xU0R6AUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582084; c=relaxed/simple;
	bh=4J0w/9yc2JVD8H+ljNSMIrZxux6P1Zepecw3a7ltVZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VDQG4E0r41RD4z15pVdBRI2132x7caIRs6aTIXLUcYL4iaUVPWGx0LTWEr9AXU+vJfcXqteBK+HduBmpzjE8ZCFpU/pJuYeKWqp8gvxPvZIdXkTAlPEt1zU+SUH6ZczG8TP+r64DU6Zp5w5vJkmuYrLkd5vjzjWfTinesaO0Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldb639jd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be1808a36so8762200276.1
        for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582082; x=1724186882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUGrqgCsQ93s1mn5jRCuzR3kYh6lZBiPS4o7+rn6SUc=;
        b=ldb639jdIF1THzAgJ3aocsbuVk63GxEKy0UfE698W9aiSV63f5kuyrR28V7bzJZPfB
         tM9GpAzn+RJKifC9nhVOHL0uuFTIkOWDyndBxdLrI1UqiuzfPdPb7v1SLawEvJ77LLU6
         lt17lGXczQjErGVXCikm8/ahNs5c+7Mi2N45dXF2HzV5rxOvn6T/qTa1RRxPTix8rcLD
         ffTb+AvPvp111IfwdMHbqp1MleuIEVV/p1r9iEG8gdOYoxFUhEMbZOq0jUvDM4wpWPq7
         wGMqhGo9dd40TqZBZrbaxG0YUIIa/3ARUZNW3WwXovLu718S0MxWdS8sn4Pb3QDf+Ims
         8YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582082; x=1724186882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUGrqgCsQ93s1mn5jRCuzR3kYh6lZBiPS4o7+rn6SUc=;
        b=mE6+h5VaBSX6IjZ9tbWgbVVjwl5TyPm9eO/3VO6HmbrbFv4g+fUYYMkqttmfBILnCI
         SoJjDZkLWJjUisCXGRvjeenAKdppRw+yOsOqhhDX+Z62998qnOIW17V4Fb5RnXS8ya4l
         fjOlv6vkB1/QRqXqDEXaUHz/IC2mNe6qitkkz65pQcHgK1xEZTPFG+i0Om2iG6cjYzKZ
         Wpt2xrGfEuc5jNgvPai4GWDr4W9rvNjEsK2WKmPhAYzDVg4Y5mDOlm+dXeREJhJ+NbwN
         I6Ygp6Z0Ij+eONhHjtIL/d8VVSD0JKnliKjl0hvjBMQz6Awd27Nir0W6qLv4MECprY6z
         1PQw==
X-Forwarded-Encrypted: i=1; AJvYcCX8aRgJmC80k0f+P9CRedo0/KUCr0G9OB+pYAHg7Pp/pY//yISE+vYc0NJInvtJ3c7EUGnT7SCDAdwiiz4H0OK3+aDq6UVeLA==
X-Gm-Message-State: AOJu0YxTH0chIdG9pywHkbiRACl/RBCtms1PCMjOM7Drj8fkMQSygEyb
	7biuQgqsSJFIU8QPqa8+Qr3GeE0knKNBCdxqN7n7vkFEaLap5JPFNr48GQDj9LLLYmdPwkwTout
	h70FIvnxY7Q==
X-Google-Smtp-Source: AGHT+IFKq4mle76EHVxRvn3g1KvqjdbIlRdYAcckM9mm8INZMPhwqmIEIFFgUqblYHs8iR9k3Dh891L/+5f5YA==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6902:18d:b0:e03:589b:cbe1 with SMTP
 id 3f1490d57ef6-e1155b67c75mr35668276.7.1723582081844; Tue, 13 Aug 2024
 13:48:01 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:47:15 +0000
In-Reply-To: <20240813204716.842811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813204716.842811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813204716.842811-6-kinseyho@google.com>
Subject: [PATCH mm-unstable v2 5/5] mm: clean up mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

A clean up to make variable names more clear and to improve code readability.

No functional change.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/memcontrol.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 84de46ece9a9..87a0dc9d779a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1026,8 +1026,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 {
 	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css;
-	struct mem_cgroup *memcg = NULL;
-	struct mem_cgroup *pos = NULL;
+	struct mem_cgroup *pos;
+	struct mem_cgroup *next = NULL;
 
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -1039,10 +1039,9 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 restart:
 	if (reclaim) {
 		int gen;
-		struct mem_cgroup_per_node *mz;
+		int nid = reclaim->pgdat->node_id;
 
-		mz = root->nodeinfo[reclaim->pgdat->node_id];
-		iter = &mz->iter;
+		iter = &root->nodeinfo[nid]->iter;
 		gen = atomic_read(&iter->generation);
 
 		/*
@@ -1055,29 +1054,22 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 			goto out_unlock;
 
 		pos = rcu_dereference(iter->position);
-	} else if (prev) {
+	} else
 		pos = prev;
-	}
 
 	css = pos ? &pos->css : NULL;
 
-	for (;;) {
-		css = css_next_descendant_pre(css, &root->css);
-		if (!css) {
-			break;
-		}
-
+	while ((css = css_next_descendant_pre(css, &root->css))) {
 		/*
 		 * Verify the css and acquire a reference.  The root
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		if (css == &root->css || css_tryget(css)) {
+		if (css == &root->css || css_tryget(css))
 			break;
-		}
 	}
 
-	memcg = mem_cgroup_from_css(css);
+	next = mem_cgroup_from_css(css);
 
 	if (reclaim) {
 		/*
@@ -1085,13 +1077,13 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		if (cmpxchg(&iter->position, pos, memcg) != pos) {
+		if (cmpxchg(&iter->position, pos, next) != pos) {
 			if (css && css != &root->css)
 				css_put(css);
 			goto restart;
 		}
 
-		if (!memcg) {
+		if (!next) {
 			atomic_inc(&iter->generation);
 
 			/*
@@ -1110,7 +1102,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	if (prev && prev != root)
 		css_put(&prev->css);
 
-	return memcg;
+	return next;
 }
 
 /**
-- 
2.46.0.76.ge559c4bf1a-goog


