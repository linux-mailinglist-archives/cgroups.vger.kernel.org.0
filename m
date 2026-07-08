Return-Path: <cgroups+bounces-17581-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ip5kEItMTmqRKQIAu9opvQ
	(envelope-from <cgroups+bounces-17581-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 15:11:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC63726A64
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 15:11:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NZmMXkFX;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17581-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17581-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2355300A328
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12891277029;
	Wed,  8 Jul 2026 13:11:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534626ED2D
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 13:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516266; cv=none; b=I4tOZmlf+uRtud1xJXDsotXOUdug2WfyF+neQ7ndSOxeK9OghipCcKaK2lsWrYoGcY2xEH92NXKwhq0locyGmIbTb2drElRFJTEypRuvvY8fh2OfIs0S/+++pWQpKRjI2y265o3BBDcqhmSHKjMWrQXG0sWaG0gbLMzLXpaPj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516266; c=relaxed/simple;
	bh=B+3oEhKaHtVosZJ7jcdJPY5ml/jRCEslx5eCmABkyqc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fbB7SuePsjpOoTAHcKML3Cs87EVsgwOAGI3PUP9844oOBc73lekIraw2bnP+mkmvUMLgsR8X/keiMSQ8G7d33+FqKOR0djppR14we4WnL5P+KHWydMm5yNouKbJOz/zf7hQOsAOSXLHyiO2/QXwKP1i01eTrk0Twg0YiF09Hdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZmMXkFX; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783516264; x=1815052264;
  h=date:from:to:cc:subject:message-id;
  bh=B+3oEhKaHtVosZJ7jcdJPY5ml/jRCEslx5eCmABkyqc=;
  b=NZmMXkFXnDjT7ooSc7fF5dr+ziTJRNMc5bs6T0k4hB/1vK18XUegZQBH
   NbMIMkDWz+S5Wb/dAXAb+LYUbTmy4c7R+mlHo/7//O38gXSUv2r7cXLHx
   ipY7q0mENNEvKQcUFVGkB3M6+9ysPBEfr3QghiZSgrxviFRDBZ33T3QR3
   tiiBGwUiXmjmp/OBJ9og3Vttyon9lTSDHnHc2TY/ulqZpW9VQL4BUQGDw
   1Ya6PqviYn8wuZF4Mri6ekSKRposweg+bzJn1cba8e4LqOQgDO34smHsp
   hFLvEdwNIZi4a9B2m/bQQh61lba4VTH0OYpGuTeBLtwx48iDOs1XwRvQu
   g==;
X-CSE-ConnectionGUID: QsksoXmwTdOrGbc+js2Qzw==
X-CSE-MsgGUID: UeHPSahfR+SXPjVJ6J1t6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88001564"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="88001564"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 06:11:02 -0700
X-CSE-ConnectionGUID: D4BPDjSISnKDkmtCfZXiUg==
X-CSE-MsgGUID: dQFpkzd4QjyWQh3bYiLgCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252542355"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 08 Jul 2026 06:11:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whS3G-00000000GNt-0ufT;
	Wed, 08 Jul 2026 13:10:58 +0000
Date: Wed, 08 Jul 2026 21:10:55 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 37f35256008bb5c31804cf1baf226ba0c111d6e1
Message-ID: <202607082145.BlNS8B5i-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17581-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBC63726A64

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 37f35256008bb5c31804cf1baf226ba0c111d6e1  Merge branch 'for-7.2-fixes' into for-next

elapsed time: 721m

configs tested: 224
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
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260708    clang-23
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260708    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260708    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260708    clang-23
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260708    clang-23
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

