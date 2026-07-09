Return-Path: <cgroups+bounces-17590-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GzpJNWQdT2osawIAu9opvQ
	(envelope-from <cgroups+bounces-17590-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 06:02:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6793472C7C3
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 06:02:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V8pvMtie;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17590-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17590-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EA7730300F1
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB435C183;
	Thu,  9 Jul 2026 04:02:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB932E696
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 04:02:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569729; cv=none; b=AxXUMqGOnAIbY2ibfPXDCDZcXYDxqz/ICUrr4Lf99n5jtwjelDoLMdpKeJ58j4h652BBNuNJ+QOU8pnEmlItyaTzB43PaMZS9q5ktWd+PgEha+7VGjaC2Z8ZzyqJX4sC2fIcLgkW2/+Qb8ClAqQIuCVqZsfGi5MCPmXipdTXTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569729; c=relaxed/simple;
	bh=O999eOVy3mIHjxLa0mOku7daEn7JUY7y/CD4NsLiNDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nyz/lWYBNc99ADna+0vC+fUq2OLVJWZFQU/XSBnfs5J7vqxaHqEXEEP4rM8Kaz+XZSZ3nbxauMTC/nKRk4pe596xok2DXHYULuHGpAJQGb7zFNyyQDxAWKaP210/niNoge3fbX26le0SovZDfPeC3e1zQisggZjUk9fK9IvHaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8pvMtie; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842338c18e0so1265597b3a.1
        for <cgroups@vger.kernel.org>; Wed, 08 Jul 2026 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569727; x=1784174527; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8zdSKyJHGaSQVXICXuU1S4Ua7zP2wyhTHAVBqc1s6N4=;
        b=V8pvMtiemCz3kiZ8pJrUQCllxANOBlHVmgzNJxrrKPua8rtAhHrwAiKWmh+Xw52Xhp
         NgkM+5UgExgrqM7pHB4LzEA0KX9fTuIjLYhckc4n6AS2+Y1DsyKFeoNhmE3A0kCIcYHJ
         5WSqfAOJh0iFXVVlnHeOL8qlWpaiLzlUF3WGepB5BAZtxoBriCuroYIRNlrPOBl74G3g
         T6gCJlxEOQq3/lVLltvpWN5RZfMy2cKBT8AQzvtr9gawwJwa4Q6LPS7dqVw+tKIyshZi
         Hnx1UNApAPqcUwD4UdQdKvahMOQQ6qFDhj46lpP8ZNVffgwWhjRIiUCfgo5JZKhX9XWz
         QWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569727; x=1784174527;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8zdSKyJHGaSQVXICXuU1S4Ua7zP2wyhTHAVBqc1s6N4=;
        b=RpYlvI48Z14YU9FxXPhD22N7GNSTxuePrS/33GQpDNdkJoqohYENCwzKaTTBRPPxJY
         WC+uEL1jyT3cFfT+7WymewmYmzwMs1ERYxcE/g22559qyP144hb5cYefpy7uW8ycgw+g
         sVYJ47BNYCBC+094fngOHi4A2aS33LvKospEVM/KPdAGc38mq2QIQZeRnQBdsT3P6v15
         QpeoS937nRN/f/RLpgZLMTZuopEbLVTME8yQKwI7h/VNyXmVItVm5/CXd62KcdAIn8V1
         h46hznMoubW+PPWUIDXIm7tJNO/vkjY0PVUgnSEv+zTmKq+E5Agmfx4OUR9M7HaYPf2q
         wIjw==
X-Forwarded-Encrypted: i=1; AHgh+RohjYwJDadYfQLUKY9yeOJu/WZSUTR3jPcLnGrkRLIo0oVRAkUGpMMTtOeJNlkzuJDF4/yAmQ3h@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+SldJ04v6Ggac/VwsPPltLH/fAeMcPp2bPvtHR9Wrfg880sD
	7w0JUEF9Rjw9XnyS/h+nTzhvb/7ov/qxebROkYBDJ02/W5XKqBHT8mRy
X-Gm-Gg: AfdE7cki9kzr/fJCzPbjb2AjGVl0pTYgRSIFFmlGM5baBRKLEwGtPNGNs9rhHFqkojV
	ta2w94kPOiGntNLDvlNTeTSo2vZ5T/oM8LwhNw+T+IVGywCghONnucFG1xrAk+rsR1D/G2HVamo
	6bj/+bokR1RqxkEceFCGxJnckjCf0YLsCM/T2cdAZE8gTfYeLAZdzyYP3ogpV0aq4KfiQpy5BnH
	+trliJhwMma+dIeUvrHlrL4jQljxvF4mxtqXiOFl/d+3kT7bUJjOiPGMP2HQsGNcwE15Iv+KVhp
	iL7jDVZuW3gObZ+GztXYYvdKlkvYS96Dqy/wV/U1TsEkVa4AzojZBKAReQUVVPzHTUw82PyoNQM
	WfbRp7BSESZ4zja3g2Ee+pP0PNnehVrHS84jjIMwOTA02dpAfPFh5vEwU3u8q32sBZxXF/G5Uhl
	gw5WJoNSsAy84=
X-Received: by 2002:a05:6a00:4405:b0:845:ebe2:c656 with SMTP id d2e1a72fcca58-84842fec34cmr5532174b3a.47.1783569726713;
        Wed, 08 Jul 2026 21:02:06 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b97bbesm8188838b3a.17.2026.07.08.21.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:02:06 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Thu, 09 Jul 2026 12:02:00 +0800
Subject: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with
 proactive reclaim
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-feature-dmem-high-v7-1-de559e7e7768@gmail.com>
X-B4-Tracking: v=1; b=H4sIADcdT2oC/22NQQ6CMBBFr0Jm7RhapIAr72FYkHZoJ7FAWmw0h
 LtbiUuX7yX//Q0iBaYI12KDQIkjz1OG5lSAdsNkCdlkBllKVdaiw5GG9RkIjSePjq1DobquEZf
 W6KqFvFsCjfw6mvc+s+O4zuF9XCT1tb9aJf7UkkKBsqxVRdooo5ub9QM/znr20O/7/gEIbGJqs
 gAAAA==
To: Christian Koenig <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Natalie Vock <natalie.vock@gmx.de>
Cc: Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-mm@kvack.org, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>, Jing Wu <realwujing@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:natalie.vock@gmx.de,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:yuanql9@chinatelecom.cn,m:realwujing@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17590-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,cmpxchg.org,suse.com,gmx.de];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,lists.freedesktop.org,vger.kernel.org,kvack.org,chinatelecom.cn,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6793472C7C3

