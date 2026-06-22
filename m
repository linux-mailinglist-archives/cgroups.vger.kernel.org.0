Return-Path: <cgroups+bounces-17127-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5cpwOoDPOGrBiQcAu9opvQ
	(envelope-from <cgroups+bounces-17127-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 08:00:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6B6ACDAD
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 08:00:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Z3ILcLIQ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17127-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17127-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FA5730011AF
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 06:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9372D7DE9;
	Mon, 22 Jun 2026 06:00:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC961A275
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 06:00:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108026; cv=none; b=W74Ip7i8XCozg1R6bSHpQ9JJFInLZKOBJzRLEtDwpn+SCSEGtd5k30LldAi089hVvpgwl3j4CM3aUa0/oLzrSfswXT70FOTtSQz0pFMTcWveRxR/Us4uSbhgQq8ceU4JicYa546lwcEqbJ5DzFkvt/BFcI2iGDtp7AIvJRwMXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108026; c=relaxed/simple;
	bh=HWOF5ciQkUQd5adg10wwHlFigHHz660v14MoDHt7HRM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=USKaeHH9eGeypPWGBbytr/wEfkIeBAIBHB0kKAeZD/HOTaA5oBz1tVq3zIoXs7AamTTnKuZxHVcSCdRnnC1oMP9chLR6ZQXS80M6ch7kz1PEOK8rGigC+Geep6G1gW07LSVlg6081aAG14vNkGCsFKGWWPGqljihXqwiul6KXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3ILcLIQ; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782108024; x=1813644024;
  h=date:from:to:cc:subject:message-id;
  bh=HWOF5ciQkUQd5adg10wwHlFigHHz660v14MoDHt7HRM=;
  b=Z3ILcLIQvmnwWWgyFYwy6kVDweIEsT1XRJMEEmGd+K28fahhoiLT7HJZ
   lByZbZyuv9xHyKAViV/Aa1MLcJTt9dHv8u9NoryOCNMChEVsxbH3O68qE
   Qv/aYOxrtW2KNNYQkXiryGZ8pYMmF3gZb8eKgAAVS6VUQ766IqoHWxxXI
   hEf7kAxMM2Em+dL3pG2rkr0yM+BtBWK8LNAbWtoigpNQ45/OOhwsnfHg4
   4RTFlAdRwcldmlgLKPL0PKiqXYNuoNN1t4Ub/P6E33CM1YWYH7NlXO+nI
   bQrdPPdl2KmTaN5J4JVpOL7ZKMO+5yIgUQYfQ2qbsRrPNgFk/+k60kD5c
   w==;
X-CSE-ConnectionGUID: qQ1gj3FyRqOh0R5un4NEfg==
X-CSE-MsgGUID: nC13dOAISESLRDQF+P35/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="94221888"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="94221888"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 23:00:23 -0700
X-CSE-ConnectionGUID: 8VOSYTs8RrGpkOGta/a9/A==
X-CSE-MsgGUID: wGtB/pPfQButohtH7zqwYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="273204850"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Jun 2026 23:00:22 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbXhj-000000000Y8-43rL;
	Mon, 22 Jun 2026 06:00:19 +0000
Date: Mon, 22 Jun 2026 13:54:16 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-for-7.2] BUILD SUCCESS
 b62299084fb88382321b5eed2edef2a0d0cdf117
Message-ID: <202606221306.xt1JY2nG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17127-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FE6B6ACDAD

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-7.2
branch HEAD: b62299084fb88382321b5eed2edef2a0d0cdf117  Merge branch 'for-7.2' into test-merge-for-7.2

elapsed time: 6339m

