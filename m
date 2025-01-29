Return-Path: <cgroups+bounces-6371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34611A2184C
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 08:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6161884A51
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379581990AB;
	Wed, 29 Jan 2025 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fx7giOYJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327E19580F
	for <cgroups@vger.kernel.org>; Wed, 29 Jan 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136674; cv=none; b=K1rTeB+8D6fDH567ZQZIo36bFEksgv4gIk8XxttB9LnTvXWcHDzeJy49glRJzQxDR0TfcFFmv7f293bmBv0Izc2YMzdbZUUZ8n3tNHq9QhwMgWCSl4dRz3W/H7aMwgkOMldSI/TZ+wLQG9DI11vEY8My5Zc6+OuBnIvxUVAu330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136674; c=relaxed/simple;
	bh=BsaDkm79+ZnhVf14GkxPhbDvqRUJhDhHbtZkCiGq8Es=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VND4KpZF9DBPtQO71yGIG+CICrTD2DLPu6ckh8VzyNjzGTIykg7CxA5MYZVbrRR7JOZi0cZqJt3moKkzHXaTrW+RMbGDsEq1ab+INItGsdpmKC0JQlIIAuL2dfA3VFhS609xY1qsQgPQgDpas56ZO+JBRHrY0+dmW2r0iwOv+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fx7giOYJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738136672; x=1769672672;
  h=date:from:to:cc:subject:message-id;
  bh=BsaDkm79+ZnhVf14GkxPhbDvqRUJhDhHbtZkCiGq8Es=;
  b=Fx7giOYJriIKaSDJu6UHwnU8fyyv+q09fdIzTNbwx7vycWsKPbnHxWLR
   SWbbrDS1UtKWYjeDdC+wkmMeTIGBdPDq3QNfAqLv/svin2N4jo3ukl56J
   CZ9VvemjQtRO4aBm6t2TlOOuxyAPsjR7kGRotxmDllYZ8FgpR/l2QK1BU
   4oYglM4KBOgzYXuDxywcC9mPuPpc5dX9uKKarEq+AknlFj7vJkmrb2IWh
   lJuIno7valM17w6DdvEo1fGlw8vYUlWvbiyQM6vcystkOQPLNZairRFTM
   vAzdbe4PC3B86Nhen29cY79pubv3rzQ5IW96nvTm/nnLsu3ChpogUA7ke
   g==;
X-CSE-ConnectionGUID: ldgyMjr7S1uj0LnqMGcA5g==
X-CSE-MsgGUID: JNaFEH0YQViCRk5RRTlvYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="63993475"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="63993475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 23:44:31 -0800
X-CSE-ConnectionGUID: u6WzhVqZR52FqCEdZ4Yb2g==
X-CSE-MsgGUID: B5WtWHsISkCti2SvmMuPVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="113941252"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Jan 2025 23:44:30 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1td2kN-000ijH-32;
	Wed, 29 Jan 2025 07:44:27 +0000
Date: Wed, 29 Jan 2025 15:44:14 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 ad6c08d8c1045843ec564a73981ece6ec31d11a0
Message-ID: <202501291508.9iDDzJB2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: ad6c08d8c1045843ec564a73981ece6ec31d11a0  cgroup/misc: Remove unused misc_cg_res_total_usage

elapsed time: 723m

configs tested: 99
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250129    gcc-13.2.0
arc                   randconfig-002-20250129    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250129    gcc-14.2.0
arm                   randconfig-002-20250129    clang-20
arm                   randconfig-003-20250129    gcc-14.2.0
arm                   randconfig-004-20250129    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250129    gcc-14.2.0
arm64                 randconfig-002-20250129    gcc-14.2.0
arm64                 randconfig-003-20250129    gcc-14.2.0
arm64                 randconfig-004-20250129    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250129    gcc-14.2.0
csky                  randconfig-002-20250129    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250129    clang-19
hexagon               randconfig-002-20250129    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250129    clang-19
i386        buildonly-randconfig-002-20250129    gcc-12
i386        buildonly-randconfig-003-20250129    clang-19
i386        buildonly-randconfig-004-20250129    clang-19
i386        buildonly-randconfig-005-20250129    clang-19
i386        buildonly-randconfig-006-20250129    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250129    gcc-14.2.0
loongarch             randconfig-002-20250129    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250129    gcc-14.2.0
nios2                 randconfig-002-20250129    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250129    gcc-14.2.0
parisc                randconfig-002-20250129    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250129    clang-20
powerpc               randconfig-002-20250129    clang-20
powerpc               randconfig-003-20250129    gcc-14.2.0
powerpc64             randconfig-001-20250129    clang-16
powerpc64             randconfig-002-20250129    clang-18
powerpc64             randconfig-003-20250129    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250129    gcc-14.2.0
riscv                 randconfig-002-20250129    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250129    clang-20
s390                  randconfig-002-20250129    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250129    gcc-14.2.0
sh                    randconfig-002-20250129    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250129    gcc-14.2.0
sparc                 randconfig-002-20250129    gcc-14.2.0
sparc64               randconfig-001-20250129    gcc-14.2.0
sparc64               randconfig-002-20250129    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250129    gcc-12
um                    randconfig-002-20250129    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250129    clang-19
x86_64      buildonly-randconfig-002-20250129    gcc-12
x86_64      buildonly-randconfig-003-20250129    gcc-12
x86_64      buildonly-randconfig-004-20250129    gcc-12
x86_64      buildonly-randconfig-005-20250129    gcc-12
x86_64      buildonly-randconfig-006-20250129    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250129    gcc-14.2.0
xtensa                randconfig-002-20250129    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

