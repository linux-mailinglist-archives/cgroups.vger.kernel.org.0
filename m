Return-Path: <cgroups+bounces-15976-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE6eItgZB2rnrgIAu9opvQ
	(envelope-from <cgroups+bounces-15976-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 15:04:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2204550241
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 15:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE75309C3A1
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 12:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D930674B;
	Fri, 15 May 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiR03c5/"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE347DF8A
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848948; cv=none; b=ULHn/5iRviaFmKc3CeKj4lvwtgPCENlVI0c/2tQcJAwyldGB0N180v+FO1oph4no964hLYOx4vB6fdyhby1A1A/QDLFJmIB+xzDN2AfnOoqxwKHJb3g+Y1JPLCJJeY3LfM5rRnuwzj9S5g7hlPqURobfR6uZpTQ1iNx1eZhIvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848948; c=relaxed/simple;
	bh=MCALHLv+Nb6FbhUqW4g3xkJ5ApdTL0FidcVtOrWXK3I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gi9dvVOG2heQcW52HKQfVfuzlM6pcYqup/DgxF/q2i4SX/iD6ljsX3BSRoxxlS1jwGTyoPRHk/Cp/SKWhbiAsUnWD9WvGM2e/AZK7bwbSCKa+4iUlMQJLPaWs7W/Snohy0tB5Tx0EFuOpSAABy7rVzuAOlrvTyq8HtkhJv7XTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiR03c5/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778848945; x=1810384945;
  h=date:from:to:cc:subject:message-id;
  bh=MCALHLv+Nb6FbhUqW4g3xkJ5ApdTL0FidcVtOrWXK3I=;
  b=AiR03c5/FKk41nqnBZ6TRWmUG+p0c0uVAvmau57xVYwcwsmkuBJD8fUL
   r3Db6iz0lUwopnG06v9ppJMWNL8rrc4ugC6qzKkxm43WPBNFLkGqL9jtv
   +GsKm8+tYQAiNNUr0DwfghiaXgojU8LzLklGMWP1aRbIZrYoYU2p0no3e
   kjuI8bob9qSRkaTwoGnD6R6Z9wCorISGtAo02eCqo0xiR1DDaqHhvyL2X
   9vSWzCjzrowusbcCk5Qlr8jIM4Zt+iZxhWLEODqpv7SpiT36DRz6Yn/0l
   O+wAC0KsajgyW0YmPD2JuofVGsWiLmVWc88vzFR1J0kXaG6GwHxYPNxXd
   Q==;
X-CSE-ConnectionGUID: bA0jckorTlaGHIPXg6rNfw==
X-CSE-MsgGUID: OZW4urgMS12jHSfhO6OkDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90906560"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90906560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:42:25 -0700
X-CSE-ConnectionGUID: sLy0Ld/OSSuGRmHJOuBQig==
X-CSE-MsgGUID: zJULFofRSla9whhBQjcYvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262204418"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 15 May 2026 05:42:22 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNrrw-000000001ZB-3B1k;
	Fri, 15 May 2026 12:42:20 +0000
Date: Fri, 15 May 2026 20:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.2] BUILD SUCCESS
 4376352f2c651ed5308a46caf21d2ccb53c240eb
Message-ID: <202605152007.lEp8Bkpr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E2204550241
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-15976-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.2
branch HEAD: 4376352f2c651ed5308a46caf21d2ccb53c240eb  cgroup/rdma: document rdma.peak, rdma.events and rdma.events.local

elapsed time: 896m

configs tested: 229
configs skipped: 4

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
arc                   randconfig-001-20260515    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260515    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260515    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260515    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260515    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260515    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260515    clang-16
arm64                 randconfig-001-20260515    gcc-11.5.0
arm64                 randconfig-002-20260515    gcc-10.5.0
arm64                 randconfig-002-20260515    gcc-11.5.0
arm64                 randconfig-003-20260515    gcc-11.5.0
arm64                 randconfig-004-20260515    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260515    gcc-10.5.0
csky                  randconfig-001-20260515    gcc-11.5.0
csky                  randconfig-002-20260515    gcc-11.5.0
csky                  randconfig-002-20260515    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260515    clang-23
hexagon               randconfig-002-20260515    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260515    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260515    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260515    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260515    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260515    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260515    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260515    clang-20
i386                  randconfig-002-20260515    clang-20
i386                  randconfig-003-20260515    clang-20
i386                  randconfig-004-20260515    clang-20
i386                  randconfig-005-20260515    clang-20
i386                  randconfig-006-20260515    clang-20
i386                  randconfig-007-20260515    clang-20
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260515    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260515    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260515    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260515    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260515    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260515    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260515    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260515    gcc-15.2.0
loongarch             randconfig-002-20260515    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260515    gcc-11.5.0
nios2                 randconfig-002-20260515    gcc-8.5.0
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
parisc                randconfig-001-20260515    gcc-8.5.0
parisc                randconfig-002-20260515    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260515    gcc-8.5.0
powerpc               randconfig-002-20260515    gcc-8.5.0
powerpc64             randconfig-001-20260515    gcc-8.5.0
powerpc64             randconfig-002-20260515    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260515    gcc-15.2.0
riscv                 randconfig-002-20260515    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260515    gcc-15.2.0
s390                  randconfig-002-20260515    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260515    gcc-15.2.0
sh                    randconfig-002-20260515    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260515    gcc-8.5.0
sparc                 randconfig-002-20260515    gcc-15.2.0
sparc                 randconfig-002-20260515    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260515    clang-20
sparc64               randconfig-001-20260515    gcc-8.5.0
sparc64               randconfig-002-20260515    clang-20
sparc64               randconfig-002-20260515    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260515    gcc-14
um                    randconfig-001-20260515    gcc-8.5.0
um                    randconfig-002-20260515    gcc-14
um                    randconfig-002-20260515    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260515    clang-20
x86_64      buildonly-randconfig-001-20260515    gcc-14
x86_64      buildonly-randconfig-002-20260515    gcc-14
x86_64      buildonly-randconfig-003-20260515    gcc-14
x86_64      buildonly-randconfig-004-20260515    gcc-12
x86_64      buildonly-randconfig-004-20260515    gcc-14
x86_64      buildonly-randconfig-005-20260515    gcc-14
x86_64      buildonly-randconfig-006-20260515    clang-20
x86_64      buildonly-randconfig-006-20260515    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260515    clang-20
x86_64                randconfig-012-20260515    clang-20
x86_64                randconfig-013-20260515    clang-20
x86_64                randconfig-014-20260515    clang-20
x86_64                randconfig-015-20260515    clang-20
x86_64                randconfig-016-20260515    clang-20
x86_64                         randconfig-071    gcc-12
x86_64                randconfig-071-20260515    gcc-12
x86_64                         randconfig-072    gcc-12
x86_64                randconfig-072-20260515    gcc-12
x86_64                         randconfig-073    gcc-12
x86_64                randconfig-073-20260515    gcc-12
x86_64                         randconfig-074    gcc-12
x86_64                randconfig-074-20260515    gcc-12
x86_64                         randconfig-075    gcc-12
x86_64                randconfig-075-20260515    gcc-12
x86_64                         randconfig-076    gcc-12
x86_64                randconfig-076-20260515    gcc-12
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
xtensa                randconfig-001-20260515    gcc-8.5.0
xtensa                randconfig-001-20260515    gcc-9.5.0
xtensa                randconfig-002-20260515    gcc-11.5.0
xtensa                randconfig-002-20260515    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

