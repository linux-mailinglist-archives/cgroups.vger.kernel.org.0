Return-Path: <cgroups+bounces-16479-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N/yJVaTGmoe5wgAu9opvQ
	(envelope-from <cgroups+bounces-16479-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 09:35:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92BB60B993
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 09:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950D0303E4FC
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612C439478D;
	Sat, 30 May 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqMUEsMo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05F383C77
	for <cgroups@vger.kernel.org>; Sat, 30 May 2026 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780126538; cv=none; b=UuB+aNT/8hvJmswMW+W33wEYp5mEVUlAxV/B6ScBTl9n0XRgAmSzG3XZ/6T1nBJHMMuVyh5HniEJdhLcJXk8x2Tq/Mez7q5KHskMl+lcPrk9JCSNDRkgq8AHtPGS0N1K5MbY3s0qonUoUBvTRz0SdY5h6uP5i68FgoVIAbkorlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780126538; c=relaxed/simple;
	bh=xzfOsvJdAGauaR1anYLcq6Y+r6SvqEt8PxfqQr9NWvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ig1FVkB1NnKlVoml9FA/An7Oy1OzlR83oQ0n4R+6SLkmcDOEbKJ/fqIoj+2lm/E/IOUXbfvPiCaAZz3X97/V6BDBG4IhFQytsP2yuv20AJafBKaG8xZoPmvnSqOiUPYR0heq8nrsiEBhmX2rt7HjbfOvcIRzcImgO7ts7trdpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqMUEsMo; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304e6c6464dso3763378eec.1
        for <cgroups@vger.kernel.org>; Sat, 30 May 2026 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780126534; x=1780731334; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39Cnxhi4FnCrp7MTKYla7YbmboLtT4AoKytr/Zbd3Mg=;
        b=WqMUEsMoP6260H/SvuMUEsz+kl9U28LpHImN9x2Jd6yhT3pvAaP7DCkUy+qhl6Wamb
         9tXX0gztBI5u5pXJIciZuVRSWxiO2nm4AgqEB//6ZwN0It86xejdNHi2r4M8WTiNmhgV
         yTgnMEHYKrL/j+hQAo4S5gSLI/JJaiv1fTyzzRdxNW84h4G+O4sIeXmtx/CmhgXTdzfR
         /n+2vy2WvtsEBLHqXeXHRmPfbFNO47voNaNlvczfK4EwOaMkTh60ntyi6ZbMaCBljG+N
         dJ1aJG8QFRTH6VvTazbs4dRzoge6lQ9jADaITfhrgtylORmrkU5/jdcWoh6ElYdHEaa5
         bDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780126534; x=1780731334;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39Cnxhi4FnCrp7MTKYla7YbmboLtT4AoKytr/Zbd3Mg=;
        b=h25eBjj6H2JAlevCAR1w7SAy2E6+KH5cOnX3EDfNfwPZFuVCWvyO6pOEG2UD4z/V/0
         Px0LhqvJTA3JFKiCOkqoY3p1HqMeyXYo3G4qQWI05ZRDInqYVbZeqKftpxvp5nd+2/rb
         YKy6IT0rUZSSlMgIiLnOloED5Bz2Qc/PsN8fToinXYiBqz94wsBwB3ob1I60YA23i8Ik
         vpOY6r6cdBNqCPOAgTs4oOUiqUPmPVcnQi7ND2+iXPGqJA22RDHoz2RNfeDb15bqicda
         nx0O429k30rxYX6DXjDH7M23oB+3xqupZJxAF8N5KyoUwCyP8rFMMXIEMzerRdS4Fkr0
         KUag==
X-Forwarded-Encrypted: i=1; AFNElJ+7d7/S12w9HX2UY1DTtThTBoFHlU+dDAg++ZQoQJfvn6Ok97BVuWYdDqZtUaTLl5de1KjsXX7Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxQa+DDyMQN8Ae2nBVZmZAJVbrVSIO+Vx5EO1HRLFuYG19bQmIL
	c6QinOE2o2VBh11cb82EsOMna/7xsIfvss84+J8bkKmME8kT67Eijjdn
X-Gm-Gg: Acq92OGoOkMhTCESZYgmBJxn8vIrGoeknteKW+OnSMa53kdlHTdqHexKiQq95njrc0w
	iyRTHWc75EOyuLQYuyhVUCS57MXLg21fxLOb6jBhRdC9xjhb0kAy66aBWk9nb4NJQvulwoeXjFE
	ZTTi+130RzupwIkOdtjiaeBbVotl2/Bi2hPrq/C/p6s+Dqjhgm/1OszdXwiw/FMz+BedVV3Q6gZ
	uAl1GK660p06gADSAH90dOBzez7uH9dCrY8KwDAc/lx23LdI6K3jYz937Uv+/A2QlNbBWQu2D73
	xEqHqCuBA3hpBTgwNOBbItwND1Ds3pMCpqDYc2j2JCVdvxSaHYOJ1wva+b3yri/omD4Nzz1JXR4
	kfg4XLIuQIjY8dk6bDPn0gAF19EGvQ6As5+5xQiWcrK51/rcsjb6immsSuqWb49VgOFWbz/G1Hj
	Coe/E+fNp5BWzVH3I4h+BYmFnuZGFAL7EcBt6dQ9ux
X-Received: by 2002:a05:7300:c87:b0:304:cefc:5fde with SMTP id 5a478bee46e88-304fa6b5144mr1459260eec.26.1780126534160;
        Sat, 30 May 2026 00:35:34 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm3298939eec.27.2026.05.30.00.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 00:35:33 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Sat, 30 May 2026 15:35:27 +0800
Subject: [PATCH v4] cgroup/dmem: implement dmem.high soft limit via
 prioritized eviction
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-feature-dmem-high-v4-1-ee7c6ec1c8da@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvIfiy7SrSInHQWWmhFIN09a
 fkt3ksQKTBFGIsEgW6OvPuMtixgtYs3hKyzoa5qWXVC4UbLeQVC7cihZWNRSKV60Q56bQbI3RF
 o4+d/TvP7fhsW5YRjAAAA
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
	TAGGED_FROM(0.00)[bounces-16479-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: C92BB60B993
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
parameter.  When set, the function evaluates the try_high condition
first (before the limit_pool == test_pool shortcut) so that even the
limit-hitting cgroup's own BOs are filtered by the high threshold.
It then walks the page_counter parent chain to check whether any
ancestor exceeds its high limit, and verifies that the pool is above
its effective minimum to respect dmem.min protection.

Refactor ttm_bo_evict_alloc() into a 3-pass eviction strategy.
Pass 1 uses a blocking lock and targets only BOs whose cgroup exceeds
dmem.high, ensuring over-limit cgroups are penalized even when their
BOs are actively in use.  Pass 2 falls back to the standard above-elow
trylock eviction.  Pass 3+ uses proper locking and repeats while
making progress with the existing low-watermark fallback.

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

v3: https://lore.kernel.org/r/20260528-feature-dmem-high-v3-1-c642b34bcb2f@gmail.com
v2: https://lore.kernel.org/r/20260522-feature-dmem-high-v2-1-1d7d4a0fa5da@gmail.com
v1: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com
---
 drivers/gpu/drm/ttm/ttm_bo.c | 32 +++++++++++++----
 include/linux/cgroup_dmem.h  |  4 +--
 kernel/cgroup/dmem.c         | 81 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 104 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f02..bf06e9e4b18a3 100644
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
@@ -577,31 +580,46 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	};
 	s64 lret;
 
-	evict_walk.walk.arg.trylock_only = true;
+	/*
+	 * Pass 1 (blocking, high-priority): Evict only BOs whose cgroup
+	 * exceeds its dmem.high soft limit.  A blocking lock is used to
+	 * ensure over-limit cgroups are penalized even when their BOs are
+	 * actively in use.
+	 */
+	evict_walk.walk.arg.trylock_only = false;
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
index dd4869f1d736e..06115d35509b1 100644
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
@@ -54,7 +54,7 @@ static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64
 static inline
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
-				      bool ignore_low, bool *ret_hit_low)
+				      bool try_high, bool ignore_low, bool *ret_hit_low)
 {
 	return true;
 }
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f2..f81fbb538cf2f 100644
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
@@ -301,12 +316,56 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
  */
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
-				      bool ignore_low, bool *ret_hit_low)
+				      bool try_high, bool ignore_low, bool *ret_hit_low)
 {
 	struct dmem_cgroup_pool_state *pool = test_pool;
 	struct page_counter *ctest;
 	u64 used, min, low;
 
+	ctest = &test_pool->cnt;
+	used = page_counter_read(ctest);
+
+	if (try_high) {
+		/*
+		 * When the limit-hitting cgroup's own BOs are being
+		 * considered, only evict them if their pool exceeds its
+		 * own dmem.high limit.  No ancestry check is needed
+		 * because the limit was triggered by this pool itself.
+		 */
+		if (limit_pool == test_pool)
+			return used > READ_ONCE(ctest->high);
+
+		{
+			struct page_counter *c;
+
+			/*
+			 * Walk the page_counter parent chain to check
+			 * whether any ancestor cgroup exceeds its
+			 * dmem.high limit.  This prevents child cgroups
+			 * from evading the penalty when a parent cgroup
+			 * is over its high limit.
+			 */
+			if (used <= READ_ONCE(ctest->high)) {
+				for (c = ctest->parent; c; c = c->parent) {
+					if (page_counter_read(c) >
+					    READ_ONCE(c->high))
+						break;
+				}
+				if (!c)
+					return false;
+			}
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
+
 	/* Can always evict from current pool, despite limits */
 	if (limit_pool == test_pool)
 		return true;
@@ -329,11 +388,8 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 			{}
 	}
 
-	ctest = &test_pool->cnt;
-
 	dmem_cgroup_calculate_protection(limit_pool, test_pool);
 
-	used = page_counter_read(ctest);
 	min = READ_ONCE(ctest->emin);
 
 	if (used <= min)
@@ -835,6 +891,17 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
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
@@ -868,6 +935,12 @@ static struct cftype files[] = {
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


