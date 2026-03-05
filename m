Return-Path: <cgroups+bounces-14620-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLt0FmjMqGm4xQAAu9opvQ
	(envelope-from <cgroups+bounces-14620-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 01:20:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF7120961F
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 01:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB746303A3F7
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA21ACED5;
	Thu,  5 Mar 2026 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzLwOhLS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494E219FC
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670050; cv=none; b=luxUhZbN7rNAqjw4qhnocnDQOsLzVsB5SX4yZEufIiaPqYa66AewPncb/7WmDPf1CuUW1F45BQ9scjCWYmO3ivv9VqK3+VwTa/lLOCMhyTVLAL2uLyWJzeayd9hVWEfjaH++2cBOWMHR4Km9YDvloFmqGjbkP6z+qu2j5IKhjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670050; c=relaxed/simple;
	bh=AlXnOFKu3ePtEXWQizbAhdbGvxaTDkDdqsbf3AdOKlc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ctYXEylXNXfjOJTkrbhja/2lvvvpiPEUkDmjfmcXy5shNzO2O836GgnQfyl6ou2Q0T6/bw6kK402Y+CckuGZxM4HkiUXgPrxPSma53DFv6Mx8+mjM0+Hlwhkly1Cm5S3STA4XYVXCygmwaG5n38EHPfJyMtuuQj9oft6XmFqCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzLwOhLS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772670048; x=1804206048;
  h=date:from:to:cc:subject:message-id;
  bh=AlXnOFKu3ePtEXWQizbAhdbGvxaTDkDdqsbf3AdOKlc=;
  b=RzLwOhLS3QIjkrYMfdgaiuGuuv5FZgCHCEnDfGNXyaC3Oy91AavlCNNz
   fqEoaqrKG3/IUYcEplFq2pOkDT2VFLJWq/fRGS728BKY8XexkwlTYsvM8
   hzhLDn/y+9REpHZ4ZjV3htWDvyP0LZzURT6mgt/2bhYPqLJN4e5gE74lD
   2khE43wPlbFM4+ZZePzigO0QoOzXKSrm0R6Croa/NBBu2i+P00vy8w4ke
   RuRGhuUcYt9ChneRHcrHUdRjTpH+yOVlYHFrXKPcQW7ADplB7sFPzL1UX
   DtpLAzHhCxwqSN4mee26KJhoPFhTfieQ9zNa7OXgUwH3ChgzSB+AfmUb5
   A==;
X-CSE-ConnectionGUID: 5veZvBwxTZyvJaVp7wuMSw==
X-CSE-MsgGUID: qxnDxxZyT4OYhj3wXIoZ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84380893"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="84380893"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:20:48 -0800
X-CSE-ConnectionGUID: PlZ4y4T4THyK9uYOmAyKrg==
X-CSE-MsgGUID: PuR6y6cRTwSOV7meXHbxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="245070152"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Mar 2026 16:20:47 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxwSK-000000004mX-1nkg;
	Thu, 05 Mar 2026 00:20:44 +0000
Date: Thu, 05 Mar 2026 08:20:13 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-cgroup-7.0-rc2-fixes] BUILD SUCCESS
 e92f9e943242db2fd5eccfe67f6686b1d2a68339
Message-ID: <202603050805.fPZElUq0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7BF7120961F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14620-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-cgroup-7.0-rc2-fixes
branch HEAD: e92f9e943242db2fd5eccfe67f6686b1d2a68339  Merge branch 'for-7.0-fixes' into test-merge-cgroup-7.0-rc2-fixes

elapsed time: 1511m

