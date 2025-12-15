Return-Path: <cgroups+bounces-12353-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF68CBCABE
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 07:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A96A83002939
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DE25BF15;
	Mon, 15 Dec 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bioo+fam"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406DC72628
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781213; cv=none; b=YxoypzwG0uPbTP04whNwe42slEZfytIq/+ZjeCS/IQPuH+UrPWu58lEMnxF9YzpXhCfzTtqw+CbKVeJCHBBk/MrKUdM7j75JRX4frNePNr1kCpSuUnXVZ/UnRjDzZhowE001TsyvA99FcaTFJALSacm6aBtBgZxyMa/cKCk1vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781213; c=relaxed/simple;
	bh=mtp+CnZF0v/lRyKKA6BvpdCUa60zGbf2/zQ5UuxYVGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m4X4kI95TKfEzEQmUWx8xtUcViItYyPgTi+x+aCDkmvKgDhFkFwejxGyZrhNhcf7amziiXCaMNfj0Za2NqYY1JaFi2hK8qcL7XQzHKHUiQUv9lv714RYftKSE+M+DK2Fe6ufaan8gYvLUmr1xTEyOfU3bWeZCPHScxG1mPW1u5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bioo+fam; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so788510a91.3
        for <cgroups@vger.kernel.org>; Sun, 14 Dec 2025 22:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765781211; x=1766386011; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdoHM3mJ1jSMiyUaXuH436UztU0Bj9UASxNBl93ugYk=;
        b=bioo+fammc1/hNu5JotemOH+tfWMDH3Vt4QRHT2ugP982vdYV6pGTHy2biEYBcc7ei
         P3lXbp8jVBSlq/oPZD+ji2z7IkpisU+j84u3QsoUcKsh/mKpjyXRFUI+POIV2NeQk0dz
         H+v8j3ques8P3ZaJChissJBp/ltF+FARl4AvkrEDpwGXVY5OW42I/vgUu6ScQacmiSpg
         Gr1qVBhOIyO+WQBxTGNBEugiJTw3NgXlmz6uRbR/f4gcFb9V8YJrW6+nB7kbttBD1V3S
         l3DyYQwJtsgzTdB1FeZwgD+zi9aCw0x9Pw3If/4S6ABEI1Kc6fAn03GOeQZi5nMzmY9l
         QQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765781211; x=1766386011;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdoHM3mJ1jSMiyUaXuH436UztU0Bj9UASxNBl93ugYk=;
        b=NAdCb1Vo98APYJEBxdnpCU/5sdwxCGyYhBvupuGXjkybFQBoMa7ysfKr9cEF8W2+lr
         xD5oEkB4BF213BCmebu/9H+dj3KgaeO1ewQV2j4YyUHHzbX8erFbPhgIy9v7AH6XPymb
         bU5VqmXF4W3lEpqNkxWHFBLbmPYygk1fJo4dwmep/nC1rZwAbdJ8iJzqGX9A5mk972pn
         RKdFv0bCVAsHRVo/lF62aC86W+A71gqiF0XfQeH6gSsVocGI/3pk+uFlgnvlr30MycO2
         vXHQFg1wj5W5jqtmrsuu3od500VLfU5PylD4b8Ko+xO+TQc55E6WrXyxYMoIszOObH0o
         ezwg==
X-Forwarded-Encrypted: i=1; AJvYcCX36hXjKfaX4MueZv/D1/AQL2gzJJux84jJ0I/wb9IwFf4rB996K28Z6uOvSrqBY2olloeVqynY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hzaN+ym/+8u2EYDVAYiywpeuGaqVlQkWouumelgMUzzuOA/i
	gxb8nMgl6PFt5RY46IVyl8XcRL9i5TWJQrGQK7ho0dCTRjrJlALAI3Uj6wjzk9WTgH4=
X-Gm-Gg: AY/fxX5TkN97l8uJrCkaSjRwOjHB7Ct3jQLyZCn4z2hxUFrwCWQt3RX87JtLhJ8AxEW
	7mSMrnVLhUhA5rc4yqeIUMSgHAcOdVfv1xQ4DRLrw5RLLpE9F2RP2AAKxs2NM2tZvjADxNyxbWy
	XrTgq3GWqqI6fyUEaaMbT3KH24Or6iW8LcmnNWqaXZzFWzqM8+GAwKpqNHHYSqK6emt1jWIhWiR
	pFMeSPIafrRyjfIJusIM8t1mx+NU/MWi8jWrMWYbQjMzZJpLNQA2aRuAW4ATmUi2Brxa4MXVELg
	FjpMLFjgavAT8oRSl7uZ+SLMDbAwXVEhWvHL0ksMPMmRx2lfAgrddv9sdwXkeUbWD/q1VRIzwlY
	R9j/JUMsGmDvI+KCbwHaJ9dOf7WM9SL4QiRrH2x5OAzQ1gtFXECzOrKyYESnj31+TD+vs3Kq2Y0
	dHAcokkoAswfJ+c3CrapOTRyMA2vVms42+U6BRn78H8x0lmxZj4XtcMI46Hw==
