Return-Path: <cgroups+bounces-13097-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAB9D15216
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C94A63016AF3
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E229B324B2A;
	Mon, 12 Jan 2026 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxxPvj9j"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58473246F0;
	Mon, 12 Jan 2026 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247625; cv=none; b=W0zUYnFHe+KQ1/oJgiGPlXWE/q02vHRvJOoPTJKtsnWBHcZRlRXS+9zvny8XJGHzTPLYTuMO7/Je80pcKmEYZbecxHYfWavrVZQNJUEoHv94xrdQciOhIYZUMI2XB1F8rGPEfSU6ln3qGjjsEjGlPhCRlB7G8JCw1MGQ6ySAfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247625; c=relaxed/simple;
	bh=eQSE13Mj/cSh5VM2aVTWfAZ8l8ufC/dT5PMfleZtSkk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=C8NRSIWd/KjdECywvjlVZd8VpT1suLMIRuVPdwdIBVaSgdda8o/VdZeVlmgdpVgxzN0BgpzAmvSBahKO7kh+6XJvl+A0LC75crEIVQr+x2U8gJmUBLknLOoA13wDs9d+sMbQ2nEkbLf+VEnM2jlw6FjYXB2sowsQ/HZhy33xGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxxPvj9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F56C116D0;
	Mon, 12 Jan 2026 19:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768247625;
	bh=eQSE13Mj/cSh5VM2aVTWfAZ8l8ufC/dT5PMfleZtSkk=;
	h=Date:From:To:Cc:Subject:From;
	b=lxxPvj9jvnjhbthPD/vcv6TUCK4B1yX1me894KgWTCaWG4vlz5Zfo0hCACaL9ZpuW
	 unFFr/+ssGy7U8+0I+0sRvOO0EM+qjrjeKeY3oxr7RNYKlTQ9xM9ZTE19up6QZqXjM
	 qKhF0uCKRKRI3zgTJyRsTX1AeuDNn+URbEVEpIB8u2df8zohoSb6FJ5GKAzE9XHm3V
	 WgZWxTSgDbLFOJfryZ35LRaqBH2XLKrR/AyiUJzU3hFROXKcWTg+FmDLyCWU15AaQB
	 aIJOjzDteXqh2mdqvwwHF2o9KXLT9K3YSkUZZRb7B1wfHBckuAQKyiDi408jHih0T9
	 df3DgDA1IGsUw==
Date: Mon, 12 Jan 2026 09:53:44 -1000
Message-ID: <2b67728dc00d11baa695ce60bbbd0e71@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup fixes for v6.19-rc5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Hi Linus,

The following changes since commit aa7d3a56a20f07978d9f401e13637a6479b13bd0:

  cpuset: fix warning when disabling remote partition (2025-12-18 06:38:54 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc5-fixes

for you to fetch changes up to ef56578274d2b98423c8ef82bb450223f5811b59:

  cgroup: Eliminate cgrp_ancestor_storage in cgroup_root (2026-01-07 15:11:03 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.19-rc5

- Fix -Wflex-array-member-not-at-end warnings in cgroup_root.

----------------------------------------------------------------
Michal Koutný (1):
      cgroup: Eliminate cgrp_ancestor_storage in cgroup_root

 include/linux/cgroup-defs.h | 25 ++++++++++++++-----------
 kernel/cgroup/cgroup.c      |  2 +-
 2 files changed, 15 insertions(+), 12 deletions(-)

Thanks.
--
tejun

