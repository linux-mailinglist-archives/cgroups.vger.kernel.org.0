Return-Path: <cgroups+bounces-3065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D228D745C
	for <lists+cgroups@lfdr.de>; Sun,  2 Jun 2024 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AA0B2104B
	for <lists+cgroups@lfdr.de>; Sun,  2 Jun 2024 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085425745;
	Sun,  2 Jun 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnkzdGxF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D313ACC
	for <cgroups@vger.kernel.org>; Sun,  2 Jun 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318552; cv=none; b=u7cBEAXo7p7h0+Jbz9RrtlDEOrRH5CXtjIOPgDj09lOFivSLoxQsv3yOcOZonSz932NX4fLPL867QocwtHUZsj2sXJZFHWq0SnoBc6kBqvO3rRWXL6zWs3+oPhbrmR8U9nxOhECTb0EfHx0rD/ryCJ/PxkJ0VCAOkk66ESAMwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318552; c=relaxed/simple;
	bh=QuF7ooywPG61pCz9jq5Uy0PytWMf/LLKeZFrCUNFCms=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fZnBfOTONoA4KAu9ush0pOz1MiJO5aQprXiu95pT0Kvzwgip5jk3qKZ0LlfzOBvt9JPJQN7RWX47H+VA9t7eCRIeUN0FEhDyJSFl+mYvS00LLQLE3E1cS8gkb2MwC24HrqBVrXmy2ccv4lVbjm3LrjC3G8eBKY+eSHMozZW5Pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnkzdGxF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717318550; x=1748854550;
  h=date:from:to:cc:subject:message-id;
  bh=QuF7ooywPG61pCz9jq5Uy0PytWMf/LLKeZFrCUNFCms=;
  b=lnkzdGxFIddNBNKJNzL0PuZ5RKNaj62RXcbDPT8YEwsPQpnm+d+XaV9x
   HjG54pYGXL2E79r6B2GxPvefPQP9LdskRXoFp4L54H6TTXX99nrhOg5KV
   r5LNA4ek9wjyCTIl5dUEbilHv1rscNvdZcWTkltEVfiHiDzwVyFzxO0CJ
   xpgUsu1cFF2QPbEzJjhv6H0EuBQpG/Wr7Xg0HJr4DsNU9RjNJWQlPPdk2
   Rp6ovO3O3trE8w1DjshB5leUk3MRdzab8ducfgaGOaPuHRaatmxmW3mNg
   TNOTg0oW30Ec9Jikv8vI/aLyV/7FWIfkMgP1UrlYfoHf1H/Nwx2GVbm8D
   Q==;
X-CSE-ConnectionGUID: vUa7k3tdSJelVwvq42MbkQ==
X-CSE-MsgGUID: kNy8metOTxqnKRem9iKTVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24481384"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="24481384"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 01:55:49 -0700
X-CSE-ConnectionGUID: aeHSeWRBQEKO4KB//hjR4A==
X-CSE-MsgGUID: nGtVf3SZTTyTTLLyYI0lfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="36612778"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Jun 2024 01:55:48 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDh0E-000JtN-1L;
	Sun, 02 Jun 2024 08:55:46 +0000
Date: Sun, 02 Jun 2024 16:55:08 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 018ee567def3b43f810aebf15221eef3858177b2
Message-ID: <202406021606.grpPOY5X-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 018ee567def3b43f810aebf15221eef3858177b2  cgroup/cpuset: Reduce the lock protecting CS_SCHED_LOAD_BALANCE

elapsed time: 915m

configs tested: 163
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-002-20240602   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240602   clang
arm                   randconfig-002-20240602   clang
arm                   randconfig-003-20240602   gcc  
arm                   randconfig-004-20240602   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240602   clang
arm64                 randconfig-002-20240602   gcc  
arm64                 randconfig-003-20240602   clang
arm64                 randconfig-004-20240602   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-002-20240602   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240602   clang
hexagon               randconfig-002-20240602   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240602   clang
i386         buildonly-randconfig-002-20240602   gcc  
i386         buildonly-randconfig-003-20240602   clang
i386         buildonly-randconfig-004-20240602   clang
i386         buildonly-randconfig-005-20240602   clang
i386         buildonly-randconfig-006-20240602   clang
i386                                defconfig   clang
i386                  randconfig-001-20240602   clang
i386                  randconfig-002-20240602   clang
i386                  randconfig-003-20240602   clang
i386                  randconfig-004-20240602   gcc  
i386                  randconfig-005-20240602   clang
i386                  randconfig-006-20240602   clang
i386                  randconfig-011-20240602   clang
i386                  randconfig-012-20240602   clang
i386                  randconfig-013-20240602   clang
i386                  randconfig-014-20240602   gcc  
i386                  randconfig-015-20240602   gcc  
i386                  randconfig-016-20240602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-002-20240602   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-002-20240602   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-002-20240602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240602   clang
powerpc               randconfig-002-20240602   gcc  
powerpc               randconfig-003-20240602   clang
powerpc64             randconfig-001-20240602   clang
powerpc64             randconfig-002-20240602   gcc  
powerpc64             randconfig-003-20240602   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240602   clang
riscv                 randconfig-002-20240602   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240602   gcc  
s390                  randconfig-002-20240602   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-002-20240602   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-002-20240602   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240602   gcc  
um                    randconfig-002-20240602   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240602   gcc  
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-004-20240602   gcc  
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240602   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240602   gcc  
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-004-20240602   gcc  
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-011-20240602   gcc  
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-014-20240602   gcc  
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-016-20240602   gcc  
x86_64                randconfig-071-20240602   gcc  
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-073-20240602   gcc  
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-076-20240602   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-002-20240602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

