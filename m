Return-Path: <cgroups+bounces-15220-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NL1jBGfc2WmWtwgAu9opvQ
	(envelope-from <cgroups+bounces-15220-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 07:30:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4714B3DE6DE
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5F23015882
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1024BBFD;
	Sat, 11 Apr 2026 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4io6G36"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE52EA754
	for <cgroups@vger.kernel.org>; Sat, 11 Apr 2026 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775885412; cv=none; b=U/1WaBiBpUh3cc7+tuQHhUu04hxm16CpZQSpuE4PRm1ha658FIzZpcEcnLZImxuOdDho0E6TUhmN+SJ5hGXLzwyGJXdY67ztfDSvTSuxx1iTQGKfdsuyHbtxaeMwXE22+G6ThRGppH6xoWNSHkMHQcdEIX+5lquvxndSWWo6ZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775885412; c=relaxed/simple;
	bh=bgvraLUvDN6oL3XPf19dONCwK9v3gerhBD1XhiadwN8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g6RjmTEF1iVJKdkysUU8TmVvBUOcd8QOdDvLq+G6DB4hja7s6p7KA9kDJRXQX54XT/gRiA5KhRPKkorhgb70ukNbTEpdhxeW5MZnxupssO7aznjvDKyglXbhc+CYDjCh31OGebxP0J+9pnuZMAH6+KrE9QnFpbU3NH+VrghZ2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4io6G36; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775885409; x=1807421409;
  h=date:from:to:cc:subject:message-id;
  bh=bgvraLUvDN6oL3XPf19dONCwK9v3gerhBD1XhiadwN8=;
  b=N4io6G36zbgtobyTVOcoqUuQweotolreZhjGUJx5KVkIXEp6NAVDmtSF
   H5X/JMPcVizWmWvEnUDD4mWTFhYYTEXgriM8lp2/s2CuwuaMkcbBj4Dkh
   b49yTgU9YYAmi/civAohYk7tjj108hbXLd/j1qx+HeeZU0BYf1ytdFODu
   7xp/hAMUEQcPh0zRrT2QJBC9E6Uzyq+3wtxGZq0OeIFYuiUN3Dir4pUjr
   IPuwpQ+wo3uauH5yT1hDj1VV5sGa2eVSMf2H6zseB2dpqeLzDJUjptlSU
   Ajwj4ZqsDrxk/8vxuED0DzJhntFWBVoBMBvwPDjPVFC1xHTwFMd/yHqbX
   g==;
X-CSE-ConnectionGUID: +9Sy0gbPRU+Im1sHoOg+XA==
X-CSE-MsgGUID: Jwq4Q4QqT+OvaGid5wrkTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="94477270"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="94477270"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 22:30:09 -0700
X-CSE-ConnectionGUID: bCDIpk/CS92OwOTtRGvaVg==
X-CSE-MsgGUID: 5r5Q+nG9RsuQ+1Wol/AGuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="229547950"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Apr 2026 22:30:06 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBQuy-000000000pp-0vq7;
	Sat, 11 Apr 2026 05:30:04 +0000
Date: Sat, 11 Apr 2026 13:29:36 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 7bccd95b6a17f2c66a0b6b6f38cd3228c424f673
Message-ID: <202604111330.aqrT671A-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15220-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 4714B3DE6DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 7bccd95b6a17f2c66a0b6b6f38cd3228c424f673  Merge branch 'for-7.1' into for-next

elapsed time: 724m

configs tested: 189
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
arc                   randconfig-001-20260411    gcc-12.5.0
arc                   randconfig-002-20260411    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260411    gcc-12.5.0
arm                   randconfig-002-20260411    gcc-12.5.0
arm                   randconfig-003-20260411    gcc-12.5.0
arm                   randconfig-004-20260411    gcc-12.5.0
arm                        shmobile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260411    clang-23
arm64                 randconfig-002-20260411    clang-23
arm64                 randconfig-003-20260411    clang-23
arm64                 randconfig-004-20260411    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260411    clang-23
csky                  randconfig-002-20260411    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260411    gcc-14.3.0
hexagon               randconfig-002-20260411    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260411    gcc-14
i386        buildonly-randconfig-002-20260411    gcc-14
i386        buildonly-randconfig-003-20260411    gcc-14
i386        buildonly-randconfig-004-20260411    gcc-14
i386        buildonly-randconfig-005-20260411    gcc-14
i386        buildonly-randconfig-006-20260411    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260411    clang-20
i386                  randconfig-002-20260411    clang-20
i386                  randconfig-003-20260411    clang-20
i386                  randconfig-004-20260411    clang-20
i386                  randconfig-005-20260411    clang-20
i386                  randconfig-006-20260411    clang-20
i386                  randconfig-007-20260411    clang-20
i386                  randconfig-011-20260411    clang-20
i386                  randconfig-012-20260411    clang-20
i386                  randconfig-013-20260411    clang-20
i386                  randconfig-014-20260411    clang-20
i386                  randconfig-015-20260411    clang-20
i386                  randconfig-016-20260411    clang-20
i386                  randconfig-017-20260411    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260411    gcc-14.3.0
loongarch             randconfig-002-20260411    gcc-14.3.0
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
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260411    gcc-14.3.0
nios2                 randconfig-002-20260411    gcc-14.3.0
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
parisc                randconfig-001-20260411    gcc-11.5.0
parisc                randconfig-002-20260411    gcc-11.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260411    gcc-11.5.0
powerpc               randconfig-002-20260411    gcc-11.5.0
powerpc64             randconfig-001-20260411    gcc-11.5.0
powerpc64             randconfig-002-20260411    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260411    gcc-10.5.0
riscv                 randconfig-002-20260411    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260411    gcc-10.5.0
s390                  randconfig-002-20260411    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260411    gcc-10.5.0
sh                    randconfig-002-20260411    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260411    gcc-14
sparc                 randconfig-002-20260411    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260411    gcc-14
sparc64               randconfig-002-20260411    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260411    gcc-14
um                    randconfig-002-20260411    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260411    gcc-14
x86_64      buildonly-randconfig-002-20260411    gcc-14
x86_64      buildonly-randconfig-003-20260411    gcc-14
x86_64      buildonly-randconfig-004-20260411    gcc-14
x86_64      buildonly-randconfig-005-20260411    gcc-14
x86_64      buildonly-randconfig-006-20260411    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260411    gcc-14
x86_64                randconfig-002-20260411    gcc-14
x86_64                randconfig-003-20260411    gcc-14
x86_64                randconfig-004-20260411    gcc-14
x86_64                randconfig-005-20260411    gcc-14
x86_64                randconfig-006-20260411    gcc-14
x86_64                randconfig-011-20260411    clang-20
x86_64                randconfig-012-20260411    clang-20
x86_64                randconfig-013-20260411    clang-20
x86_64                randconfig-014-20260411    clang-20
x86_64                randconfig-015-20260411    clang-20
x86_64                randconfig-016-20260411    clang-20
x86_64                randconfig-071-20260411    clang-20
x86_64                randconfig-072-20260411    clang-20
x86_64                randconfig-073-20260411    clang-20
x86_64                randconfig-074-20260411    clang-20
x86_64                randconfig-075-20260411    clang-20
x86_64                randconfig-076-20260411    clang-20
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
xtensa                randconfig-001-20260411    gcc-14
xtensa                randconfig-002-20260411    gcc-14
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

