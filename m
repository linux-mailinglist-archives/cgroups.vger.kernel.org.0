Return-Path: <cgroups+bounces-2922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5E8C6DD1
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 23:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AF028398C
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866AA15B15B;
	Wed, 15 May 2024 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvMan9CS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B61FC4;
	Wed, 15 May 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809189; cv=none; b=E9T4cV6FKo8FQECNNWkyeCmgPZ2hLf3jdCFNAydRFun6zcf7xbKqoRO8ki/Ve+mm3//yxm1N/tbsal/D7ntgW3I+OZI+L/MVR+tz6hDOCmtvBoPRU7MAHapeo06mCwuL+fT2/36L8wJ5lKAqD8KeclLnuHt5Jmj1AfThCeO/ue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809189; c=relaxed/simple;
	bh=dqlLpsKrsm5SEmrZ7kdUr2WtIzsxXW0VZCTTFo3Mkyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GJ4cNbFqTcaRK7EL1HbU0bopTo5u0cOMsqnSq2SfmLPgKYGpdg/7Qlr24yxCkYban6bD3RLysU6IM22anxhQnFRW/lnSdqIOIXnzsx8E1egbpTlKSadbrWfaLH3qYDBruZarpnnIr/43tk9z26RWL/Vlly8fIdTWDUJA3JJwCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvMan9CS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4e59081e6so4369875b3a.3;
        Wed, 15 May 2024 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715809187; x=1716413987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huR6E6DplpuTonlyO5Iy16lkmZdsmdBUeUabW5Y3K3w=;
        b=FvMan9CSl4eyZg387Jvu6xfvR6nYAGYO0lm/E1IoqPgzYbHJLcyyalj/gAMwuiSAiX
         msgE5IKIppSrqRgX2YtpHLlX8hXuRxiJeGvmYJbpZi2w8CGDz1dWY+zCZgR/hiHNOCF4
         5KlUEM7NehIbZzctyFImw7POgrrWdqetYVmaAGlHcFmrqLusXztGi8sbaUOvLC63MhR/
         yGy/oXEuOwm8BcihNYUB6lFDWtDwQF+qMmJcMdn7gD2nRxSUrKn6TXJkyNolM+m7maGQ
         XmIcJmdN8DRIMKoExbqD9r+3Nx5pMbomWBFF2ARY/h5FE4T2HmLeKoOfRNxlzvlr4IxF
         6r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809187; x=1716413987;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=huR6E6DplpuTonlyO5Iy16lkmZdsmdBUeUabW5Y3K3w=;
        b=aHECqnZBZ6juV7zDda5m0J5Y+N9zsMWpKQQ7c2qcY0mgTc/vQtUtpYNdX/YAioVXu3
         u2T6yAhQwKlukteBamn/Nin84wNWJlAqzOovgnxMMWHOFhEQZLMm5uD+X0FoUxNquv6o
         r8tvI+B/7N5rbx4Q0c5feOum000bBrNVuCm39Yl0V4E8xiLZuXTcseTy7rYymF92ZBjU
         hYvzFFSD/c2ZB/k/4mx+Td/scxRsDBvZaVZ5WlS9pLqMFF19OD0QJvsRQPSQ8lv8Ln52
         7uH4OzpqmR4ibJnuxKTmEz/1KxlWLfp+ZS6sn8eDeicXa+53nZpZJLPHHWuM3rAZITaU
         d1gw==
X-Forwarded-Encrypted: i=1; AJvYcCWrE76iKXPHaa3h2lrGes7rNEPPhQO0BwbcsGjKFR4JZrrv4rj2fZ4omsbzvbZlhMN/idr6CwxYyjJ7WaSvmFFydIMGBdkPfA==
X-Gm-Message-State: AOJu0Yy8zhv3s42Y/vLUZxlcNbveDU4GB/CGnQarkKKsZcQefbCxW6sm
	Or4RAW1xzWLU8oKyAs2KX6ZW8c6p6YVsNK6CRMZl1mQcWsDduIDamT4XYw==
X-Google-Smtp-Source: AGHT+IFCHBqIgZKQVk4jCPT4G6f0osnOzphta6SNS9jqOuqn2m6WWcTp4RwLa3Ff0RbADR8f12Eo0g==
X-Received: by 2002:a05:6a00:2e11:b0:6f3:e6dc:5484 with SMTP id d2e1a72fcca58-6f4e029bddemr19842758b3a.6.1715809186908;
        Wed, 15 May 2024 14:39:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae2fcasm11605735b3a.123.2024.05.15.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:39:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 11:39:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [GIT PULL] cgroup: Changes for v6.10
Message-ID: <ZkUrofC2xdDndwxO@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.10