X-Google-Smtp-Source: AGHT+IEWi9rpszfpsJIcG2AJbfKEy0KXwGK5j/XRhgO6Nbp+mDcp1SVnXoHwY8h/edXRSMxd9U9F6w==
X-Received: by 2002:a17:90b:3f0e:b0:340:be44:dd11 with SMTP id 98e67ed59e1d1-34abd77b410mr8852050a91.27.1765781211469;
        Sun, 14 Dec 2025 22:46:51 -0800 (PST)
Received: from [127.0.0.1] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3a2623sm7958018a91.2.2025.12.14.22.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 22:46:50 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 15 Dec 2025 14:45:43 +0800
Subject: [PATCH RFC] mm/memcontrol: make lru_zone_size atomic and simplify
 sanity check
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-mz-lru-size-cleanup-v1-1-95deb4d5e90f@tencent.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQpAQBCA4VfRnE2ZLZGr8gCuctDsYIql3Ujk3
 W2O3+H/HwjiVQJUyQNeTg26uQhKE+B5cJOg2mgwmcnJEOF64+IPDHoL8iKDO3bkkqwwjza3BcR
 y9zLq9V87aJsa+vf9AD31WalqAAAA
X-Change-ID: 20251211-mz-lru-size-cleanup-c81deccfd5d7
To: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
 Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765781208; l=3839;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=5Z8c+a+3jENgLhaYOexfVai00HxxbKrt0eKrdFBvjVY=;
 b=hybdzQeGCdI8OPofHO1fIoNFOLIcMOPPjiP4OyRefxmYv7dtly8Ya5ok83UtN0DMuYhqmm5eD
 9BG1NGYsq7BAePb9TvwgkZAICg5q8vYAqJ7baR+K1tc/4wQ03QkPbVL
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=

From: Kairui Song <kasong@tencent.com>

commit ca707239e8a7 ("mm: update_lru_size warn and reset bad lru_size")
introduced a sanity check to catch memcg counter underflow, which is
more like a workaround for another bug: lru_zone_size is unsigned, so
underflow will wrap it around and return an enormously large number,
then the memcg shrinker will loop almost forever as the calculated
number of folios to shrink is huge. That commit also checks if a zero
value matches the empty LRU list, so we have to hold the LRU lock, and
do the counter adding differently depending on whether the nr_pages is
negative.

But later commit b4536f0c829c ("mm, memcg: fix the active list aging for
lowmem requests when memcg is enabled") already removed the LRU
emptiness check, doing the adding differently is meaningless now. And if
we just turn it into an atomic long, underflow isn't a big issue either,
and can be checked at the reader side. The reader size is much less
frequently called than the updater.

So let's turn the counter into an atomic long and check at the
reader side instead, which has a smaller overhead. Use atomic to avoid
potential locking issue. The underflow correction is removed, which
should be fine as if there is a mass leaking of the LRU size counter,
something else may also have gone very wrong, and one should fix that
leaking site instead.

For now still keep the LRU lock context, in thoery that can be removed
too since the update is atomic, if we can tolerate a temporary
inaccurate reading, but currently there is no benefit doing so yet.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h |  9 +++++++--
 mm/memcontrol.c            | 18 +-----------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0651865a4564..197f48faa8ba 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -112,7 +112,7 @@ struct mem_cgroup_per_node {
 	/* Fields which get updated often at the end. */
 	struct lruvec		lruvec;
 	CACHELINE_PADDING(_pad2_);
-	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
+	atomic_long_t		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
 
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
@@ -903,10 +903,15 @@ static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
 {
+	long val;
 	struct mem_cgroup_per_node *mz;
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
+	val = atomic_long_read(&mz->lru_zone_size[zone_idx][lru]);
+	if (WARN_ON_ONCE(val < 0))
+		return 0;
+
+	return val;
 }
 
 void __mem_cgroup_handle_over_high(gfp_t gfp_mask);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9b07db2cb232..d5da09fbe43e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1273,28 +1273,12 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 				int zid, int nr_pages)
 {
 	struct mem_cgroup_per_node *mz;
-	unsigned long *lru_size;
-	long size;
 
 	if (mem_cgroup_disabled())
 		return;
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	lru_size = &mz->lru_zone_size[zid][lru];
-
-	if (nr_pages < 0)
-		*lru_size += nr_pages;
-
-	size = *lru_size;
-	if (WARN_ONCE(size < 0,
-		"%s(%p, %d, %d): lru_size %ld\n",
-		__func__, lruvec, lru, nr_pages, size)) {
-		VM_BUG_ON(1);
-		*lru_size = 0;
-	}
-
-	if (nr_pages > 0)
-		*lru_size += nr_pages;
+	atomic_long_add(nr_pages, &mz->lru_zone_size[zid][lru]);
 }
 
 /**

---
base-commit: 1ef4e3be45a85a103a667cc39fd68c3826e6acb9
change-id: 20251211-mz-lru-size-cleanup-c81deccfd5d7

Best regards,
-- 
Kairui Song <kasong@tencent.com>


