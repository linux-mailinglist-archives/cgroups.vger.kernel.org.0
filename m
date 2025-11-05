Return-Path: <cgroups+bounces-11593-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F57C3633E
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAD624FA7E0
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515AF22A4F4;
	Wed,  5 Nov 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATqblyKg"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0E248F57
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354576; cv=none; b=hQEaPzB3rq610bp/ciSkWO9Rn9f/zeJ7kOMuUkIjnFYq7ESKHZiOZrV8MlODgavysDNv4oE/s3vNoX4TAcP2ugviZt3fUSfryXSmlJUBJZG+nfAdCwAwPzgJEYtEnFKxZ/gAEquHLH6F+FOeo91MRn6+4tU9gWt4wtCeympobKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354576; c=relaxed/simple;
	bh=vxLga8UwwdEwexnkNwY5hV1VwUt2AlN7gwRFIFAUgYI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bcy/mWER7aPng0h8M8cnYAVila5/MOtt4AZU3qz07gDWE8ng5Xw2hVa7hJ2d/gsJ45mOOfrD/CAUwGVh1gLcrX/gGR4nrv9FxcZeZx4I9M523dMnP6Lo3aY49flxWHJGEuxgTvh4itzJZE42ffz8FIyWvWXUVnkTv9+zcOhTP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATqblyKg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762354574; x=1793890574;
  h=date:from:to:cc:subject:message-id;
  bh=vxLga8UwwdEwexnkNwY5hV1VwUt2AlN7gwRFIFAUgYI=;
  b=ATqblyKgkFOB8g2GuV728kyh3Zjs24bDSmX5y1Y/IG4BHlujB5CiIZDm
   uYqx5JVNoCBhpHzNScj9OIhEZ6vfi82fCpEK2c8ULQgOuND5BDlZcM2eT
   Op+KWnS/qyOF8PEVhAbLvcg8O06HKDd0WAaxDvfqBKsMfWZEUpnts7x//
   cW/wyfpy0ukvRmjApufIwhOSNures48jViW0bbAuzpXokMJCiUbZo4tZi
   Za9lebWDOmLEtEctwwea3dBU1JsuyWkF9evfBntqJrP6IzQqGtzA70J47
   R0yM4lKnBSGGh/N8yE4LLyeECWEHRSpCfcmFlyuPx8mij5qGHqR/a0+lg
   g==;
X-CSE-ConnectionGUID: x5yIj9XmTtKASdU6+yR/2w==
X-CSE-MsgGUID: P2vUuy1XTfywvgfsFvXpwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68308822"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68308822"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:56:14 -0800
X-CSE-ConnectionGUID: nF4QEQLORhe1u9ZRKdl0Kg==
X-CSE-MsgGUID: 0hNp0N74SialYN1YV3qJ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="192643362"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2025 06:56:13 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGevV-000Sit-2Y;
	Wed, 05 Nov 2025 14:56:10 +0000
Date: Wed, 05 Nov 2025 22:45:10 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19] BUILD SUCCESS
 d245698d727ab8f5420b3e28d1243f96a5234851
Message-ID: <202511052205.sEW8BRrP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19
branch HEAD: d245698d727ab8f5420b3e28d1243f96a5234851  cgroup: Defer task cgroup unlink until after the task is done switching out

elapsed time: 2146m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    clang-19
arc                    allmodconfig    clang-19
arc                    allmodconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    clang-19
arc                    allyesconfig    gcc-15.1.0
arc         randconfig-001-20251104    gcc-12.5.0
arc         randconfig-002-20251104    gcc-9.5.0
arm                    allmodconfig    clang-19
arm                    allmodconfig    gcc-15.1.0
arm                     allnoconfig    clang-22
arm                    allyesconfig    clang-19
arm                    allyesconfig    gcc-15.1.0
arm         randconfig-001-20251104    gcc-14.3.0
arm         randconfig-002-20251104    gcc-10.5.0
arm         randconfig-003-20251104    clang-22
arm         randconfig-004-20251104    gcc-8.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-19
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-19
hexagon     randconfig-001-20251104    clang-22
hexagon     randconfig-002-20251104    clang-16
i386                   allmodconfig    clang-20
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    clang-20
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
loongarch   randconfig-001-20251104    gcc-15.1.0
loongarch   randconfig-002-20251104    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                  allmodconfig    clang-22
nios2                   allnoconfig    gcc-11.5.0
nios2                  allyesconfig    clang-22
nios2                  allyesconfig    gcc-11.5.0
nios2       randconfig-001-20251104    gcc-8.5.0
nios2       randconfig-002-20251104    gcc-11.5.0
openrisc               allmodconfig    clang-22
openrisc               allmodconfig    gcc-15.1.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
parisc      randconfig-001-20251104    gcc-8.5.0
parisc      randconfig-002-20251104    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    gcc-15.1.0
powerpc     randconfig-001-20251104    gcc-15.1.0
powerpc     randconfig-002-20251104    clang-22
powerpc64   randconfig-001-20251104    clang-22
riscv                  allmodconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    gcc-15.1.0
s390                   allmodconfig    gcc-15.1.0
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                  allyesconfig    clang-22
sparc                  allyesconfig    gcc-15.1.0
sparc64                allmodconfig    clang-22
sparc64                allyesconfig    clang-22
sparc64                allyesconfig    gcc-15.1.0
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
xtensa                 allyesconfig    clang-22
xtensa                 allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

