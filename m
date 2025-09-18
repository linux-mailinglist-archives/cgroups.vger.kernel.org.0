Return-Path: <cgroups+bounces-10271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC114B872E5
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 23:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E597E4063
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232572D7DDE;
	Thu, 18 Sep 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qpbuv+BF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700952222B4
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232327; cv=none; b=r0EDd3C9YZkO9quF2Qse9QiEZWxtDD6oCyvnK4gdeq8cJNWTB+KV0FlmUw9AvjuuqZuD6IjWCE55YLPMzm6J5WMNgvda/tPNwKF5ZiDaAgGNxWADCVYSH+C0YvzrsISUaHp/q0vgPSseM+D4JkH+TaYjN1tbYj4enXPijvXUifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232327; c=relaxed/simple;
	bh=K7+O9+GHq7OWE6dUmxnEinNjDleDLBujzz330n+OXE8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i2xLq1iS8zlz481c0/LZGb5llIUHRlU5F4TNoJTypfkRropqlzjsy4+lNuzz97wCScINqkITO0HhxktFD+3WC2m5u5sEYMSyMkhuXNZ7v3OqZ/sAZnYlNPQdgcDafMsAm+FtVZI/aF20vAw6k6dWJ66Bd+EE/1CsodA8HtcX5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qpbuv+BF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758232327; x=1789768327;
  h=date:from:to:cc:subject:message-id;
  bh=K7+O9+GHq7OWE6dUmxnEinNjDleDLBujzz330n+OXE8=;
  b=Qpbuv+BFFHTQ3qyYt4QcqQY+nOQe8VbtqZMvtai2eyZGFScLE/EIOeKc
   MQEBwTWhMZ5uOKGeTzqnrDwsSFwHySmJfvqBBPKWS7KMMLlJxqgHmdR9A
   xeVwsy0xEhnk5ZFTH3L33OKYVDTjoUm4hdsLN2d1mJVtC1ttZyRugiHmW
   5dlBa8/KE7kKJdXn8URqnySq47CrzGZ2UqdmRkl1wPO62YM5QvXm/0ktp
   8mtGTx/ll3uNXHlCg7yMKq/QAZbPArBCkgDBOCqxsBjEOFeCvVsCccFw+
   1cEYA1z53Lp20mgw3J/Ss0JlfdePZAoP5ae6HDpdXlULLgaloybGmDAh8
   A==;
X-CSE-ConnectionGUID: Dc5BlwvMSXOD+b6GPJcgVw==
X-CSE-MsgGUID: bf6P+nEgSRewn0PvsZgZ7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="78020639"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="78020639"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:52:06 -0700
X-CSE-ConnectionGUID: dBsxO1RfTTeaX20LeVJGGA==
X-CSE-MsgGUID: 1e/gDbNnQhm8JIFdG/YJig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="176071559"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Sep 2025 14:52:04 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzMXq-0003lj-2V;
	Thu, 18 Sep 2025 21:52:02 +0000
Date: Fri, 19 Sep 2025 05:51:53 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18] BUILD SUCCESS
 c49b5e89c45f317f23d11b640f77e91d0d8e5b56
Message-ID: <202509190547.dHRGmQ67-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
branch HEAD: c49b5e89c45f317f23d11b640f77e91d0d8e5b56  cpuset: use partition_cpus_change for setting exclusive cpus

elapsed time: 1555m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-002-20250918    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                          ep93xx_defconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250918    gcc-11.5.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-002-20250918    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250918    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-002-20250918    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-002-20250918    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-002-20250918    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-003-20250918    clang-19
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-003-20250918    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-002-20250918    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-002-20250918    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-002-20250918    clang-18
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

