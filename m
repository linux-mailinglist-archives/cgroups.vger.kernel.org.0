Return-Path: <cgroups+bounces-15167-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HYZL2yBzmkqoAYAu9opvQ
	(envelope-from <cgroups+bounces-15167-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 16:47:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CC38AC79
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E0DA301A789
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF333B949;
	Thu,  2 Apr 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwyNTP3t"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DED3ED5A2
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141187; cv=none; b=n9TlMtcrN0Afe0vuTxKcfvSmcfzgvrBDzr1+D6gWDecvwDet8FHjkbzMOo7/G3Dysu+L57WrgM9LQBjdHHXnGPE8004ydkfOzSdbTDku3IW0LCDMu/zKtFgDBIu2JrJFRaCGU13zxc7a2FMLri7R5W5sBo8kZqgitqrlHbxKzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141187; c=relaxed/simple;
	bh=eO90+eY0RbCA/qUkbTCNobNk2XveqwjBIIqZkkHFupg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iOHirakMKCLgPkZMV3kugqB6M86FwGKHT2YbqDYJ7n4jyEbjGkKFWiD6C7TV/Q0+8bLIVrUXKOwnm0KlRxJ4xqCP6BuTKFD2QzQCEy9g3D0bMLn56MZq6QbErU64sKgh9JMilyeQYyLAOEEvE0CSTT8Q0FStYoDdJrY5DDCGtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwyNTP3t; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775141184; x=1806677184;
  h=date:from:to:cc:subject:message-id;
  bh=eO90+eY0RbCA/qUkbTCNobNk2XveqwjBIIqZkkHFupg=;
  b=YwyNTP3t9ODoDxGvqdnB44XQAmkPV24fDixe3PVM8n1B71RsDCicaRrk
   jpqyIM7qloY5S8vZBGUeWo7zvg09ENRCo4Xjl9ihxyQY6jM+pC3OIPNVL
   klz/0L5HqjBxNJ2ewShnP8tg94tmOlAT7rDgHXcmo+7UMh//bEeUZ7QGv
   2/k7VbaQARR9H84o1T/2+aJGAyNgEuyZGREeIaKEYVG9U4IITYo8Kb3ux
   z4dQvo+cle8+yYXcI0D2eYYKIeeWAbx+XPPrqOJFIhrE9M63/wLk0t+Je
   VLU12RRYsLRbyBcQF8A7SO6gWGR8ub9cOKJK0jscNeEoDjz0VP6Lrq0E8
   A==;
X-CSE-ConnectionGUID: MdowpnMKQnif8l0G4q+egQ==
X-CSE-MsgGUID: 7S5aCpNUSbOPqXUvkPbjqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="86903374"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="86903374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 07:46:22 -0700
X-CSE-ConnectionGUID: WJY2CRtiSpKVWF09ziMNVw==
X-CSE-MsgGUID: JUUiMUNdRe+P68gTDzdRhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="225993041"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Apr 2026 07:46:22 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8JJK-0000000003F-3qwx;
	Thu, 02 Apr 2026 14:46:18 +0000
Date: Thu, 02 Apr 2026 22:45:53 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.0-fixes] BUILD SUCCESS
 089f3fcd690c71cb3d8ca09f34027764e28920a0
Message-ID: <202604022245.L6UpLTLX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15167-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 620CC38AC79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.0-fixes
branch HEAD: 089f3fcd690c71cb3d8ca09f34027764e28920a0  cgroup/cpuset: Skip security check for hotplug induced v1 task migration

elapsed time: 2297m

