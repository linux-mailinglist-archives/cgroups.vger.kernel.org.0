Return-Path: <cgroups+bounces-4868-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA549977327
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 22:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF8C1C240A3
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BED1C3F27;
	Thu, 12 Sep 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6f0xQEX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5621C3F1E;
	Thu, 12 Sep 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174594; cv=none; b=QIQ6OXxSPihErISv7N8qkci82vi7hwdwiELFl33FPsMNReLhMcGqz7JJQ7AzwQFBg5tlLMm6iqPv3YsoMotM7CW9lIf8MzpxPXPRN/0hgMNd/Ar19ik3bJ5pUOw/aCCxTyZzk65ZYP3P+JyDASli+V0K518tSK3Cpdt9V4ppRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174594; c=relaxed/simple;
	bh=L7W91oHIJMuEtO58gO4Ue+RG5vV00ay6/5X6YgnfWUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YgfB/D1LEWQ2jsmCvb50YczpQy2tS/qHDLCHxGLEoiiSL6YfLQppdRs30WliHfGA/1kZRJc3jLs6ius9GuG27xx8ZJsvfUvxRuPwUFGaHoUE4Yw4EdLRdFl7Arp+qBGPCWOAXdpDGWuowgZ0yAd9gIS1i6hdfaqBvf0AdW5ooM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6f0xQEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A85C4CEC3;
	Thu, 12 Sep 2024 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726174593;
	bh=L7W91oHIJMuEtO58gO4Ue+RG5vV00ay6/5X6YgnfWUo=;
	h=Date:From:To:Cc:Subject:From;
	b=i6f0xQEXzN8f8xvgqdxxQp0vhGV7Bjf+uEhmCD56rFRzYzH33cPrYLMZasKqInDf1
	 G5RlpdhduuKPXs0AGqFwCJUB12fySzegOshYg8r8jsDPJbWy9b9+v0R3y2xHgrJbWD
	 Q+EfzIu9pzHqkIMM4H0XqIyZi1M2RuxG4iBsW3QLIU48uDgx1XiLZFY6XEViVN9Phh
	 ruwfsub1fqHU0jVONxeWgtbNd4Mo+h62zxzWR1FzUzb0buGthqguh0nOSRlR9lOJZj
	 xgSjv3/81DJ4aki7VSfYP4rDBgjGwB8p3cW60lzQ4xBWUDzNo49VprwxZJGDTapqIi
	 tA/Q/tXcFy6CA==
Date: Thu, 12 Sep 2024 10:56:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: [GIT PULL] cgroup: Changes for v6.12
Message-ID: <ZuNVf1ocpQi03lkf@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit ff0ce721ec213499ec5a532041fb3a1db2dc5ecb:

  cgroup/cpuset: Eliminate unncessary sched domains rebuilds in hotplug (2024-08-05 10:54:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.12

for you to fetch changes up to af000ce85293b8e608f696f0c6c280bc3a75887f:

  cgroup: Do not report unavailable v1 controllers in /proc/cgroups (2024-09-10 10:04:28 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.12

- cpuset isolation improvements.

- cpuset cgroup1 support is split into its own file behind the new config
  option CONFIG_CPUSET_V1. This makes it the second controller which makes
  cgroup1 support optional after memcg.

- Handling of unavailable v1 controller handling improved during cgroup1
  mount operations.

- union_find applied to cpuset. It makes code simpler and more efficient.

- Reduce spurious events in pids.events.

- Cleanups and other misc changes.

- Contains a merge of cgroup/for-6.11-fixes to receive cpuset fixes that
  further changes build upon.

----------------------------------------------------------------
Chen Ridong (18):
      cgroup/cpuset: remove child_ecpus_count
      cgroup/cpuset: add decrease attach_in_progress helpers
      cgroup: update some statememt about delegation
      cgroup/cpuset: Correct invalid remote parition prs
      cgroup/cpuset: remove fetch_xcpus
      cgroup/cpuset: remove use_parent_ecpus of cpuset
      cgroup/cpuset: introduce cpuset-v1.c
      cgroup/cpuset: move common code to cpuset-internal.h
      cgroup/cpuset: move memory_pressure to cpuset-v1.c
      cgroup/cpuset: move relax_domain_level to cpuset-v1.c
      cgroup/cpuset: move memory_spread to cpuset-v1.c
      cgroup/cpuset: add callback_lock helper
      cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
      cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
      cgroup/cpuset: move v1 interfaces to cpuset-v1.c
      cgroup/cpuset: rename functions shared between v1 and v2
      cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
      cgroup/cpuset: add sefltest for cpuset v1

Michal Koutný (3):
      cgroup/cpuset: Expose cpuset filesystem with cpuset v1 only
      cgroup: Disallow mounting v1 hierarchies without controller implementation
      cgroup: Do not report unavailable v1 controllers in /proc/cgroups

Tejun Heo (1):
      Merge branch 'cgroup/for-6.11-fixes' into cgroup/for-6.12

Waiman Long (7):
      cgroup: Show # of subsystem CSSes in cgroup.stat
      cgroup/cpuset: Check for partition roots with overlapping CPUs
      selftest/cgroup: Add new test cases to test_cpuset_prs.sh
      cgroup: Fix incorrect WARN_ON_ONCE() in css_release_work_fn()
      cgroup/cpuset: Account for boot time isolated CPUs
      selftest/cgroup: Make test_cpuset_prs.sh deal with pre-isolated CPUs
      cgroup/cpuset: Move cpu.h include to cpuset-internal.h

Xavier (3):
      Union-Find: add a new module in kernel library
      cpuset: use Union-Find to optimize the merging of cpumasks
      Documentation: Fix the compilation errors in union_find.rst

Xiu Jianfeng (3):
      cgroup/pids: Avoid spurious event notification
      cgroup/cpuset: Remove cpuset_slab_spread_rotor
      cgroup/pids: Remove unreachable paths of pids_{can,cancel}_fork

 Documentation/admin-guide/cgroup-v2.rst            |   22 +-
 Documentation/core-api/index.rst                   |    1 +
 Documentation/core-api/union_find.rst              |  106 ++
 .../translations/zh_CN/core-api/index.rst          |    1 +
 .../translations/zh_CN/core-api/union_find.rst     |   92 ++
 MAINTAINERS                                        |   12 +
 include/linux/cgroup-defs.h                        |   14 +
 include/linux/cpuset.h                             |   10 +-
 include/linux/sched.h                              |    1 -
 include/linux/union_find.h                         |   41 +
 init/Kconfig                                       |   13 +
 kernel/cgroup/Makefile                             |    1 +
 kernel/cgroup/cgroup-v1.c                          |   17 +-
 kernel/cgroup/cgroup.c                             |   68 +-
 kernel/cgroup/cpuset-internal.h                    |  305 ++++++
 kernel/cgroup/cpuset-v1.c                          |  562 ++++++++++
 kernel/cgroup/cpuset.c                             | 1155 +++-----------------
 kernel/cgroup/pids.c                               |   32 +-
 kernel/fork.c                                      |    1 -
 lib/Makefile                                       |    2 +-
 lib/union_find.c                                   |   49 +
 tools/testing/selftests/cgroup/test_cpuset_prs.sh  |   56 +-
 .../selftests/cgroup/test_cpuset_v1_base.sh        |   77 ++
 23 files changed, 1569 insertions(+), 1069 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 kernel/cgroup/cpuset-internal.h
 create mode 100644 kernel/cgroup/cpuset-v1.c
 create mode 100644 lib/union_find.c
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_base.sh

-- 
tejun

