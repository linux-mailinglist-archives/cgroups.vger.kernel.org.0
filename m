Return-Path: <cgroups+bounces-9060-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FDDB1F8F6
	for <lists+cgroups@lfdr.de>; Sun, 10 Aug 2025 09:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111B1189800F
	for <lists+cgroups@lfdr.de>; Sun, 10 Aug 2025 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2BE2153C1;
	Sun, 10 Aug 2025 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAzjGw4Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD285B21A
	for <cgroups@vger.kernel.org>; Sun, 10 Aug 2025 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812045; cv=none; b=lJGEfAxW8MKFGHw9dtHExmPSZl5KUEuQW79ijml4L/RPE+J+02OTCEb05w45FZ6u7Nho0hGIA5M4jQJSH2D1OMHZ+RSc/wdLiVffXXRg3rgDU9rW6UO6PKMn/AOsIwGfaRhMIqQ4FlsDqwIKbcTa2i5uILdmeNcQUBReojeko/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812045; c=relaxed/simple;
	bh=wQnNeKLrGyDvZMFLU9bhTtif2X2PJkckWYwVuvPdl6s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rJug3AKD7hQFuRv+DXrUcTxGt1J0Cn+Y0Bow/6eOhN/g86bZGQbyriknSyLZJ90/bICN0R5OoMhXib09pdvVuzN9gVKCDyhD5e3M0LbqDADpdkP/uYhACOzX009MBK27ZT04R9CJgMyv4uWtXkjyTyltPj3X4kArz7klfiwEW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAzjGw4Q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754812044; x=1786348044;
  h=date:from:to:cc:subject:message-id;
  bh=wQnNeKLrGyDvZMFLU9bhTtif2X2PJkckWYwVuvPdl6s=;
  b=NAzjGw4Qa81dxYqn9wHVMaDNUvx/u637Yz52PiIgEMe9voAbRNOf9Liv
   Ua+bGTH74C38QdEPPj3DugWx9NF9BqXs3r3Nt7hp+VUPP4+6BD6q8PPKw
   VlFxc5bq3KfEiD7UdvyFg/zG6kpHe+RaqV5+nvFe0zQfVn8IuRCvIeNeK
   lIP8vpEGjMm1BOla9agom0WAJeW3pLEit246oK5uKIWfW+CKHeGknq0RT
   nlCH3edsZJ7+IlzyqwTz6mkYvj2zxJm7bt2u3ZKbKgtUCQ8GI7AvF1h0m
   6fBhjXhyrVyy6VZcpVeZK2PW/neG5+m9Ln4yJ3Ql/th2pVGfJDFyczDE/
   Q==;
X-CSE-ConnectionGUID: fizIJDUCQO23fPauZbaWQQ==
X-CSE-MsgGUID: PHBZwQuLTnSw6tS4+kPWAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="56996970"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56996970"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 00:47:24 -0700
X-CSE-ConnectionGUID: whPk61axQe2Hg1VJzUokJQ==
X-CSE-MsgGUID: BYLsg0B1SYOrzudQPmQcAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165302525"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 10 Aug 2025 00:47:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ul0lu-0005D8-0S;
	Sun, 10 Aug 2025 07:47:15 +0000
Date: Sun, 10 Aug 2025 15:46:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 eea51c6e3f6675b795f6439eaa960eb2948d6905
Message-ID: <202508101517.C8khXKbY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: eea51c6e3f6675b795f6439eaa960eb2948d6905  cgroup: avoid null de-ref in css_rstat_exit()

elapsed time: 721m

configs tested: 135
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20250810    gcc-8.5.0
arc                   randconfig-002-20250810    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                            dove_defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20250810    gcc-8.5.0
arm                   randconfig-002-20250810    gcc-8.5.0
arm                   randconfig-003-20250810    clang-22
arm                   randconfig-004-20250810    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250810    gcc-10.5.0
arm64                 randconfig-002-20250810    gcc-8.5.0
arm64                 randconfig-003-20250810    clang-20
arm64                 randconfig-004-20250810    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250810    gcc-12.5.0
csky                  randconfig-002-20250810    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250810    clang-20
hexagon               randconfig-002-20250810    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250810    clang-20
i386        buildonly-randconfig-002-20250810    clang-20
i386        buildonly-randconfig-003-20250810    gcc-12
i386        buildonly-randconfig-004-20250810    gcc-12
i386        buildonly-randconfig-005-20250810    clang-20
i386        buildonly-randconfig-006-20250810    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250810    gcc-15.1.0
loongarch             randconfig-002-20250810    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-22
mips                        omega2p_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250810    gcc-8.5.0
nios2                 randconfig-002-20250810    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250810    gcc-9.5.0
parisc                randconfig-002-20250810    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     asp8347_defconfig    clang-22
powerpc                   lite5200b_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20250810    clang-22
powerpc               randconfig-002-20250810    clang-22
powerpc               randconfig-003-20250810    gcc-9.5.0
powerpc64             randconfig-001-20250810    gcc-10.5.0
powerpc64             randconfig-002-20250810    gcc-12.5.0
powerpc64             randconfig-003-20250810    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250810    clang-22
riscv                 randconfig-002-20250810    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250810    clang-22
s390                  randconfig-002-20250810    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250810    gcc-15.1.0
sh                    randconfig-002-20250810    gcc-15.1.0
sh                          sdk7786_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250810    gcc-14.3.0
sparc                 randconfig-002-20250810    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250810    gcc-12.5.0
sparc64               randconfig-002-20250810    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250810    gcc-12
um                    randconfig-002-20250810    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250810    clang-20
x86_64      buildonly-randconfig-002-20250810    gcc-12
x86_64      buildonly-randconfig-003-20250810    gcc-12
x86_64      buildonly-randconfig-004-20250810    clang-20
x86_64      buildonly-randconfig-005-20250810    gcc-12
x86_64      buildonly-randconfig-006-20250810    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250810    gcc-11.5.0
xtensa                randconfig-002-20250810    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

