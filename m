Return-Path: <cgroups+bounces-16386-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAoNMG4wGGpwfggAu9opvQ
	(envelope-from <cgroups+bounces-16386-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 14:09:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEFD5F1E10
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 14:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5CF312116C
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5F3E7BC8;
	Thu, 28 May 2026 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIqwpZZ/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97313E7BBA
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969820; cv=none; b=XMAIDUBXqEOZ2sPYNY+tRvE/phZTErQaAeuKCe+ebWy8xXoG8nFWXuLbjal9Fsd99UbWxX9AfNdkRaQ5V9q6oh/RwP/qroVFNJxTXc9gTbRU26NKEpiOrcojBt4bpM1LrBmns8x1pPb2igTe3dZ9OBjIJ5SOF4PIokf8Oz8UqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969820; c=relaxed/simple;
	bh=OnLfoBEGl/L+fi+ptHThj7ThHl8vQruu5WsetJMGQtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h+lzTJkU+tyLqm3kNLDqsPeIz3SctcxNCkACFY2n3TgaiGdkS8zlZemQbKdoxHh3hwaegt7eBpOJZA557ZVXfppbqC+5favt1Ac7SZYsx9RBTrZmX9phVmMEJDwEBdUXvSy6f6foim0jA9xjZuczfIKPKFvi5sKnBqLHtJariOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIqwpZZ/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5102582e23eso100601101cf.1
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779969817; x=1780574617; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cM2o5grV8Dn9u4uPmeFDpnxwRxbJqTaVT40/+VIccNE=;
        b=fIqwpZZ/SzeE+m1ac4udme8nxQzzl+QWBiBZRuHitS08gMkcGjWWaD1jCmUxkdP8gg
         5bovaibKSJurMB+n+bGj/kFWYhiQMe0QQHezIk31RCO+IEBSVgyvdfQ7FgvBw3b0VfX7
         gYJAvW/UpDfLCE2n57PbToSvFY9fVBIObPhgjR7OvPc66kNKj7HFjULNVon8i/VoKiIT
         Q5rYq6EXNMGujZfUaqRh/JxRNbxwFIvX7P6529s27XgfEIzBjHzaO50hI/7eFMLbnFy3
         0gGaYbJgq2P1yQ19kaO9yCSv5dQPsMeHiJg05Q5rf8O6eva8aIv1Gi6/kLzkYWQY3WeL
         GxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779969817; x=1780574617;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM2o5grV8Dn9u4uPmeFDpnxwRxbJqTaVT40/+VIccNE=;
        b=KRg8JAWOv3GW6U8mapVJh3a1ZoJYPxPVZHHjQzRJjF/kvvOhpMEPCRix4NkDQdwqMS
         7EzpVN1FixuS+cbuPMOePyUQ0a7knb9nemSNQvpQXbn4IcVzXcYLjmSewU5mO/m4MSoo
         5XnxMPyxPdOELiUSZ7E5mWacVLkBPbEkDnCnOuFJDVHD34b7j2lEIeHHkW0TTcPwQo4O
         p2lT5+SIPjEcJSW898/Q2UoFlKMuAJZw2r65O+fjIOffKXiPmZgb2A2qH4+JDmw/XYHn
         oVqLgUMRv07SBXMPCJjtnV2BgLzpUo80Z/yY+Yu0iBzd4bcLrRTJ0cDm/b5FdO9cAXfU
         rU4A==
X-Forwarded-Encrypted: i=1; AFNElJ9gHqbO9n2sKIHGOML6ldwFGcs3TuX5qIDSPh7DwtJbyJduwbeX+Pj1R4naoaKV6y2NRIFvLsIq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1/UK+nx0STSJbqGX9JrAvwvAQ8X69vvdaYj9fyjY7MlRojYw
	tMPQ+ULw0PfcwnUOJRKbE70tBh8MPSrPvodun6TJcGXKcFxRUoCLu2Qf
X-Gm-Gg: Acq92OGXRI7+7B2LFcPykNQHVmdsjseD1SZ4lNsX6cO3oJ+lSWbquEejVw67YHpU+m3
	vJmoKalcDMxgpLXrVi+IP3x67/EeK3TnISB5qgdc6961lMAAbTPxo7Rk3NWVGaa+yRLRxADiAIN
	PYUE5ydxsSaKq/1M9yWhHSBVA01k4xuHfy+I1qoMIjatGpzpo4/0KfnHLfjRE0e+Z/vEmyN3m2K
	XymzY9NPaq5tWxZMWj6bY6NRsgQHkqxe0VehuHe5j0lqTeO+nrK/6GCqunX2xHDBU1bxSnJhGJs
	olu8Xg9vbIJd1gF3aYkTbGBNpEthfxBGd43r2gCRaCIh0qCUs9ebbFT2Bl5XhvzAtz7njFo8evx
	CnTgvubIPytVKox7mhc1pIUSMEfInq+663AHN0YGUJfXmJlobmD53oy+1l1UnA+PGJEgdr4BqIg
	ZC0hl3vfPDn3gRwJyxqG80BsASIcQAUXDbpBRPqRkd
X-Received: by 2002:a05:622a:144d:b0:516:e517:6dfa with SMTP id d75a77b69052e-516e5177074mr282647901cf.18.1779969816687;
        Thu, 28 May 2026 05:03:36 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b0bad4sm72208001cf.31.2026.05.28.05.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:03:36 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Thu, 28 May 2026 20:03:28 +0800
Subject: [PATCH v3] cgroup/dmem: implement dmem.high soft limit via
 prioritized eviction
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-feature-dmem-high-v3-1-c642b34bcb2f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvIfiy7SrSInHQWWmhFIN09a
 fkt3ksQKTBFGIsEgW6OvPuMpixgtYs3hKyzoa5qWXVC4UbLeQVC7cihZWNRSKV60Q56bQbI3RF
 o4+d/TvP7fgtK7hxjAAAA
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
	TAGGED_FROM(0.00)[bounces-16386-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 3BEFD5F1E10
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
chain to check whether any ancestor exceeds its high limit, then
verifies that the pool is above its effective minimum to respect
dmem.min protection.  Only pools meeting both criteria are evicted.

Refactor ttm_bo_evict_alloc() into a 3-pass eviction strategy.
Pass 1 uses trylock and targets only BOs whose cgroup exceeds
dmem.high.  Pass 2 falls back to the standard above-elow eviction.
Pass 3 begins with a properly-locked high-priority pass in case
Pass 1 failed due to trylock contention, then proceeds with the
standard repeat-while-making-progress loop with low-watermark
fallback.

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

v1: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com
v2: https://lore.kernel.org/all/20260522-feature-dmem-high-v2-1-d805deddecbb@gmail.com
---
 drivers/gpu/drm/ttm/ttm_bo.c | 35 ++++++++++++++++++++----
 include/linux/cgroup_dmem.h  |  4 +--
 kernel/cgroup/dmem.c         | 65 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f02..2f2b428f1d30a 100644
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
@@ -577,31 +580,51 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
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
+	 * First retry the high-priority pass with proper locking in case
+	 * Pass 1 failed due to trylock contention on over-limit BOs.
+	 * If that still fails, fall back to the standard low-priority eviction.
+	 */
 	evict_walk.try_low = evict_walk.hit_low = false;
-	/* If ticket-locking, repeat while making progress. */
 	evict_walk.walk.arg.trylock_only = false;
+	evict_walk.try_high = true;
+	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
+	evict_walk.try_high = false;
+	if (lret)
+		goto out;
 
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
index 4753a67d0f0f2..c80444c0da177 100644
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
@@ -331,9 +346,38 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 
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
+
 	dmem_cgroup_calculate_protection(limit_pool, test_pool);
 
-	used = page_counter_read(ctest);
 	min = READ_ONCE(ctest->emin);
 
 	if (used <= min)
@@ -835,6 +879,17 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
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
@@ -868,6 +923,12 @@ static struct cftype files[] = {
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


