Return-Path: <cgroups+bounces-14801-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CfwIc33s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14801-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:41:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E22825BE
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44B7F3033BCA
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07049378D9D;
	Fri, 13 Mar 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="Qt4Eara5"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AD36896F
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402052; cv=none; b=QQuYRk5CfI7m/kpVYaA5MKqOuSz/i4pLgzBWNxse6FZwFqcNr4ixZ23oIjuSkXZZRivRpGHNOFRayrSh2Wd/vq2lPIXBDGhyt/aZvh6lsZ5WQxzN75Xe80CG1WSlbPMdWyXEhpBfXYD3MqIAoZE3J0zhLKQ2NNC4Ydj1xWbqFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402052; c=relaxed/simple;
	bh=ak99usl48W7qDvWPBnxP/abytl0e6IbeW62WgWAs2cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDxwM83qWuIg6UvvVA4VbyH6g/qyXL8s+GNz4AHrXULU2iGwBkbTmbUymrEyCOV3vKrrw+qZBw+D3im28ybxh4Z86w5BPFznuz1dTP3oh8IjJAA/G6Gp0acUhVrz+/RBdGMUqdsmJ66RnHUvbljtUjMjCIRFSctQJMcN1qs52P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=Qt4Eara5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773402042; x=1774006842; i=natalie.vock@gmx.de;
	bh=vFoTznpU+jRmVuPPlKYFzgVAdbUOjxVq1sifROCcWzk=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qt4Eara5d0b3RhgTdtW/tOkn/2I3KPcDOMev4v/bA2M/RF/PJtLW6Jofw68w1t4c
	 hdRBtRnhRVg8KYy0AWjtSxl9Y1OHVaJ5HVqwhKuFod3Hj95icBgWbTsjjWZsKmRkQ
	 Um0DHw6BvnhZ5UxB7wqq4EFZ0sxKOSRkfxQ1WscBHW3p2jKTokCKTelgImOB8FxDL
	 BA3DitKn/pcJgzHi/HfnubPikDQUP/810vmO5I/IR521cy9KQ4zVXiIasKn55trtz
	 OUsty16GXkkFF3/Huu0JAM/Y1I1Ob7n90vfa07n0rdziwiBIr9dtym+sHsF3HWz5c
	 zcjbxdc/dQcceyM6KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1vPjiX2rK3-00h8Ib; Fri, 13
 Mar 2026 12:40:42 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 13 Mar 2026 12:40:04 +0100
Subject: [PATCH v6 5/6] drm/ttm: Be more aggressive when allocating below
 protection limit
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260313-dmemcg-aggressive-protect-v6-5-7c71cc1492db@gmx.de>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Natalie Vock <natalie.vock@gmx.de>
X-Mailer: b4 0.14.3
X-Provags-ID: V03:K1:Iry6dy++vs+OFI97Ke3fhLrhKHSC09N+T64oOewzM2PpMzn61iC
 TAv5rkKnMO0COdrThIMaw/CStL2em9c2FcymtUWPKkGP8sFM6LuP0jTxLedfCNJgTRTe/5F
 Uvby05kS6M3Sn9gUQh8Uma6p3bY3Mt8MBRYXpNnjPRIlV8AzxmyXAVAYRsdRpMsndrdzUf6
 GOrj4DW1HqvOZsTd2laaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n6Tv+BtBmF8=;8E6VxIhSnco+L3Pvu4x2pHx4RMc
 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
 69ao/POo3tjXWRWVJgsrx1i8heomPfWZg==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14801-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: 868E22825BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the cgroup's memory usage is below the low/min limit and allocation
fails, try evicting some unprotected buffers to make space. Otherwise,
application buffers may be forced to go into GTT even though usage is
below the corresponding low/min limit, if other applications filled VRAM
with their allocations first.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/ttm/ttm_bo.c | 51 +++++++++++++++++++++++++++++++++++++++=
++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 4adc9b80cba4a..7300b91b77dd3 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -496,6 +496,10 @@ struct ttm_bo_alloc_state {
 	struct dmem_cgroup_pool_state *limit_pool;
 	/** @in_evict: Whether we are currently evicting buffers */
 	bool in_evict;
+	/** @may_try_low: If only unprotected BOs, i.e. BOs whose cgroup
+	 *  is exceeding its dmem low/min protection, should be considered for e=
viction
+	 */
+	bool may_try_low;
 };
=20
 /**
@@ -545,6 +549,42 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_ob=
ject *bo,
 		}
 	}
=20
+	/*
+	 * cgroup protection plays a special role in eviction.
+	 * Conceptually, protection of memory via the dmem cgroup controller
+	 * entitles the protected cgroup to use a certain amount of memory.
+	 * There are two types of protection - the 'low' limit is a
+	 * "best-effort" protection, whereas the 'min' limit provides a hard
+	 * guarantee that memory within the cgroup's allowance will not be
+	 * evicted under any circumstance.
+	 *
+	 * To faithfully model this concept in TTM, we also need to take cgroup
+	 * protection into account when allocating. When allocation in one
+	 * place fails, TTM will default to trying other places first before
+	 * evicting.
+	 * If the allocation is covered by dmem cgroup protection, however,
+	 * this prevents the allocation from using the memory it is "entitled"
+	 * to. To make sure unprotected allocations cannot push new protected
+	 * allocations out of places they are "entitled" to use, we should
+	 * evict buffers not covered by any cgroup protection, if this
+	 * allocation is covered by cgroup protection.
+	 *
+	 * Buffers covered by 'min' protection are a special case - the 'min'
+	 * limit is a stronger guarantee than 'low', and thus buffers protected
+	 * by 'low' but not 'min' should also be considered for eviction.
+	 * Buffers protected by 'min' will never be considered for eviction
+	 * anyway, so the regular eviction path should be triggered here.
+	 * Buffers protected by 'low' but not 'min' will take a special
+	 * eviction path that only evicts buffers covered by neither 'low' or
+	 * 'min' protections.
+	 */
+	if (!alloc_state->in_evict) {
+		may_evict |=3D dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
+		alloc_state->may_try_low =3D may_evict;
+
+		may_evict |=3D dmem_cgroup_below_low(NULL, alloc_state->charge_pool);
+	}
+
 	ret =3D ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
 	if (ret) {
 		if (ret =3D=3D -ENOSPC && may_evict)
@@ -657,8 +697,12 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev=
,
 	evict_walk.walk.arg.trylock_only =3D true;
 	lret =3D ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
=20
-	/* One more attempt if we hit low limit? */
-	if (!lret && evict_walk.hit_low) {
+	/* If we failed to find enough BOs to evict, but we skipped over
+	 * some BOs because they were covered by dmem low protection, retry
+	 * evicting these protected BOs too, except if we're told not to
+	 * consider protected BOs at all.
+	 */
+	if (!lret && evict_walk.hit_low && state->may_try_low) {
 		evict_walk.try_low =3D true;
 		lret =3D ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	}
@@ -679,7 +723,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	} while (!lret && evict_walk.evicted);
=20
 	/* We hit the low limit? Try once more */
-	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
+	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
+			state->may_try_low) {
 		evict_walk.try_low =3D true;
 		goto retry;
 	}

=2D-=20
2.53.0


