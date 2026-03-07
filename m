Return-Path: <cgroups+bounces-14697-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMvzEc1grGmlpAEAu9opvQ
	(envelope-from <cgroups+bounces-14697-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 18:30:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91322CFE9
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 18:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074E9300F511
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817EB313E0D;
	Sat,  7 Mar 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioWomXtH"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC07239099
	for <cgroups@vger.kernel.org>; Sat,  7 Mar 2026 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904649; cv=none; b=HGdgvRB+DN4Ox7f4l2b+LtqBtzvD8CTjuJKcfG4nEwfcQvOIj8YSxnZc4e4ZpHr5W3eQ7p1jWUzm+VCuyK3GkV2HBRKh9OoKj5+17VMIEEVHMBvGv7o4o0HV/NqN5Pld3YjPRxTUPHY1cPrIoSV01U5VmbpGDhjyXdmeGw8Ebrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904649; c=relaxed/simple;
	bh=4qArpA9Uw/X6g24uqUqeYkMFKwh4hR/Z+saptpJ4kR4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l9old2JSxNmXVnnVBXcnXxC/jg71Q1eB72xB1sA5aJHUNgD/6Hkx48QZ0i79uSMvT4vWwQbArDTfOIO6ODlcwXkKI9DS0gfYO4YXSVotxE26im2LxWU7XGchWKdqAbHJ2aC6BpAueKNHnMShYNavuRuUB87p/6CiBoK85Q2iUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioWomXtH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772904648; x=1804440648;
  h=date:from:to:cc:subject:message-id;
  bh=4qArpA9Uw/X6g24uqUqeYkMFKwh4hR/Z+saptpJ4kR4=;
  b=ioWomXtHKWJC+MbPOtN65PrKVXuN5DhOH5ZURGEHxcFC8azUiaYdE1oB
   tr79+UqhVgHXjCKfiuWDkd5ZFuoXQmEtnU7J7uc+mif1So1Z5pwfUScOh
   p7oP1C0pdJjeKWD3qXOceUIIDtruhOxfipqATJ/Iq+Q3p1STrf0yROns9
   PNArPh4g04Lf/w1G8mj2a+l3SNWBCEQbNbZS85rOB13f4Y708tTsVkwQC
   YRfPJ4Kd5XKRZAcxXLue1tZpRtK9oLnDrLAkUZdbZoe0JDyi8nOfVsCx5
   dUG9V2CQqlDYtd8wt4Tq0XwygtsZycWI2e0mnLtk/KnyEmI0qT8oxnGQU
   g==;
X-CSE-ConnectionGUID: lK+u07hKRDSit5p5KOFQYw==
X-CSE-MsgGUID: EvAZzfZwSWW4x27hOEQBAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="91560672"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="91560672"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 09:30:48 -0800
X-CSE-ConnectionGUID: n5K0+HIRQn+i60zMv8xyTQ==
X-CSE-MsgGUID: RUbGXwYuS7CSj3foBh26lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="224010227"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Mar 2026 09:30:46 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyvUC-000000002O7-1HWl;
	Sat, 07 Mar 2026 17:30:44 +0000
Date: Sun, 08 Mar 2026 01:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 51e451160670cbb720e7f173f90e6ef999749c15
Message-ID: <202603080149.gvaKGHez-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9D91322CFE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14697-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 51e451160670cbb720e7f173f90e6ef999749c15  Merge branch 'for-7.0-fixes' into for-next

elapsed time: 1106m

configs tested: 107
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260307    gcc-14.3.0
arc                   randconfig-002-20260307    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260307    clang-23
arm                   randconfig-002-20260307    gcc-15.2.0
arm                   randconfig-003-20260307    gcc-13.4.0
arm                   randconfig-004-20260307    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260307    gcc-8.5.0
arm64                 randconfig-002-20260307    gcc-11.5.0
arm64                 randconfig-003-20260307    gcc-15.2.0
arm64                 randconfig-004-20260307    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260307    gcc-15.2.0
csky                  randconfig-002-20260307    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-002-20260307    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260307    gcc-14
i386        buildonly-randconfig-002-20260307    gcc-14
i386        buildonly-randconfig-003-20260307    gcc-12
i386        buildonly-randconfig-004-20260307    clang-20
i386        buildonly-randconfig-005-20260307    gcc-14
i386        buildonly-randconfig-006-20260307    clang-20
i386                  randconfig-011-20260307    clang-20
i386                  randconfig-012-20260307    clang-20
i386                  randconfig-013-20260307    clang-20
i386                  randconfig-014-20260307    clang-20
i386                  randconfig-015-20260307    gcc-14
i386                  randconfig-016-20260307    gcc-14
i386                  randconfig-017-20260307    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260307    gcc-12.5.0
parisc                randconfig-002-20260307    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260307    gcc-8.5.0
powerpc               randconfig-002-20260307    gcc-11.5.0
powerpc64             randconfig-001-20260307    gcc-8.5.0
powerpc64             randconfig-002-20260307    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260307    clang-17
riscv                 randconfig-002-20260307    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260307    clang-23
s390                  randconfig-002-20260307    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260307    gcc-15.2.0
sh                    randconfig-002-20260307    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260307    gcc-15.2.0
sparc                 randconfig-002-20260307    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260307    clang-23
sparc64               randconfig-002-20260307    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                    randconfig-001-20260307    gcc-14
um                    randconfig-002-20260307    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260307    gcc-14
x86_64      buildonly-randconfig-002-20260307    gcc-14
x86_64      buildonly-randconfig-003-20260307    gcc-14
x86_64      buildonly-randconfig-004-20260307    clang-20
x86_64      buildonly-randconfig-005-20260307    clang-20
x86_64      buildonly-randconfig-006-20260307    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260307    gcc-8.5.0
xtensa                randconfig-002-20260307    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

