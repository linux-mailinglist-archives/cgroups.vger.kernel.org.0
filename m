Return-Path: <cgroups+bounces-10780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC9BDEDFB
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 15:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9B254F49E2
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863220E029;
	Wed, 15 Oct 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="W6pZJYuu"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739C23BD1D
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536691; cv=none; b=RhYgobqNzECEE1pVAUOqEpNPzn8H6vs8J6CG11ullSh4mIUHSrKuxk6p7f6Zmth3SU3TjR4k/wVn/xm9cySqCDNmh1B1HxMkJxjYWPGTsIFYIl5EH4GvfdAvhAGUWPThGCoOlDa2j6PjIuD8LECiReGALs+/zmReqJpifK8pcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536691; c=relaxed/simple;
	bh=IAC1kbu9p9T3B31eCOUYiL6+CWNFn1elrybMZ3YGc54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z2T9ZuB+Dol5u3Rue7KWwL72HsuMUUCnbmTWlhYQPW/uhx7yqvx5tpBaOQvIp6PPL+5m7jMsVJdtPYEPI5YJ8DHO4ErxznSLXfPFiY8BDS6r2tqelkGQM11XQHATZ/CZbq1T12DTrnFerOIC/VDnTV8kozuo67cDU5kFE/DdrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=W6pZJYuu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760536670; x=1761141470; i=natalie.vock@gmx.de;
	bh=XOuZcXyIp3/53q/5u2NeWtvU5bkFV4TO99WTVHyFobE=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W6pZJYuuH1K+M5Xoc+YSp1Oo3QN15dktGmc4tK8zZbd/pbKH4XSumJaqKVM2yAOZ
	 VxNowHwbW7eOXYti4hZzml32fFJEmNiMoLSN2NNx8+H7CokIWt32Ho0vSo4NW47f0
	 xohneCUTdaXLCPpGJEiolv9M8gO0coaT/crJ8cFgFAwNcCtrWC3aLD/LUfRqVWpJf
	 P+fv33uYqPK3KrM7JzbyMZKd1XdvDhLf3YniI+Zqo9HUbFtVmAw4klveM06tenZjb
	 GRTa8oQfnm5aaG7XebRXy1nzd5TVNDgf2YepRgSRBREOeUGMbK4XW+qUs3HjrBwuA
	 XbAYblzoTuc6ci69ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1uLUHy21n2-00sm30; Wed, 15
 Oct 2025 15:57:50 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH v2 0/5] cgroup/dmem,drm/ttm: Improve protection in
 contended cases
Date: Wed, 15 Oct 2025 15:57:27 +0200
Message-Id: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAEeo72gC/42NTQrDIBBGrxJm3SlRkdCueo+SRTKOZhb5QUVSQ
 u5emxN0+R587zsgcRRO8GwOiFwkybpU0LcGaBqWwCiuMuhW2/ahLLqZZwo4hBA5JSmMW1wzU0Z
 L3nS+Ux25Eep+i+xlv9rvvvIkKa/xc10V9bP/VIvCFrU3xprRkxvoFeb97hj68zy/6uZZg78AA
 AA=
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
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Provags-ID: V03:K1:zN3Oi2L89i57JQRq1YnG+3afvBL30CfNVISujfbxehkWOD5PA1U
 ZbfvxrwFNBvRbGuys5BsMYclAmtGzoWFcYS1Bbh+zRtkf32t8SPChdPCSYRJ5J5Xe0L0apM
 x/hXCNRTnt/IHZWIOs8GDMbVVqz1mGa6fEnInitPRd6IWrX6NFZrlFrZU/aEKPmg/I7n/YQ
 H9Bv+y+qBeggt5B7SglSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HDWEgEb8nUY=;TvpD1jpPg9PnI4E3qd09b/SThBy
 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

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
this to the dmem controller. The second two patches are the TTM
implementation:

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
Changes in v2:
- Factored out the ttm logic for charging/allocating/evicting into a
  separate helper to keep things simpler
- Link to v1: https://lore.kernel.org/r/20250915-dmemcg-aggressive-protect=
-v1-0-2f3353bfcdac@gmx.de

=2D--
Natalie Vock (5):
      cgroup/dmem: Add queries for protection values
      cgroup/dmem: Add dmem_cgroup_common_ancestor helper
      drm/ttm: Make a helper for attempting allocation in a place
      drm/ttm: Be more aggressive when allocating below protection limit
      drm/ttm: Use common ancestor of evictor and evictee as limit pool

 drivers/gpu/drm/ttm/ttm_bo.c       | 147 ++++++++++++++++++++++++++++++--=
=2D----
 drivers/gpu/drm/ttm/ttm_resource.c |  48 ++++++++----
 include/drm/ttm/ttm_resource.h     |   6 +-
 include/linux/cgroup_dmem.h        |  25 +++++++
 kernel/cgroup/dmem.c               |  73 ++++++++++++++++++
 5 files changed, 258 insertions(+), 41 deletions(-)
=2D--
base-commit: f3e82936857b3bd77b824ecd2fa7839dd99ec0c6
change-id: 20250915-dmemcg-aggressive-protect-5cf37f717cdb

Best regards,
=2D-=20
Natalie Vock <natalie.vock@gmx.de>


