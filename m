Return-Path: <cgroups+bounces-14790-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOAmHajxsmlaRAAAu9opvQ
	(envelope-from <cgroups+bounces-14790-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 18:02:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56003276462
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 18:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E289E305A108
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D83D669E;
	Thu, 12 Mar 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2muZXZB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CD3FB7EF
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334678; cv=none; b=Q8cTo9VIs5+xSybDvtleyroaAbcxrHKoCaKVv9uc4VHpvTe/cIK2lXocRbNxfwOfRKNP40KtitRR4nE8ko1WVwAuYtvUVYcunlLlVHQOK4Sv1XFayPaFyIH0KPE0ZRYKP9AuaYPcedi7QZ9EBLC/Pe+mibsFeOEFMB+43YPu/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334678; c=relaxed/simple;
	bh=4xE7pmnflXMAARMjecXi/eyThUnVsn4JmhqInMqb4NI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gVEZzba0AsqTBDE8AsYYnn4GA+vCiCcsf4l9YlqwXtxoCS/ADurHx2uW6oEGd/QExXrRN7Ls8UgDB7FMsdx8IIqTgR69dYQER0M2Ocr8KlnW/0CYjlpRtGyqWvb2M7mVYKXep7XxDz9v07JKNl8dKDCQJRmFymQhfTU/kEHOUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2muZXZB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773334676; x=1804870676;
  h=date:from:to:cc:subject:message-id;
  bh=4xE7pmnflXMAARMjecXi/eyThUnVsn4JmhqInMqb4NI=;
  b=g2muZXZBEpVLdqVfjpcZ8qptGeLKC0NkgAuVc00bgTM3+JNATlQRLr3e
   91DJtr3DZ2+2n4z1UUTt0YASSOpyNIuZN/rfh6fM6PJP5M6ZgYOFcRWaz
   LB4XpUj7zA9qYoODyxqPrU8uKJSnB+HOl3NqPfsxXGmiYLsaWDB/mmf5f
   F14aPGvOpMpbsLQo0gLmNyyxeN31GXbSC4pomlJJErkZadWyR1ayVblJH
   YZGblLlJP1Aa1XkHCJFgLc8YL0D3JmV7YoRcnFUKHUYgkxA7f6T0RvOYC
   Fz2L25/ojIHfFw50hUsCEIa+9vBE6mys7zKobYCARRYwsBZ6afuDzymS1
   Q==;
X-CSE-ConnectionGUID: T+iDnpkMQ5SovqwXvDMn4w==
X-CSE-MsgGUID: 2yuWCbdpQSSG2kPBrCJhpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85137532"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85137532"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:57:55 -0700
X-CSE-ConnectionGUID: u3cj5z6GQH6gyVHY1TXOLA==
X-CSE-MsgGUID: l9Jo/+47Qv2EYOhgvMW0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="218673969"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2026 09:57:54 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0jM7-000000002iB-3OJd;
	Thu, 12 Mar 2026 16:57:51 +0000
Date: Fri, 13 Mar 2026 00:57:43 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 4c7c17b16c98e56507d57335faa1c92c466294c8
Message-ID: <202603130037.R96hVM7D-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-14790-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 56003276462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 4c7c17b16c98e56507d57335faa1c92c466294c8  Merge branch 'for-7.1' into for-next

elapsed time: 1090m

configs tested: 222
configs skipped: 2

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
arc                   randconfig-001-20260312    gcc-8.5.0
arc                   randconfig-002-20260312    gcc-14.3.0
arc                   randconfig-002-20260312    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260312    gcc-8.5.0
arm                   randconfig-002-20260312    gcc-11.5.0
arm                   randconfig-002-20260312    gcc-8.5.0
arm                   randconfig-003-20260312    gcc-10.5.0
arm                   randconfig-003-20260312    gcc-8.5.0
arm                   randconfig-004-20260312    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260312    clang-18
arm64                 randconfig-001-20260312    gcc-8.5.0
arm64                 randconfig-002-20260312    clang-18
arm64                 randconfig-002-20260312    gcc-13.4.0
arm64                 randconfig-003-20260312    clang-18
arm64                 randconfig-004-20260312    clang-18
arm64                 randconfig-004-20260312    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260312    clang-18
csky                  randconfig-001-20260312    gcc-12.5.0
csky                  randconfig-002-20260312    clang-18
csky                  randconfig-002-20260312    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260312    clang-23
hexagon               randconfig-001-20260312    gcc-11.5.0
hexagon               randconfig-002-20260312    clang-23
hexagon               randconfig-002-20260312    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260312    gcc-12
i386        buildonly-randconfig-001-20260312    gcc-14
i386        buildonly-randconfig-002-20260312    gcc-14
i386        buildonly-randconfig-003-20260312    gcc-14
i386        buildonly-randconfig-004-20260312    gcc-12
i386        buildonly-randconfig-004-20260312    gcc-14
i386        buildonly-randconfig-005-20260312    gcc-14
i386        buildonly-randconfig-006-20260312    clang-20
i386        buildonly-randconfig-006-20260312    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260312    gcc-14
i386                  randconfig-002-20260312    gcc-14
i386                  randconfig-003-20260312    gcc-12
i386                  randconfig-003-20260312    gcc-14
i386                  randconfig-004-20260312    gcc-14
i386                  randconfig-005-20260312    gcc-14
i386                  randconfig-006-20260312    gcc-14
i386                  randconfig-007-20260312    gcc-12
i386                  randconfig-007-20260312    gcc-14
i386                  randconfig-011-20260312    clang-20
i386                  randconfig-012-20260312    clang-20
i386                  randconfig-013-20260312    clang-20
i386                  randconfig-014-20260312    clang-20
i386                  randconfig-015-20260312    clang-20
i386                  randconfig-016-20260312    clang-20
i386                  randconfig-017-20260312    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260312    gcc-11.5.0
loongarch             randconfig-001-20260312    gcc-15.2.0
loongarch             randconfig-002-20260312    clang-23
loongarch             randconfig-002-20260312    gcc-11.5.0
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
nios2                 randconfig-001-20260312    gcc-11.5.0
nios2                 randconfig-002-20260312    gcc-11.5.0
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
parisc                randconfig-001-20260312    clang-23
parisc                randconfig-002-20260312    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260312    clang-23
powerpc               randconfig-002-20260312    clang-23
powerpc64             randconfig-001-20260312    clang-23
powerpc64             randconfig-002-20260312    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260312    gcc-13.4.0
riscv                 randconfig-002-20260312    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260312    gcc-13.4.0
s390                  randconfig-002-20260312    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260312    gcc-13.4.0
sh                    randconfig-002-20260312    gcc-13.4.0
sh                          rsk7201_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260312    gcc-15.2.0
sparc                 randconfig-002-20260312    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260312    gcc-15.2.0
sparc64               randconfig-002-20260312    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260312    gcc-15.2.0
um                    randconfig-002-20260312    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260312    gcc-12
x86_64      buildonly-randconfig-001-20260312    gcc-14
x86_64      buildonly-randconfig-002-20260312    gcc-14
x86_64      buildonly-randconfig-003-20260312    clang-20
x86_64      buildonly-randconfig-003-20260312    gcc-14
x86_64      buildonly-randconfig-004-20260312    gcc-14
x86_64      buildonly-randconfig-005-20260312    gcc-14
x86_64      buildonly-randconfig-006-20260312    clang-20
x86_64      buildonly-randconfig-006-20260312    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260312    clang-20
x86_64                randconfig-002-20260312    clang-20
x86_64                randconfig-003-20260312    clang-20
x86_64                randconfig-004-20260312    clang-20
x86_64                randconfig-005-20260312    clang-20
x86_64                randconfig-006-20260312    clang-20
x86_64                randconfig-011-20260312    clang-20
x86_64                randconfig-011-20260312    gcc-14
x86_64                randconfig-012-20260312    clang-20
x86_64                randconfig-012-20260312    gcc-14
x86_64                randconfig-013-20260312    clang-20
x86_64                randconfig-013-20260312    gcc-14
x86_64                randconfig-014-20260312    clang-20
x86_64                randconfig-014-20260312    gcc-14
x86_64                randconfig-015-20260312    clang-20
x86_64                randconfig-016-20260312    clang-20
x86_64                randconfig-071-20260312    gcc-14
x86_64                randconfig-072-20260312    gcc-14
x86_64                randconfig-073-20260312    gcc-14
x86_64                randconfig-074-20260312    gcc-14
x86_64                randconfig-075-20260312    gcc-14
x86_64                randconfig-076-20260312    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260312    gcc-15.2.0
xtensa                randconfig-002-20260312    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

