Return-Path: <cgroups+bounces-8944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B582BB16938
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 01:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D0E1AA1D92
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 23:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689922B594;
	Wed, 30 Jul 2025 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTs1OBkN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A5376;
	Wed, 30 Jul 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916960; cv=none; b=QxTdAKhzET4LrberWOfdCbGeJBM83fvXrGT+6XOHY7H4AWGm35Daqm7kS/VHAZ7WBIUd86/o+szJL/ThFb+jh/C5colAuo6bFMkhxgR0qPikIEI/TsN5VCn4RXaW686wXsFekixl2uzoiTfTCGsI+AvlVtKyxkbKQ3LSZqzTsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916960; c=relaxed/simple;
	bh=jWK+2vcwMV2X7+9pqxnzwY6rxLt7ezaNRM0TqULxrN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AYgAvVjLuOz7q8ill0az0BNzHaMXZSklQ7SttbSdCmOEMYwWa0Qyx1cYd7+GIxFM+VdnY5LGe2faOFY02Oyyb4QcLUjDPNgJXMVLQ55PIiSAVz8NZiNbBhOAccy2+413Fb36aOn2rf3RyEnH1JUlmLIVEaDz0Le6/7eODGfkvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTs1OBkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6190C4CEE3;
	Wed, 30 Jul 2025 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916958;
	bh=jWK+2vcwMV2X7+9pqxnzwY6rxLt7ezaNRM0TqULxrN4=;
	h=Date:From:To:Cc:Subject:From;
	b=DTs1OBkNgdCk7RyTLwscW4dVwBlor0BZrGT5WVrTNfsmqKE2vam/1eLmFy05sNvCU
	 HvQMCJ5dxKxtQayVwcaFB3HTT0aQWxTKdEW7s1wajJP0n1YYRTEsNMzlv0HjVzaOgT
	 lCnHVm8hIjEJya+nG5qFgmb2M/9PY2uSdNnATm9nfI78zknglBhAu/PkPzMPmOoAwq
	 gNSGR4mUibWOARhClj2BnxWvEUs+QPAMgqOBj+20Hs6K7yx/Y8LlRiIWl0DJekZVDZ
	 drJlK0TiGPjrfyMzoNctuZGk8nRjxLKH3EhuIEISk48WT4to8tadH1Z4LAWpoHfqkX
	 GwCXAR0Dai8aA==
Date: Wed, 30 Jul 2025 13:09:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Changes for v6.17
Message-ID: <aIqmHVGyKjFG8agb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 2043ae9019e0f75c7785048230586c3f3ca0a2a4:

  Merge tag 'hid-for-linus-2025060301' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2025-06-03 10:34:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17

for you to fetch changes up to 646faf36d7271c597497ca547a59912fcab49be9:

  cgroup: Add compatibility option for content of /proc/cgroups (2025-07-19 06:14:44 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.17

- Allow css_rstat_updated() in NMI context to enable memory accounting for
  allocations in NMI context.

- /proc/cgroups doesn't contain useful information for cgroup2 and was
  updated to only show v1 controllers. This unfortunately broke something in
  the wild. Add an option to bring back the old behavior to ease transition.

- selftest updates and other cleanups.

----------------------------------------------------------------
Michal Koutný (6):
      cgroup: Drop sock_cgroup_classid() dummy implementation
      selftests: cgroup_util: Add helpers for testing named v1 hierarchies
      selftests: cgroup: Add support for named v1 hierarchies in test_core
      selftests: cgroup: Optionally set up v1 environment
      selftests: cgroup: Fix compilation on pre-cgroupns kernels
      cgroup: Add compatibility option for content of /proc/cgroups

Sebastian Chlad (2):
      selftests: cgroup: Allow longer timeout for kmem_dead_cgroups cleanup
      selftests: cgroup: Fix missing newline in test_zswap_writeback_one

Shakeel Butt (5):
      cgroup: support to enable nmi-safe css_rstat_updated
      cgroup: make css_rstat_updated nmi safe
      cgroup: remove per-cpu per-subsystem locks
      memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
      cgroup: llist: avoid memory tears for llist_node

Shashank Balaji (1):
      selftests/cgroup: fix cpu.max tests

Tejun Heo (1):
      Merge branch 'for-6.16-fixes' into for-6.17

Vishal Chourasia (1):
      Documentation: cgroup: add section explaining controller availability

 Documentation/admin-guide/cgroup-v2.rst            |   9 +
 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 include/linux/cgroup-defs.h                        |  21 +--
 include/linux/llist.h                              |   6 +-
 include/trace/events/cgroup.h                      |  47 ------
 kernel/cgroup/cgroup-v1.c                          |  14 +-
 kernel/cgroup/rstat.c                              | 184 ++++++++++-----------
 mm/memcontrol.c                                    |  10 +-
 tools/testing/selftests/cgroup/lib/cgroup_util.c   |   4 +-
 .../selftests/cgroup/lib/include/cgroup_util.h     |   5 +
 tools/testing/selftests/cgroup/test_core.c         |  84 ++++++++--
 tools/testing/selftests/cgroup/test_cpu.c          |  63 ++++---
 tools/testing/selftests/cgroup/test_kmem.c         |   5 +-
 tools/testing/selftests/cgroup/test_zswap.c        |   2 +-
 14 files changed, 264 insertions(+), 198 deletions(-)

-- 
tejun

