Return-Path: <cgroups+bounces-14800-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKUpMV/4s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14800-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:43:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEDD282635
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B74B321A3A2
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D736C9E4;
	Fri, 13 Mar 2026 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="fMc0+p79"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855FF2BEFF5
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402047; cv=none; b=eRrr8USLR1+ECr3jghw26y5Slrgqlprofo45oZU4/+PKIny6pXr7g3YzSH2bb9WZf35TO+NfGsFohjyCsU5o0xLr0EzibX15Crvad2bCAuwdeRI5n5jDFjFZpnG8/rdaEH6sDqJHpgxjmXm5pK1Cj8Fk8cfaAKvAhoHLZaYAsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402047; c=relaxed/simple;
	bh=mGx30mQMsCrzmsMGNqzIUP4sLoc2hVMu6Z24Rb0L9/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2kj35pZlKzI1xogCXto5OtzYWWWKf0k8eQ+/ATu6dLvZ77irvP1Dmw9NFyr8OI0UUIlK25YEVcSGwIPoKuimjE19/XRPfJuLCEG6wuxgSFYaSsVKHmmV4khPa7x9aylUCSxczvAenO01fW9js/oPJcHihC5r1COdkzLL2tyAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=fMc0+p79; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773402043; x=1774006843; i=natalie.vock@gmx.de;
	bh=9udnM9I+ivn9SBAxWwTXSZtKlQDggApmwak6kpWBETU=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fMc0+p79wOd7lUDblXKxcQalEutilm+nzm9hnpWrII3kAyfN14CFrbViCiBLHZPP
	 y8IseilGjsJdglAN9q5uk8xu1hYYFcADSRFUXSxdAIaNrBf/P9v8yUgX4AKGJlq3L
	 lPX8sHxH1t6tHMZSdQ67VP23m6/MlVCVfK9SHcObB2T2krfVoRM6EOdiVcNkFqDQz
	 oQ6za+Omq8bgwIkHyDJh/UFbwB4Ta1Ss9QgrABFqLJqv549eqbF1rq/zZc3jEDmhQ
	 JlfgYiyb5RTyWXD7c3Cg57Rq79A1OV4t1aHbry95Y8MiJ9Z3haoJC/h5F6QbUhcWs
	 c+968Nqqj7O+0sPUrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1vsBB52XJI-009jMs; Fri, 13
 Mar 2026 12:40:43 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 13 Mar 2026 12:40:05 +0100
Subject: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and evictee
 as limit pool
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
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
X-Provags-ID: V03:K1:uHi2i89UMEg97Oh4yvRvImaHTaT7/zRdc66Ind5wBqn7S8Tfrwx
 U1qM7R03IQ9v7tEmDwHM8G18g2d7nHjYdJEpWqMY15bk5Z7gpf6g10ueBFLiCyAJo5C7XKt
 475lIifOhbE7I6cfgQr4mCAa3NzzNj+YeOmNFl8rfN5lZDM72eNA6paAPv/1tQ8zKxp6Gy/
 hKndfPfImBX584gJNgVPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Di140pVR5vw=;YCQg3CFLXAUhE+IfrChYE8Lmi1T
 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
 0WcsNuMHslAygZ7f7OiE
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14800-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AEDD282635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When checking whether to skip certain buffers because they're protected
by dmem.low, we're checking the effective protection of the evictee's
cgroup, but depending on how the evictor's cgroup relates to the
evictee's, the semantics of effective protection values change.

When testing against cgroups from different subtrees, page_counter's
recursive protection propagates memory protection afforded to a parent
down to the child cgroups, even if the children were not explicitly
protected. This prevents cgroups whose parents were afforded no
protection from stealing memory from cgroups whose parents were afforded
more protection, without users having to explicitly propagate this
protection.

However, if we always calculate protection from the root cgroup, this
breaks prioritization of sibling cgroups: If one cgroup was explicitly
protected and its siblings were not, the protected cgroup should get
higher priority, i.e. the protected cgroup should be able to steal from
unprotected siblings. This only works if we restrict the protection
calculation to the subtree shared by evictor and evictee.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/ttm/ttm_bo.c | 43 +++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 7300b91b77dd3..df4f4633a3a53 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -628,11 +628,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk=
, struct ttm_buffer_object *
 {
 	struct ttm_bo_evict_walk *evict_walk =3D
 		container_of(walk, typeof(*evict_walk), walk);
+	struct dmem_cgroup_pool_state *limit_pool, *ancestor =3D NULL;
+	bool evict_valuable;
 	s64 lret;
=20
-	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_poo=
l,
-					      bo->resource->css, evict_walk->try_low,
-					      &evict_walk->hit_low))
+	/*
+	 * If may_try_low is not set, then we're trying to evict unprotected
+	 * buffers in favor of a protected allocation for charge_pool. Explicitl=
y skip
+	 * buffers belonging to the same cgroup here - that cgroup is definitely=
 protected,
+	 * even though dmem_cgroup_state_evict_valuable would allow the eviction=
 because a
+	 * cgroup is always allowed to evict from itself even if it is protected=
.
+	 */
+	if (!evict_walk->alloc_state->may_try_low &&
+			bo->resource->css =3D=3D evict_walk->alloc_state->charge_pool)
+		return 0;
+
+	limit_pool =3D evict_walk->alloc_state->limit_pool;
+	/*
+	 * If there is no explicit limit pool, find the root of the shared subtr=
ee between
+	 * evictor and evictee. This is important so that recursive protection r=
ules can
+	 * apply properly: Recursive protection distributes cgroup protection af=
forded
+	 * to a parent cgroup but not used explicitly by a child cgroup between =
all child
+	 * cgroups (see docs of effective_protection in mm/page_counter.c). Howe=
ver, when
+	 * direct siblings compete for memory, siblings that were explicitly pro=
tected
+	 * should get prioritized over siblings that weren't. This only happens =
correctly
+	 * when the root of the shared subtree is passed to
+	 * dmem_cgroup_state_evict_valuable. Otherwise, the effective-protection
+	 * calculation cannot distinguish direct siblings from unrelated subtree=
s and the
+	 * calculated protection ends up wrong.
+	 */
+	if (!limit_pool) {
+		ancestor =3D dmem_cgroup_get_common_ancestor(bo->resource->css,
+							   evict_walk->alloc_state->charge_pool);
+		limit_pool =3D ancestor;
+	}
+
+	evict_valuable =3D dmem_cgroup_state_evict_valuable(limit_pool, bo->reso=
urce->css,
+							  evict_walk->try_low,
+							  &evict_walk->hit_low);
+	if (ancestor)
+		dmem_cgroup_pool_state_put(ancestor);
+
+	if (!evict_valuable)
 		return 0;
=20
 	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk-=
>place))

=2D-=20
2.53.0