The dmem cgroup v2 controller currently only provides a hard "max"
limit, which causes immediate allocation failures when a cgroup's
device memory usage reaches its quota.  GPU-bound AI workloads need
smoother over-subscription support: a soft limit that provides
backpressure through reclaim before the hard limit is reached.

Implement dmem.high as a proper soft limit following the memory.high
semantics: the limit is checked in the charge path on every successful
allocation, and proactive reclaim is triggered when usage crosses the
threshold, rather than waiting for a dmem.max hit to drive eviction.

Expose "high" as a new cgroupfs control file per region via
set_resource_high() and get_resource_high(), initialized to
PAGE_COUNTER_MAX in reset_all_resource_limits().  Like get_resource_max(),
get_resource_high() returns PAGE_COUNTER_MAX when the pool is NULL.

Extend dmem_cgroup_try_charge() with a ret_over_high_pool output
parameter.  On a successful charge, if the pool's usage now exceeds its
dmem.high threshold, ret_over_high_pool is set so the caller can
trigger proactive reclaim.  Propagate this signal through
ttm_resource_alloc() up to ttm_bo_alloc_resource().

Add ttm_bo_proactive_evict_high() in TTM, which walks the LRU and
evicts one BO from the over-limit cgroup (using the existing try_high
logic in dmem_cgroup_state_evict_valuable()).  This is best-effort:
the allocation already succeeded since dmem.high is a soft limit.
A blocking lock is used when a ww_acquire_ctx ticket is available,
trylock otherwise.

