Return-Path: <cgroups+bounces-13302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85384D39854
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 18:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 602AA3005A93
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377B1226863;
	Sun, 18 Jan 2026 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVgZiO6X"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE200500945;
	Sun, 18 Jan 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756336; cv=none; b=gZmuMAnp2fLu5vt/nOtDj94Y4DvWSf4FEI/9sp2Lown6KOtPMZDReTTfU0F9ov0AHu6idorsEhKiOv4+v/rDdMpLJY9a0jTU3iF0XVb56i5E3VmGAp4+IIBaAf9cpYJ5WxALPorNXY2hvb22RaLFhzQeys6qiUT78Uxsl6bNbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756336; c=relaxed/simple;
	bh=UZ6QszaSsZJUehI9zSPIlFPf5tUAhPFZU/JkqvzMZfs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=rSATsdPLp5F1lJZ1L/ngsvHyhMH868fftq2PawrGm9f1e8O7e5OxEZEyt0ezB5MXPnqMjx4e7n8Yj9uToCgAfwp3UFncHZlBHAVXInLl9U5gX+2m2qTzsrd7fTRj5JHCI2vbUfmd2gvqfGrrnonL+a+ilYJvuVWnm46fpBrgdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVgZiO6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D92C116D0;
	Sun, 18 Jan 2026 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768756335;
	bh=UZ6QszaSsZJUehI9zSPIlFPf5tUAhPFZU/JkqvzMZfs=;
	h=Date:From:To:Cc:Subject:From;
	b=uVgZiO6XheRcxJwvxS+2Lo4aVwS5WkXpuJNIDSdV/BbTQoyUfzKQ/HolZIx/MVFTi
	 2A0u6dYTdfNNrChG/GsyRyi1pVA7tQkoOC3kaHksh4bDLwwoBoZyeAoPgs0H6ORD84
	 XwPs7iqBuPzXRI0WD0XiPlOBbuGSwa2t/jTJKrVwkc8cSo6ItYJOPkHHgXJrv++xMa
	 lFkoJlvWDG/nDdyt1Rxbzmoi/Ol96QvCPt+1BQ79modL3WM0ZcJUz5u4jn7yIAQrbd
	 xdMAC2Ghd/KnrlU8HVZauZ29X5GQqLZlDwN/bmJXTmanwwj8ww2OmrL96u5peU0Zuw
	 Z2MteCPNCj8qg==
Date: Sun, 18 Jan 2026 07:12:14 -1000
Message-ID: <2d1e28eab84b46584aa3a127ae1e974d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: [GIT PULL] Another cgroup fix for v6.19-rc5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Hi Linus,

The following changes since commit ef56578274d2b98423c8ef82bb450223f5811b59:

  cgroup: Eliminate cgrp_ancestor_storage in cgroup_root (2026-01-07 15:11:03 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc5-fixes-2

for you to fetch changes up to 84697bf5532923f70ac99ea9784fab325c560df0:

  kernel: cgroup: Add LGPL-2.1 SPDX license ID to legacy_freezer.c (2026-01-15 22:03:15 -1000)

----------------------------------------------------------------
cgroup: Another fix for v6.19-rc5

- Add Chen Ridong as cpuset reviewer.

- Add SPDX license identifiers to cgroup files that were missing them.

----------------------------------------------------------------
Tim Bird (2):
      kernel: cgroup: Add SPDX-License-Identifier lines
      kernel: cgroup: Add LGPL-2.1 SPDX license ID to legacy_freezer.c

Waiman Long (1):
      MAINTAINERS: Add Chen Ridong as cpuset reviewer

 MAINTAINERS                    | 1 +
 kernel/cgroup/cgroup.c         | 5 +----
 kernel/cgroup/cpuset.c         | 5 +----
 kernel/cgroup/legacy_freezer.c | 9 +--------
 4 files changed, 4 insertions(+), 16 deletions(-)

Thanks.
--
tejun

