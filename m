Return-Path: <cgroups+bounces-17582-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p8UKK99OTmogKgIAu9opvQ
	(envelope-from <cgroups+bounces-17582-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 15:21:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6452726BFE
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 15:21:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Jaj6Lrfo;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17582-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17582-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70C0B3051280
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC028469F;
	Wed,  8 Jul 2026 13:14:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A4282F23
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 13:14:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516444; cv=none; b=F8BTbhHO6lt/gckqVyQ7ekayzLyWH5w9lVMxw8pJOSzqYGvz88g18D9OMn5JgOhEfwxAeumgqgN8XVAJDfA7e6MVQ18Tk9wpoYaKYZq7yDikOTn/R1DOp7zRqbB2/C4+JAGgqsHYxtRE/LzZblz0FhqX7oIWCPjeNxf5I5TJqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516444; c=relaxed/simple;
	bh=S+mfKcQKkCbbx2K71tOPd5m/oPNo1aP13WSBSTmrko8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F9uZzscZwZ43Rg43bGVs/NYjEZQoj0hSlhIBUJFijheRjqxPu3KiZwNGAwnR3VwOPQ9miDUPzTBMFAE2fu0B0bRAdbtz5AmSKtdV/KZBTVjj8QCkGxxQraOpLWVdArJIqt0Bq8bgmiR8CM+/pwhI99yhAUfz1niF/IDS8A1uL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jaj6Lrfo; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783516443; x=1815052443;
  h=date:from:to:cc:subject:message-id;
  bh=S+mfKcQKkCbbx2K71tOPd5m/oPNo1aP13WSBSTmrko8=;
  b=Jaj6LrfoOi7wcO/EUbAB8se8WNyOc5VwfUoTyq8Cgpl06q9WMs/KnKTf
   /ca+slu1YUyJ/QSARTqgwbSWT+L5qFbxPZscXgo1KAfUF7mit4uynl1H6
   gtquWgWSMirvY1l4gPuiZWfA9tFI8UUozHqW9RLPPhBW7ptSDL7AFwDb6
   1K3Wx97yS+Zuki2YFTyoMtVMvzdZF2j5kQJnshT5ei4LPOmPpfkuTJtOD
   74eNjmlVGp3lRthXtFV2MGFiJ3f0IiTwrSMMzxFJt3mCoNbqymZVALPHH
   m/N3D8udVwADnV/CUYnIC0eu5A+eSC/U3jDfUZ+NA4bgYvMptesAl9xxi
   A==;
X-CSE-ConnectionGUID: DB0PaDYoTOG5GCKi7msy2A==
X-CSE-MsgGUID: Ead1SJgbSqScdAc8Kwif2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101723903"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101723903"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 06:14:02 -0700
X-CSE-ConnectionGUID: 4p1IVMhbT/iZ0OhUQZf4BA==
X-CSE-MsgGUID: Si1ujLBFSGe5CaeHhgsjkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257872477"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 08 Jul 2026 06:14:01 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whS6A-00000000GOS-31So;
	Wed, 08 Jul 2026 13:13:58 +0000
Date: Wed, 08 Jul 2026 21:13:28 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.2-fixes] BUILD SUCCESS
 97fef602584458b100d383afed9d176c0bc689ab
Message-ID: <202607082118.6RrsqZnv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17582-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6452726BFE

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.2-fixes
branch HEAD: 97fef602584458b100d383afed9d176c0bc689ab  Docs/admin-guide/cgroup-v2: note blkcg_debug_stats gates io.latency stats

elapsed time: 724m

