Return-Path: <cgroups+bounces-4238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1C950E1A
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E391284EDC
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D61A7065;
	Tue, 13 Aug 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsOcKd0s"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF41A3BAE
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582076; cv=none; b=kMbWAS48pv7giwXaA3DpKH4P72ytHagW0UDtLdBrMgNnjVOvAm02u3CnWLAvI1fXKP8bEDVA1lIo8sQo/USTZJFYUqR6NO/g2YJuNPU4i+x9qYOAshmC0t60JusJRBXK+EK6KY2/Lc8cQARJmsKlub7ZVmJcUGsA1or3Abaaxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582076; c=relaxed/simple;
	bh=aQJok3gSjvHmXRiPrNrzugTOpERQ4gz+fm2rPvjru2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVcVREzN6CL6/3G+lL/CKpxYmmVOvVD44i1SHwCa5Yjx+8DGke6iyFzbWZEw9CgWnVcUChU34DkMuybSswqCp+kz/kWXbEh1IPzfqavtCvaAN5KbKMsYm+8g1x/0tsEgCelaHq+fPnoaztQAJ6e1jA+rIF2IadxgPFRwguCPofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsOcKd0s; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a28217cfecso5360555a12.2
        for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582075; x=1724186875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYWJhwEE6NYCkgyDLBhCsOHKcazNm9LYuzYyiRCtiIM=;
        b=vsOcKd0sLbpv/ij/D4qpGkGeeJcPivdojRl/gizzBRZCMS5pJVL4G9XfiVuX6ThhFX
         PyjGOtPs+9LsYUIsjw2yCwnVg4MzWzjL0+sBmPlGkLgGdDBsB8iapH/7Q4Zpl+2BEJ0m
         6tTJR6EA+1YuS7zP6HakykyqKAxOi9P3sMQqtp46A10WrWCU9lGITSR/oS23oXWbxVEx
         5TBSJiz7MmXXRW6ZJXVoKZGWIONA3rOGQtGTyPnf9uDEYxcJVCDqW27YSlKLRoY7MfQ7
         9n+Y1Qr//iZiQpvjsS1V9DR65nscfmw7tNbyDJfY8d7R9Ytq1cHKog3E3m5mhHFPrQbL
         nN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582075; x=1724186875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYWJhwEE6NYCkgyDLBhCsOHKcazNm9LYuzYyiRCtiIM=;
        b=Zaj93dRK0IzkQndMj1jypZ4AZ780R4SbC9foFTyx0xRvBb+Yb+6oJiHuwwMdP4tFR0
         Mwo2C8VWzoNnQjvAhvFJZcUdf7mbyOHW148hzdADj+IYNh6Qj3Hx0jD6BN7soxobgn6J
         zBB6parHhpES01ShyRCBJZDPhG1Yee/N7i8XONJgG+pD46Lzr8uFNi1G4BgfPK21bTw8
         3ejc2c/EKx+b9E0dgzEF8ORWhAuKUNHaZmcpQZWuBBiuz9NfA7Xv2Pr5UcEaqUPhPpLU
         8Fsw31OLpjrpaj1wMPDioHjt2RaOpTVGnK4yI6/zbF2S3fRUzU66p12TwzZBz1mJOfwT
         8Dng==
X-Forwarded-Encrypted: i=1; AJvYcCWa1wsKhtIr+R38Emwq0rMREey3LgjNE9ubQloXRHrFB3+q+JqmjnPC4SV7buk9zVNiGT/vX2nFU6TSss5+4awptMl8v8y7nQ==
X-Gm-Message-State: AOJu0YyRckY8HHofdxHo9Izt86En7hmBlPKe/AqTTJpa8/SzNtCSPxVC
	SU4u+3/jXoBl4x9yTS2mAYSIZkuTQ43XIH0r4wA3DYk4ZLjm4pE024s9OvjQDK+FV5qp2l6GsUK
	EDwmauTyQTw==
X-Google-Smtp-Source: AGHT+IHxMBB1WIpSpQKruSLzaZb5mFQ79yQ49km4F0bFBxJKf7BgUc4XswgMUAKJQxmwnNey7FUrSuzdOv6Aag==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a63:114a:0:b0:694:4311:6eb4 with SMTP id
 41be03b00d2f7-7c6a587fd3fmr1059a12.8.1723582074503; Tue, 13 Aug 2024 13:47:54
 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:47:11 +0000
In-Reply-To: <20240813204716.842811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813204716.842811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813204716.842811-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v2 1/5] cgroup: clarify css sibling linkage is
 protected by cgroup_mutex or RCU
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly document that css sibling/descendant linkage is protected by
cgroup_mutex or RCU. Also, document in css_next_descendant_pre() and
similar functions that is isn't necessary to hold a ref on @pos.

The following changes in this patchset rely on this clarification
for simplification in memcg iteration code.

Suggested-By: Yosry Ahmed <yosryahmed@google.com>
Signed-Off-By: Kinsey Ho <kinseyho@google.com>

---
 include/linux/cgroup-defs.h |  6 +++++-
 kernel/cgroup/cgroup.c      | 16 +++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7fc2d0195f56..6862243bd1c2 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -172,7 +172,11 @@ struct cgroup_subsys_state {
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
 
-	/* siblings list anchored at the parent's ->children */
+	/*
+	 * siblings list anchored at the parent's ->children
+	 *
+	 * linkage is protected by cgroup_mutex or RCU
+	 */
 	struct list_head sibling;
 	struct list_head children;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0a97cb2ef124..ece2316e2bca 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4602,8 +4602,9 @@ struct cgroup_subsys_state *css_next_child(struct cgroup_subsys_state *pos,
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critical
- * section.  This function will return the correct next descendant as long
- * as both @pos and @root are accessible and @pos is a descendant of @root.
+ * section. Additionally, it isn't necessary to hold onto a reference to @pos.
+ * This function will return the correct next descendant as long as both @pos
+ * and @root are accessible and @pos is a descendant of @root.
  *
  * If a subsystem synchronizes ->css_online() and the start of iteration, a
  * css which finished ->css_online() is guaranteed to be visible in the
@@ -4651,8 +4652,9 @@ EXPORT_SYMBOL_GPL(css_next_descendant_pre);
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critical
- * section.  This function will return the correct rightmost descendant as
- * long as @pos is accessible.
+ * section. Additionally, it isn't necessary to hold onto a reference to @pos.
+ * This function will return the correct rightmost descendant as long as @pos
+ * is accessible.
  */
 struct cgroup_subsys_state *
 css_rightmost_descendant(struct cgroup_subsys_state *pos)
@@ -4696,9 +4698,9 @@ css_leftmost_descendant(struct cgroup_subsys_state *pos)
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critical
- * section.  This function will return the correct next descendant as long
- * as both @pos and @cgroup are accessible and @pos is a descendant of
- * @cgroup.
+ * section. Additionally, it isn't necessary to hold onto a reference to @pos.
+ * This function will return the correct next descendant as long as both @pos
+ * and @cgroup are accessible and @pos is a descendant of @cgroup.
  *
  * If a subsystem synchronizes ->css_online() and the start of iteration, a
  * css which finished ->css_online() is guaranteed to be visible in the
-- 
2.46.0.76.ge559c4bf1a-goog