Remove the try_high first pass from ttm_bo_evict_alloc(): that pass
tied the interface semantics to a specific eviction ordering detail
rather than a proper soft limit.  Proactive reclaim in the charge
path is the correct place to enforce the soft limit.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
Implement dmem.high as a proper soft limit for the dmem cgroup v2
controller, following memory.high semantics: the limit is checked in
the charge path on every successful allocation, and proactive reclaim
is triggered when usage crosses the threshold.

The dmem cgroup currently only supports a hard "max" limit, which causes
allocation failures for GPU-bound workloads.  A soft limit enables
smoother over-subscription by providing backpressure through reclaim
before the hard limit is reached.

The implementation extends dmem_cgroup_try_charge() with a
ret_over_high_pool output parameter that signals callers when a
successful charge pushes usage above the dmem.high threshold.
ttm_resource_alloc() propagates this signal up to
ttm_bo_alloc_resource(), where ttm_bo_proactive_evict_high() evicts
one BO from the over-limit cgroup on a best-effort basis.
---
V6 -> V7:
- Replace prioritized eviction (eviction-time ordering) with proactive
  reclaim (charge-time enforcement): dmem.high is now checked in
  dmem_cgroup_try_charge() on every successful allocation, matching
  memory.high semantics as requested by Tejun Heo.
- Add ret_over_high_pool output parameter to dmem_cgroup_try_charge()
  to signal callers when a successful charge crosses the high threshold.
- Add ttm_bo_proactive_evict_high() to evict one BO from the over-limit
  cgroup on each allocation that crosses dmem.high (best-effort; the
  allocation already succeeded since dmem.high is a soft limit).
- Remove the try_high first pass from ttm_bo_evict_alloc(): the high
  limit is no longer enforced via eviction ordering in the max path.
- Propagate ret_over_high_pool through ttm_resource_alloc() and update
  all callers (including TTM test files) to pass the new parameter.
- Add Michal Hocko, Roman Gushchin, Shakeel Butt, Muchun Song to Cc
  per Tejun's request for memcg input on soft limit semantics.

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
- Remove task throttling entirely.
- Add dmem.high cgroupfs control file per region.
- Extend dmem_cgroup_state_evict_valuable() with try_high parameter.
- Refactor ttm_bo_evict_alloc() into a 3-pass eviction strategy.
- Initialize high to PAGE_COUNTER_MAX in reset_all_resource_limits().

v6: https://lore.kernel.org/r/20260531-feature-dmem-high-v6-1-20563ecd6dc7@gmail.com
v5: https://lore.kernel.org/r/20260531-feature-dmem-high-v5-1-1c6c532b26a9@gmail.com
v4: https://lore.kernel.org/r/20260530-feature-dmem-high-v4-1-ee7c6ec1c8da@gmail.com
v3: https://lore.kernel.org/r/20260528-feature-dmem-high-v3-1-c642b34bcb2f@gmail.com
v2: https://lore.kernel.org/r/20260522-feature-dmem-high-v2-1-1d7d4a0fa5da@gmail.com
v1: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c          |  18 ++--
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   4 +-
 drivers/gpu/drm/ttm/tests/ttm_resource_test.c    |   2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                     |  60 ++++++++++---
 drivers/gpu/drm/ttm/ttm_resource.c               |   8 +-
 include/drm/ttm/ttm_resource.h                   |   3 +-
 include/linux/cgroup_dmem.h                      |  15 +++-
 kernel/cgroup/dmem.c                             | 104 +++++++++++++++++++++--
 8 files changed, 179 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index f3103307b5df9..7a03f6a04f4e8 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -258,13 +258,13 @@ static void ttm_bo_unreserve_basic(struct kunit *test)
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 	bo->priority = bo_prio;
 
