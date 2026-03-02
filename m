Return-Path: <cgroups+bounces-14502-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHDpOYuGpWn4DAYAu9opvQ
	(envelope-from <cgroups+bounces-14502-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:46:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 598161D8FB3
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8337330C4433
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EE7371074;
	Mon,  2 Mar 2026 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="dEIqcqBa"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77C373BF1
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455074; cv=none; b=fj9P4ng9MyvHjx5qnZopYeIW2kgv1ICN1CMZyff7zO+dAMFahhdrmnhz7YwGmQ7iEdXK9JI8H8gbHxGGGpqslSn0OX5vH8bV3DajP8rxcMzIziUbcWCYFZDvNrp+m0u3uK98uPf2V9xTCA0r8es7D7ALQAgcIf9JXkSEZit5Xnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455074; c=relaxed/simple;
	bh=pbl5dYpMRHzk8WHpc92CL/7gvnTi1VPBtVpCqYZ9Ra8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j/ReiS0vjTvqk8dLS0KX0RTt+lW2ub3piSRSKKTZpmJZRs/JG02bz3apn/7kSACrC1D0Ab/1E/VYTUxWv8mhtanPeJZ+FDxWJbbkAeLLjEjxOEdX9so3nzhufYmjVinQQvM1fa0rkXagqeqteW4Rlp3AZCLA4B1gYMxa35PksXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=dEIqcqBa; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772455053; x=1773059853; i=natalie.vock@gmx.de;
	bh=ldnGibj+E4o7b9LoeKe64HOT6hzpmFeBrBmkE4jkwmQ=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dEIqcqBaeENMJcgAaon0Ad1S1H20gQ+0x+aXJhZOHF+Dfj+bjzLHPTCWmd2DJsKp
	 C6NVQWwszYAnvNmUDub1/YCmvP0y/i1YChvWQPzFyJavoz/P+tcp7qY86eu67Mxxq
	 TW2osOW+UJaJtGSwaBVRfgiq+Fbp+nluhZp/RDxQuz2OVs96Wr1oIHHJkZQ0552Ae
	 RZaDOjTnLhgZ86SuYDW+jCF7DIfTlHYcK1NYmVLnWUwo+RmAP3s5iI8x1YnJZbP7H
	 t/0Q4DBkZEh++E1cafH3+Nlo9x/BITTTJQkMiXN6LUP2K/qW/yZKLor5b40GHkghl
	 CAfpBGAE8TUarVB9Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1vJM8T0DlQ-00hImA; Mon, 02
 Mar 2026 13:37:33 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH v5 0/6] cgroup/dmem,drm/ttm: Improve protection in
 contended cases
Date: Mon, 02 Mar 2026 13:37:02 +0100
Message-Id: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTW7CMBAF4KsgrzHy+CchrHqPqotkPGO8CEF2Z
 FGh3L0OUkFsIpZvpPneu4tMKVIWp91dJCoxx+lSg9vvBJ77SyAZfc1CK+1UB076kUYMsg8hUc6
 xkLymaSacpUM2LbfQoh9E/b8m4nh72N8/NZ9jnqf0+6gqsF4/UQtIJTUb48zA6Hv8CuPt4EmsZ
 NFPBtQ2oytjmsZaHizVnW+MeTEAaosx6xromJHRWereGPvPNErrzTW2Mp6Otu0H4+Bon8yyLH8
 7ncCClAEAAA==
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
X-Provags-ID: V03:K1:73Ui7PkiMmywYo0uNrCxGQvQIyQpqw2/QCQYieNULIzR/3ao8PG
 jPGSEM4tIxT7BvUGGNx8rWpcoCK0MxF/nYRtxoyIGhdTpoNKuYY8pbGPkDyXgR8wjJckbKq
 Iga0z4NNn0D4L3WpalYUbul0Jk07I10aa17TDitRH+ftQqCcFzuz52xZIRqOZdJ0tKHKuUh
 tpc40ydNJyZ4QFW/mPeDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AGA481E8ipM=;32WLsYhHdEs853eGrIPYSrqyrf7
 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
 /iF/hizANNMRn3QTtDl8PTijyr4Pt
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14502-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Queue-Id: 598161D8FB3
X-Rspamd-Action: no action

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

 drivers/gpu/drm/ttm/ttm_bo.c       | 214 ++++++++++++++++++++++++++++++++=
=2D----
 drivers/gpu/drm/ttm/ttm_resource.c |  48 ++++++---
 include/drm/ttm/ttm_resource.h     |   6 +-
 include/linux/cgroup.h             |  21 ++++
 include/linux/cgroup_dmem.h        |  25 +++++
 kernel/cgroup/dmem.c               | 105 +++++++++++++++++-
 6 files changed, 374 insertions(+), 45 deletions(-)
=2D--
base-commit: 61c0f69a2ff79c8f388a9e973abb4853be467127
change-id: 20250915-dmemcg-aggressive-protect-5cf37f717cdb

Best regards,
=2D-=20
Natalie Vock <natalie.vock@gmx.de>