configs tested: 230
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260618    gcc-15.2.0
arc                   randconfig-002-20260618    gcc-15.2.0
arc                   randconfig-002-20260618    gcc-8.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                          pxa3xx_defconfig    clang-17
arm                   randconfig-001-20260618    gcc-10.5.0
arm                   randconfig-001-20260618    gcc-15.2.0
arm                   randconfig-002-20260618    clang-17
arm                   randconfig-002-20260618    gcc-15.2.0
arm                   randconfig-003-20260618    gcc-13.4.0
arm                   randconfig-003-20260618    gcc-15.2.0
arm                   randconfig-004-20260618    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260618    gcc-15.2.0
arm64                 randconfig-002-20260618    gcc-15.2.0
arm64                 randconfig-003-20260618    gcc-15.2.0
arm64                 randconfig-004-20260618    gcc-15.2.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260618    gcc-15.2.0
csky                  randconfig-002-20260618    gcc-15.2.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260618    clang-17
hexagon               randconfig-001-20260618    clang-23
hexagon               randconfig-002-20260618    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260618    gcc-14
i386        buildonly-randconfig-002-20260618    gcc-14
i386        buildonly-randconfig-003-20260618    gcc-14
i386        buildonly-randconfig-004-20260618    gcc-14
i386        buildonly-randconfig-005-20260618    gcc-14
i386        buildonly-randconfig-006-20260618    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260618    clang-22
i386                  randconfig-002-20260618    clang-22
i386                  randconfig-003-20260618    clang-22
i386                  randconfig-004-20260618    clang-22
i386                  randconfig-005-20260618    clang-22
i386                  randconfig-006-20260618    clang-22
i386                  randconfig-007-20260618    clang-22
i386                  randconfig-011-20260618    clang-22
i386                  randconfig-012-20260618    clang-22
i386                  randconfig-013-20260618    clang-22
i386                  randconfig-014-20260618    clang-22
i386                  randconfig-014-20260618    gcc-14
i386                  randconfig-015-20260618    clang-22
i386                  randconfig-016-20260618    clang-22
i386                  randconfig-017-20260618    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260618    clang-23
loongarch             randconfig-002-20260618    clang-23
loongarch             randconfig-002-20260618    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                         cobalt_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260618    clang-23
nios2                 randconfig-001-20260618    gcc-8.5.0
nios2                 randconfig-002-20260618    clang-23
nios2                 randconfig-002-20260618    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260618    gcc-14.3.0
parisc                randconfig-001-20260618    gcc-16.1.0
parisc                randconfig-002-20260618    gcc-16.1.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260618    gcc-16.1.0
powerpc               randconfig-001-20260618    gcc-8.5.0
powerpc               randconfig-002-20260618    gcc-11.5.0
powerpc               randconfig-002-20260618    gcc-16.1.0
powerpc64             randconfig-001-20260618    gcc-16.1.0
powerpc64             randconfig-001-20260618    gcc-8.5.0
powerpc64             randconfig-002-20260618    clang-17
powerpc64             randconfig-002-20260618    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260618    gcc-11.5.0
riscv                 randconfig-001-20260618    gcc-13.4.0
riscv                 randconfig-002-20260618    clang-20
riscv                 randconfig-002-20260618    gcc-13.4.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260618    clang-23
s390                  randconfig-001-20260618    gcc-13.4.0
s390                  randconfig-002-20260618    clang-23
s390                  randconfig-002-20260618    gcc-13.4.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                         ap325rxa_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                        edosk7760_defconfig    gcc-16.1.0
sh                    randconfig-001-20260618    gcc-13.4.0
sh                    randconfig-002-20260618    gcc-13.4.0
sh                    randconfig-002-20260618    gcc-16.1.0
sh                           se7619_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260618    gcc-14.3.0
sparc                 randconfig-002-20260618    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260618    gcc-14.3.0
sparc64               randconfig-002-20260618    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260618    gcc-14.3.0
um                    randconfig-002-20260618    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260618    clang-22
x86_64      buildonly-randconfig-002-20260618    clang-22
x86_64      buildonly-randconfig-003-20260618    clang-22
x86_64      buildonly-randconfig-004-20260618    clang-22
x86_64      buildonly-randconfig-005-20260618    clang-22
x86_64      buildonly-randconfig-006-20260618    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260618    clang-22
x86_64                randconfig-002-20260618    clang-22
x86_64                randconfig-002-20260618    gcc-14
x86_64                randconfig-003-20260618    clang-22
x86_64                randconfig-004-20260618    clang-22
x86_64                randconfig-005-20260618    clang-22
x86_64                randconfig-005-20260618    gcc-14
x86_64                randconfig-006-20260618    clang-22
x86_64                randconfig-011-20260618    clang-22
x86_64                randconfig-011-20260618    gcc-14
x86_64                randconfig-012-20260618    gcc-14
x86_64                randconfig-013-20260618    gcc-14
x86_64                randconfig-014-20260618    gcc-14
x86_64                randconfig-015-20260618    clang-22
x86_64                randconfig-015-20260618    gcc-14
x86_64                randconfig-016-20260618    gcc-14
x86_64                randconfig-071-20260618    clang-22
x86_64                randconfig-072-20260618    clang-22
x86_64                randconfig-073-20260618    clang-22
x86_64                randconfig-074-20260618    clang-22
x86_64                randconfig-075-20260618    clang-22
x86_64                randconfig-076-20260618    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260618    gcc-14.3.0
xtensa                randconfig-002-20260618    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

