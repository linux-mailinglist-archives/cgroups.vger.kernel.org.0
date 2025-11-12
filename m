Return-Path: <cgroups+bounces-11897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F5FC54DE2
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 01:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405A24E03B6
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 00:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D12F1FDE;
	Thu, 13 Nov 2025 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDmZi027"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54135CBC1
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992001; cv=none; b=Mxrf9tGSYYRHrhKj6j6Ow/cfNOyAtvdZBQs0rlnrXZwBWXrRDCJknKw8UynJ6zlKAJqy5UZkxgK3Ft0VFcQfh9um2bDQ6Dt45rKejseegLbrVCl7jRDf37ZDq3155MDsVgp9LPwdsuWKnepCrtvYS94tzxWRmy6lX6hwvBh/ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992001; c=relaxed/simple;
	bh=ZyIxt9/00sHM6bBtW8Y8dNA/bp64Fn3kWUNVUyw5sEI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I22YO+apnOMjTdfE9HUGijRmsugwzq8jqb+582kAGqm7Ot/ZvZn98X0B4bZ9u09Vu2APnsoaZY+vwJv8AU/XlgMFjyWFxqGP043HMLNIxMo8BFTBzkeQAE/896iRpjiYwujFqVD+YG3OlmKcr3LAOzXPj0XB5cqnrysjJsnArtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDmZi027; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762991999; x=1794527999;
  h=date:from:to:cc:subject:message-id;
  bh=ZyIxt9/00sHM6bBtW8Y8dNA/bp64Fn3kWUNVUyw5sEI=;
  b=dDmZi027t+0JSuFXAE/602HoyyEoLcRKxWtl7Iv4vTMlVqpkQBGNKmBK
   /tgpCVqYItdKMUzwtIdAoiXWAImkXW+fJsaY8uclnebvK1TrY4KqgFQbP
   OIfwkYtH+nK//a1WxPVUhcXIVe87CUGkdzHLK3YZ4l9YCURBL1yLkCk/S
   NRnxe8cgUMzThjsGcnmhOAdDmgYuUWjTV/kkBRd4W1Rj/zjjm/cFD0AKi
   2oxMEUqCbLTnlgdpYTKRwIj5FQEcz3aV9JMNT4/kqhFW4+CRygrf46WQF
   NbWZKtPGo8y6k+UCe3o53a6YEutltPL0cVbx92KGPh/t+++qow6ox7ob3
   Q==;
X-CSE-ConnectionGUID: vHvbCrL4Tr+GfQm4oR3C+w==
X-CSE-MsgGUID: Ir7AiARSRomRYC3nX/KTxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67665040"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="67665040"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 15:59:58 -0800
X-CSE-ConnectionGUID: JkwabmsNTCqWWdB+Qc0O8w==
X-CSE-MsgGUID: izqY+rzgSbSZ4mZl/wjfNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189357873"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2025 15:59:56 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJKkk-0004jB-2O;
	Wed, 12 Nov 2025 23:59:54 +0000
Date: Thu, 13 Nov 2025 07:59:07 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19] BUILD SUCCESS
 f23cb0ced8fb28ba65bf4ddaa2fcaf044c6894cc
Message-ID: <202511130702.cKZ9bHZc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19
branch HEAD: f23cb0ced8fb28ba65bf4ddaa2fcaf044c6894cc  cpuset: remove need_rebuild_sched_domains

elapsed time: 1544m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251112    gcc-8.5.0
arc                   randconfig-002-20251112    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251112    gcc-8.5.0
arm                   randconfig-002-20251112    clang-22
arm                   randconfig-003-20251112    clang-22
arm                   randconfig-004-20251112    gcc-14.3.0
arm                        realview_defconfig    clang-16
arm                           sama5_defconfig    gcc-15.1.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251112    clang-22
arm64                 randconfig-002-20251112    gcc-10.5.0
arm64                 randconfig-003-20251112    gcc-8.5.0
arm64                 randconfig-004-20251112    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251112    gcc-13.4.0
csky                  randconfig-002-20251112    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251112    clang-16
hexagon               randconfig-002-20251112    clang-22
i386                              allnoconfig    gcc-14
i386                  randconfig-001-20251113    gcc-14
i386                  randconfig-004-20251113    gcc-14
i386                  randconfig-011-20251112    gcc-14
i386                  randconfig-012-20251112    gcc-14
i386                  randconfig-013-20251112    clang-20
i386                  randconfig-014-20251112    clang-20
i386                  randconfig-015-20251112    clang-20
i386                  randconfig-016-20251112    gcc-14
i386                  randconfig-017-20251112    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251112    gcc-15.1.0
loongarch             randconfig-002-20251112    gcc-13.4.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251112    gcc-11.5.0
nios2                 randconfig-002-20251112    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251112    gcc-9.5.0
parisc                randconfig-002-20251112    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251112    clang-22
powerpc               randconfig-002-20251112    clang-22
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251112    clang-22
powerpc64             randconfig-002-20251112    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251113    gcc-8.5.0
riscv                 randconfig-002-20251113    gcc-11.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251113    clang-22
s390                  randconfig-002-20251113    clang-17
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251113    gcc-15.1.0
sh                    randconfig-002-20251113    gcc-11.5.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251113    gcc-8.5.0
sparc                 randconfig-002-20251113    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251113    clang-20
sparc64               randconfig-002-20251113    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251113    gcc-14
um                    randconfig-002-20251113    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251113    gcc-14
x86_64      buildonly-randconfig-002-20251113    clang-20
x86_64      buildonly-randconfig-003-20251113    clang-20
x86_64      buildonly-randconfig-004-20251113    gcc-14
x86_64      buildonly-randconfig-005-20251113    gcc-12
x86_64      buildonly-randconfig-006-20251113    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251113    gcc-14
x86_64                randconfig-072-20251113    gcc-12
x86_64                randconfig-073-20251113    gcc-12
x86_64                randconfig-074-20251113    gcc-14
x86_64                randconfig-075-20251113    gcc-14
x86_64                randconfig-076-20251113    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251113    gcc-15.1.0
xtensa                randconfig-002-20251113    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

