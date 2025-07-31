Return-Path: <cgroups+bounces-8962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C8EB17094
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 13:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A060056351E
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D578230BE0;
	Thu, 31 Jul 2025 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3fzFpQf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118C78F5E
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962585; cv=none; b=mxLG9SGYQZzTRpNIbD2APJ0l4BNu/t84sLAjq3yi3hr+fGb9sbFXBPqNFR6SCBbBXK+nOeoiJZxmbbPstw2AAjr45gUf2SvxAyRxe58aLLQkXZEW6CdibilVPs2QDuGP8n1xlWMqzPpX+5YaawBhJ3Ek4IzRfoDc6NCM2QzJ6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962585; c=relaxed/simple;
	bh=zVEMyRnrrttX0C7tPeXm/ydZFAEfWube34lNvTdp/Ig=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CVZRbXFDMOOjdKYshVedVG4NBYnk19gJWPdPpCvfgQTtht8+Sk9ahW749ahcDHRzZlkwib4OLIcHcVsvi/V/wFYBf1j/vQSrZDhAljxfskBKmJDcxfzBPXbwYry+dvKEPHh2YKVjg+OsQIF6h/cmXkRuAlw4vUVgp71FPSwKRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3fzFpQf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753962584; x=1785498584;
  h=date:from:to:cc:subject:message-id;
  bh=zVEMyRnrrttX0C7tPeXm/ydZFAEfWube34lNvTdp/Ig=;
  b=b3fzFpQf8W4wgiLKCd+TYL36Fu4SF6bf1Q6vDupMXIYbSzdx++bkzpz5
   X5m15/XT2GVExVPSJF7KnyBYhZIWQKtvugUFIaCZlzeLQnEK/zrV+GPmj
   eg9b0vBgPUpcXq6vRf+4k13mL5sh01WUoFsvlftDB5MNmMx4Yx+4x9gBg
   NGcY9evH3595U6MgcBfeaRZwjaP8Lr/hkVDMHA04bwLwIrpksk5T2lixW
   aM1XlvLemdoFaPrHeLrCNOswZb4/Tz9M9DfsqHjER43p0sTxaWUVjiDvK
   EcKJKzQIxWj1wDQltM7fcM2m0khexC0bVKaw5cKmfIpOwpCiqGI0E8U/h
   g==;
X-CSE-ConnectionGUID: pQDXwQRERSiHGYOS+UTy6Q==
X-CSE-MsgGUID: e8TKGQ26QSG2IgqRyAFQjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="78833923"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="78833923"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 04:49:44 -0700
X-CSE-ConnectionGUID: AoW+h9mLQ0SQQdzZp/bKhQ==
X-CSE-MsgGUID: HzHUEm4kQginXob1V8pB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="167727663"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Jul 2025 04:49:42 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhRn1-0003je-1w;
	Thu, 31 Jul 2025 11:49:39 +0000
Date: Thu, 31 Jul 2025 19:49:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge] BUILD SUCCESS
 244e90769461a82d9fea6d37b49aa210da37646c
Message-ID: <202507311902.nkoXBKrH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge
branch HEAD: 244e90769461a82d9fea6d37b49aa210da37646c  Merge branch 'for-6.17' into test-merge

elapsed time: 729m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250731    gcc-13.4.0
arc                   randconfig-002-20250731    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250731    gcc-14.3.0
arm                   randconfig-002-20250731    gcc-8.5.0
arm                   randconfig-003-20250731    gcc-8.5.0
arm                   randconfig-004-20250731    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250731    gcc-8.5.0
arm64                 randconfig-002-20250731    gcc-13.4.0
arm64                 randconfig-003-20250731    gcc-10.5.0
arm64                 randconfig-004-20250731    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250731    gcc-12.5.0
csky                  randconfig-002-20250731    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250731    clang-16
hexagon               randconfig-002-20250731    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250731    gcc-12
i386        buildonly-randconfig-002-20250731    gcc-12
i386        buildonly-randconfig-003-20250731    clang-20
i386        buildonly-randconfig-004-20250731    gcc-12
i386        buildonly-randconfig-005-20250731    gcc-12
i386        buildonly-randconfig-006-20250731    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250731    gcc-13.4.0
loongarch             randconfig-002-20250731    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250731    gcc-11.5.0
nios2                 randconfig-002-20250731    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250731    gcc-8.5.0
parisc                randconfig-002-20250731    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250731    gcc-13.4.0
powerpc               randconfig-002-20250731    gcc-13.4.0
powerpc               randconfig-003-20250731    gcc-15.1.0
powerpc64             randconfig-001-20250731    clang-22
powerpc64             randconfig-002-20250731    gcc-12.5.0
powerpc64             randconfig-003-20250731    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250731    gcc-13.4.0
riscv                 randconfig-002-20250731    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250731    clang-22
s390                  randconfig-002-20250731    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250731    gcc-10.5.0
sh                    randconfig-002-20250731    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250731    gcc-8.5.0
sparc                 randconfig-002-20250731    gcc-11.5.0
sparc64               randconfig-001-20250731    gcc-8.5.0
sparc64               randconfig-002-20250731    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250731    clang-22
um                    randconfig-002-20250731    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250731    gcc-12
x86_64      buildonly-randconfig-002-20250731    clang-20
x86_64      buildonly-randconfig-003-20250731    gcc-12
x86_64      buildonly-randconfig-004-20250731    gcc-12
x86_64      buildonly-randconfig-005-20250731    gcc-12
x86_64      buildonly-randconfig-006-20250731    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250731    gcc-14.3.0
xtensa                randconfig-002-20250731    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

