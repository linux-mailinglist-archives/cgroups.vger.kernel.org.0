Return-Path: <cgroups+bounces-10901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4069BF2E52
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6963B7486
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F572C327D;
	Mon, 20 Oct 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyPftaaU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D0238C07;
	Mon, 20 Oct 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984156; cv=none; b=dFEtWNJDvvm2Rs/kIEzx9mCO+291UO7OP57Cd8xdhXWCJCX6M+41CJ9qcwTH5Q3CUdK5+j4BSEHjZenWdaDrD4iPWKI0+Vg9WDrF+yWd6rvac37EYXoBbtQnAhA8I0LzvQOClsEb4dSvwtF6R+OqcsLBKvx9wBSSOM+c9dbMri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984156; c=relaxed/simple;
	bh=zQcc5yhERmpGq/vLPe43FDqWAu905f1ZxFDEXEDg+RE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Zd+075cL5jjdcxDh3ucE3HImZbVq0t7TKvP4H64pjxCzk1Cm83ZgNCd1TSpB4vsBlkqzi8TaDrBPJBVIcv20r+GvGTnVqe8871jAo0Hj//UdBuwfaRMO4wiQo1yghogOs8mNo+BWTbPr98DsHbTmOQ/Iu0HWYeV46oOUv+C+AA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyPftaaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03245C4CEF9;
	Mon, 20 Oct 2025 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760984156;
	bh=zQcc5yhERmpGq/vLPe43FDqWAu905f1ZxFDEXEDg+RE=;
	h=Date:From:To:Cc:Subject:From;
	b=FyPftaaUBDecBNT7WtQi7n7diGchzJg+4AIaA7Ff1ZjqtHRNahSQ9Fcgt57vgXTk1
	 3BIPxGhCcR+qPsyyS5fQUFywlUlQRHxAIpqN34LE0yIKsfbMqLQWP4tCfrXGG9StPj
	 hcDkZ6pmDmsWlIRPzx2dsoy1ADZITcSqO+i7Xc7KgCf+rsp0AYCcrXc+wZFNQZUtMC
	 ljjHq8CV7do+/ffeiTPaRgPOEOcLM1wkjEqEuufMEBMrzy/omxvMFetTHOaUaVl6ky
	 8r50w42zhAH9pAQHm1SkCOj/+BZ8NN/yI+HGcqLH54HA5JDmWgsYY6Ke5VIf9pL0DJ
	 k5zyoT1z54WEA==
Date: Mon, 20 Oct 2025 08:15:54 -1000
Message-ID: <ca8c62e00bea051b0bd3bf682155428f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.18-rc2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The following changes since commit e406d57be7bd2a4e73ea512c1ae36a40a44e499e:

  Merge tag 'mm-nonmm-stable-2025-10-02-15-29' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2025-10-02 18:44:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.18-rc2-fixes

for you to fetch changes up to 0fbbcab7f9082cdc233da5e5e353f69830f11956:

  cgroup/misc: fix misc_res_type kernel-doc warning (2025-10-17 05:31:56 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.18-rc2

- Fix seqcount lockdep assertion failure in cgroup freezer on PREEMPT_RT.
  Plain seqcount_t expects preemption disabled, but PREEMPT_RT spinlocks
  don't disable preemption. Switch to seqcount_spinlock_t to properly
  associate css_set_lock with the freeze timing seqcount.

- Misc changes including kernel-doc warning fix for misc_res_type enum and
  improved selftest diagnostics.

----------------------------------------------------------------
Nirbhay Sharma (1):
      cgroup: Fix seqcount lockdep assertion in cgroup freezer

Randy Dunlap (1):
      cgroup/misc: fix misc_res_type kernel-doc warning

Sebastian Chlad (2):
      selftests: cgroup: add values_close_report helper
      selftests: cgroup: Use values_close_report in test_cpu

 include/linux/cgroup-defs.h                          |  2 +-
 include/linux/misc_cgroup.h                          |  2 +-
 kernel/cgroup/cgroup.c                               |  2 +-
 .../selftests/cgroup/lib/include/cgroup_util.h       | 20 ++++++++++++++++++++
 tools/testing/selftests/cgroup/test_cpu.c            | 18 +++++++++---------
 5 files changed, 32 insertions(+), 12 deletions(-)

