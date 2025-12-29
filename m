Return-Path: <cgroups+bounces-12785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCFCE59EB
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 01:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 636573005FE7
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 00:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA9188735;
	Mon, 29 Dec 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edUThazR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A778F26;
	Mon, 29 Dec 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766968801; cv=none; b=bkw2JenCjAlS7QG8jCLUrKnDQOIuo3j1AO3T9eFfOLYSHVPirn7MKb59xydyCi9ADIWDviLZViLYFw5F2hZpgbYXR8qUQ2/DI1+UhZME02ttps3jxaSsIt0zvz3+bHUIwhk3GpOLH0r1XyxZO6UApGUZ79E57BsmedweCI853b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766968801; c=relaxed/simple;
	bh=BZf/B+5u8qCEuojMXyHyY8ktzWHieYIrdma2LKrXNmE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=MyvugGbf3eNVOLZ5MzA+99sf7CUmvfeJM6jbbZqnJnxvw4ykIb3H22RqW77gKvnfqHxgS8rb6caGGUVRCFF+mRKCE3JxcOusvNWEsFwOrGYXW3qRdch/Qdw5KEYbCegO+Nkcxr88pbXVLuwK0nPRkFDSNtS2VAinoOWHLH/wOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edUThazR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFE5C4CEFB;
	Mon, 29 Dec 2025 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766968801;
	bh=BZf/B+5u8qCEuojMXyHyY8ktzWHieYIrdma2LKrXNmE=;
	h=Date:From:To:Cc:Subject:From;
	b=edUThazRQ+w13kVSXMm9DNfjNFmfrrquvmgjEqgutA5R+9Z8izjPlNGRelUM9pLHt
	 jq+RhEfwSLjwPKRlbbfZ+2aULWCvGBf4LLeo0Jm2nfCHpdRNMKT+6fr8f8NO1Z/CxD
	 UnWKbXClio7Ia+Omn7cksfaugF1P7VgNnS/mv0AlbXb8VgGQ03lg+l4BqTA4PTmVzW
	 rBAO9OAX+h6+y/Pxkwe7JojDP9a0kBNM1jTmUKkEUMtK/sMJkrXN1abphw2cxdTQln
	 47Hm2pX+Ou6AziZgF12SIndsPP6YGPKxRDGFUA7NEIl/D/ROYFx1P3wpE1bmAPWah8
	 y3IwNRVRLItlA==
Date: Sun, 28 Dec 2025 14:39:59 -1000
Message-ID: <ad89f5a3271616fd4effa3fe5f465e26@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup fixes for v6.19-rc3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Hi Linus,

The following changes since commit 3309b63a2281efb72df7621d60cc1246b6286ad3:

  cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated (2025-12-08 08:26:56 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc3-fixes

for you to fetch changes up to aa7d3a56a20f07978d9f401e13637a6479b13bd0:

  cpuset: fix warning when disabling remote partition (2025-12-18 06:38:54 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.19-rc3

- cpuset: Fix spurious warning when disabling remote partition after CPU
  hotplug leaves subpartitions_cpus empty. Guard the warning and invalidate
  affected partitions.

----------------------------------------------------------------
Chen Ridong (1):
      cpuset: fix warning when disabling remote partition

 kernel/cgroup/cpuset.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

Thanks.
--
tejun

