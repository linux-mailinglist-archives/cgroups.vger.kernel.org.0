Return-Path: <cgroups+bounces-11684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5F4C43678
	for <lists+cgroups@lfdr.de>; Sun, 09 Nov 2025 00:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C00614E23F1
	for <lists+cgroups@lfdr.de>; Sat,  8 Nov 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AD27EFEF;
	Sat,  8 Nov 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fS7J3qWA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA428031D
	for <cgroups@vger.kernel.org>; Sat,  8 Nov 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762644604; cv=none; b=r4sRu3tqSVjWLejjTdUL5diX1zwTTB3bOiSrLmk4r54BKNS7yEg6YSUSlJ56n2LqAe1pjLvwnl5VWlAbKycF+A401uv1f+fCgBHX2t64LrjvreHtbpjgpPaPo41Ltu+Qsn4Ia4AavnapDgS3rH18mzyg10Uow0kHhbO2FW1us2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762644604; c=relaxed/simple;
	bh=bhOD2Y7RYBFrtCn/oN76u48SaQKT2Ai6nnpt/fQq66g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bYkoXWo89NbEe4VEpdy9IuiKnlsrl/AQoPnE6kOfhsZEn/m4MgQze2wz31SrdH7AVe2jA2RZn7j/9k5/68kAA9ocAe2rMGuI6skBeELP+KT+w1Lo6dW1t6NwFstjhuZmYKcagBDlL7tjLohHoUxGE7mXtUdtJIfoBVaTnA8ODAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fS7J3qWA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762644602; x=1794180602;
  h=date:from:to:cc:subject:message-id;
  bh=bhOD2Y7RYBFrtCn/oN76u48SaQKT2Ai6nnpt/fQq66g=;
  b=fS7J3qWAwnhWE31Ra4jWX4NUt89xCQIGfolzriLwoI3iQoa31RR22e/4
   lt88B6vCICUKoVyOlmvG6FPXnrmVtfkqx+zuPsNmiAtR0hS61EPIZeVUZ
   glMi0euLB61HLWLUYyDU5jQ+LEVqWjm0lYAWKpOR/EdZUCZEVjU4IssXH
   mHjXcy+ZeTNG8+yt3DkdnTdSAN2gZizWGWwjJeMq7hoIOYHYdPbmOI6Lb
   7lJjEPTdv8Qr1/JONj1zRKBZSZ0h9Wih8hIr+1/9u8pWDAt8D7KakJwC4
   SJbGUpsx1UJo+drBdzuscRbmHzDo6uCBOghiJ9JPu6+IGxFc3uFEEzbPj
   A==;
X-CSE-ConnectionGUID: a6Ak5qr0Qd2yqvlPvWtCBg==
X-CSE-MsgGUID: KcTrznOYRUG6UbEIL3pv6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63759887"
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="63759887"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 15:30:01 -0800
X-CSE-ConnectionGUID: zF9xZXwmTs+8Lr/etrKatA==
X-CSE-MsgGUID: qJ2Y2k/ORZ+gbHzIvWDqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="192615269"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2025 15:30:00 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHsNa-0001Yn-12;
	Sat, 08 Nov 2025 23:29:58 +0000
Date: Sun, 09 Nov 2025 07:29:00 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18-fixes] BUILD SUCCESS
 de8163e2dd03e0c2e4c16935c7e45b796e24d0d1
Message-ID: <202511090754.yiPiwyGQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18-fixes
branch HEAD: de8163e2dd03e0c2e4c16935c7e45b796e24d0d1  cgroup: Skip showing PID 0 in cgroup.procs and cgroup.threads

elapsed time: 2937m

configs tested: 82
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    clang-19
arc                    allmodconfig    clang-19
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    clang-19
arc         randconfig-001-20251107    gcc-8.5.0
arc         randconfig-002-20251107    gcc-9.5.0
arm                    allmodconfig    clang-19
arm                     allnoconfig    clang-22
arm                    allyesconfig    clang-19
arm         randconfig-001-20251107    clang-17
arm         randconfig-002-20251107    gcc-13.4.0
arm         randconfig-003-20251107    clang-22
arm         randconfig-004-20251107    gcc-8.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-19
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-19
hexagon     randconfig-001-20251107    clang-22
hexagon     randconfig-002-20251107    clang-22
i386                   allmodconfig    clang-20
i386                    allnoconfig    gcc-14
i386                   allyesconfig    clang-20
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
loongarch   randconfig-001-20251107    gcc-15.1.0
loongarch   randconfig-002-20251107    clang-19
m68k                   allmodconfig    clang-19
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    clang-19
microblaze             allmodconfig    clang-19
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    clang-19
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251107    gcc-11.5.0
nios2       randconfig-002-20251107    gcc-8.5.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    gcc-15.1.0
riscv                  allmodconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    gcc-15.1.0
riscv       randconfig-001-20251107    clang-22
riscv       randconfig-002-20251107    gcc-13.4.0
s390                    allnoconfig    clang-22
s390        randconfig-001-20251107    gcc-8.5.0
s390        randconfig-002-20251107    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251107    gcc-13.4.0
sh          randconfig-002-20251107    gcc-11.5.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    clang-19
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

