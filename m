Return-Path: <cgroups+bounces-7203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F7A6ABDD
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 18:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B264E188D4C2
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE7224231;
	Thu, 20 Mar 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbqJ/6oa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D46223301;
	Thu, 20 Mar 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491437; cv=none; b=nGBMmuGDJtmr7ShQpV7tHDXGHyGgCMq1MU8P7Bxb7Ta8VhGiyvpDMw4XqQGtm9nQwqPVJsxPds2BqKannbp6zkQlUavJa00c+UHiobkl+cjteOsbk9dYEKZdHz+a98ODRp33PPk0I7tVfbjIh2i9hzAnSzxZJfbYMWEdAxqdHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491437; c=relaxed/simple;
	bh=gryFhtDu7XEGwiKBLSCriZUlTbrAYOqWjssTwooJpi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WvMxuipJ0b3JPR15B2Acg3FXYb6ow9ndjkXMht63nPdOKqlj2OvtC6GZxOHlXjy4kLRG7ZfSvkeXx3AvLI5UoHxLmDiu1Z3HxSe/2csjSZp66mUm7u7QTT6frnM5vEPUcthcm6oxHMZBWRS5d5lr/GrkUqWegM1cUy+0qpvzUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbqJ/6oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A4C4CEDD;
	Thu, 20 Mar 2025 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742491437;
	bh=gryFhtDu7XEGwiKBLSCriZUlTbrAYOqWjssTwooJpi8=;
	h=Date:From:To:Cc:Subject:From;
	b=FbqJ/6oaWNJa60N6rbl+vavRinTUxGW1nmvjAtmYtcS9cb6wSkJ0yqsQyBsDKXDll
	 IQK4tJjHAySIXA1pl2cQHlA73ZVu7kENE0/7CgScvp1uPntzcr8NfGRBPcxaEAKOOC
	 cL2EpyQiKqGtGiXRZFRgf47B9hTdgLZrkuwkchmQfLPunU+xxyN7/XFqB7klNgvUMF
	 yhB0GYRBkB7wrB6EUoMr4pjHy8jfYcdv3nyAnljhgsRE5G1e4jlIs/v6G/JUQy3QnA
	 fGkrCcjayaul0SQ1kLCAy5h1K5hfBdekYXO0L6Rcpcjzvso9Zt3Ov1uGZsxbHSn2fH
	 52LrEKpDSS1Tg==
Date: Thu, 20 Mar 2025 07:23:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Changes for v6.15
Message-ID: <Z9xPK55yOmH4YUsk@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit b9d8a295ed6bc3cee846f8e3f27c9c6e9ebe43f2:

  Merge tag 'x86_misc_for_v6.14_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-01-21 09:38:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15

for you to fetch changes up to 093c8812de2d3436744fd10edab9bf816b94f833:

  cgroup: rstat: Cleanup flushing functions and locking (2025-03-20 06:53:02 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.15

- Add deprecation info messages to cgroup1-only features.

- rstat updates including a bug fix and breaking up a critical section to
  reduce interrupt latency impact.

- Other misc and doc updates.

----------------------------------------------------------------
Abel Wu (1):
      cgroup/rstat: Fix forceidle time in cpu.stat

Dr. David Alan Gilbert (1):
      cgroup/misc: Remove unused misc_cg_res_total_usage

Eric Dumazet (1):
      cgroup/rstat: avoid disabling irqs for O(num_cpu)

Haorui He (1):
      cgroup: update comment about dropping cgroup kn refs

Michal Koutný (12):
      cgroup/cpuset: Move procfs cpuset attribute under cgroup-v1.c
      cgroup/cpuset-v1: Add deprecation messages to sched_load_balance and memory_pressure_enabled
      cgroup/cpuset-v1: Add deprecation messages to memory_spread_page and memory_spread_slab
      cgroup/blkio: Add deprecation messages to reset_stats
      cgroup: Print message when /proc/cgroups is read on v2-only system
      cgroup/cpuset-v1: Add deprecation messages to mem_exclusive and mem_hardwall
      cgroup/cpuset-v1: Add deprecation messages to memory_migrate
      RFC cgroup/cpuset-v1: Add deprecation messages to sched_relax_domain_level
      mm: Add transformation message for per-memcg swappiness
      cgroup: Add deprecation message to legacy freezer controller
      cgroup: Update file naming comment
      blk-cgroup: Simplify policy files registration

Shashank Balaji (1):
      cgroup, docs: Be explicit about independence of RT_GROUP_SCHED and non-cpu controllers

Tejun Heo (1):
      mm: Fix a build breakage in memcontrol-v1.c

Yosry Ahmed (1):
      cgroup: rstat: Cleanup flushing functions and locking

 .../admin-guide/cgroup-v1/freezer-subsystem.rst    |   4 +
 Documentation/admin-guide/cgroup-v1/memory.rst     |   1 +
 Documentation/admin-guide/cgroup-v2.rst            |  23 ++--
 block/blk-cgroup.c                                 |   8 +-
 block/blk-ioprio.c                                 |  23 ++--
 include/linux/cgroup-defs.h                        |   5 +-
 include/linux/cgroup.h                             |   3 +-
 include/linux/misc_cgroup.h                        |   6 --
 init/Kconfig                                       |   5 +-
 kernel/cgroup/cgroup-internal.h                    |   1 +
 kernel/cgroup/cgroup-v1.c                          |   7 ++
 kernel/cgroup/cgroup.c                             |   6 +-
 kernel/cgroup/cpuset-v1.c                          |  49 +++++++++
 kernel/cgroup/cpuset.c                             |  45 --------
 kernel/cgroup/legacy_freezer.c                     |   6 +-
 kernel/cgroup/misc.c                               |  16 ---
 kernel/cgroup/rstat.c                              | 116 +++++++--------------
 mm/memcontrol-v1.c                                 |   6 +-
 18 files changed, 142 insertions(+), 188 deletions(-)

-- 
tejun

