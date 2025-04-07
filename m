Return-Path: <cgroups+bounces-7393-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF29A7E8AA
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8E4189865F
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31445221717;
	Mon,  7 Apr 2025 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIvM9G9K"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F721B1AB;
	Mon,  7 Apr 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047272; cv=none; b=aiTqj/4X5F0XxCc2YZUMaZIYmfJPFe/wulixQVaQd+ypslj6hk7YY3CM9hKuL8RrF0FcgdE3Va2ftJZdh4EBYs7t5Pm3gSxoxhaCimeIIHRKTR7GH2wKQ4juJgJwwyI6ok8NC72yzRaMg1KXyww5orZnQiX5izXFKFPGnkn7TKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047272; c=relaxed/simple;
	bh=o63Kr8wHNE3EOi+oVha6nVGxp6Yoorpa1gflUrhu3J0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lrOjQ2+GpfEyOtpGpOHF7c1F0AVK+uW6rgTfslcH4YcG3e4n2jPbe774fBGsGEYxKo9Y+un+4GW4IpA5wyE6YleU9pAKUpwB0gBD1Uhsq4CP/LuwgQQmNjjU7jkoQKABg6B3+PSil0vCMUQTGkZ+DiNdwmgo1PBGkGdo3IvlQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIvM9G9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D753C4CEDD;
	Mon,  7 Apr 2025 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047272;
	bh=o63Kr8wHNE3EOi+oVha6nVGxp6Yoorpa1gflUrhu3J0=;
	h=Date:From:To:Cc:Subject:From;
	b=AIvM9G9KtpnXpve51JFF+dO41kdErgyup6M1biPljJfC7vmEl8MjpousOzbV1gO2E
	 A8CVidrgrX6diPFz7sZau3F8VS1Zno9Kzjhz95lNVA5WX7bbilMG/DALG/3AK9YNht
	 SzYkGhGBUSxVaJAOHYHXc/2bVDTLy7lqzOKcYB5PEqK3wO6mcgY+FFavLePnBIv8U/
	 Esgi8xocqAGLMdzhmjJ2k3MNAfoO5G0FpVfqIkbnozdCHRoVF9bK0VvvNTGmiCpUNx
	 mug97U3IaFYJXmgbGxhsR8WR/vD5BpDVG9onn+JwRLACkyGjqfKGRqylhUsHv1EWfY
	 Mu0P+Co0aizzg==
Date: Mon, 7 Apr 2025 07:34:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: [GIT PULL] cgroup: Fixes for v6.15-rc1
Message-ID: <Z_QMp_w1wVoU5A2w@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1e7857b28020ba57ca7fdafae7ac855ba326c697:

  x86: don't re-generate cpufeaturemasks.h so eagerly (2025-03-31 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc1-fixes

for you to fetch changes up to a22b3d54de94f82ca057cc2ebf9496fa91ebf698:

  cgroup/cpuset: Fix race between newly created partition and dying one (2025-04-01 21:46:22 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.15-rc1

- A number of cpuset remote partition related fixes and cleanups along with
  selftest updates.

- A change from this merge window made cgroup_rstat_updated_list() called
  outside cgroup_rstat_lock leading to list corruptions. Fix it by
  relocating the call inside the lock.

----------------------------------------------------------------
Shakeel Butt (1):
      cgroup: rstat: call cgroup_rstat_updated_list with cgroup_rstat_lock

Waiman Long (10):
      cgroup/cpuset: Fix incorrect isolated_cpus update in update_parent_effective_cpumask()
      cgroup/cpuset: Fix error handling in remote_partition_disable()
      cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition
      cgroup/cpuset: Don't allow creation of local partition over a remote one
      cgroup/cpuset: Code cleanup and comment update
      cgroup/cpuset: Remove unneeded goto in sched_partition_write() and rename it
      selftest/cgroup: Update test_cpuset_prs.sh to use | as effective CPUs and state separator
      selftest/cgroup: Clean up and restructure test_cpuset_prs.sh
      selftest/cgroup: Add a remote partition transition test to test_cpuset_prs.sh
      cgroup/cpuset: Fix race between newly created partition and dying one

 include/linux/cgroup-defs.h                       |   1 +
 include/linux/cgroup.h                            |   2 +-
 kernel/cgroup/cgroup.c                            |   6 +
 kernel/cgroup/cpuset-internal.h                   |   1 +
 kernel/cgroup/cpuset.c                            | 401 ++++++++------
 kernel/cgroup/rstat.c                             |   3 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 617 ++++++++++++++--------
 7 files changed, 651 insertions(+), 380 deletions(-)

-- 
tejun

