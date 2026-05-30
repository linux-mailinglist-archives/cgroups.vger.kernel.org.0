Return-Path: <cgroups+bounces-16477-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vStIIz+IGmpt5QgAu9opvQ
	(envelope-from <cgroups+bounces-16477-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 08:48:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595E60B7D2
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 08:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01ACE305AF2E
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D357C38229A;
	Sat, 30 May 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TU71y7Ha"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B02D978A
	for <cgroups@vger.kernel.org>; Sat, 30 May 2026 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780123705; cv=none; b=AYS5bsW6buFgDOoCTi6ia6QU2mLo01TNGqPyId1aNj/ZeW1sDk9RjORksul1r9qPCYTyvwEVwqWxpFjx1wSMB3+EXx8jbTKMeZpp+4bPoOTwpX2jSef/AooCRl08LGlaeKCSxIRfOq3wWmspZRtzJY4JmNVbxNPc0WvX0bmBGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780123705; c=relaxed/simple;
	bh=nYkX5bW7VXLOo9TEpxNDhUfn2XtkM4vlv1g+SUOZi8Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FSNI7Yb4YOdcE+ttTZ23KOS2l9baGX1BrLloR0qXPLvYyyi38b5zQS03kjuw0N0bNbYdrStb0Z20XzCP/+T3pdFx0m/7gvgikoRg97/jykdVptiOz2fhpBi9gXolH4VHOSuVb9MDM/zwG+OD7v4KxnLoUCuL/uAWeJ8DqkVEUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TU71y7Ha; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780123703; x=1811659703;
  h=date:from:to:cc:subject:message-id;
  bh=nYkX5bW7VXLOo9TEpxNDhUfn2XtkM4vlv1g+SUOZi8Y=;
  b=TU71y7HaRVRKTys1H+l/gxEgmYcekHV6yK6m4LKgZ/3/UbuyouLu5LcY
   AthLzQBfb7e4wxTPCP4odfHk+iM9duGWz5Wtgt66EoexLPozv//7WhCFg
   bSR6QSd52uNxqr0S/7E3OH7YVc+IRMuqoR5/wAsR0Ky41FevZenvw3+8D
   kowy6Ih/dKcyg6vfmtTroCtU0K0OuEi7MV04N4XdZspS8aKB1aaEqqKsT
   GEh8HTVhNDYDeV5+obY0sYik1Hoyt9s1k1hwCx6qEWlaqKjNDzRrlp6Wz
   t3EB3zIonyDxXPYjoPqC6DE0U1OnT+/aXgYMHPNrzxYTKzZNQMGkFlhJA
   Q==;
X-CSE-ConnectionGUID: YvzWx74rTQika+6Aijg89Q==
X-CSE-MsgGUID: K/KXY6m+ReCaeQ/Rip2qVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="83544962"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="83544962"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 23:48:23 -0700
X-CSE-ConnectionGUID: IJo/xe4kQ5y23ERvRvBftw==
X-CSE-MsgGUID: E/VfP2YwRYeFWeCW8sA1Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="243140922"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 May 2026 23:48:21 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTDUY-000000008CG-3HKH;
	Sat, 30 May 2026 06:48:18 +0000
Date: Sat, 30 May 2026 14:47:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 ebc50c66b365d3046c7741195224d2aa7809c9b5
Message-ID: <202605301448.pZ8CbYi8-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16477-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9595E60B7D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: ebc50c66b365d3046c7741195224d2aa7809c9b5  Merge branch 'for-7.2' into for-next

elapsed time: 724m

configs tested: 171
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
arc                   randconfig-001-20260530    gcc-14.3.0
arc                   randconfig-002-20260530    gcc-14.3.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                        multi_v7_defconfig    gcc-15.2.0
arm                   randconfig-001-20260530    gcc-14.3.0
arm                   randconfig-002-20260530    gcc-14.3.0
arm                   randconfig-003-20260530    gcc-14.3.0
arm                   randconfig-004-20260530    gcc-14.3.0
arm                             rpc_defconfig    clang-18
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260530    gcc-8.5.0
arm64                 randconfig-002-20260530    gcc-8.5.0
arm64                 randconfig-003-20260530    gcc-8.5.0
arm64                 randconfig-004-20260530    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260530    gcc-8.5.0
csky                  randconfig-002-20260530    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260530    clang-23
hexagon               randconfig-002-20260530    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260530    clang-20
i386        buildonly-randconfig-002-20260530    clang-20
i386        buildonly-randconfig-003-20260530    clang-20
i386        buildonly-randconfig-004-20260530    clang-20
i386        buildonly-randconfig-005-20260530    clang-20
i386        buildonly-randconfig-006-20260530    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260530    clang-20
i386                  randconfig-002-20260530    clang-20
i386                  randconfig-003-20260530    clang-20
i386                  randconfig-004-20260530    clang-20
i386                  randconfig-005-20260530    clang-20
i386                  randconfig-006-20260530    clang-20
i386                  randconfig-007-20260530    clang-20
i386                  randconfig-011-20260530    clang-20
i386                  randconfig-012-20260530    clang-20
i386                  randconfig-013-20260530    clang-20
i386                  randconfig-014-20260530    clang-20
i386                  randconfig-015-20260530    clang-20
i386                  randconfig-016-20260530    clang-20
i386                  randconfig-017-20260530    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260530    clang-23
loongarch             randconfig-002-20260530    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        qi_lb60_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260530    clang-23
nios2                 randconfig-002-20260530    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260530    gcc-8.5.0
parisc                randconfig-002-20260530    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260530    gcc-8.5.0
powerpc               randconfig-002-20260530    gcc-8.5.0
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260530    gcc-8.5.0
powerpc64             randconfig-002-20260530    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260530    gcc-12.5.0
riscv                 randconfig-002-20260530    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260530    gcc-12.5.0
s390                  randconfig-002-20260530    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260530    gcc-12.5.0
sh                    randconfig-002-20260530    gcc-12.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260530    gcc-9.5.0
sparc                 randconfig-002-20260530    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260530    gcc-9.5.0
sparc64               randconfig-002-20260530    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260530    gcc-9.5.0
um                    randconfig-002-20260530    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260530    gcc-14
x86_64      buildonly-randconfig-002-20260530    gcc-14
x86_64      buildonly-randconfig-003-20260530    gcc-14
x86_64      buildonly-randconfig-004-20260530    gcc-14
x86_64      buildonly-randconfig-005-20260530    gcc-14
x86_64      buildonly-randconfig-006-20260530    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260530    gcc-14
x86_64                randconfig-002-20260530    gcc-14
x86_64                randconfig-003-20260530    gcc-14
x86_64                randconfig-004-20260530    gcc-14
x86_64                randconfig-005-20260530    gcc-14
x86_64                randconfig-006-20260530    gcc-14
x86_64                randconfig-011-20260530    gcc-14
x86_64                randconfig-012-20260530    gcc-14
x86_64                randconfig-013-20260530    gcc-14
x86_64                randconfig-014-20260530    gcc-14
x86_64                randconfig-015-20260530    gcc-14
x86_64                randconfig-016-20260530    gcc-14
x86_64                randconfig-071-20260530    gcc-14
x86_64                randconfig-072-20260530    gcc-14
x86_64                randconfig-073-20260530    gcc-14
x86_64                randconfig-074-20260530    gcc-14
x86_64                randconfig-075-20260530    gcc-14
x86_64                randconfig-076-20260530    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260530    gcc-9.5.0
xtensa                randconfig-002-20260530    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

