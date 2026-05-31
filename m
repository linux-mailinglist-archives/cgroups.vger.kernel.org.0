Return-Path: <cgroups+bounces-16487-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPYGH+wEHGohIgkAu9opvQ
	(envelope-from <cgroups+bounces-16487-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 11:52:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30676157C0
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20BED301874E
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 09:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617E2D3A7C;
	Sun, 31 May 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntJX0h0n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27072617
	for <cgroups@vger.kernel.org>; Sun, 31 May 2026 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780221158; cv=none; b=OxfhtJW/R72gJYA71Sb70n2T4lXEBtYW7ven5GcXrDSDQcGwwUTxSJcCrj/G8NR/I8U+bl0ZVr194XtxTtlBnlJqas+VYZisYBj89LZjv94sRW+gT8by6VbTW4TJ6zGo9x72Ev5dj/x1c+3gnYlaZVMEEjNy/Q7OYHy1HH/1qTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780221158; c=relaxed/simple;
	bh=UlgJMDEs1zaiMCiy7kxASsVB0umGJBmWO4EJt6eZyZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tLJTrne1wJxgkrOAtxN0lPxbiZFtySVVqv2vJsHvebxllubu43hZal/iM+7AK+/K9FiDu5QBoPQMDCpMEje6TPJg0Nb1EhFkjFNIziiXkFDWbbvFaCjnVavZgxQjY6byCOhRo6gp4Q2JPL53Dcv9Zyh9XqsFDm4uU2ssZQ/hzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntJX0h0n; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1378943cd4aso6236230c88.0
        for <cgroups@vger.kernel.org>; Sun, 31 May 2026 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780221155; x=1780825955; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ0etL94ocsCfPAx1v7CdirkPq3WBkk+TD53poHwYjw=;
        b=ntJX0h0nQ0ONok/laLyW3MxasiI1J9bEmVrbP72fG9/i9D0rKJ/MinOlovIp/JZW2P
         QBY1p35i+GidE+M3zkhndIZKOMHtPXiyO5IhGSIEtYLJQ2sASrL1QBrQZjO4GDjxakOU
         03jFaI9edJPZeLAzxVx3X22SJyR6Q3wMGvneTEWODePXlJYEQcYkh59eSYoJbNDwGNgO
         bYOyYnHxsNS+fDgQPeBw2m1XJPHF2NuY+9HZnzE4JpAn4yqUVwIL0b+p9nGFibqy8AVa
         GfdH0Jj5vYXDy5X6ONDULmW17Q4fL8CYGPz1B0ioan3OdKUh44q06jw+XF7CTjr5nukF
         vP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780221155; x=1780825955;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ0etL94ocsCfPAx1v7CdirkPq3WBkk+TD53poHwYjw=;
        b=g8MojAzNZRUHobCXsAmv7M2mcBv2NITbDE2/2C+bXTI2M1b37gYeC8piDD+4/ud1Kk
         k0sw5+Mq0M3816BeqkW1wX96s4Dlyya2EQpdEwti67KZ6GrqdM0TvVJ/2oB9oCsr/5Gn
         4VBIfshtx7JuuOnOF3WOA5/ividKI78NG81HLLHPBchXNxI1lcuxA0/uOPLn/rRBf5TI
         eab9Hs4413s+Q7F5aONUg380/s1lgs2Yf5144LJn7y4iVJHEpAqQis1Bc6K5XqwCNFuf
         S3dykOpzirXfgAY8H35J8S0VH7sfonTNZ164pzDW9GG3BOa54FUGVqZZrm8qGjn0qrUF
         xDzg==
X-Forwarded-Encrypted: i=1; AFNElJ/7gf3idSUprZ0UbRLGYojZmBRBLfkln7af5o/u3g4/QLxLEkQNOzqFBxYrUTaupbLsybSIWerL@vger.kernel.org
X-Gm-Message-State: AOJu0YwIB1riCqClgrzPaVZ0s53gLZBOOup4RZmMGbo8WZOUEC7YItpB
	WQL6vgj+FXokAR+iIfuYMBqLusQpCy0Ln4Cuoq3CmNLmO/7Nc9hK8dIIPAoSjkQ0
X-Gm-Gg: Acq92OFjqn8Qi8asH8P8C7JYliM6TpFqIX3oNY01YseMnEvTGkq3Nb5fHCEB4bvR0EA
	WuRkGv49Y3FNE5BXhDH31M82YUqYw9O6DBw2oXk5VmdT0gBBiT2oJb3e1lUg0yxkoi5zhmhyLMS
	RXiJ/d+i9d1MbuMO3U0M0y46G6FMftMlRmJFgMjw++1hs1ZhJ4vmpo8N0IMXP8gSY7x+wGU/tsL
	cZ22DNvmmMgoXDtnTmVFRwdEH/A8lgv49gUj3DNqrOS+9R9kdJvibdNkmzv11EDFrjf3/C5YwO9
	ght4FZ96q3HGyiXMCgB/4hEkEHgpXay9+A7cvSy9nIkBaNKnV8PuP72KexI1yOYFFQ1bSiLQHOf
	J12LZi/7Xai4oT2hj8/kINBM7tjal+v+OiLY7+3/B4RWqh+VU18+QfSzMVIlT0WLErxWIzZ1n04
	DA6zNtxWih1FirQelTVeh50aq9fM4UZT6Z87u20npj
X-Received: by 2002:a05:7022:7a0:b0:136:c565:e862 with SMTP id a92af1059eb24-137d42626f0mr3001062c88.26.1780221155375;
        Sun, 31 May 2026 02:52:35 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a6019sm4199611c88.2.2026.05.31.02.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 02:52:33 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Sun, 31 May 2026 17:52:23 +0800
Subject: [PATCH v6] cgroup/dmem: implement dmem.high soft limit via
 prioritized eviction
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-feature-dmem-high-v6-1-20563ecd6dc7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvIfky7SrSInHQWWmhFEN09a
 fkt3nsgUWRKMBQPRLo48RYyZFnA4uZgCdlkQ13VsuqExpXm44yExpNHx9ahkFr3olVmaRTkbo+
 08v0/x+l9P2CfKadjAAAA
X-Change-ID: 20260519-feature-dmem-high-16997148dc38
To: Christian Koenig <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Natalie Vock <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16487-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,cmpxchg.org,suse.com,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D30676157C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dmem cgroup v2 controller currently only provides a hard "max"
limit, which causes immediate allocation failures when a cgroup's
device memory usage reaches its quota.  GPU-bound AI workloads need
smoother over-subscription support: a soft limit that temporarily
allows excess usage while applying backpressure through reclaim
rather than outright failure.

Add dmem.high, a soft limit that penalizes over-limit cgroups by
evicting their buffer objects first when eviction is triggered (e.g.
due to a "max" limit hit).  Unlike the rejected v1 approach which
used sleep-on-allocation throttling, this version provides a
meaningful recovery action through prioritized reclaim.

Expose "high" as a new cgroupfs control file per region via
set_resource_high() and get_resource_high(), and initialize it to
PAGE_COUNTER_MAX in reset_all_resource_limits().  Like get_resource_max(),
get_resource_high() returns PAGE_COUNTER_MAX when the pool is NULL.

Extend dmem_cgroup_state_evict_valuable() with a "try_high"
parameter.  When set, the function walks the page_counter parent
chain to check whether any ancestor exceeds its high limit, and
verifies that the pool is above its effective minimum to respect
dmem.min protection.  For the limit-hitting cgroup's own BOs, the
ancestry check is skipped but the high threshold still applies.
When CONFIG_CGROUP_DMEM is disabled, the stub returns false in
try_high mode so the first pass has no effect.

Refactor ttm_bo_evict_alloc() into a 3-pass eviction strategy.
Pass 1 targets only BOs whose cgroup exceeds dmem.high, using a
blocking lock when a ticket is available or trylock otherwise.
Pass 2 falls back to the standard above-elow trylock eviction.
Pass 3+ uses proper locking and repeats while making progress
with the existing low-watermark fallback.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
Introduce a "high" soft limit for the dmem cgroup v2 controller.
When a "max" limit is hit and eviction is triggered, buffer objects
belonging to cgroups that exceed their dmem.high limit are targeted
first, providing a meaningful recovery action through reclaim.

The dmem cgroup currently only supports hard "max" limits, which
cause immediate allocation failures for GPU-bound workloads. A soft
limit enables smoother over-subscription by penalizing over-limit
cgroups via prioritized eviction rather than outright rejection.

The implementation adds a "high" cgroupfs control file per region,
a try_high parameter to dmem_cgroup_state_evict_valuable() for
tier-1 eviction, and a 3-pass strategy in ttm_bo_evict_alloc().
---
V5 -> V6:
- Guard the try_high dereference of test_pool->cnt with a NULL check
  to prevent a kernel panic during global memory pressure eviction
  when a BO has no associated cgroup.
- Make the disabled-cgroup stub for dmem_cgroup_state_evict_valuable()
  return false in try_high mode so the stub does not incorrectly
  enable Pass 1 when CONFIG_CGROUP_DMEM=n.

V4 -> V5:
- Restore the original control flow in dmem_cgroup_state_evict_valuable():
  test_pool is no longer dereferenced before the ancestry checks, fixing
  a NULL pointer dereference on BOs without a cgroup.  The limit_pool
  NULL-to-root-cgroup resolution is now performed before the try_high
  block, fixing a panic during global memory pressure eviction.
- Keep the try_high check for limit_pool == test_pool inside the existing
  early-return branch to avoid bypassing the hierarchy constraint check
  that prevents cross-cgroup eviction.
- Use a blocking lock in Pass 1 only when a ticket is available
  (trylock otherwise), addressing the deadlock risk of blocking without
  a valid ww_acquire_ctx.
- Explicitly reset trylock_only to true before Pass 2 so it does not
  inherit Pass 1's blocking behavior.

V3 -> V4:
- Use a blocking lock in Pass 1 instead of trylock to ensure
  over-limit cgroups are penalized even when their BOs are actively
  in use, as requested by Maarten Lankhorst.
- Evaluate the try_high condition before the limit_pool == test_pool
  early-return so that the limit-hitting cgroup's own BOs are also
  filtered by dmem.high.
- Remove the high-priority compensation retry at the start of Pass 3,
  which is no longer needed now that Pass 1 uses a blocking lock.

V2 -> V3:
- Walk the page_counter parent chain in the try_high pass to prevent
  child cgroups from evading the penalty when a parent cgroup exceeds
  its dmem.high limit.
- Check dmem.min protection in the try_high pass to avoid evicting
  BOs below the effective minimum.
- Add a properly-locked high-priority retry at the beginning of Pass 3
  so that actively-used over-limit BOs (which failed trylock in Pass 1)
  are not skipped while innocent cgroups are evicted.
- Fix get_resource_high(NULL) returning 0 instead of PAGE_COUNTER_MAX
  to match the behavior of get_resource_max().

V1 -> V2:
- Replace sleep-on-allocation throttling with prioritized eviction.
  When a "max" limit is hit, BOs from cgroups exceeding dmem.high are
  evicted first in a dedicated pass. No throttling or sleeping is
  performed in the charge path.
- Remove task throttling (schedule_timeout_killable, TIF_NOTIFY_RESUME,
  resume_user_mode_work() integration) entirely.
- Add dmem.high cgroupfs control file per region.
- Extend dmem_cgroup_state_evict_valuable() with try_high parameter
  to target over-limit cgroups as tier-1 eviction.
- Refactor ttm_bo_evict_alloc() into a 3-pass eviction strategy:
  (1) trylock: evict only BOs exceeding dmem.high
  (2) trylock: above-elow
  (3) proper-lock: repeat with low fallback.
- Initialize high to PAGE_COUNTER_MAX in reset_all_resource_limits().

v5: https://lore.kernel.org/r/20260531-feature-dmem-high-v5-1-1c6c532b26a9@gmail.com
v4: https://lore.kernel.org/r/20260530-feature-dmem-high-v4-1-ee7c6ec1c8da@gmail.com
v3: https://lore.kernel.org/r/20260528-feature-dmem-high-v3-1-c642b34bcb2f@gmail.com
v2: https://lore.kernel.org/r/20260522-feature-dmem-high-v2-1-1d7d4a0fa5da@gmail.com
v1: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com
---
 drivers/gpu/drm/ttm/ttm_bo.c | 33 ++++++++++++++----
 include/linux/cgroup_dmem.h  |  6 ++--
 kernel/cgroup/dmem.c         | 79 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f02..21fe34fd43eec 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -505,6 +505,8 @@ struct ttm_bo_evict_walk {
 
 	/** @limit_pool: Which pool limit we should test against */
 	struct dmem_cgroup_pool_state *limit_pool;
+	/** @try_high: Whether to only evict BO's above the high watermark (first pass) */
+	bool try_high;
 	/** @try_low: Whether we should attempt to evict BO's with low watermark threshold */
 	bool try_low;
 	/** @hit_low: If we cannot evict a bo when @try_low is false (first pass) */
@@ -518,7 +520,8 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 	s64 lret;
 
 	if (!dmem_cgroup_state_evict_valuable(evict_walk->limit_pool, bo->resource->css,
-					      evict_walk->try_low, &evict_walk->hit_low))
+					      evict_walk->try_high, evict_walk->try_low,
+					      &evict_walk->hit_low))
 		return 0;
 
 	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
