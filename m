Return-Path: <cgroups+bounces-5616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F89D1508
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8D3284783
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8491BD01F;
	Mon, 18 Nov 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAAQfv9Q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69631199EBB;
	Mon, 18 Nov 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945989; cv=none; b=shVm0iu/dH56ppJkYPXjpejbf6O9FdqUd+YfZiC1Sm6GVGNR7vOYgiK2xzYHUipvbvndnD8cq4ibYQdLq/WNhwku3QzZysf4PrO7yZwNeLGHH2oWUrKUz1yktodebyKV1awZxJexCNjjZc+QTXUKUAwU5VI3sb7XTnGacxmdK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945989; c=relaxed/simple;
	bh=rhz37qIrqDoRA45wbU+7TmbyRU4Eu00BRP/vhreoaTY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M49NnFT1kAlDhbH0dzUT/6/+Bfjov92n9cF7vN7AE4bsKeAdELO5ApoJP2iUYwypqZkgzW6bxVxrlhskFzdC1wuO/tTti1RwVXVVaGW9p6v0uAVLY0toOw++8hDkQ00lf9l0nHzI4NMRNz2Y8PM/pIxOCglASa/pEJ+gUZc3pzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAAQfv9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91B4C4CECC;
	Mon, 18 Nov 2024 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731945988;
	bh=rhz37qIrqDoRA45wbU+7TmbyRU4Eu00BRP/vhreoaTY=;
	h=Date:From:To:Cc:Subject:From;
	b=hAAQfv9QlRP3ao6rZXTe+f8ggYOpQfTQRv87RFSkL/FkFU34KkY6J0B1bXndnaYGm
	 DiB+BsIMEKgJ+UJNJ2dfDlkkTnpJEN9Did68uaLHNbBNwauu9IhidxYvr98jvaNIcQ
	 Z4UwqV49KtAfOjd4GFCY/YwJXNMroLTJy5GFqUlvSHePMy5kY5ddurR0KSHK78rdIw
	 Pl1bd2GE9sdEmX5tfnmzXlbdK9R0FEDOEjtSF+F+krNphOZWGXsBDXhiIF4VxNtg3L
	 5t6JQghsNH1Udwo+jONpqAnuHe5vgONMBes7Pgc0xTOJvlz9TQkts7M5lbbzGP5nQB
	 aOOHH3ehZmC5g==
Date: Mon, 18 Nov 2024 06:06:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: [GIT PULL] cgroup: Changes for v6.13
Message-ID: <ZztmA9FyfqLtPy47@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.13

for you to fetch changes up to fbfbf86685b3270dc27d1c5d6108532334aaf329:

  cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test if not load balancing (2024-11-14 08:44:03 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.13

- cpu.stat now also shows niced CPU time.

- Freezer and cpuset optimizations.

- Other misc changes.

----------------------------------------------------------------
Chen Ridong (4):
      Revert "cgroup: Fix memory leak caused by missing cgroup_bpf_offline"
      cgroup/bpf: only cgroup v2 can be attached by bpf programs
      cgroup/freezer: Reduce redundant traversal for cgroup_freeze
      cgroup/freezer: Add cgroup CGRP_FROZEN flag update helper

Joshua Hahn (2):
      cgroup/rstat: Tracking cgroup-level niced CPU time
      cgroup/rstat: Selftests for niced CPU statistics

Waiman Long (4):
      cgroup/cpuset: Revert "Allow suppression of sched domain rebuild in update_cpumasks_hier()"
      cgroup/cpuset: Enforce at most one rebuild_sched_domains_locked() call per operation
      cgroup/cpuset: Further optimize code if CONFIG_CPUSETS_V1 not set
      cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test if not load balancing

Xiu Jianfeng (1):
      selftests/cgroup: Fix compile error in test_cpu.c

Zefan Li (1):
      MAINTAINERS: remove Zefan Li

everestkc (1):
      cgroup/cpuset: Fix spelling errors in file kernel/cgroup/cpuset.c

 CREDITS                                   |   3 +
 MAINTAINERS                               |   2 -
 include/linux/cgroup-defs.h               |   3 +-
 kernel/cgroup/cgroup.c                    |  21 ++--
 kernel/cgroup/cpuset.c                    | 157 +++++++++++++++++-------------
 kernel/cgroup/freezer.c                   |  97 +++++++++---------
 kernel/cgroup/rstat.c                     |  19 +++-
 tools/testing/selftests/cgroup/test_cpu.c |  75 ++++++++++++++
 8 files changed, 239 insertions(+), 138 deletions(-)

-- 
tejun