configs tested: 233
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260304    clang-23
arc                   randconfig-001-20260305    clang-19
arc                   randconfig-002-20260304    clang-23
arc                   randconfig-002-20260305    clang-19
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260304    clang-23
arm                   randconfig-001-20260305    clang-19
arm                   randconfig-002-20260304    clang-23
arm                   randconfig-002-20260305    clang-19
arm                   randconfig-003-20260304    clang-23
arm                   randconfig-003-20260305    clang-19
arm                   randconfig-004-20260304    clang-23
arm                   randconfig-004-20260305    clang-19
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260304    gcc-15.2.0
arm64                 randconfig-001-20260305    gcc-8.5.0
arm64                 randconfig-002-20260304    gcc-15.2.0
arm64                 randconfig-002-20260305    gcc-8.5.0
arm64                 randconfig-003-20260304    gcc-15.2.0
arm64                 randconfig-003-20260305    gcc-8.5.0
arm64                 randconfig-004-20260304    gcc-15.2.0
arm64                 randconfig-004-20260305    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260304    gcc-15.2.0
csky                  randconfig-001-20260305    gcc-8.5.0
csky                  randconfig-002-20260304    gcc-15.2.0
csky                  randconfig-002-20260305    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260305    gcc-15.2.0
hexagon               randconfig-002-20260305    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260305    clang-20
i386        buildonly-randconfig-002-20260305    clang-20
i386        buildonly-randconfig-003-20260305    clang-20
i386        buildonly-randconfig-004-20260305    clang-20
i386        buildonly-randconfig-005-20260305    clang-20
i386        buildonly-randconfig-006-20260305    clang-20
i386                  randconfig-001-20260304    clang-20
i386                  randconfig-001-20260305    gcc-14
i386                  randconfig-002-20260304    clang-20
i386                  randconfig-002-20260305    gcc-14
i386                  randconfig-003-20260304    clang-20
i386                  randconfig-003-20260305    gcc-14
i386                  randconfig-004-20260304    clang-20
i386                  randconfig-004-20260305    gcc-14
i386                  randconfig-005-20260304    clang-20
i386                  randconfig-005-20260305    gcc-14
i386                  randconfig-006-20260304    clang-20
i386                  randconfig-006-20260305    gcc-14
i386                  randconfig-007-20260304    clang-20
i386                  randconfig-007-20260305    gcc-14
i386                  randconfig-011-20260304    gcc-14
i386                  randconfig-012-20260304    gcc-14
i386                  randconfig-013-20260304    gcc-14
i386                  randconfig-014-20260304    gcc-14
i386                  randconfig-015-20260304    gcc-14
i386                  randconfig-016-20260304    gcc-14
i386                  randconfig-017-20260304    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260305    gcc-15.2.0
loongarch             randconfig-002-20260305    gcc-15.2.0
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
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260305    gcc-15.2.0
nios2                 randconfig-002-20260305    gcc-15.2.0
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
parisc                randconfig-001-20260304    gcc-8.5.0
parisc                randconfig-001-20260305    gcc-9.5.0
parisc                randconfig-002-20260304    gcc-8.5.0
parisc                randconfig-002-20260305    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260304    gcc-8.5.0
powerpc               randconfig-001-20260305    gcc-9.5.0
powerpc               randconfig-002-20260304    gcc-8.5.0
powerpc               randconfig-002-20260305    gcc-9.5.0
powerpc64             randconfig-001-20260304    gcc-8.5.0
powerpc64             randconfig-001-20260305    gcc-9.5.0
powerpc64             randconfig-002-20260304    gcc-8.5.0
powerpc64             randconfig-002-20260305    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260305    clang-23
riscv                 randconfig-002-20260305    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260305    clang-23
s390                  randconfig-002-20260305    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260305    clang-23
sh                    randconfig-002-20260305    clang-23
sh                           se7751_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260305    gcc-14.3.0
sparc                 randconfig-002-20260305    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260305    gcc-14.3.0
sparc64               randconfig-002-20260305    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260305    gcc-14.3.0
um                    randconfig-002-20260305    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260304    gcc-14
x86_64      buildonly-randconfig-001-20260305    clang-20
x86_64      buildonly-randconfig-002-20260304    gcc-14
x86_64      buildonly-randconfig-002-20260305    clang-20
x86_64      buildonly-randconfig-003-20260304    gcc-14
x86_64      buildonly-randconfig-003-20260305    clang-20
x86_64      buildonly-randconfig-004-20260304    gcc-14
x86_64      buildonly-randconfig-004-20260305    clang-20
x86_64      buildonly-randconfig-005-20260304    gcc-14
x86_64      buildonly-randconfig-005-20260305    clang-20
x86_64      buildonly-randconfig-006-20260304    gcc-14
x86_64      buildonly-randconfig-006-20260305    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260304    clang-20
x86_64                randconfig-002-20260304    clang-20
x86_64                randconfig-003-20260304    clang-20
x86_64                randconfig-004-20260304    clang-20
x86_64                randconfig-005-20260304    clang-20
x86_64                randconfig-006-20260304    clang-20
x86_64                randconfig-011-20260304    gcc-14
x86_64                randconfig-011-20260305    clang-20
x86_64                randconfig-012-20260304    gcc-14
x86_64                randconfig-012-20260305    clang-20
x86_64                randconfig-013-20260304    gcc-14
x86_64                randconfig-013-20260305    clang-20
x86_64                randconfig-014-20260304    gcc-14
x86_64                randconfig-014-20260305    clang-20
x86_64                randconfig-015-20260304    gcc-14
x86_64                randconfig-015-20260305    clang-20
x86_64                randconfig-016-20260304    gcc-14
x86_64                randconfig-016-20260305    clang-20
x86_64                randconfig-071-20260304    clang-20
x86_64                randconfig-071-20260305    gcc-14
x86_64                randconfig-072-20260304    clang-20
x86_64                randconfig-072-20260305    gcc-14
x86_64                randconfig-073-20260304    clang-20
x86_64                randconfig-073-20260305    gcc-14
x86_64                randconfig-074-20260304    clang-20
x86_64                randconfig-074-20260305    gcc-14
x86_64                randconfig-075-20260304    clang-20
x86_64                randconfig-075-20260305    gcc-14
x86_64                randconfig-076-20260304    clang-20
x86_64                randconfig-076-20260305    gcc-14
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
xtensa                randconfig-001-20260305    gcc-14.3.0
xtensa                randconfig-002-20260305    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