@@ -577,31 +580,47 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	};
 	s64 lret;
 
-	evict_walk.walk.arg.trylock_only = true;
+	/*
+	 * Pass 1 (high-priority): Evict only BOs whose cgroup exceeds its
+	 * dmem.high soft limit.  A blocking lock is used when a ticket is
+	 * available to ensure over-limit cgroups are penalized even when
+	 * their BOs are actively in use; trylock otherwise.
+	 */
+	evict_walk.walk.arg.trylock_only = !ticket;
+	evict_walk.try_high = true;
 	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
+	evict_walk.try_high = false;
+	if (lret)
+		goto out;
 
-	/* One more attempt if we hit low limit? */
+	/*
+	 * Pass 2 (trylock): Evict BOs above the effective low watermark.
+	 * Falls back to low-priority eviction if needed.
+	 */
+	evict_walk.walk.arg.trylock_only = true;
+	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	if (!lret && evict_walk.hit_low) {
 		evict_walk.try_low = true;
 		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	}
+
 	if (lret || !ticket)
 		goto out;
 
-	/* Reset low limit */
+	/*
+	 * Pass 3+ (properly locked): Evict while making progress.
+	 * Reset flags and retry with try_low if we hit the low watermark.
+	 */
 	evict_walk.try_low = evict_walk.hit_low = false;
