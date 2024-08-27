Return-Path: <cgroups+bounces-4524-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C9961A47
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8441F24827
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B8B1D6182;
	Tue, 27 Aug 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWZnfO+j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AF1D54E5
	for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800309; cv=none; b=R8+8irvCVB379i6+xckHg/CnJle/L/8yONShgJs2PC9kU/woigKScO2V/KTE/QDIAX3u/MGgglON/NJKL/lUFQMUYlD7ZPIC8gFu/PNNmaglnlKmOh6SbonC2WQKDQ31qBIbQfRPhLG1tNAERxuBLG8uhtRzWCPvcTbHGyWSq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800309; c=relaxed/simple;
	bh=Wq+jQvGM0OF+bTL/TJg3bi4vuxkoCJyt+mqQiab3tvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ca7s2vhEePQswBochuomdNF88623Hy+Fi2vMVThMt2oefEepySohEfIKMYRUU1+kQT6yiploCjX7vxkFDb0TFRrOMpduyLjCQ57RMIuNoeVS6QzGSfmxDjXrSBANLf4oYJn2hG7TomuOq7bie2UC/UChfzzDr0H8XCMt3f6t9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWZnfO+j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e164ceba5ffso10162863276.3
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800307; x=1725405107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9O1xAoZAOV8c4zW9/De55yG0OzoFjxVL+7Ggug8PCo=;
        b=jWZnfO+jg24B0DMs4vYV0POKGupZnKieQLE2DOa2/4OyECJo53vESogMi92CGHtE6f
         6o6cJyKSmj8U0PWJLvL++U2zTZMbSEJlrJbNfakGm09zPUpNYsUirOF+v4p9KnOoS6Ql
         HHuAwH/jN9p2HnGCdpoXC84TuwxHZmyxlC5y6HtWKQJo4vEUv7Wt4X52VSDuAK442LW1
         Js5CPoa4o5t97w9v2rb7aSpJPk8G5RnZ89daz/dvZIbEnIqU5eYDcJJqRTDaRUug2meP
         i1avA0HFZB1ZhSHnwC6lT0hHrT5cJ672jJVSyXQqwmJzq7XD7WcQ8ckckF770LkQy/Q/
         JsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800307; x=1725405107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9O1xAoZAOV8c4zW9/De55yG0OzoFjxVL+7Ggug8PCo=;
        b=PmYmhI8Yicit2C2O4IXqcYXXrNz49CCTS5WbMXYZDYIQM7kXyr5c/5Gz6wvmYCSJNv
         m8ZbUaBQ7h6bjx0g1Lg0yUunzGHA3Wbu0kdipnuoM8UMQdd/NomYAeaOhYj/ySJfx8Dk
         axtiAjaCqd963tktCUole6BdgnfrrvROHM0WP5du/gJUwQcHZIdMztFgFk25jbfTPxad
         TJI+3FoNyjpAgu3w12NSaPULtqPxSCcvdpxEdXVQHvVopc2BTE5X1HQh+TsPzEbeGQ9m
         vELZzTqRwnBZHg1stHlo2VK5cWun+92DjKAp4Gp0ym6HaGTAqvl6wWIa3uRa5mLcXwfc
         A2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7xqKQkrLt4YWOSNir6q5FvKHwVUreCTQlI5L5C3Q2TgUVWxotfuxkay2aKX40Rwvunw9GJrew@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDx+zPC1h4YcbaJqKkbUEzkCjHA+udOIfReMkjjni02OlKbXx
	VWIaknVvDPTToRckfh9obriE+oTvrkAN40Esi+AwYJIZBBLRXnMxcdaY6LgZeEcvJVVfMPNEZKd
	ZRwhAqq2nrA==
X-Google-Smtp-Source: AGHT+IGhyXg3/eIiJrPzV8LA1GsjfwoUYtS3Vb5uXpGkz/KSc2MBd8B85rwqll+iK9yx1Z8d0EFBFb/FbykjYg==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a25:2905:0:b0:e0b:f69b:da30 with SMTP id
 3f1490d57ef6-e1a4580f12amr2713276.9.1724800306773; Tue, 27 Aug 2024 16:11:46
 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:42 +0000
In-Reply-To: <20240827230753.2073580-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-6-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 5/5] mm: clean up mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

A clean up to make variable names more clear and to improve code
readability.

No functional change.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/memcontrol.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 33bd379c738b..2bdad7c29ac0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -987,8 +987,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 {
 	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css;
-	struct mem_cgroup *memcg = NULL;
-	struct mem_cgroup *pos = NULL;
+	struct mem_cgroup *pos;
+	struct mem_cgroup *next = NULL;
 
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -1000,10 +1000,9 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
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
@@ -1016,29 +1015,22 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 			goto out_unlock;
 
 		pos = READ_ONCE(iter->position);
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
@@ -1046,13 +1038,13 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
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
@@ -1071,7 +1063,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	if (prev && prev != root)
 		css_put(&prev->css);
 
-	return memcg;
+	return next;
 }
 
 /**
-- 
2.46.0.295.g3b9ea8a38a-goog


