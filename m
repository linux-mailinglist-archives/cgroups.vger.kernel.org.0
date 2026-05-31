Return-Path: <cgroups+bounces-16485-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NHFLHCv1G2rdHgkAu9opvQ
	(envelope-from <cgroups+bounces-16485-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 10:45:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A9E6152F8
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 10:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE7763012D6C
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E214381AE7;
	Sun, 31 May 2026 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxBuLITq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC22F8E90
	for <cgroups@vger.kernel.org>; Sun, 31 May 2026 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217127; cv=none; b=OpuwLsLGSjPBGqfuxSvboyROJbP9ZAdH3HVY3x//c/fyHvic8ror5HZrBlk5kgqIsvTNcXEabOVRD02/OEHfZX0YWGUzzCp6ud3rWra8zN7+GGaXXNuYX2f6V4jpWt4Zs/vVIAnYao7IPrj+71H4SxKThXb+rUrxJeNLHa08k1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217127; c=relaxed/simple;
	bh=XOeF/7Fjsxw9DrpEhPxT5xONO7ulnqddCQ504l4V4Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kBq1NITJuI1xdCyzjNiGeW8vgwaIpxEcHJudHC5vZ4OVURXsU+nsrzvbwqa4IKpS7O/ulo1IlWJZeq/ALxeq2qixdvRjSMx95MSUBohpDRij+uBqzVGMUu2+4/BauHIQsf8niHwWY9wRA672EJMNbwIJ6XqadXvVePpJ9inwW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxBuLITq; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137c928ec7bso1644744c88.1
        for <cgroups@vger.kernel.org>; Sun, 31 May 2026 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780217125; x=1780821925; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/vPGPYIWZ3cYQnQnKuyT6luc+iRq2TIQF+FlFNhbeQ=;
        b=jxBuLITqoHGdLlBNggQ8qjgiXUSOGksNqNx+uOKAAkzLdul3fyURDFxm54ONjmm2dt
         trh+wGo796UnX37+W2I+MASZeZ0vA1AK4QxAI3z4B2J2Z/hmYr8pd0C2O2BMkeOO4Euw
         TQHGB6Ep4A12SY0ngtLeWvxRT3y+4nBK/EhAtfSlC4F+2CFWbjqP+Fj6G0lZMYWNWk2E
         9I5t+kIDXrWtyhi2mXi1n84cCyrCZjO8kPedVmZxpHAID+qc7BopkSug46v1E2Y9dthS
         LJw7fhPy7tYSGh2X/sIaWIeKoXZLhOWz65C6xWTvCE91mliUIWqXP866MmAmToVdkHr8
         psJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780217125; x=1780821925;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/vPGPYIWZ3cYQnQnKuyT6luc+iRq2TIQF+FlFNhbeQ=;
        b=HNHtJ42Jw8BXLllgbCV2W2ghOKMxSpaiz4ewdPhJs4zjaD+SEoVpZapzjJfIKHcPg6
         dQCCaRNr0hQd20n9h91c+65LZbDJnZsD8W1S88JNH8AuBE10xRGz8+ZPxLVgCDS0JfE4
         R4u85XzjrY9ZFmfZjGg1Ad2d+PEsOh/uzAfQCwSya77INI9EHOET3fLv+2gtSpROlKor
         U1BL7x2l80eK2UbkkQ1OpJFdD/N8uypoqJfG6yMnFVawOjwyLkX7EzCTISLCS5IDPSGC
         f3/uI+oXNa8VT2lnWCPG/KgI0lxqWThijvwMtpfQqw8erbvh5f5EC8fUwm+b3s3ZsN9e
         +Yww==
X-Forwarded-Encrypted: i=1; AFNElJ8duIKO8YIHBNCu57uyV+KcxYSIPmVzJqaULMrq2Hd1V5kZfuTLF9urFqwdKrLILqarQJ1CVWSy@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4yOEpMZhOagqaCss0dkSysPkhURxvmigdpB2QF+rCnau7tdx
	0Yee+w0iAAIQ1Y6kiIQTdBk0qcLVNJc1I9JBykAWtsNVvPQFjcc5D435g3s2oxIq
X-Gm-Gg: Acq92OEu1nLK24eZeYhnvBy0tpCc5u/Mll7hv5E7p9oxt4BVVsH8Ze7gw5pYISOiwNf
	E4LpK8BGQj+/dqkcFC8CscLNmRReHvzmRszQn5cKrJ53GQHmHfBiwsHv3HlTdONrQd63Ospfb1V
	0SkgzERQmXzQ/1IFg27oKCdZTqopNrglkiYi04dwt+7s03WCtsqEIfNEpXbMKqRQ3xE+Q4tRWt5
	lz9O8fmDytcx4KmU1tJOq6yhqo/VFMwb7g/PbP8DfZfoGFYQ6xjfyLJ2/vjeWE91mLRioTKOR1V
	idBPIfPLDGvO8s8P7Tg9bAYEMxHKRy3VxqPxwuFWHMeTSbXhd1GgfuFiqSA/es1fJEuxtg9Bl8W
	cMPHlsTJIXbk/RM7+afK0koVE2ZERnfm5385ZM2qrjJIDJqqu8+5OsN8JH9ir2hoRKdzhTBCdhs
	aWVMc/uz06beBLnb941IEKKV8R+NHjeH8sqSlp3WrG
X-Received: by 2002:a05:7300:ef83:b0:304:ba84:a0cc with SMTP id 5a478bee46e88-304fa74682bmr2981286eec.33.1780217124924;
        Sun, 31 May 2026 01:45:24 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a0b7dsm6124336eec.22.2026.05.31.01.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 01:45:24 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Sun, 31 May 2026 16:45:19 +0800
Subject: [PATCH v5] cgroup/dmem: implement dmem.high soft limit via
 prioritized eviction
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-feature-dmem-high-v5-1-1c6c532b26a9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NL3bTUxJLSolTdlNzUXN2MzPQMXUMzS0tzQxOLlGRjCyWgvoKi1LT
 MCrCZ0bG1tQCG0bt4YwAAAA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16485-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,cmpxchg.org,suse.com,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 07A9E6152F8
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

v4: https://lore.kernel.org/r/20260530-feature-dmem-high-v4-1-ee7c6ec1c8da@gmail.com
v3: https://lore.kernel.org/r/20260528-feature-dmem-high-v3-1-c642b34bcb2f@gmail.com
v2: https://lore.kernel.org/r/20260522-feature-dmem-high-v2-1-1d7d4a0fa5da@gmail.com
v1: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com
---
 drivers/gpu/drm/ttm/ttm_bo.c | 33 ++++++++++++++----
 include/linux/cgroup_dmem.h  |  4 +--
 kernel/cgroup/dmem.c         | 79 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 103 insertions(+), 13 deletions(-)

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
index 4753a67d0f0f2..29f8c68e92f7f 100644
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
+		if (try_high) {
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


