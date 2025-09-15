Return-Path: <cgroups+bounces-10085-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C7B57B37
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB117F770
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97833093BC;
	Mon, 15 Sep 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="MeFmssPm"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6730AABC
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939828; cv=none; b=eMFLAfESWyezN2nro2dwLIt/P7qTF4R107YCrR2vjZwNRBsQbmHvFBRLAAMfSB+DDMTtlqSWoZ0dsuIlJcANQ1/R7nzXOVT/p4DPGcs9dOEzV3e7C74cW5mOetH4rlTi6ndhUaFPXg9vwkAepi2Jyef1sAqcYSwX+vjSsFzf4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939828; c=relaxed/simple;
	bh=z/YsDt+zJX62MStPbMKpMUNGUZvH/LaCKadzspunQ0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F8E3FvHsF2ak/fvz4wDQ1p51ij6m2Nb/Ba5sRU0p8VU6w2VVOnK5FTd4M33+MHiLuiuu+Y03oBzxFkZjX1V3wlj/b8e4vF/OWuQj2JpA81vgbJmmgyumGLCBbmHWxjwhgZhe+LMp0HlhwdYL8iq5hlhk2vJ3hdRUxZYp2HuMG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=MeFmssPm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757939820; x=1758544620; i=natalie.vock@gmx.de;
	bh=XLov8RlCWVl2IID+p1nO7hFPn6pJtz7G6VeAVxCQSZI=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MeFmssPmDh//lLP9YCTwJGv3Wh5mYBFQ3gbPFypJEZ4OaJ3ns6dnPkmMQiLLHr3k
	 uOqqzGiFOmDeZUL0p9UshzUiZ/LZCgzNH54yGT2tDXEJQf7Sb37dQ+52d0XdlzOP7
	 96+5bz3VLksnJKHyw63eVzOjqBw4sthJ++P26c69ctqo72nTRfjhOCN+g8lAJC43+
	 4oDReANHofO2PL28wpEf4QsvugdXdRulmsgThDyiJryOe59fxQyt9byWhZd3Go+MR
	 pPLOsrDLIxePskhvj6a33HKeNuOKEbJ1qyS2zB10YWK/RgLvJksO1rIgYg1TCkuWR
	 ci7jfOPryA5A4OifEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1v0LNU16jY-00GrfM; Mon, 15
 Sep 2025 14:37:00 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH 0/4] cgroup/dmem,drm/ttm: Improve protection in contended
 cases
Date: Mon, 15 Sep 2025 14:36:27 +0200
Message-Id: <20250915-dmemcg-aggressive-protect-v1-0-2f3353bfcdac@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAEsIyGgC/x3MSwrDMAxF0a0EjSuIU4xpt1I6SOVnV4N8kEIIh
 Oy9psMzuPckhymcnt1Jhl1dl7kh3DqS7zhXsOZmGvoh9o8QOU+YpPJYq8Fdd/BqywbZOEq5p5J
 Ckvyh1q+Gosf//Xpf1w9dWjLEawAAAA==
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
X-Provags-ID: V03:K1:T8PyzfoH1hc2vAl/Us3KIQxM+TEyirqF5n4UST3Ytz5SxusridW
 yh+k8tm1ekbZMkH/Th0c4JmeIljW8inUNLEi6Bre8wQ8lnsq93QFwjatwazwJ7sv1IBh18m
 88jToxsA1qCibKyzq9jTKGBH1KcfbuKFdcVN4EY5M23qfeyGb/7nVJxVe1uemH8M5xcp//4
 TZB386H/ZEPyljxWAI1uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1rrboOZkExc=;mz6mfYPBym7asv6Ms2xZz84g7/K
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
Natalie Vock (4):
      cgroup/dmem: Add queries for protection values
      cgroup/dmem: Add dmem_cgroup_common_ancestor helper
      drm/ttm: Be more aggressive when allocating below protection limit
      drm/ttm: Use common ancestor of evictor and evictee as limit pool

 drivers/gpu/drm/ttm/ttm_bo.c       | 79 ++++++++++++++++++++++++++++++++-=
=2D----
 drivers/gpu/drm/ttm/ttm_resource.c | 48 ++++++++++++++++-------
 include/drm/ttm/ttm_resource.h     |  6 ++-
 include/linux/cgroup_dmem.h        | 25 ++++++++++++
 kernel/cgroup/dmem.c               | 73 +++++++++++++++++++++++++++++++++=
++
 5 files changed, 205 insertions(+), 26 deletions(-)
=2D--
base-commit: f3e82936857b3bd77b824ecd2fa7839dd99ec0c6
change-id: 20250915-dmemcg-aggressive-protect-5cf37f717cdb

Best regards,
=2D-=20
Natalie Vock <natalie.vock@gmx.de>