for you to fetch changes up to 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2:

  cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints (2024-05-14 09:43:17 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.10

- The locking around cpuset hotplug processing has always been a bit of mess
  which was worked around by making hotplug processing asynchronous. The
  asynchronity isn't great and led to other issues. We tried to make the
  behavior synchronous a while ago but that led to lockdep splats. Waiman
  took another stab at cleaning up and making it synchronous. The patch has
  been in -next for well over a month and there haven't been any complaints,
  so fingers crossed.

- Tracepoints added to help understanding rstat lock contentions.

- A bunch of minor changes - doc updates, code cleanups and selftests.

----------------------------------------------------------------
Edward Liaw (1):
      selftests/cgroup: Drop define _GNU_SOURCE

I Hsin Cheng (1):
      docs: cgroup-v1: Fix description for css_online

Illia Ostapyshyn (1):
      docs: cgroup-v1: Update page cache removal functions

Jesper Dangaard Brouer (3):
      cgroup/rstat: add cgroup_rstat_lock helpers and tracepoints
      cgroup/rstat: desc member cgrp in cgroup_rstat_flush_release
      cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints

John Hubbard (4):
      selftests/cgroup: fix clang build failures for abs() calls
      selftests/cgroup: fix clang warnings: uninitialized fd variable
      selftests/cgroup: cpu_hogger init: use {} instead of {NULL}
      selftests/cgroup: fix uninitialized variables in test_zswap.c

Michal Koutný (1):
      cgroup/pids: Remove superfluous zeroing

Tianchen Ding (1):
      selftests: cgroup: skip test_cgcore_lesser_ns_open when cgroup2 mounted without nsdelegate

Waiman Long (4):
      cgroup, docs: Clarify limitation of RT processes with cgroup v2 cpu controller
      cgroup/cpuset: Make cpuset hotplug processing synchronous
      cgroup/cpuset: Add test_cpuset_v1_hp.sh
      cgroup/cpuset: Fix incorrect top_cpuset flags

Xiu Jianfeng (8):
      cgroup_freezer: update comment for freezer_css_online()
      cgroup: don't call cgroup1_pidlist_destroy_all() for v2
      docs, cgroup: add entries for pids to cgroup-v2.rst
      cgroup, legacy_freezer: update comment for freezer_css_offline()
      cgroup: Avoid unnecessary looping in cgroup_no_v1()
      cgroup/cpuset: Statically initialize more members of top_cpuset
      cgroup/cpuset: Avoid clearing CS_SCHED_LOAD_BALANCE twice
      cgroup/cpuset: Remove outdated comment in sched_partition_write()

 Documentation/admin-guide/cgroup-v1/cgroups.rst    |   2 +-
 Documentation/admin-guide/cgroup-v1/memcg_test.rst |   2 +-
 Documentation/admin-guide/cgroup-v2.rst            |  31 +++-
 include/linux/cgroup.h                             |   2 +-
 include/linux/cpuset.h                             |   3 -
 include/trace/events/cgroup.h                      |  92 ++++++++++++
 kernel/cgroup/cgroup-v1.c                          |   1 +
 kernel/cgroup/cgroup.c                             |   3 +-
 kernel/cgroup/cpuset.c                             | 156 ++++++++-------------
 kernel/cgroup/legacy_freezer.c                     |   5 +-
 kernel/cgroup/pids.c                               |   2 -
 kernel/cgroup/rstat.c                              | 118 +++++++++++++---
 kernel/cpu.c                                       |  48 -------
 kernel/power/process.c                             |   2 -
 tools/testing/selftests/cgroup/Makefile            |   2 +-
 tools/testing/selftests/cgroup/cgroup_util.c       |  11 +-
 tools/testing/selftests/cgroup/cgroup_util.h       |   4 +-
 tools/testing/selftests/cgroup/test_core.c         |   9 +-
 tools/testing/selftests/cgroup/test_cpu.c          |   8 +-
 tools/testing/selftests/cgroup/test_cpuset.c       |   2 +-
 .../testing/selftests/cgroup/test_cpuset_v1_hp.sh  |  46 ++++++
 tools/testing/selftests/cgroup/test_freezer.c      |   2 +-
 .../testing/selftests/cgroup/test_hugetlb_memcg.c  |   4 +-
 tools/testing/selftests/cgroup/test_kill.c         |   2 +-
 tools/testing/selftests/cgroup/test_kmem.c         |   8 +-
 tools/testing/selftests/cgroup/test_memcontrol.c   |   8 +-
 tools/testing/selftests/cgroup/test_zswap.c        |   8 +-
 27 files changed, 358 insertions(+), 223 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh

