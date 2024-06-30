Return-Path: <cgroups+bounces-3462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A9691D340
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E2E1F211E9
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF652C69B;
	Sun, 30 Jun 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbda75W1"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDAD2110F
	for <cgroups@vger.kernel.org>; Sun, 30 Jun 2024 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719773167; cv=none; b=fQWwlsYUY0Kq3ekNCZN1Ew9GWxKlkpToZe4yJEThEb54Z8m9ce3QLFB6XIsJ2K49SpiueBypdrpdGcjtns3ZS6OOiuPhJZTaVMaZvLxpDZWAw2r9y8l6CAzHmQMUKM72y2u6DV7QrCIIfhGANjDbpmMtC/tu0erDIKAfMVj08WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719773167; c=relaxed/simple;
	bh=J1ZtDH+DDrbsTPVM87r3Cta7luWva8NYzXhZfQ9wulw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rrTSQJZr4fXbVrvBB2Zk5+vm1bUYogNx24JdwTjdbSKDuzYZmcqJHvEhxF4ECmJxiahUpgvbwPIwfRZJOo8RHFk3aT8ks7tsCCnziuo3sYi53Umg6hSCoFqstwin0dKMPnuJbgNC+1rwuq/o18AdNI3NcI1HdWhUSxT4O7iKEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbda75W1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719773163; x=1751309163;
  h=date:from:to:cc:subject:message-id;
  bh=J1ZtDH+DDrbsTPVM87r3Cta7luWva8NYzXhZfQ9wulw=;
  b=kbda75W1Z4ej34uMKPR8M1Lz3JWjy2NwjvP1Ovuozc1pEBvkKtr+yAJE
   kpthvYSZzI+Pbd6JFs+oyaTydazMkvFA47ckq0/dcdVb8Ablhs6CTZM2r
   smL3rvMOHemixYdsVI06cXYcfjnA4uEuU8/jX5fdaq0cP4ON2rfYhrrBd
   I0+ecnOnOB3lzlcbNMc6dWJNdgGpga+NZA2Fs3bxGr8NkCfL/3XgkYr21
   y4cXr3z6haMhBIpGLv8dZSGIE+OtS8l04O6KxBIlbP9Wn1bP2krtw1gt1
   5TQgEtcpINzvnxpZtcWPHiFxgUvSKAzxKprfVyoCf8mHIUcmuKowmpiYW
   A==;
X-CSE-ConnectionGUID: I+2qg+0xQgOQoopiOV7aNg==
X-CSE-MsgGUID: aE9IU/VYRV6xb99L/jgchw==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="16837853"
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="16837853"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 11:46:03 -0700
X-CSE-ConnectionGUID: 78p6hzVCRVSVUPuccslYtA==
X-CSE-MsgGUID: 2PshAHZ0SlSCNC86IHElJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="50469600"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Jun 2024 11:46:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNzYl-000LqR-2S;
	Sun, 30 Jun 2024 18:45:59 +0000
Date: Mon, 01 Jul 2024 02:45:10 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.10-fixes] BUILD SUCCESS
 1be59c97c83ccd67a519d8a49486b3a8a73ca28a
Message-ID: <202407010208.ZdFglyr7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.10-fixes
branch HEAD: 1be59c97c83ccd67a519d8a49486b3a8a73ca28a  cgroup/cpuset: Prevent UAF in proc_cpuset_show()

elapsed time: 2936m

configs tested: 75
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