configs tested: 252
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260401    clang-23
arc                   randconfig-001-20260402    gcc-11.5.0
arc                   randconfig-002-20260401    clang-23
arc                   randconfig-002-20260402    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-001-20260402    gcc-11.5.0
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-002-20260402    gcc-11.5.0
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-003-20260402    gcc-11.5.0
arm                   randconfig-004-20260401    clang-23
arm                   randconfig-004-20260402    gcc-11.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    gcc-15.2.0
arm64                 randconfig-001-20260402    gcc-15.2.0
arm64                 randconfig-002-20260401    gcc-15.2.0
arm64                 randconfig-002-20260402    gcc-15.2.0
arm64                 randconfig-003-20260401    gcc-15.2.0
arm64                 randconfig-003-20260402    gcc-15.2.0
arm64                 randconfig-004-20260401    gcc-15.2.0
arm64                 randconfig-004-20260402    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-15.2.0
csky                  randconfig-001-20260402    gcc-15.2.0
csky                  randconfig-002-20260401    gcc-15.2.0
csky                  randconfig-002-20260402    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260401    gcc-15.2.0
hexagon               randconfig-001-20260402    clang-18
hexagon               randconfig-002-20260401    gcc-15.2.0
hexagon               randconfig-002-20260402    clang-18
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-001-20260402    clang-20
i386        buildonly-randconfig-002-20260401    gcc-14
i386        buildonly-randconfig-002-20260402    clang-20
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-003-20260402    clang-20
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-004-20260402    clang-20
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-005-20260402    clang-20
i386        buildonly-randconfig-006-20260401    gcc-14
i386        buildonly-randconfig-006-20260402    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-001-20260402    clang-20
i386                  randconfig-002-20260401    gcc-14
i386                  randconfig-002-20260402    clang-20
i386                  randconfig-003-20260401    gcc-14
i386                  randconfig-003-20260402    clang-20
i386                  randconfig-004-20260401    gcc-14
i386                  randconfig-004-20260402    clang-20
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-005-20260402    clang-20
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-006-20260402    clang-20
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-007-20260402    clang-20
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-011-20260402    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-012-20260402    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-013-20260402    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-014-20260402    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-015-20260402    clang-20
i386                  randconfig-016-20260401    clang-20
i386                  randconfig-016-20260402    clang-20
i386                  randconfig-017-20260401    clang-20
i386                  randconfig-017-20260402    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-001-20260402    clang-18
loongarch             randconfig-002-20260401    gcc-15.2.0
loongarch             randconfig-002-20260402    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260401    gcc-15.2.0
nios2                 randconfig-001-20260402    clang-18
nios2                 randconfig-002-20260401    gcc-15.2.0
nios2                 randconfig-002-20260402    clang-18
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-001-20260402    clang-20
parisc                randconfig-002-20260401    gcc-8.5.0
parisc                randconfig-002-20260402    clang-20
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-001-20260402    clang-20
powerpc               randconfig-002-20260401    gcc-8.5.0
powerpc               randconfig-002-20260402    clang-20
powerpc64             randconfig-001-20260401    gcc-8.5.0
powerpc64             randconfig-001-20260402    clang-20
powerpc64             randconfig-002-20260401    gcc-8.5.0
powerpc64             randconfig-002-20260402    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260401    gcc-9.5.0
riscv                 randconfig-001-20260402    clang-23
riscv                 randconfig-002-20260401    gcc-9.5.0
riscv                 randconfig-002-20260402    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-001-20260402    clang-23
s390                  randconfig-002-20260401    gcc-9.5.0
s390                  randconfig-002-20260402    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260401    gcc-9.5.0
sh                    randconfig-001-20260402    clang-23
sh                    randconfig-002-20260401    gcc-9.5.0
sh                    randconfig-002-20260402    clang-23
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260401    clang-16
sparc                 randconfig-001-20260402    gcc-14
sparc                 randconfig-002-20260401    clang-16
sparc                 randconfig-002-20260402    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260401    clang-16
sparc64               randconfig-001-20260402    gcc-14
sparc64               randconfig-002-20260401    clang-16
sparc64               randconfig-002-20260402    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260401    clang-16
um                    randconfig-001-20260402    gcc-14
um                    randconfig-002-20260401    clang-16
um                    randconfig-002-20260402    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260401    gcc-12
x86_64      buildonly-randconfig-001-20260402    clang-20
x86_64      buildonly-randconfig-002-20260401    gcc-12
x86_64      buildonly-randconfig-002-20260402    clang-20
x86_64      buildonly-randconfig-003-20260401    gcc-12
x86_64      buildonly-randconfig-003-20260402    clang-20
x86_64      buildonly-randconfig-004-20260401    gcc-12
x86_64      buildonly-randconfig-004-20260402    clang-20
x86_64      buildonly-randconfig-005-20260401    gcc-12
x86_64      buildonly-randconfig-005-20260402    clang-20
x86_64      buildonly-randconfig-006-20260401    gcc-12
x86_64      buildonly-randconfig-006-20260402    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260401    clang-20
x86_64                randconfig-001-20260402    gcc-14
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-002-20260402    gcc-14
x86_64                randconfig-003-20260401    clang-20
x86_64                randconfig-003-20260402    gcc-14
x86_64                randconfig-004-20260401    clang-20
x86_64                randconfig-004-20260402    gcc-14
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-005-20260402    gcc-14
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-006-20260402    gcc-14
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-011-20260402    clang-20
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-012-20260402    clang-20
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-013-20260402    clang-20
x86_64                randconfig-014-20260401    gcc-14
x86_64                randconfig-014-20260402    clang-20
x86_64                randconfig-015-20260401    gcc-14
x86_64                randconfig-015-20260402    clang-20
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-016-20260402    clang-20
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-071-20260402    clang-20
x86_64                randconfig-072-20260401    gcc-14
x86_64                randconfig-072-20260402    clang-20
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-073-20260402    clang-20
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-074-20260402    clang-20
x86_64                randconfig-075-20260401    gcc-14
x86_64                randconfig-075-20260402    clang-20
x86_64                randconfig-076-20260401    gcc-14
x86_64                randconfig-076-20260402    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260401    clang-16
xtensa                randconfig-001-20260402    gcc-14
xtensa                randconfig-002-20260401    clang-16
xtensa                randconfig-002-20260402    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

