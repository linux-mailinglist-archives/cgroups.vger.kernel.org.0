Return-Path: <cgroups+bounces-14803-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOz4DMv3s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14803-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D152825B0
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33F1C3049E27
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B737FF7B;
	Fri, 13 Mar 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="jCi59vlK"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9637F8CF
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402056; cv=none; b=jfybxe/dbcJs1GViTApAtBcvSn2+Pmya81c7w9x63i7pfNCnGGua/SHT66d7+IwKqelgmXt0V+QQE1cmomYzYTlJOzgTmiP2bTj2CfJhlpKCiLWGAdGoSaT0Eh5AhaKmo9PEhnQqy3otly9tgyXwwId+T6OEROjG9VP+ifA1H94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402056; c=relaxed/simple;
	bh=rL4Q0seXOy3FZhFZ6gO155s00+tDKXQjFwLihBEVwLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J/Rd+raPLsKbHd6NHjwyyfS/veR0O5bIXtCOVUju/RDachKY1DQzoER3DPHTF4oOD01BZGBRw2QfYGenVhQ/Eu80MaFGNb/slNEpIVZMivNTqwTy5f/R9LVmg8JuYQttYC5cEP9YNumxcdcLNu+l20UxqTL5g9o7dtLFcL1C4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=jCi59vlK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773402037; x=1774006837; i=natalie.vock@gmx.de;
	bh=V5jXNwTzO8SwdIW86kQH9un7ZTFbFBnER2KXe6QJn+0=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jCi59vlKcxNplrmcHABxTy5EWctYWlSjRhIXs2uRRCjwGYS9fLdcl13lYSRq/rYA
	 GoJKNPwWlhUIk4S6rbAOPOQKGGFuJ9vYuEJGCSw6bxOGkYn92Nl3YWKwP+Te6jJ+N
	 wGXbRNc9ZCVCeYGl1rB3xC6vE60MOupG2DG5KkB9DFLesGi3AtazCDct/VkU/ycuT
	 kuuC4U8YCXUYUNDNRr3egtZ6kmPc25bjCUPlY9rvRyBBP35lg2hrlkfO3HyvAoMsl
	 B8NpMZQ/V8EKdxv9PZJls1RTU/oRfybHfGW2jFsIEw6BRCR0OQEw852085Y/h1SeI
	 iKdrKc61rUVKdScIUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1wB5dm37gx-00SdnZ; Fri, 13
 Mar 2026 12:40:37 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH v6 0/6] cgroup/dmem,drm/ttm: Improve protection in
 contended cases
Date: Fri, 13 Mar 2026 12:39:59 +0100
Message-Id: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwYrDIBAG4FcpnmtRR5Omp32PZQ9GZ6yHNEWDd
 Cl59zWFbcgl9PgPzPf/T5YxRczscniyhCXmON5qaI4H5q72FpBHXzNTQhnRScP9gIML3IaQMOd
 YkN/TOKGbuHEELbWydb5n9f+ekOLjZX//1HyNeRrT76uqyOX6iVokF1wRgIGenLfuKwyPk0e2k
 EW9GSn2GVUZaBqtqddYd24YWBkpxR4DyxrZETlyRmO3YfQ/0wildtfoyng869b2YORZbxizMiD
 UHmMqQ+TBLo0g1jXzPP8BKJsKFtsBAAA=
X-Change-ID: 20250915-dmemcg-aggressive-protect-5cf37f717cdb
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
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
X-Mailer: b4 0.14.3
X-Provags-ID: V03:K1:27zh/WjwvHpNmgS6dRdTuin58lB4RNc7DsxrkFRDMg9Q6VSo6Oy
 fibPumEEmc22nsETZyqz7/ZWHtkgd8yrqIOlsjYmVbuhqF7Jzdg5xEdHFf4g5MVAirEA/G4
 zDoO9DwWoYcaAOvsonAx5VBcxDRnhy5SDB8Er9cOV/ktaHP6tp7UzefPkuouQ4XMcCBUX84
 z5TTKNP6gn0hZUv9pMC6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ruzj3eLyNBY=;kmyLs/948s6xvG0m+wbi7RfH6Yx
 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
 mM7OkHssBOJXAtTbyhU2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14803-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmx.de,igalia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: C3D152825B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I've been looking into some cases where dmem protection fails to prevent
allocations from ending up in GTT when VRAM gets scarce and apps start
competing hard.

In short, this is because other (unprotected) applications end up
filling VRAM before protected applications do. This causes TTM to back
off and try allocating in GTT before anything else, and that is where
the allocation is placed in the end. The existing eviction protection
cannot prevent this, because no attempt at evicting is ever made
(although you could consider the backing-off as an immediate eviction to
GTT).

This series tries to alleviate this by adding a special case when the
allocation is protected by cgroups: Instead of backing off immediately,
TTM will try evicting unprotected buffers from the domain to make space
for the protected one. This ensures that applications can actually use
all the memory protection awarded to them by the system, without being
prone to ping-ponging (only protected allocations can evict unprotected
ones, never the other way around).