-	err = ttm_resource_alloc(bo, place, &res1, NULL);
+	err = ttm_resource_alloc(bo, place, &res1, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	bo->resource = res1;
 
 	/* Add a dummy resource to populate LRU */
-	ttm_resource_alloc(bo, place, &res2, NULL);
+	ttm_resource_alloc(bo, place, &res2, NULL, NULL);
 
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_unreserve(bo);
@@ -300,12 +300,12 @@ static void ttm_bo_unreserve_pinned(struct kunit *test)
 	dma_resv_lock(bo->base.resv, NULL);
 	ttm_bo_pin(bo);
 
-	err = ttm_resource_alloc(bo, place, &res1, NULL);
+	err = ttm_resource_alloc(bo, place, &res1, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res1;
 
 	/* Add a dummy resource to the pinned list */
-	err = ttm_resource_alloc(bo, place, &res2, NULL);
+	err = ttm_resource_alloc(bo, place, &res2, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	KUNIT_ASSERT_EQ(test,
 			list_is_last(&res2->lru.link, &priv->ttm_dev->unevictable), 1);
@@ -355,7 +355,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	ttm_bo_set_bulk_move(bo1, &lru_bulk_move);
 	dma_resv_unlock(bo1->base.resv);
 
-	err = ttm_resource_alloc(bo1, place, &res1, NULL);
+	err = ttm_resource_alloc(bo1, place, &res1, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo1->resource = res1;
 
@@ -363,7 +363,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	ttm_bo_set_bulk_move(bo2, &lru_bulk_move);
 	dma_resv_unlock(bo2->base.resv);
 
-	err = ttm_resource_alloc(bo2, place, &res2, NULL);
+	err = ttm_resource_alloc(bo2, place, &res2, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo2->resource = res2;
 
@@ -401,7 +401,7 @@ static void ttm_bo_fini_basic(struct kunit *test)
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 	bo->type = ttm_bo_type_device;
 
-	err = ttm_resource_alloc(bo, place, &res, NULL);
+	err = ttm_resource_alloc(bo, place, &res, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res;
 
@@ -518,7 +518,7 @@ static void ttm_bo_pin_unpin_resource(struct kunit *test)
 
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 
-	err = ttm_resource_alloc(bo, place, &res, NULL);
+	err = ttm_resource_alloc(bo, place, &res, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res;
 
@@ -569,7 +569,7 @@ static void ttm_bo_multiple_pin_one_unpin(struct kunit *test)
 
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
 
-	err = ttm_resource_alloc(bo, place, &res, NULL);
+	err = ttm_resource_alloc(bo, place, &res, NULL, NULL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	bo->resource = res;
 
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index 2db221f6fc3a1..cd40f5b2ab4f1 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -547,7 +547,7 @@ static void ttm_bo_validate_no_placement_signaled(struct kunit *test)
 
 	ttm_bo_reserve(bo, false, false, NULL);
 
-	err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
+	err = ttm_resource_alloc(bo, place, &bo->resource, NULL, NULL);
 	KUNIT_EXPECT_EQ(test, err, 0);
 	KUNIT_ASSERT_EQ(test, man->usage, size);
 
@@ -604,7 +604,7 @@ static void ttm_bo_validate_no_placement_not_signaled(struct kunit *test)
 	bo = ttm_bo_kunit_init(test, test->priv, size, NULL);
 	bo->type = params->bo_type;
 
-	err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
+	err = ttm_resource_alloc(bo, place, &bo->resource, NULL, NULL);
 	KUNIT_EXPECT_EQ(test, err, 0);
 
 	placement = kunit_kzalloc(test, sizeof(*placement), GFP_KERNEL);
diff --git a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
index c0e4e35e04426..41fe4d89cd714 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
@@ -303,7 +303,7 @@ static void ttm_sys_man_free_basic(struct kunit *test)
 	res = kunit_kzalloc(test, sizeof(*res), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, res);
 
-	ttm_resource_alloc(bo, place, &res, NULL);
+	ttm_resource_alloc(bo, place, &res, NULL, NULL);
 
 	man = ttm_manager_type(priv->devs->ttm_dev, mem_type);
 	man->func->free(man, res);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f02..bdfcfe5c7d1e2 100644
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
@@ -538,7 +541,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 	evict_walk->evicted++;
 	if (evict_walk->res)
 		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
-					  evict_walk->res, NULL);
+					  evict_walk->res, NULL, NULL);
 	if (lret == 0)
 		return 1;
 out:
@@ -553,6 +556,38 @@ static const struct ttm_lru_walk_ops ttm_evict_walk_ops = {
 	.process_bo = ttm_bo_evict_cb,
 };
 
+/*
+ * Proactive reclaim: evict one BO from a cgroup that exceeds its dmem.high
+ * soft limit.  Called after a successful charge that pushed usage over the
+ * high threshold.  Best-effort; allocation already succeeded (soft limit).
+ */
+static void ttm_bo_proactive_evict_high(struct ttm_device *bdev,
+					struct ttm_resource_manager *man,
+					const struct ttm_place *place,
+					struct ttm_buffer_object *evictor,
+					struct ttm_operation_ctx *ctx,
+					struct ww_acquire_ctx *ticket,
+					struct dmem_cgroup_pool_state *over_high_pool)
+{
+	struct ttm_bo_evict_walk evict_walk = {
+		.walk = {
+			.ops = &ttm_evict_walk_ops,
+			.arg = {
+				.ctx = ctx,
+				.ticket = ticket,
+				.trylock_only = !ticket,
+			}
+		},
+		.place = place,
+		.evictor = evictor,
+		.res = NULL,
+		.limit_pool = over_high_pool,
+		.try_high = true,
+	};
+
+	ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
+}
+
 static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 			      struct ttm_resource_manager *man,
 			      const struct ttm_place *place,
@@ -579,29 +614,24 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 
 	evict_walk.walk.arg.trylock_only = true;
 	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
-
-	/* One more attempt if we hit low limit? */
 	if (!lret && evict_walk.hit_low) {
 		evict_walk.try_low = true;
 		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	}
+
 	if (lret || !ticket)
 		goto out;
 
-	/* Reset low limit */
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
@@ -737,7 +767,17 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
 			continue;
 
 		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
-		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
+		{
+			struct dmem_cgroup_pool_state *over_high_pool = NULL;
+
+			ret = ttm_resource_alloc(bo, place, res,
+						 force_space ? &limit_pool : NULL,
+						 &over_high_pool);
+			if (!ret && over_high_pool)
+				ttm_bo_proactive_evict_high(bdev, man, place, bo,
+							    ctx, ticket, over_high_pool);
+			dmem_cgroup_pool_state_put(over_high_pool);
+		}
 		if (ret) {
 			if (ret != -ENOSPC) {
 				dmem_cgroup_pool_state_put(limit_pool);
@@ -1152,7 +1192,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 		memset(&hop, 0, sizeof(hop));
 		place.mem_type = TTM_PL_SYSTEM;
-		ret = ttm_resource_alloc(bo, &place, &evict_mem, NULL);
+		ret = ttm_resource_alloc(bo, &place, &evict_mem, NULL, NULL);
 		if (ret)
 			goto out;
 
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 154d6739256f8..e6ad46d9ff181 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -389,7 +389,8 @@ EXPORT_SYMBOL(ttm_resource_fini);
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res_ptr,
-		       struct dmem_cgroup_pool_state **ret_limit_pool)
+		       struct dmem_cgroup_pool_state **ret_limit_pool,
+		       struct dmem_cgroup_pool_state **ret_over_high_pool)
 {
 	struct ttm_resource_manager *man =
 		ttm_manager_type(bo->bdev, place->mem_type);
@@ -397,7 +398,8 @@ int ttm_resource_alloc(struct ttm_buffer_object *bo,
 	int ret;
 
 	if (man->cg) {
-		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
+		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool,
+					     ret_limit_pool, ret_over_high_pool);
 		if (ret) {
 			if (ret == -EAGAIN)
 				ret = -ENOSPC;
@@ -409,6 +411,8 @@ int ttm_resource_alloc(struct ttm_buffer_object *bo,
 	if (ret) {
 		if (pool)
 			dmem_cgroup_uncharge(pool, bo->base.size);
+		if (ret_over_high_pool)
+			dmem_cgroup_pool_state_put(*ret_over_high_pool);
 		return ret;
 	}
 
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index a5d386583fb6e..88fb402acfdc6 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -461,7 +461,8 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res,
-		       struct dmem_cgroup_pool_state **ret_limit_pool);
+		       struct dmem_cgroup_pool_state **ret_limit_pool,
+		       struct dmem_cgroup_pool_state **ret_over_high_pool);
 void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res);
 bool ttm_resource_intersects(struct ttm_device *bdev,
 			     struct ttm_resource *res,
diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736e..1808bfbbc9a31 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -19,11 +19,12 @@ struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *nam
 void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region);
 int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 			   struct dmem_cgroup_pool_state **ret_pool,
-			   struct dmem_cgroup_pool_state **ret_limit_pool);
+			   struct dmem_cgroup_pool_state **ret_limit_pool,
+			   struct dmem_cgroup_pool_state **ret_over_high_pool);
 void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
-				      bool ignore_low, bool *ret_hit_low);
+				      bool try_high, bool ignore_low, bool *ret_hit_low);
 
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
 #else
@@ -38,13 +39,17 @@ static inline void dmem_cgroup_unregister_region(struct dmem_cgroup_region *regi
 
 static inline int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 					 struct dmem_cgroup_pool_state **ret_pool,
-					 struct dmem_cgroup_pool_state **ret_limit_pool)
+					 struct dmem_cgroup_pool_state **ret_limit_pool,
+					 struct dmem_cgroup_pool_state **ret_over_high_pool)
 {
 	*ret_pool = NULL;
 
 	if (ret_limit_pool)
 		*ret_limit_pool = NULL;
 
+	if (ret_over_high_pool)
+		*ret_over_high_pool = NULL;
+
 	return 0;
 }
 
@@ -54,8 +59,10 @@ static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64
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
index 4753a67d0f0f2..b322c8a7e2a67 100644
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
@@ -634,8 +688,9 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
  * dmem_cgroup_try_charge() - Try charging a new allocation to a region.
  * @region: dmem region to charge
  * @size: Size (in bytes) to charge.
- * @ret_pool: On succesfull allocation, the pool that is charged.
+ * @ret_pool: On successful allocation, the pool that is charged.
  * @ret_limit_pool: On a failed allocation, the limiting pool.
+ * @ret_over_high_pool: On successful allocation, set if usage exceeds dmem.high.
  *
  * This function charges the @region region for a size of @size bytes.
  *
@@ -647,11 +702,17 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
  * eviction as argument to dmem_cgroup_evict_valuable(). This reference must be freed
  * with @dmem_cgroup_pool_state_put().
  *
+ * When the function succeeds and @ret_over_high_pool is non-null, it will be
+ * set if the charged pool's usage now exceeds its dmem.high soft limit. The
+ * caller should trigger proactive eviction to bring usage back under the limit.
+ * This reference must be freed with @dmem_cgroup_pool_state_put().
+ *
  * Return: 0 on success, -EAGAIN on hitting a limit, or a negative errno on failure.
  */
 int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 			  struct dmem_cgroup_pool_state **ret_pool,
-			  struct dmem_cgroup_pool_state **ret_limit_pool)
+			  struct dmem_cgroup_pool_state **ret_limit_pool,
+			  struct dmem_cgroup_pool_state **ret_over_high_pool)
 {
 	struct dmemcg_state *cg;
 	struct dmem_cgroup_pool_state *pool;
@@ -661,6 +722,8 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	*ret_pool = NULL;
 	if (ret_limit_pool)
 		*ret_limit_pool = NULL;
+	if (ret_over_high_pool)
+		*ret_over_high_pool = NULL;
 
 	/*
 	 * hold on to css, as cgroup can be removed but resource
@@ -685,6 +748,18 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 		goto err;
 	}
 
+	/*
+	 * Charge succeeded. Check if usage now exceeds the soft high limit so
+	 * the caller can trigger proactive reclaim to bring the cgroup back
+	 * under its dmem.high threshold.
+	 */
+	if (ret_over_high_pool &&
+	    page_counter_read(&pool->cnt) > READ_ONCE(pool->cnt.high)) {
+		*ret_over_high_pool = pool;
+		css_get(&pool->cs->css);
+		dmemcg_pool_get(*ret_over_high_pool);
+	}
+
 	/* On success, reference from get_current_dmemcs is transferred to *ret_pool */
 	*ret_pool = pool;
 	return 0;
@@ -835,6 +910,17 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
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
@@ -868,6 +954,12 @@ static struct cftype files[] = {
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
Jing Wu <realwujing@gmail.com>


