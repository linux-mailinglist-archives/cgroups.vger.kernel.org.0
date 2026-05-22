Return-Path: <cgroups+bounces-16202-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N77JxQUEGryTAYAu9opvQ
	(envelope-from <cgroups+bounces-16202-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 10:30:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 039CA5B0990
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1803037460
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744083A7F52;
	Fri, 22 May 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMAsfNir"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB33A7585
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438500; cv=none; b=cI+s742LKUk8abaAQ/l/k9F/yxtZzbHrsGU0B03IUVc52qYC8bRvzMGVc1wHdWr6nFy2s12/CPcKP8z3nJaA/eJ4eWl1biM/+MJGajwe3JLi+5P63kGWxOCRa+beA+S6W2a5qYDoBUXpay2W6+y/j2HCGwu1LpX4ATb7Jhh5+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438500; c=relaxed/simple;
	bh=22AnOA2E4gIttKLSIMM4IVgcoqszOvxEuV8pjsI+oNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iaEak0mJvnRXagVcDQQ8rX/Ft06yolgCtauyoXq4xIE5vyZfD5jaX76F5bfNSpcI5vdjuzi3ULeB1JH3kCE7umcbVhmf0cE6HhsJB6RF2OrjO9WQ11Ce/TALHdquVQUnR/vxaooQ048s889IlexwvjM4cEBVh44gYH1qKZtEU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMAsfNir; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4904127c32cso4803345e9.2
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779438497; x=1780043297; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsaFe+7Xyz5+ITLDpBQw1qNHqE6BqqIIroG5/kytuLw=;
        b=TMAsfNirzlZZBZFf77VWDqOXjG1DnyKAexaara9LUqMjWzMkFVof4GlVSYVLyoN33S
         7WKkN1QHIgMa/r+EZP85ysqh6FjshabjMdTg8gnIMvJfu4NDs0Oe1q60DSZcRsFy1z+S
         +8KAqsWeUYshKRTx75wn4Ccv7q9Y6PQex9/jBGEFGLjPsZ7CB1TKu6LlSugtagqLZV+x
         HGRTJ9ipgl1Luhb35wWsakZPQsHaNbdW67xTfSxLre9qFBRP5VR848abw/wwor11sbDK
         GksAflN6iCHofv/e/BysBDAMbHcq1lOu8T/aH4jvOdxIXoD6cZaAyvL8vYEwzhRBFcqU
         zPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438497; x=1780043297;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsaFe+7Xyz5+ITLDpBQw1qNHqE6BqqIIroG5/kytuLw=;
        b=lPOG5lTZCmDiNYsvyKD7Z3d3nxdO721EQ4EK9Ifmb8srgcumk8Fu7u/cCazDSFqK+y
         2gWv8zXCDRZtlq/3Slkw35kATbtCbRbT94ILW0UJ2lClHtbWBWI9CoNpiOCPZEAW9OLU
         BBmGDjupL5ifRU2H8hp/jZjSl3uFX8lLu37/v5wSXBabxBZZ20huCePI5RlR8EkQwzxo
         UOtiELzckCn3jxm0/55m+/KnFmgdAru/ICTBMZHYGe5pvJAIYXdbMMXygzsMWJD4ZpOL
         hcUYOtZtjZOG/8wr2qVnpLXRnQwiuUFn53OTHOpBP+ElLKP6ufnDEd4lPteIGbuXou+/
         0W4g==
X-Forwarded-Encrypted: i=1; AFNElJ/HCmnEs6zGRuFyg6zf51fMllGuV1vjs+VXmjkw3yNjcEp/il209+eRogtjs+WtDX2DKTQ3GSPd@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuEoO/hLcfI/eekHhD1+7GGCenEiYRx1e7ilAx0ozB4C35tRZ
	ARMAV+37OLi1ynSVaWVtMybOAgnPVChY6JfTTdAtpoBiCP5Q1tm5njgN
X-Gm-Gg: Acq92OHLBBDpESFqpR6Lwy5w/IcgqXMc8ne5IwG/BXDdwMsIzwjShsNamSQUYJAW4Tt
	xciq1aWdlAhbc1VDvw5nS2TGv4UUx6Y6qIY+kxLwkYcS+SOe0/XRdshvAUze5Npa1G5zAloyhoo
	UJC0/EMswf2UovHbvBVzW56FiFhNy81If/G7KMpFhxZNuzc38KCQVeIDorrQdTjuOHrzA5VCoCz
	B/mFTE1bggPbBkdVr+v3ImiRIid8Fxl3PijlN3mzdk5r8NtNwyKxYMFAhlnQw3tFPHKY++/xeCA
	EO0zg1ItNurv+ifOm3WD5IcLfl0hpxvh/I+cgl3Ctuyv3VrmknHDDPhfWMkHmRYo7mpiNbf/BnW
	NcxONOrEHZ5RKQseMcKlUOxe0B8GAEhUyR8Sp4aHOy7pKHH1UHQyfCh78ayM5VCX2w9H0UR1F8Q
	TYJVQa2BdRWDJnfi8nxKBMR5D80Yvl1P7iLpRzmbsf
X-Received: by 2002:a05:600c:1c0d:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490424b3927mr35735625e9.9.1779438496277;
        Fri, 22 May 2026 01:28:16 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042d081f5sm14065795e9.5.2026.05.22.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:28:15 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 22 May 2026 16:28:05 +0800
Subject: [PATCH v2] cgroup/dmem: implement dmem.high soft limit via
 prioritized eviction
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-feature-dmem-high-v2-1-1d7d4a0fa5da@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBA0avIrE2iRamriIXoaGfRkhaRiLtrL
 N/i/wcSRaYEQ/FApIsTbyFDlgUsbg6WkE02yEqqqhUaV5qPMxIaTx4dW4dCad2JpjdL3UPu9kg
 r3/9znN73A5aNsOBjAAAA
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16202-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,cmpxchg.org,suse.com,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 039CA5B0990
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
PAGE_COUNTER_MAX in reset_all_resource_limits().

Extend dmem_cgroup_state_evict_valuable() with a "try_high"
parameter.  When set, only pools with usage above their high limit
are considered evictable, implementing tier-1 of the prioritized
eviction model.  For the existing low-priority passes, the original
effective-low/effective-min protection logic is unchanged.

Refactor ttm_bo_evict_alloc() into a 3-pass eviction strategy.
Pass 1 uses trylock and targets only BOs whose cgroup exceeds
dmem.high.  Pass 2 falls back to the standard above-elow eviction.
Pass 3+ uses proper locking and repeats while making progress,
with the existing low-watermark fallback.

This adds one extra LRU walk when over-limit cgroups are present,
but avoids any throttling or sleeping in the charge path, which
would be catastrophic for GPU submission pipelines.

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

v1: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com
---
 drivers/gpu/drm/ttm/ttm_bo.c | 28 +++++++++++++++++++++------
 include/linux/cgroup_dmem.h  |  4 ++--
 kernel/cgroup/dmem.c         | 45 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f02..eefcdb6155d63 100644
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
@@ -577,31 +580,44 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	};
 	s64 lret;
 
