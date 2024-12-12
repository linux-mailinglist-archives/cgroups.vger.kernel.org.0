Return-Path: <cgroups+bounces-5858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BD9EEF9A
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 17:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678AE297937
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4C222D65;
	Thu, 12 Dec 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/CaQ3j5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0A223E71
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019646; cv=none; b=j/YWL/Qlc0+noiX9th4WaF1BDctRnlQZJ4hotE0ndD7qnnuczJOOFiJhf+zplBhEPRH2t/SXsueLSs7WhrjysNLYHHRPdZXjG2fN+b+lVoVTiwKiTwJAb/fO5YAoPpNzM+IEbQtWauSEsgRhw8bDCGCJbA/GBVrygfHGtSgcBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019646; c=relaxed/simple;
	bh=sVo2uXZjElJI3rby2wiIfDSVuccG6Njdw9fSD9kxrss=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I8CeGNqMeShX2VLtJgRtAQmSkb7XCCPYfmcr7QbzhFXB6rpg9Tkpep/D4nth4rdBhjxUPPmSz9OUR6QVpR/5cV7AxeFnJTOTch4vhf1k7SJ/4WKKc38kGa9JfDpaFH9EhW422xleQ4a2rWNZD5cfj9qWdNK1VVLFxR+Mukol+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/CaQ3j5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734019645; x=1765555645;
  h=date:from:to:cc:subject:message-id;
  bh=sVo2uXZjElJI3rby2wiIfDSVuccG6Njdw9fSD9kxrss=;
  b=R/CaQ3j5f/F1jAfhYIIWvuiP7FCmisdyJI1Gyi2mcuKDYwfPzRXT8LrQ
   tnkve1XYZ+T6jnDMnLqe7Fb7xGDCQ7vgdYIW2eFSgdEcmKNtwnmuOHQpy
   ny5bicHx5eJQEpMiLVLuFueDZCVv/ZWO4g404s5y9GCK4sIXmLHGt0eWw
   Idd09RXowUdgQe+44Fd432OxlP3SBi8blgx41FMBN06xSuGMQEv7+jDsV
   FU2WVemHqZGBqPrN/Un+Hpd9pkHCVZOKPmDVLk9OkGkTHN+HBCnbjrdiP
   UZHxzJHrZ6LQuZO6NsuH7GWNEVrd+gkAMjssHiNcF2oVh1PVPcjsoCvj2
   g==;
X-CSE-ConnectionGUID: L1rOqYEFRQmlf6lLTfS86w==
X-CSE-MsgGUID: g/rsOosnQfOJmjrYA+YViQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45829967"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45829967"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:07:24 -0800
X-CSE-ConnectionGUID: yYUKdDiWQ8yJ2MAWSvcncw==
X-CSE-MsgGUID: 5K0+Moo7R+yrgGSxO4dy6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101220756"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Dec 2024 08:07:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLlif-000941-2b;
	Thu, 12 Dec 2024 16:07:17 +0000
Date: Fri, 13 Dec 2024 00:06:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.13-fixes] BUILD SUCCESS
 9b496a8bbed9cc292b0dfd796f38ec58b6d0375f
Message-ID: <202412130044.Jxdzj0Am-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.13-fixes
branch HEAD: 9b496a8bbed9cc292b0dfd796f38ec58b6d0375f  cgroup/cpuset: Prevent leakage of isolated CPUs into sched domains

elapsed time: 1455m

configs tested: 70
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20241212    gcc-13.2.0
arc                   randconfig-002-20241212    gcc-13.2.0
arm                   randconfig-001-20241212    gcc-14.2.0
arm                   randconfig-002-20241212    clang-20
arm                   randconfig-003-20241212    clang-19
arm                   randconfig-004-20241212    clang-20
arm64                 randconfig-001-20241212    clang-20
arm64                 randconfig-002-20241212    clang-15
arm64                 randconfig-003-20241212    clang-20
arm64                 randconfig-004-20241212    gcc-14.2.0
csky                  randconfig-001-20241212    gcc-14.2.0
csky                  randconfig-002-20241212    gcc-14.2.0
hexagon               randconfig-001-20241212    clang-14
hexagon               randconfig-002-20241212    clang-16
i386        buildonly-randconfig-001-20241212    clang-19
i386        buildonly-randconfig-002-20241212    clang-19
i386        buildonly-randconfig-003-20241212    clang-19
i386        buildonly-randconfig-004-20241212    clang-19
i386        buildonly-randconfig-005-20241212    clang-19
i386        buildonly-randconfig-006-20241212    gcc-12
loongarch             randconfig-001-20241212    gcc-14.2.0
loongarch             randconfig-002-20241212    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241212    gcc-14.2.0
nios2                 randconfig-002-20241212    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20241212    gcc-14.2.0
parisc                randconfig-002-20241212    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20241212    gcc-14.2.0
powerpc               randconfig-002-20241212    clang-20
powerpc               randconfig-003-20241212    clang-15
powerpc64             randconfig-001-20241212    clang-20
powerpc64             randconfig-002-20241212    gcc-14.2.0
powerpc64             randconfig-003-20241212    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20241212    clang-17
riscv                 randconfig-002-20241212    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241212    clang-18
s390                  randconfig-002-20241212    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241212    gcc-14.2.0
sh                    randconfig-002-20241212    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241212    gcc-14.2.0
sparc                 randconfig-002-20241212    gcc-14.2.0
sparc64               randconfig-001-20241212    gcc-14.2.0
sparc64               randconfig-002-20241212    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20241212    gcc-12
um                    randconfig-002-20241212    clang-20
x86_64      buildonly-randconfig-001-20241212    clang-19
x86_64      buildonly-randconfig-002-20241212    gcc-12
x86_64      buildonly-randconfig-003-20241212    clang-19
x86_64      buildonly-randconfig-004-20241212    clang-19
x86_64      buildonly-randconfig-005-20241212    gcc-11
x86_64      buildonly-randconfig-006-20241212    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241212    gcc-14.2.0
xtensa                randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

