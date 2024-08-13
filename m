Return-Path: <cgroups+bounces-4239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7845950E1C
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 22:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F42B24586
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003C1A76B4;
	Tue, 13 Aug 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TosVy3aD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B751A3BAE
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582078; cv=none; b=cZub24dStwRhAm//qO22heupnYZ+7GBNbO1JbYa9c2+1rXA5aICLIkhQ/wxjOzMxe39HO9sfwjMQVuTT8qIBGITTO5aRD8YedcCEIcGTp0tUp4IEPbGjEb0LRRUfeJ9r5LLhgoqJ7OBGb5eVzgEh2UIGLlM9XwwHxirNGFQm5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582078; c=relaxed/simple;
	bh=KPTZtUl0BijCL5/vrgLCA/Byfa3nBjCHG6N9mdvcBjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bhYRwMjXk/d12v4Oo540Y8NNDZ4xugiVDB94cMXg215237bgm9dEhjzuGHfIG0wojB5mCPd+cdly9M/XYBJ0nMm4CtljVpxurtPoE1iRGzgXSE0+OzxqRa1EjwSd1rIm1zbeq36gyjLxBTRxuXCpQaKJPr9w0WofKFByXhLhGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TosVy3aD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be7c74d79so8776301276.0
        for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582076; x=1724186876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmvEk3aWaELcFNHaifCCcbwnogY+IyR2g5JVb5or6kw=;
        b=TosVy3aDbg3ag/3xrFjPACUDxbfsynvJqjyHB1MSN1nTpA7bXECTlrAwFkdmBkAGUz
         Xql1idM8Vrtxwwd5O+ZP5QxCyhYZ2pDfjSX1YuYyQjO96lS8LetxGZ/xBPt8cPXUa/qB
         pjS40boryFdK5D5uq9spvw0fUIXWzpg7rBKbI9k83236C7KRBThnNg4M6QrUocdnzCSQ
         Lfpdovh5GA8ifXDNs3WE/A/iRnUu75rLD71ssoC/MqgcgDNaqHIGXlWdlVAVR9/FZ3Cv
         VQggOBRZUfZ57rmsFrH0uu+tC/ucAhZsFFDF4ETmXf+lyAJ3b+qbfw+zVBoc/7hh4H0R
         WQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582076; x=1724186876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmvEk3aWaELcFNHaifCCcbwnogY+IyR2g5JVb5or6kw=;
        b=pbZAGfF6z+Tyt0nNRB4lYPNv4VWsjrjV3U1pzDFBM6lKid43E+6zwLBz8RSNxWYzh5
         tRLj4MlIctuAUHBHfRSiVRHrbXtrm4YdPLumVtXsGy+ezWUXkuS+Ok9IMN1Xy87IZvwj
         CcCV4xi1vEXWQqDHcIpRV/XeDxHhOAux2/00OYm9y26O7m5Q2rW4Qywx7IkBiKcqhYB2
         stBFFKfreTBTyPgFOqNhJeEBOJCieyE7eZOOJaggOfHdJM/Ciww4kfP4g3uHR9rzqYUg
         VL7nhuWRBZuS4CdTnamUtNRu5hSe8cBMf2eN2YdiXNXtSWtuH8JGvlbLTmZmSLwcuCA2
         oDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp7kLVgM6vGAHJbbxdY7VtjB7r2XFL0O2pMMIlrKAIXOCIrsK6EKx7wVkTRvSGjuqQOEg+GOaXbrZU6W3IIxZ5H/FE3BwTwQ==
X-Gm-Message-State: AOJu0YzYiyr1rB+GyEQGj+u0K17sUGZz65chbL43hR2XOp21gfPq93Vb
	yg7gN3njF9z2vtwgD/eCVXlr8pUhQZSSWuDuL5Obfas9TWgXG60MggE/NalYk6kgiR8T5sETbZu
	ixUPRvcStmw==
X-Google-Smtp-Source: AGHT+IHiDHCjFRbPR5+mkcQhIrf9lDLp4M5EcHeImCSP6xD1TY/GSvpgSst1fxEwRAEkFihKnMepRjSKepm4bA==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a25:c788:0:b0:e03:62dc:63de with SMTP id
 3f1490d57ef6-e1155ada202mr39205276.6.1723582076373; Tue, 13 Aug 2024 13:47:56
 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:47:12 +0000
In-Reply-To: <20240813204716.842811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813204716.842811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813204716.842811-3-kinseyho@google.com>
Subject: [PATCH mm-unstable v2 2/5] mm: don't hold css->refcnt during traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

To obtain the pointer to the next memcg position, mem_cgroup_iter()
currently holds css->refcnt during memcg traversal only to put
css->refcnt at the end of the routine. This isn't necessary as an
rcu_read_lock is already held throughout the function. The use of
the RCU read lock with css_next_descendant_pre() guarantees that
sibling linkage is safe without holding a ref on the passed-in @css.

Remove css->refcnt usage during traversal by leveraging RCU.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/memcontrol.h |  2 +-
 mm/memcontrol.c            | 18 +-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 90ecd2dbca06..1aaed2f1f6ae 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -75,7 +75,7 @@ struct lruvec_stats_percpu;
 struct lruvec_stats;
 
 struct mem_cgroup_reclaim_iter {
-	struct mem_cgroup *position;
+	struct mem_cgroup __rcu *position;
 	/* scan generation, increased every round-trip */
 	unsigned int generation;
 };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dacf4fec4541..1688aae3b1b4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1052,20 +1052,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		else if (reclaim->generation != iter->generation)
 			goto out_unlock;
 
-		while (1) {
-			pos = READ_ONCE(iter->position);
-			if (!pos || css_tryget(&pos->css))
-				break;
-			/*
-			 * css reference reached zero, so iter->position will
-			 * be cleared by ->css_released. However, we should not
-			 * rely on this happening soon, because ->css_released
-			 * is called from a work queue, and by busy-waiting we
-			 * might block it. So we clear iter->position right
-			 * away.
-			 */
-			(void)cmpxchg(&iter->position, pos, NULL);
-		}
+		pos = rcu_dereference(iter->position);
 	} else if (prev) {
 		pos = prev;
 	}
@@ -1106,9 +1093,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
 
-		if (pos)
-			css_put(&pos->css);
-
 		if (!memcg)
 			iter->generation++;
 	}
-- 
2.46.0.76.ge559c4bf1a-goog