configs tested: 229
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                         haps_hs_defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260708    gcc-13.4.0
arc                   randconfig-001-20260708    gcc-16.1.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260708    gcc-13.4.0
arc                   randconfig-002-20260708    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260708    gcc-13.4.0
arm                   randconfig-001-20260708    gcc-16.1.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260708    gcc-13.4.0
arm                   randconfig-002-20260708    gcc-16.1.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260708    gcc-13.4.0
arm                   randconfig-003-20260708    gcc-16.1.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260708    gcc-13.4.0
arm                   randconfig-004-20260708    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-9.5.0
arm64                 randconfig-001-20260708    gcc-9.5.0
arm64                          randconfig-002    gcc-9.5.0
arm64                 randconfig-002-20260708    gcc-9.5.0
arm64                          randconfig-003    gcc-9.5.0
arm64                 randconfig-003-20260708    gcc-9.5.0
arm64                          randconfig-004    gcc-9.5.0
arm64                 randconfig-004-20260708    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-9.5.0
csky                  randconfig-001-20260708    gcc-9.5.0
csky                           randconfig-002    gcc-9.5.0
csky                  randconfig-002-20260708    gcc-9.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260708    gcc-11.5.0
hexagon               randconfig-001-20260708    gcc-13.4.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260708    gcc-11.5.0
hexagon               randconfig-002-20260708    gcc-13.4.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260708    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260708    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260708    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260708    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260708    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260708    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260708    clang-22
i386                  randconfig-002-20260708    clang-22
i386                  randconfig-003-20260708    clang-22
i386                  randconfig-004-20260708    clang-22
i386                  randconfig-005-20260708    clang-22
i386                  randconfig-006-20260708    clang-22
i386                  randconfig-007-20260708    clang-22
i386                  randconfig-011-20260708    gcc-14
i386                  randconfig-012-20260708    gcc-14
i386                  randconfig-013-20260708    gcc-14
i386                  randconfig-014-20260708    gcc-14
i386                  randconfig-015-20260708    gcc-14
i386                  randconfig-016-20260708    gcc-14
i386                  randconfig-017-20260708    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260708    gcc-11.5.0
loongarch             randconfig-001-20260708    gcc-13.4.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260708    gcc-11.5.0
loongarch             randconfig-002-20260708    gcc-13.4.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260708    gcc-11.5.0
nios2                 randconfig-001-20260708    gcc-13.4.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260708    gcc-11.5.0
nios2                 randconfig-002-20260708    gcc-13.4.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-22
parisc                randconfig-001-20260708    clang-22
parisc                         randconfig-002    clang-22
parisc                randconfig-002-20260708    clang-22
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                      bamboo_defconfig    clang-21
powerpc                        randconfig-001    clang-22
powerpc               randconfig-001-20260708    clang-22
powerpc                        randconfig-002    clang-22
powerpc               randconfig-002-20260708    clang-22
powerpc                    socrates_defconfig    gcc-16.1.0
powerpc64                      randconfig-001    clang-22
powerpc64             randconfig-001-20260708    clang-22
powerpc64                      randconfig-002    clang-22
powerpc64             randconfig-002-20260708    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260708    clang-23
riscv                 randconfig-001-20260708    gcc-8.5.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260708    clang-23
riscv                 randconfig-002-20260708    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260708    clang-20
s390                  randconfig-001-20260708    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260708    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260708    clang-23
sh                    randconfig-001-20260708    gcc-16.1.0
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260708    clang-23
sh                    randconfig-002-20260708    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260708    gcc-8.5.0
sparc                 randconfig-002-20260708    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260708    gcc-8.5.0
sparc64               randconfig-002-20260708    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260708    gcc-8.5.0
um                    randconfig-002-20260708    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260708    gcc-12
x86_64               buildonly-randconfig-002    gcc-12
x86_64      buildonly-randconfig-002-20260708    gcc-12
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20260708    gcc-12
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20260708    gcc-12
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20260708    gcc-12
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20260708    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260708    gcc-14
x86_64                randconfig-002-20260708    gcc-14
x86_64                randconfig-003-20260708    gcc-14
x86_64                randconfig-004-20260708    gcc-14
x86_64                randconfig-005-20260708    gcc-14
x86_64                randconfig-006-20260708    gcc-14
x86_64                randconfig-011-20260708    clang-22
x86_64                randconfig-012-20260708    clang-22
x86_64                randconfig-013-20260708    clang-22
x86_64                randconfig-014-20260708    clang-22
x86_64                randconfig-015-20260708    clang-22
x86_64                randconfig-016-20260708    clang-22
x86_64                randconfig-071-20260708    clang-22
x86_64                randconfig-072-20260708    clang-22
x86_64                randconfig-073-20260708    clang-22
x86_64                randconfig-074-20260708    clang-22
x86_64                randconfig-075-20260708    clang-22
x86_64                randconfig-076-20260708    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260708    gcc-8.5.0
xtensa                randconfig-002-20260708    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