The first two patches just add a few small utilities needed to implement
this to the dmem controller. The other patches are the TTM implementation:

"drm/ttm: Be more aggressive..." decouples cgroup charging from resource
allocation to allow us to hold on to the charge even if allocation fails
on first try, and adds a path to call ttm_bo_evict_alloc when the
charged allocation falls within min/low protection limits.

"drm/ttm: Use common ancestor..." is a more general improvement in
correctly implementing cgroup protection semantics. With recursive
protection rules, unused memory protection afforded to a parent node is
transferred to children recursively, which helps protect entire
subtrees from stealing each others' memory without needing to protect
each cgroup individually. This doesn't apply when considering direct
siblings inside the same subtree, so in order to not break
prioritization between these siblings, we need to consider the
relationship of evictor and evictee when calculating protection.
In practice, this fixes cases where a protected cgroup cannot steal
memory from unprotected siblings (which, in turn, leads to eviction
failures and new allocations being placed in GTT).

Thanks,
Natalie

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
Changes in v6:
- Rename dmem_cgroup_common_ancestor to dmem_cgroup_get_common_ancestor
  (Maarten)
- Use ttm_bo_alloc_at_place in eviction cb as well (Tvrtko)
- Clean up the more aggressive eviction logic (Tvrtko)
- Link to v5: https://lore.kernel.org/r/20260302-dmemcg-aggressive-protect=
-v5-0-ffd3a2602309@gmx.de

Changes in v5:
- Added cgroup_common_ancestor helper to use with
  dmem_cgroup_common_ancestor (Tejun)
- Note: "drm/ttm: Use common ancestor..." needed minor changes since
  dmem_cgroup_common_ancestor now grabs a reference to the ancestor
  pool which needs to be dropped after use
- Removed extraneous whitespaces in "drm/ttm: Split cgroup charge..."
  and unnecessary changes done in "drm/ttm: Extract code..." (Tvrtko)
- Applied a comment from v3 about below_low not needing to be
  initialized in "drm/ttm: Be more aggressive..." (Tvrtko)
- Fixed uncharging the cgroup on allocation failure (Tvrtko)
- Fixed a typo in the message of "drm/ttm: Split cgroup charge..."
  (Tvrtko)
- Added case in ttm_bo_evict_cb for when charging fails, since we need
  to retry the charge (found myself)
- Link to v4: https://lore.kernel.org/r/20260225-dmemcg-aggressive-protect=
-v4-0-de847ab35184@gmx.de

Changes in v4:
- Split cgroup charge decoupling and eviction logic changes into
  separate commits (Tvrtko)
- Fix two cases of errno handling in ttm_bo_alloc_place and its caller
  (Tvrtko)
- Improve commit message/description of "drm/ttm: Make a helper..." (now
  "drm/ttm: Extract code...") (Tvrtko)
- Documentation improvements for new TTM eviction logic (Tvrtko)
- Formatting fixes (Tvrtko)
- Link to v3: https://lore.kernel.org/r/20251110-dmemcg-aggressive-protect=
-v3-0-219ffcfc54e9@gmx.de

Changes in v3:
- Improved documentation around cgroup queries and TTM eviction helpers
  (Maarten)
- Fixed up ttm_alloc_at_place charge failure logic to return either
  -EBUSY or -ENOSPC, not -EAGAIN (found this myself)
- Link to v2: https://lore.kernel.org/r/20251015-dmemcg-aggressive-protect=
-v2-0-36644fb4e37f@gmx.de

Changes in v2:
- Factored out the ttm logic for charging/allocating/evicting into a
  separate helper to keep things simpler
- Link to v1: https://lore.kernel.org/r/20250915-dmemcg-aggressive-protect=
-v1-0-2f3353bfcdac@gmx.de

=2D--
Natalie Vock (6):
      cgroup/dmem: Add queries for protection values
      cgroup,cgroup/dmem: Add (dmem_)cgroup_common_ancestor helper
      drm/ttm: Extract code for attempting allocation in a place
      drm/ttm: Split cgroup charge and resource allocation
      drm/ttm: Be more aggressive when allocating below protection limit
      drm/ttm: Use common ancestor of evictor and evictee as limit pool

 drivers/gpu/drm/ttm/ttm_bo.c       | 221 ++++++++++++++++++++++++++++++++=
=2D----
 drivers/gpu/drm/ttm/ttm_resource.c |  48 +++++---
 include/drm/ttm/ttm_resource.h     |   6 +-
 include/linux/cgroup.h             |  21 ++++
 include/linux/cgroup_dmem.h        |  25 +++++
 kernel/cgroup/dmem.c               |  90 +++++++++++++++
 6 files changed, 368 insertions(+), 43 deletions(-)
=2D--
base-commit: 61c0f69a2ff79c8f388a9e973abb4853be467127
change-id: 20250915-dmemcg-aggressive-protect-5cf37f717cdb

Best regards,
=2D-=20
Natalie Vock <natalie.vock@gmx.de>


