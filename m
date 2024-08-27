Return-Path: <cgroups+bounces-4522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E4961A44
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B6A1C22D1C
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC571D4606;
	Tue, 27 Aug 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4UZR4KbA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AF1D47B9
	for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800306; cv=none; b=KzTlEx2cV+AMMXffgJoXyx0yyboWc7Whuudks5P79V3XmF4BId/9fI73k+ByDF0dWHfxr7hd/WPK6781H1kVUvp8Ppg36d/f0maAocol9tmfJOG3H1hxWDm6JYNJn4U5B6WWO1GqcY16BMpU7tg+SlzJK5FUH/UU4XyB/1ExpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800306; c=relaxed/simple;
	bh=4ct1zm7TMhbJ+tGP04NvmerXkcuz0zpwYeQV6rpFg28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VokceN78afCpKo/bB7+KPEal546zlGxLapKd62K1YmeEtKvdiLIJH4E4nYLVW0LP1TdVJ2P7H6njY30gwbnmHtueu7lRSvQrDWk6jX15Xy1sTXiSYJGX0SXR0aslgD/BSAi0izV/oXuD8TXXATtyg9I3gkWZgZEdXSe4B+Sxq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4UZR4KbA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7cd9ac1fa89so5657980a12.1
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800303; x=1725405103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVbBxbMJe3JYZfDSh84GXFqWqtxHIvJybjs9yUa4Qwg=;
        b=4UZR4KbAHs+z+JcG2rwMs3CfCdSIh37MeIRzGQVsRF0+6fk7yrepI60bySIXtX4BaN
         /uT8kde3nsj+YiIlK48Ddc5YqvOKbkk6vtBrQYu42W6B+wMsunmqPwj3ZO4Dl+1o2Mp7
         Vh8maNzwFiMm367YvaAA6baB0KglGOzY+lBTG4sGXt/9hADcMjD5tc80coh0XP5aKiHt
         AuKeQhlxcHuUBY1eoCFLgMzWZaH6DXfJHypT5lv+2kmQDZLmw+HWC/aVmTOk4tc/LT4V
         A9ygTMj590/9sLsZLKVCKcF9mExQtyddZL8px0jJYy29jCMbSG3ptXJx3H47sUbqRhno
         AOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800303; x=1725405103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVbBxbMJe3JYZfDSh84GXFqWqtxHIvJybjs9yUa4Qwg=;
        b=hNgt7iw9MNs3BdNWPIU+igOQNq6S+Pu4c9vzlHvsDtHp2YRX+jprWRJA8bSUPNlVn0
         LKxeIl7pghzuTU5cyLtUSjkp8kaGCu7FWNKqZ82M4PJTW+RHtSGEutU5Xkdcxwslr1nb
         OPqSxWwius5TN7y/WNXgdupNFA6zZCt5WWRa62Qrys4YkelIXYNfyYnU27hKhLanNwtj
         ptj9RpJaXoEDf3EYj/1/bfHnghXIKcVZUEMu9xXRqKXVkil5ObimHt1iTKNcEUIRcd/V
         ipj2phw6P+IJDD+fWcgCYVgqHPTRWVWGNz6VOIe5HqB5OSEO2knlp2fu/nwDmgLkm1i/
         HqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgTP/3I3bEYPj2Id5Qz8laMfMROiV4Zsfg1NkE0SqhWcN2ZULS6ypVQKB4RTXTRnZ6c0wC7+EL@vger.kernel.org
X-Gm-Message-State: AOJu0YwB91ZiltA2molVL2Sle7TTN0n80AJ0a+72KeAhPdO4UoA7pp3A
	dWCxSAlBu9opNclPw8s0UcbUldOfvYM1q33t9zfz1ssTja52ng0TmKUeLsBsV8RrFCUKUQd66m7
	2g+R9tBvohw==
X-Google-Smtp-Source: AGHT+IFdVh/6ZDHdjnuvg4eof/eCc2TmxxMkSBRAT5EDf73D7CKtBh/Kuj5HdytE0rc9XtN+OFRBe12aA8e0gw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a63:d70c:0:b0:7cb:c8c3:3811 with SMTP id
 41be03b00d2f7-7d2228e5badmr309a12.5.1724800302880; Tue, 27 Aug 2024 16:11:42
 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:40 +0000
In-Reply-To: <20240827230753.2073580-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-4-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 3/5] mm: increment gen # before restarting traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

The generation number in struct mem_cgroup_reclaim_iter should be
incremented on every round-trip. Currently, it is possible for a
concurrent reclaimer to jump in at the end of the hierarchy, causing a
traversal restart (resetting the iteration position) without
incrementing the generation number.

By resetting the position without incrementing the generation, it's
possible for another ongoing mem_cgroup_iter() thread to walk the tree
twice.

Move the traversal restart such that the generation number is
incremented before the restart.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/memcontrol.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 67b1994377b7..51b194a4c375 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -997,7 +997,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		root = root_mem_cgroup;
 
 	rcu_read_lock();
-
+restart:
 	if (reclaim) {
 		struct mem_cgroup_per_node *mz;
 
@@ -1024,14 +1024,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	for (;;) {
 		css = css_next_descendant_pre(css, &root->css);
 		if (!css) {
-			/*
-			 * Reclaimers share the hierarchy walk, and a
-			 * new one might jump in right at the end of
-			 * the hierarchy - make sure they see at least
-			 * one group and restart from the beginning.
-			 */
-			if (!prev)
-				continue;
 			break;
 		}
 
@@ -1054,8 +1046,18 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
 
-		if (!memcg)
+		if (!memcg) {
 			iter->generation++;
+
+			/*
+			 * Reclaimers share the hierarchy walk, and a
+			 * new one might jump in right at the end of
+			 * the hierarchy - make sure they see at least
+			 * one group and restart from the beginning.
+			 */
+			if (!prev)
+				goto restart;
+		}
 	}
 
 out_unlock:
-- 
2.46.0.295.g3b9ea8a38a-goog


