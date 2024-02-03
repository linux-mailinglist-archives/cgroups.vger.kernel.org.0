Return-Path: <cgroups+bounces-1328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C00847DE1
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 01:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5401F2B969
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E6622;
	Sat,  3 Feb 2024 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeAPXW0V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EC6FAE
	for <cgroups@vger.kernel.org>; Sat,  3 Feb 2024 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920458; cv=none; b=Iw6cJDKzpq6+aR5o4sUFMdIlWSEQPt0KxC85u3J+67uxC1ftF2qshyOKkIp4gBvXD5MTzTcbHnj/Zkk3k/fsH1Dt6hOCIVuFpKXDQH3C+mpArUIgeFS6CETtp9+Z87QJ/a+xPKsKHZmr8q5502JYwbnK7J4/AiyGkaimTCWEepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920458; c=relaxed/simple;
	bh=Z/cm2m18PsL8Vu1wWGOW1aO61N6+BbgnM41QboNb6Z0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W9KrZstmAu874AULxdxbIZ3RowsibHzLDF6NSnzbWN+GJYzkVXlaH9ReaGj+6RnTnDh0Cm7Wj8t46d2Q2VBzuqL1KYNItanvKbdV2eI9yzmQZDQWdiYd4BEvU19dgy1s01SjFTzv1oEtmFpvomVM1X7E9dFNLbcyUdaTK24nPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeAPXW0V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60403a678f2so44863857b3.3
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 16:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706920456; x=1707525256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BCDzdkXKmcCm4b3zn1uKLp7BZ6kePV4TL8d+mF4c+RU=;
        b=IeAPXW0VuvfS+wjiPjpLv4EX+pkt7nF/1G9Xrk/CuA8qsO3RVnx8Ab2dxNpI+IWjX3
         9+W00wk+3rbi4v0p21xPZJcDqr14iP7/YXGdUTw+sK6UUDO9jukrZ6VPMRU6JNPfMRX3
         TJHd+TyI7LWtyxAVjKX1UIG/+bddyHwaNwurbQ2DFfUCuUrFQxMvKwkVtm7allXaGF2a
         L4B4rZc530n0Wt2TDbynOrpWJsqSNuy3JiQSc8RM0BaXQhFSUCKkzfw9rH3dcWzfOXdE
         Jz+jC8uEb6vM4fxrt41EOe4KTg+PPU2vagp4VvjX4sgS5o6KJ6f9VLX2rXC4azD8L3Do
         n0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706920456; x=1707525256;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCDzdkXKmcCm4b3zn1uKLp7BZ6kePV4TL8d+mF4c+RU=;
        b=oVJ+mt9GmD2sz0R83hOhjUMvdMDvPxo5TiKZUyl9muDzWvJ1iP69e45t6wKAgzxfoi
         qd3sfWoGtdDNGu8D2NhwkKIOCUIJA+iHdnQbl/+Bwu7uCPbaMTH60ckQ78ES6hcRQqo4
         IgVwNYdOgT+zvy8TMNJvAvXUhGIIAAV1+qk/ZflFTt69OcPzKPEQXaVQZ8fKKtax9lEq
         Df+qngneYlLYHJ1E20UseP9huMPc3nwHh9K8ZwmbDoAQOx2lkhxQqCcM7fkV0S9JflK5
         DDlK108M1K0xqozPePQqrhR8TidC77d59J6CciusgAuX6qZgdxWITuqAO6gc+M8oc9AZ
         lRZw==
X-Gm-Message-State: AOJu0Ywc35cYef72jRCQ/sppgv4ffB5s3xVpyud4uDUgGU1lrLmgRVtr
	xxU2EBkZiYjnM4JS9rE2HcNgs+6FZFlymHyGnHOMIRs0Sa3QP/U+N/CrIZVZZyoAI4eOTIbS/l6
	0N+rqOeib0UCqavIf4Q==
X-Google-Smtp-Source: AGHT+IFD+IjFOQHibdEZhu5cMU8oPxcS9RMVwqQhE2xvOJKOdLFApGCusY2fdfTuFLUq9U4BvkSau2GMSgc0xy0p
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2192:b0:dc6:fec4:1c26 with
 SMTP id dl18-20020a056902219200b00dc6fec41c26mr37502ybb.1.1706920456138; Fri,
 02 Feb 2024 16:34:16 -0800 (PST)
Date: Sat,  3 Feb 2024 00:34:13 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240203003414.1067730-1-yosryahmed@google.com>
Subject: [PATCH mm-hotfixes-unstable] mm: memcg: fix struct
 memcg_vmstats_percpu size and alignment
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit da10d7e140196 ("mm: memcg: optimize parent iteration in
memcg_rstat_updated()") added two additional pointers to the end of
struct memcg_vmstats_percpu with CACHELINE_PADDING to put them in a
separate cacheline. This caused the struct size to increase from 1200 to
1280 on my config (80 extra bytes instead of 16).

Upon revisiting, the relevant struct members do not need to be on a
separate cacheline, they just need to fit in a single one. This is a
percpu struct, so there shouldn't be any contention on that cacheline
anyway. Move the members to the beginning of the struct and cachealign
the first member. Add a comment about the members that need to fit
together in a cacheline.

The struct size is now 1216 on my config with this change.

Fixes: da10d7e140196 ("mm: memcg: optimize parent iteration in memcg_rstat_updated()")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d9ca0fdbe4ab0..09f09f37e397e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -621,6 +621,15 @@ static inline int memcg_events_index(enum vm_event_item idx)
 }
 
 struct memcg_vmstats_percpu {
+	/* Stats updates since the last flush */
+	unsigned int			stats_updates ____cacheline_aligned;
+
+	/* Cached pointers for fast iteration in memcg_rstat_updated() */
+	struct memcg_vmstats_percpu	*parent;
+	struct memcg_vmstats		*vmstats;
+
+	/* The above should fit a single cacheline for memcg_rstat_updated() */
+
 	/* Local (CPU and cgroup) page state & events */
 	long			state[MEMCG_NR_STAT];
 	unsigned long		events[NR_MEMCG_EVENTS];
@@ -632,16 +641,6 @@ struct memcg_vmstats_percpu {
 	/* Cgroup1: threshold notifications & softlimit tree updates */
 	unsigned long		nr_page_events;
 	unsigned long		targets[MEM_CGROUP_NTARGETS];
-
-	/* Fit members below in a single cacheline for memcg_rstat_updated() */
-	CACHELINE_PADDING(_pad1_);
-
-	/* Stats updates since the last flush */
-	unsigned int		stats_updates;
-
-	/* Cached pointers for fast iteration in memcg_rstat_updated() */
-	struct memcg_vmstats_percpu	*parent;
-	struct memcg_vmstats		*vmstats;
 };
 
 struct memcg_vmstats {
-- 
2.43.0.594.gd9cf4e227d-goog


