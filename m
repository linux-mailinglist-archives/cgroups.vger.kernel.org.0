Return-Path: <cgroups+bounces-12548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB92CD25D8
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 03:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FC0330198EA
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043222F386;
	Sat, 20 Dec 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEBaSUgV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290F1D5CFB
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766199219; cv=none; b=bkxQjh5DFgxVj39ZEITN87IMW5zkj2+vBOZDAFjtaQ0nbouYhyoAKlXdw4WoaIqITGa41R8qOVS6URXMRSrks3LgXs0Yt1sWKpQh8niuIGnB7eSxoFOiXgdkgSXnloWbR403W2Ooz0TsI+XKbXl9SWwRtYDxisrUiiI0LgoGkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766199219; c=relaxed/simple;
	bh=0k9+Yo8lNjf39xjvzJM/kFuxBaKfuSCuKJzGazUF1Sc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jw582CLvJZQ43B7+JFdyVSW/6GLbJuZKzrQ1fjRu7pB3OUBFWvub4sl2s5cM8bjex/IX05VQqSafNHLXqmJoQcrvTuqIQLnFOIS2rJjJaHHpY/EpxTQDo+EceeQsDKBeB695sQiN/qKA1UjhPLSHAfJ1FK9p06naHfs6DehuZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEBaSUgV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766199218; x=1797735218;
  h=date:from:to:cc:subject:message-id;
  bh=0k9+Yo8lNjf39xjvzJM/kFuxBaKfuSCuKJzGazUF1Sc=;
  b=bEBaSUgVmh+pCSBB+5LsB3lNWylNmvD4446WagZDr8my/u8R0H5MQOAJ
   pE8JgeM8X24NHfcQLc/wb0Q9gnOBHOkta0pnRDe2hxLvxVOdhm1xvcfkn
   nFMBv/wjoX0bqE8gymUufuuiz5mmH8F7cDHwv3YQfJbPoFfKbauL4lRXr
   4ujy22a2+KwjCmHlqWCLLZVcgc68iLL1sEKWfhd62cF3pGuZh0KI6Smel
   2s8LEsdFKqYUjZFyS3w3Lqc2SrE/NvLno6V9f6BvcoGGW9VtKNPwTxjcm
   21bd9StFOTwdqXqZ5QSjllYY/lMzurXu1MmiWYaNGklqQisDZ9Ss9/VV5
   g==;
X-CSE-ConnectionGUID: kaCP4qGPQj6m+wa5SuyKmQ==
X-CSE-MsgGUID: yiE77xdpRP2iyYRiYVcz2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71790475"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="71790475"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 18:53:38 -0800
X-CSE-ConnectionGUID: kHdKj/yYQOeLPlbbcGqAXQ==
X-CSE-MsgGUID: Iiq34pnrSZu8y+IEO4IYQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="204085807"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Dec 2025 18:53:36 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWn65-000000004HP-3HEJ;
	Sat, 20 Dec 2025 02:53:33 +0000
Date: Sat, 20 Dec 2025 10:52:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19-fixes] BUILD SUCCESS
 aa7d3a56a20f07978d9f401e13637a6479b13bd0
Message-ID: <202512201043.ZtFdjVVy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19-fixes
branch HEAD: aa7d3a56a20f07978d9f401e13637a6479b13bd0  cpuset: fix warning when disabling remote partition

elapsed time: 2014m

configs tested: 61
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-15.1.0
alpha         allyesconfig    gcc-15.1.0
arc            allnoconfig    gcc-15.1.0
arc           allyesconfig    clang-22
arm            allnoconfig    clang-22
arm            allnoconfig    gcc-15.1.0
arm64         allmodconfig    clang-22
arm64          allnoconfig    gcc-15.1.0
csky          allmodconfig    gcc-15.1.0
csky           allnoconfig    gcc-15.1.0
hexagon       allmodconfig    gcc-15.1.0
hexagon        allnoconfig    clang-22
hexagon        allnoconfig    gcc-15.1.0
i386          allmodconfig    clang-20
i386          allmodconfig    gcc-14
i386           allnoconfig    gcc-14
i386           allnoconfig    gcc-15.1.0
i386          allyesconfig    clang-20
i386          allyesconfig    gcc-14
loongarch     allmodconfig    clang-22
loongarch      allnoconfig    clang-22
loongarch      allnoconfig    gcc-15.1.0
m68k          allmodconfig    gcc-15.1.0
m68k           allnoconfig    gcc-15.1.0
microblaze     allnoconfig    gcc-15.1.0
microblaze    allyesconfig    gcc-15.1.0
mips           allnoconfig    gcc-15.1.0
mips          allyesconfig    gcc-15.1.0
nios2         allmodconfig    clang-22
nios2          allnoconfig    clang-22
nios2          allnoconfig    gcc-11.5.0
openrisc      allmodconfig    clang-22
openrisc       allnoconfig    clang-22
openrisc       allnoconfig    gcc-15.1.0
parisc         allnoconfig    clang-22
parisc         allnoconfig    gcc-15.1.0
powerpc        allnoconfig    clang-22
powerpc        allnoconfig    gcc-15.1.0
riscv         allmodconfig    clang-22
riscv          allnoconfig    clang-22
riscv          allnoconfig    gcc-15.1.0
s390           allnoconfig    clang-22
sh            allmodconfig    gcc-15.1.0
sh             allnoconfig    clang-22
sh             allnoconfig    gcc-15.1.0
sparc          allnoconfig    clang-22
sparc          allnoconfig    gcc-15.1.0
sparc64       allmodconfig    clang-22
um             allnoconfig    clang-22
um            allyesconfig    gcc-15.1.0
x86_64        allmodconfig    clang-20
x86_64         allnoconfig    clang-20
x86_64         allnoconfig    clang-22
x86_64        allyesconfig    clang-20
x86_64        rhel-9.4-bpf    gcc-14
x86_64      rhel-9.4-kunit    gcc-14
x86_64        rhel-9.4-ltp    gcc-14
x86_64       rhel-9.4-rust    clang-20
xtensa         allnoconfig    clang-22
xtensa         allnoconfig    gcc-15.1.0
xtensa        allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

