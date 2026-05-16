Return-Path: <cgroups+bounces-16004-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJMZErpXCGr1kAMAu9opvQ
	(envelope-from <cgroups+bounces-16004-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 13:40:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EECC55B803
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 13:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D74300DDD8
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070B3D3CEF;
	Sat, 16 May 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e05W86V3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75611381B0A
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931638; cv=none; b=e4MTRZh64Htz1gkVVSs4e3b+OJ6cd60HCWBj3XUTjRb/90zbTPqorJ4tHau936VwUwa8s++CV3L3OoUQHx6nGOo0KxpfqxlYz+IRmKyxtKD8U/ic2a7PyvHreJQdQEMt+1bbYm3dLI73MFZSxNKpJHtju9O5qVu2YKB4pv2uw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931638; c=relaxed/simple;
	bh=VkrQzjFatxe6G4EwWbgOAMq6QXfmb25lhwlN8Jnu4Ck=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cOrIMW0TBI3Uy9ivwUY9Zor3sDf4BjJAPEAf/W61aBRLpe92em7iHHYwmMQ3c0H2xUGyRQlCdjfAESAT68nD/EBcbb2A+xfnsL6vFff8he0RfAyeHBlMXGh2xqtk6lrWnJRUAo/39QiDTosVQ5caSPtUDWpDn43JlMnIRFzyUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e05W86V3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778931637; x=1810467637;
  h=date:from:to:cc:subject:message-id;
  bh=VkrQzjFatxe6G4EwWbgOAMq6QXfmb25lhwlN8Jnu4Ck=;
  b=e05W86V3yN8ANhjG9fDFU5ecUji4Dgldcz0gc6vyRRej9qHukopfHikf
   PkYRXKV/SWqglYAJ8a2u0rCRbVbw+LWGRe51auv7pOo3tragJe7X5vcCe
   Aq8KpXcYqzzwRlTYX/rd4TeGeWpF2vS3T0IIHjr9GlV7z4Ck6oxtHgHLB
   hyLK8jyPFHjI5aykhSnI5tMOuajzBxfyPntffSOEZGPh9fF0je0OMUGoj
   Wg9g4gi49vCxItpovL85mbUxSjLOaSuQ2tL8uJzDSsPPx8AYqBN3AqFIO
   CwwLx4mOUg4Y6sCkDeIjCbWzWD/zDL+0C27QY0ix2u58Zk5Z9bDNqidQd
   w==;
X-CSE-ConnectionGUID: WzmeetKGTI+2vaE45Qtspw==
X-CSE-MsgGUID: QaKSuS2oTYaxM5RAdatG5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83481890"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="83481890"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 04:40:36 -0700
X-CSE-ConnectionGUID: 4YYMBMU5RR2OFvbh8rP5Mw==
X-CSE-MsgGUID: IL611D5FRF25sgxD91x29A==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 May 2026 04:40:34 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wODNg-000000000mA-1in6;
	Sat, 16 May 2026 11:40:32 +0000
Date: Sat, 16 May 2026 19:39:45 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 6c79fb30f5cd939f22959bd9b54d7f30c713a759
Message-ID: <202605161935.i6V0gXzK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9EECC55B803
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16004-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 6c79fb30f5cd939f22959bd9b54d7f30c713a759  Merge branch 'for-7.2' into for-next

elapsed time: 1075m

configs tested: 281
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260516    gcc-14.3.0
arc                   randconfig-001-20260516    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260516    gcc-13.4.0
arc                   randconfig-002-20260516    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260516    gcc-13.4.0
arm                   randconfig-001-20260516    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260516    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260516    clang-19
arm                   randconfig-003-20260516    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260516    clang-23
arm                   randconfig-004-20260516    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260516    gcc-13.4.0
arm64                 randconfig-001-20260516    gcc-9.5.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260516    clang-23
arm64                 randconfig-002-20260516    gcc-9.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260516    gcc-9.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260516    clang-23
arm64                 randconfig-004-20260516    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260516    gcc-15.2.0
csky                  randconfig-001-20260516    gcc-9.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260516    gcc-10.5.0
csky                  randconfig-002-20260516    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260516    clang-23
hexagon               randconfig-002-20260516    clang-16
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260516    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260516    clang-20
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260516    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260516    clang-20
i386        buildonly-randconfig-004-20260516    gcc-14
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260516    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260516    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260516    clang-20
i386                           randconfig-002    clang-20
i386                  randconfig-002-20260516    clang-20
i386                           randconfig-003    clang-20
i386                  randconfig-003-20260516    clang-20
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260516    clang-20
i386                           randconfig-005    clang-20
i386                  randconfig-005-20260516    clang-20
i386                           randconfig-006    clang-20
i386                  randconfig-006-20260516    clang-20
i386                           randconfig-007    clang-20
i386                  randconfig-007-20260516    clang-20
i386                  randconfig-011-20260516    gcc-14
i386                  randconfig-012-20260516    clang-20
i386                  randconfig-012-20260516    gcc-14
i386                  randconfig-013-20260516    gcc-14
i386                  randconfig-014-20260516    gcc-14
i386                  randconfig-015-20260516    clang-20
i386                  randconfig-015-20260516    gcc-14
i386                  randconfig-016-20260516    gcc-14
i386                  randconfig-017-20260516    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260516    gcc-15.2.0
loongarch             randconfig-002-20260516    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260516    gcc-10.5.0
nios2                 randconfig-002-20260516    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260516    gcc-10.5.0
parisc                randconfig-001-20260516    gcc-12.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260516    gcc-11.5.0
parisc                randconfig-002-20260516    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260516    clang-23
powerpc               randconfig-001-20260516    gcc-12.5.0
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260516    gcc-12.5.0
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260516    clang-17
powerpc64             randconfig-001-20260516    gcc-12.5.0
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260516    clang-23
powerpc64             randconfig-002-20260516    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260516    gcc-15.2.0
riscv                 randconfig-001-20260516    gcc-8.5.0
riscv                 randconfig-002-20260516    clang-16
riscv                 randconfig-002-20260516    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260516    clang-23
s390                  randconfig-001-20260516    gcc-15.2.0
s390                  randconfig-002-20260516    clang-23
s390                  randconfig-002-20260516    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                    randconfig-001-20260516    gcc-12.5.0
sh                    randconfig-001-20260516    gcc-15.2.0
sh                    randconfig-002-20260516    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260516    gcc-8.5.0
sparc                 randconfig-002-20260516    gcc-15.2.0
sparc                 randconfig-002-20260516    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260516    gcc-10.5.0
sparc64               randconfig-001-20260516    gcc-8.5.0
sparc64               randconfig-002-20260516    clang-20
sparc64               randconfig-002-20260516    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260516    clang-16
um                    randconfig-001-20260516    gcc-8.5.0
um                    randconfig-002-20260516    clang-18
um                    randconfig-002-20260516    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260516    clang-20
x86_64      buildonly-randconfig-001-20260516    gcc-14
x86_64      buildonly-randconfig-002-20260516    gcc-14
x86_64      buildonly-randconfig-003-20260516    gcc-13
x86_64      buildonly-randconfig-003-20260516    gcc-14
x86_64      buildonly-randconfig-004-20260516    gcc-14
x86_64      buildonly-randconfig-005-20260516    gcc-14
x86_64      buildonly-randconfig-006-20260516    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260516    clang-20
x86_64                randconfig-001-20260516    gcc-14
x86_64                randconfig-002-20260516    clang-20
x86_64                randconfig-002-20260516    gcc-14
x86_64                randconfig-003-20260516    gcc-14
x86_64                randconfig-004-20260516    gcc-14
x86_64                randconfig-005-20260516    gcc-14
x86_64                randconfig-006-20260516    gcc-14
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260516    clang-20
x86_64                randconfig-011-20260516    gcc-14
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260516    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260516    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260516    clang-20
x86_64                randconfig-014-20260516    gcc-14
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260516    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260516    clang-20
x86_64                randconfig-016-20260516    gcc-14
x86_64                randconfig-071-20260516    gcc-14
x86_64                randconfig-072-20260516    gcc-14
x86_64                randconfig-073-20260516    clang-20
x86_64                randconfig-073-20260516    gcc-14
x86_64                randconfig-074-20260516    clang-20
x86_64                randconfig-074-20260516    gcc-14
x86_64                randconfig-075-20260516    gcc-14
x86_64                randconfig-076-20260516    clang-20
x86_64                randconfig-076-20260516    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260516    gcc-13.4.0
xtensa                randconfig-001-20260516    gcc-8.5.0
xtensa                randconfig-002-20260516    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

