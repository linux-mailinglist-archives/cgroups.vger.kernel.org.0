Return-Path: <cgroups+bounces-3671-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D4930D65
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 07:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BED1C20EE8
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 05:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF453E23;
	Mon, 15 Jul 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSRLZHMS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6927457;
	Mon, 15 Jul 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721019652; cv=none; b=d/9uCEAxwhrtSslrxMIrIQ2SsmKhiqCSJh91RYOf9ABWw5p9ydTa4c6Ntt0k6xFxPwqF3Ap5Y0d6qQz02aj3VCJ/jFEXF8oVGik/bzkxzPrF4zKwE6NiT3X2UiHI17JlptSbEv+BlVyi/mr+U67XACDbtyy8HV5va/CctHpsv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721019652; c=relaxed/simple;
	bh=mVPA0WFc5imjRFG6WzjrqNxQsnXB53I+RJbaU5YWTJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EQWw7pbqvVQKRO49S6EjQCaTVxVQEztlj38EUneQQaqu8oc+bC7Bay10yEMCdrUINh0+X4t6UVphpja6CGZMhu7DdmNvK1JS8YZcRhyr0vuuLIr86Kk75U6jYlVHUzrhCj0PgFRUtxkJaJv/JpPaXbj9l+0eyB+U0dSqRsgMysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSRLZHMS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fbe6f83957so30416355ad.3;
        Sun, 14 Jul 2024 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721019650; x=1721624450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUgrnCFDaWB/r9EzY+fD5uZ9RBUgZpRmuqaqtaj8oww=;
        b=mSRLZHMScYmQs9c43GgoHN+hWNmcpsIb/YPW2GB6k+cuk1GGBUFfGCVCf28W0/t85z
         u5mRA/xpWBT2dmjMmZFlVyVRyK26QLflPZUnplitD2wr7C6qwhw65IeTOawq06m4twQm
         goT+897fPpZg9Qrez1r4CaH5pxp5/EFVK+frHwElfqSVRfHhxieFrpzJEyQhFj8G2kJZ
         ZFfiIu/w5NUBn5TW1sco0nJUOnvM2TZoNEX05YijHjTvLjhfmJ2EmBnvPQmbpQvYV6qY
         fJisdCuEaKXfCSx3NovnGC/UgmsE8iDUphD2C9iFGZdPmdXlqEPqY637WWwtiXx0Ff9H
         8Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721019650; x=1721624450;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUgrnCFDaWB/r9EzY+fD5uZ9RBUgZpRmuqaqtaj8oww=;
        b=k0qSxSgH24VovCb0nCX2t8LzkZcqEnYNL8jaDZo9WsYvKDGveBMtY9SFYDtywDHheT
         llKWuEKCJO7k6NcXXWTN+FafbGxG9prGG89p5HPVr91F6EPoxx4V7EVPzbTQvV0xOFQr
         r/lBqTSsokIjbm//bfa8RRkzKON6KLkQXqFbr8Dog0r1hY0z5H/hkbLIxaSOxP6TDwQZ
         gE2lctGle3YeTL3s0hT0xwYKvhIhcJgpilON90kKeb4qnz8mnkI4g78BfM6EcsbPLczu
         pypafbACJXkOh+V8nLs7/4Qfg5YAVpmeLYH4uQxqc/+wC3M2f0TNnRezaJA3o7nkrk4L
         dbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXdLACKA+cWKCbdG2Om9gnuVkcVWXQz214ewu9ysmvEiM8F0JLaazp1YJe9CUZ5UAVd0YWM5Bxi/Nq82VQMnYXkO6Mu/I++w==
X-Gm-Message-State: AOJu0Yynn4nezZ458PBSG0XlQ8XjuChgU3VNFOwvh9Wg5jzBc5jqpxN/
	Vo7WYtTypr+GnTvRyKuX4nF9t1Z2851XoUXQhKgr0+seMQN/wCDb