+	/*
+	 * Pass 1 (trylock): Only evict BOs whose cgroup is above its
+	 * dmem.high soft limit. This penalizes over-limit cgroups first.
+	 */
 	evict_walk.walk.arg.trylock_only = true;
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
index 4753a67d0f0f2..3799ecd6d7b52 100644
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
@@ -301,7 +316,7 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
  */
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
-				      bool ignore_low, bool *ret_hit_low)
+				      bool try_high, bool ignore_low, bool *ret_hit_low)
 {
 	struct dmem_cgroup_pool_state *pool = test_pool;
 	struct page_counter *ctest;
@@ -331,9 +346,18 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 
 	ctest = &test_pool->cnt;
 
+	used = page_counter_read(ctest);
+
+	/*
+	 * High-priority pass: only evict BOs whose cgroup is above its
+	 * dmem.high soft limit.  This implements tier-1 of the 3-pass
+	 * eviction model, ensuring over-limit cgroups are penalized first.
+	 */
+	if (try_high)
+		return used > READ_ONCE(ctest->high);
+
 	dmem_cgroup_calculate_protection(limit_pool, test_pool);
 
-	used = page_counter_read(ctest);
 	min = READ_ONCE(ctest->emin);
 
 	if (used <= min)
@@ -835,6 +859,17 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
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
@@ -868,6 +903,12 @@ static struct cftype files[] = {
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