-	/* If ticket-locking, repeat while making progress. */
 	evict_walk.walk.arg.trylock_only = false;
 
 retry:
 	do {
-		/* The walk may clear the evict_walk.walk.ticket field */
 		evict_walk.walk.arg.ticket = ticket;
 		evict_walk.evicted = 0;
 		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	} while (!lret && evict_walk.evicted);
 
-	/* We hit the low limit? Try once more */
 	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
 		evict_walk.try_low = true;
 		goto retry;
diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736e..3f7278cb290b3 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -23,7 +23,7 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
-				      bool ignore_low, bool *ret_hit_low);
+				      bool try_high, bool ignore_low, bool *ret_hit_low);
 
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
 #else
@@ -54,8 +54,10 @@ static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64
 static inline
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
-				      bool ignore_low, bool *ret_hit_low)
+				      bool try_high, bool ignore_low, bool *ret_hit_low)
 {
+	if (try_high)
+		return false;
 	return true;
 }
 
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f2..4267309e6b01d 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -156,6 +156,12 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 	page_counter_set_low(&pool->cnt, val);
 }
 
+static void
+set_resource_high(struct dmem_cgroup_pool_state *pool, u64 val)
+{
+	page_counter_set_high(&pool->cnt, val);
+}
+
 static void
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
@@ -167,6 +173,11 @@ static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
 	return pool ? READ_ONCE(pool->cnt.low) : 0;
 }
 