X-Google-Smtp-Source: AGHT+IGfnb+5ddRGS9IQ6fB7Qd/EXSywtJKl7hjJ8GCS7qMmmm+zKH3H4yZBlJ7SJnsQmBPIKOcuMg==
X-Received: by 2002:a17:902:d18a:b0:1fb:8aa9:e2a9 with SMTP id d9443c01a7336-1fbb6d3afb5mr105294915ad.15.1721019649591;
        Sun, 14 Jul 2024 22:00:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb9c4e3sm31217965ad.75.2024.07.14.22.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 22:00:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 14 Jul 2024 19:00:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: [GIT PULL] cgroup: Changes for v6.11
Message-ID: <ZpStAERL5IH0OAps@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 55027e689933ba2e64f3d245fb1ff185b3e7fc81:

  Merge tag 'input-for-v6.10-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2024-06-24 14:36:11 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.11

for you to fetch changes up to 9283ff5be1510a35356656a6c1efe14f765c936a:

  Merge branch 'for-6.10-fixes' into for-6.11 (2024-07-14 18:04:03 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.11

- Added Michal Koutný as a maintainer.

- Counters in pids.events were behaving inconsistently. pids.events made
  properly hierarchical and pids.events.local added.

- misc.peak and misc.events.local added.

- cpuset remote partition creation and cpuset.cpus.exclusive handling
  improved.

- Code cleanups, non-critical fixes, doc updates.

- for-6.10-fixes is merged in to receive two non-critical fixes that didn't
  trigger pull.

----------------------------------------------------------------
Chen Ridong (2):
      cgroup/cpuset: Prevent UAF in proc_cpuset_show()
      cgroup/rstat: add force idle show helper

David Wang (1):
      kernel/cgroup: cleanup cgroup_base_files when fail to add cgroup_psi_files

Michal Koutný (5):
      cgroup/pids: Separate semantics of pids.events related to pids.max
      cgroup/pids: Make event counters hierarchical
      cgroup/pids: Add pids.events.local
      selftests: cgroup: Lexicographic order in Makefile
      selftests: cgroup: Add basic tests for pids controller

Oleg Nesterov (1):
      cgroup: avoid the unnecessary list_add(dying_tasks) in cgroup_exit()

Randy Dunlap (1):
      cgroup_misc: add kernel-doc comments for enum misc_res_type

Tejun Heo (2):
      cgroup: Add Michal Koutný as a maintainer
      Merge branch 'for-6.10-fixes' into for-6.11

Waiman Long (7):
      cgroup/cpuset: Optimize isolated partition only generate_sched_domains() calls
      cgroup/cpuset: Fix remote root partition creation problem
      selftest/cgroup: Fix test_cpuset_prs.sh problems reported by test robot
      cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE until valid partition
      cgroup/cpuset: Make cpuset.cpus.exclusive independent of cpuset.cpus
      selftest/cgroup: Update test_cpuset_prs.sh to match changes
      cgroup: Protect css->cgroup write under css_set_lock

Xiu Jianfeng (5):
      cgroup/cpuset: Remove unnecessary zeroing
      cgroup/cpuset: Update comment on callback_lock
      cgroup/cpuset: Reduce the lock protecting CS_SCHED_LOAD_BALANCE
      cgroup/misc: Introduce misc.peak
      cgroup/misc: Introduce misc.events.local

 Documentation/admin-guide/cgroup-v1/pids.rst      |   3 +-
 Documentation/admin-guide/cgroup-v2.rst           |  47 +++++-
 MAINTAINERS                                       |   1 +
 include/linux/cgroup-defs.h                       |   7 +-
 include/linux/misc_cgroup.h                       |  12 +-
 kernel/cgroup/cgroup.c                            |  36 +++-
 kernel/cgroup/cpuset.c                            | 197 ++++++++++++++++------
 kernel/cgroup/misc.c                              |  80 ++++++++-
 kernel/cgroup/pids.c                              | 129 +++++++++++---
 kernel/cgroup/rstat.c                             |  37 ++--
 tools/testing/selftests/cgroup/.gitignore         |  11 +-
 tools/testing/selftests/cgroup/Makefile           |  25 +--
 tools/testing/selftests/cgroup/test_cpuset_prs.sh |  75 +++++---
 tools/testing/selftests/cgroup/test_pids.c        | 178 +++++++++++++++++++
 14 files changed, 679 insertions(+), 159 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c