+static u64 get_resource_high(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? READ_ONCE(pool->cnt.high) : PAGE_COUNTER_MAX;
+}
+
 static u64 get_resource_min(struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.min) : 0;
@@ -186,6 +197,7 @@ static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
 	set_resource_low(rpool, 0);
+	set_resource_high(rpool, PAGE_COUNTER_MAX);
 	set_resource_max(rpool, PAGE_COUNTER_MAX);
 }
 
@@ -289,10 +301,13 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
  * dmem_cgroup_state_evict_valuable() - Check if we should evict from test_pool
  * @limit_pool: The pool for which we hit limits
  * @test_pool: The pool for which to test
+ * @try_high: Only evict BOs whose usage exceeds the high limit (first pass)
  * @ignore_low: Whether we have to respect low watermarks.
  * @ret_hit_low: Pointer to whether it makes sense to consider low watermark.
  *
  * This function returns true if we can evict from @test_pool, false if not.
+ * When @try_high is set, only pools with usage above their high limit are
+ * evictable, enabling prioritized eviction of over-limit cgroups.
  * When returning false and @ignore_low is false, @ret_hit_low may
  * be set to true to indicate this function can be retried with @ignore_low
  * set to true.
@@ -301,15 +316,26 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
  */
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
-				      bool ignore_low, bool *ret_hit_low)
+				      bool try_high, bool ignore_low, bool *ret_hit_low)
 {
 	struct dmem_cgroup_pool_state *pool = test_pool;
 	struct page_counter *ctest;
 	u64 used, min, low;
 
-	/* Can always evict from current pool, despite limits */
-	if (limit_pool == test_pool)
+	/*
+	 * When the limit-hitting cgroup's own BOs are being considered
+	 * in try_high mode, only evict them if their pool exceeds its
+	 * own dmem.high limit.  For non-try_high mode, maintain the
+	 * existing behavior: always evict from the limit-hitting pool.
+	 */
+	if (limit_pool == test_pool) {
+		if (try_high && test_pool) {
+			ctest = &test_pool->cnt;
+			used = page_counter_read(ctest);
+			return used > READ_ONCE(ctest->high);
+		}
 		return true;
+	}
 
 	if (limit_pool) {
 		if (!parent_dmemcs(limit_pool->cs))
@@ -330,10 +356,38 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 	}
 
 	ctest = &test_pool->cnt;
+	used = page_counter_read(ctest);
+
+	if (try_high) {
+		struct page_counter *c;
+
+		/*
+		 * Walk the page_counter parent chain to check whether any
+		 * ancestor cgroup exceeds its dmem.high limit.  This prevents
+		 * child cgroups from evading the penalty when a parent cgroup
+		 * is over its high limit.
+		 */
+		if (used <= READ_ONCE(ctest->high)) {
+			for (c = ctest->parent; c; c = c->parent) {
+				if (page_counter_read(c) > READ_ONCE(c->high))
+					break;
+			}
+			if (!c)
+				return false;
+		}
+
+		/*
+		 * Respect dmem.min protection: do not evict BOs below the
+		 * effective minimum even during the high-priority pass.
+		 */
+		dmem_cgroup_calculate_protection(limit_pool, test_pool);
+		min = READ_ONCE(ctest->emin);
+
+		return used > min;
+	}
 
 	dmem_cgroup_calculate_protection(limit_pool, test_pool);
 
-	used = page_counter_read(ctest);
 	min = READ_ONCE(ctest->emin);
 
 	if (used <= min)
@@ -835,6 +889,17 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_low);
 }
 
+static int dmem_cgroup_region_high_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_high);
+}
+
+static ssize_t dmem_cgroup_region_high_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_high);
+}
+
 static int dmem_cgroup_region_max_show(struct seq_file *sf, void *v)
 {
 	return dmemcg_limit_show(sf, v, get_resource_max);
@@ -868,6 +933,12 @@ static struct cftype files[] = {
 		.seq_show = dmem_cgroup_region_low_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "high",
+		.write = dmem_cgroup_region_high_write,
+		.seq_show = dmem_cgroup_region_high_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "max",
 		.write = dmem_cgroup_region_max_write,

---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-feature-dmem-high-16997148dc38

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>


