Return-Path: <cgroups+bounces-16073-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF1nDX84DGq2aAUAu9opvQ
	(envelope-from <cgroups+bounces-16073-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 12:16:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3643357C068
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 12:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 106FE30B6366
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D243D47DD;
	Tue, 19 May 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfM/MS3V"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEC3793B6
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184050; cv=none; b=mEe0O/qucuLdZfVxKzn9tzbdERF9OanozYMh62oHV53KzW2bQGhEwStj2c0liAtwmgwEjCsQf+Mh2/anNgiHagghjMr3LOF/un9aoGCAmo1uDnRTfhPLUwmObUepZfpFEPA7D6DcY5R6gmqdPXiBqxX8tB7lMwRkRu53OQgGQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184050; c=relaxed/simple;
	bh=gD/Yvnh+JK2HmlV14qOjKVIiGDzc279jh+0pphYGHWg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I1m47jt6NKmm4LUfLr+ifTvQGiedc3hjtnWJ5LzN8m8H+QMTVqN8sITymcDScmFuXNK3vPh6WTMLjFGQQWQGfCzyUe/N0/aFYrEoeMHUGg2dfm7cQv3rMFZz+TJiAr+dEmCwGKxEi9uzMSSvq4AV0EwZBYKGpY8leq6jJqxS0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfM/MS3V; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779184049; x=1810720049;
  h=date:from:to:cc:subject:message-id;
  bh=gD/Yvnh+JK2HmlV14qOjKVIiGDzc279jh+0pphYGHWg=;
  b=OfM/MS3V8EsnJ6wA+CnutnfnAQdqIk4RX1MWRmPZnaEEVPwoG/vZGXdi
   1waz6jxui18N/x4XkmxVvPgxjJzODVvpU9OK9j7wZsONuJBc9kliK8ezI
   ykchcNhK+Gtpi2VRMO3ZWjEGooeUmu/ml7f8BdgVozKtedqRm5L9PNPid
   dfk6kUm/GCrL+x67JI+CyZqYvfeQz+UoMIFik8P4EPWKlOM2OybOCi0A0
   lJ7crUlZCOZclVbonbwnlYkSHJFvFQeAgKX5r2pB1BpO461+TkzezlZ/q
   WxgS9bOkp/nkcHMHKEG6npv2Bj8h7Gp5lkmp5Y/CeCjWuHKnZAo9Iq+Om
   Q==;
X-CSE-ConnectionGUID: BHlyhJzTQCOhJvNYVRELGw==
X-CSE-MsgGUID: Mgxe3Vs+TpOPed3iPCcIlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80108403"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80108403"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:47:29 -0700
X-CSE-ConnectionGUID: zboS9YOjRI6rGHsw6Zwrqw==
X-CSE-MsgGUID: NnF74+YxQlqZrN5nHCxWkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233341876"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2026 02:47:27 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPH2b-000000000pD-3uy2;
	Tue, 19 May 2026 09:47:16 +0000
Date: Tue, 19 May 2026 17:44:46 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.2] BUILD SUCCESS
 0d25e3865841ea5edfedb5af42bf15cef075192e
Message-ID: <202605191737.VaoESDwm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16073-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 3643357C068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.2
branch HEAD: 0d25e3865841ea5edfedb5af42bf15cef075192e  cgroup/rdma: Drop unnecessary READ_ONCE() on event counters

elapsed time: 823m

configs tested: 272
configs skipped: 12

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
arc                   randconfig-001-20260519    clang-23
arc                   randconfig-001-20260519    gcc-9.5.0
arc                   randconfig-002-20260519    clang-23
arc                   randconfig-002-20260519    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-004-20260519    clang-23
arm                   randconfig-004-20260519    gcc-8.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    clang-18
arm64                 randconfig-001-20260519    gcc-8.5.0
arm64                 randconfig-002-20260519    gcc-11.5.0
arm64                 randconfig-002-20260519    gcc-8.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-12.5.0
csky                  randconfig-001-20260519    gcc-8.5.0
csky                  randconfig-002-20260519    gcc-11.5.0
csky                  randconfig-002-20260519    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260519    clang-23
hexagon               randconfig-001-20260519    gcc-10.5.0
hexagon               randconfig-001-20260519    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260519    clang-23
hexagon               randconfig-002-20260519    gcc-10.5.0
hexagon               randconfig-002-20260519    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260519    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-14
i386        buildonly-randconfig-003-20260519    clang-20
i386        buildonly-randconfig-003-20260519    gcc-12
i386        buildonly-randconfig-004-20260519    gcc-12
i386        buildonly-randconfig-004-20260519    gcc-14
i386        buildonly-randconfig-005-20260519    gcc-12
i386        buildonly-randconfig-005-20260519    gcc-14
i386        buildonly-randconfig-006-20260519    clang-20
i386        buildonly-randconfig-006-20260519    gcc-12
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260519    gcc-14
i386                  randconfig-002-20260519    gcc-14
i386                  randconfig-003-20260519    gcc-14
i386                  randconfig-004-20260519    gcc-14
i386                  randconfig-005-20260519    gcc-14
i386                  randconfig-006-20260519    gcc-14
i386                  randconfig-007-20260519    gcc-14
i386                  randconfig-011-20260519    clang-20
i386                  randconfig-012-20260519    clang-20
i386                  randconfig-013-20260519    gcc-14
i386                  randconfig-014-20260519    clang-20
i386                  randconfig-015-20260519    clang-20
i386                  randconfig-016-20260519    clang-20
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260519    clang-18
loongarch             randconfig-001-20260519    gcc-10.5.0
loongarch             randconfig-001-20260519    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260519    gcc-10.5.0
loongarch             randconfig-002-20260519    gcc-11.5.0
loongarch             randconfig-002-20260519    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260519    gcc-10.5.0
nios2                 randconfig-001-20260519    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
nios2                 randconfig-002-20260519    gcc-11.5.0
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
parisc                randconfig-001-20260519    gcc-12.5.0
parisc                randconfig-001-20260519    gcc-8.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260519    clang-23
powerpc               randconfig-001-20260519    gcc-8.5.0
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64             randconfig-001-20260519    clang-23
powerpc64             randconfig-001-20260519    gcc-8.5.0
powerpc64             randconfig-002-20260519    gcc-14.3.0
powerpc64             randconfig-002-20260519    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260519    gcc-13.4.0
riscv                 randconfig-001-20260519    gcc-8.5.0
riscv                 randconfig-002-20260519    clang-17
riscv                 randconfig-002-20260519    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260519    clang-23
s390                  randconfig-001-20260519    gcc-13.4.0
s390                  randconfig-002-20260519    clang-18
s390                  randconfig-002-20260519    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260519    gcc-13.4.0
sh                    randconfig-001-20260519    gcc-15.2.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260519    gcc-14.3.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260519    gcc-11.5.0
sparc                 randconfig-002-20260519    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260519    gcc-14.3.0
sparc64               randconfig-001-20260519    gcc-8.5.0
sparc64                        randconfig-002    clang-23
sparc64               randconfig-002-20260519    gcc-14.3.0
sparc64               randconfig-002-20260519    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260519    clang-23
um                    randconfig-001-20260519    gcc-14.3.0
um                             randconfig-002    clang-23
um                    randconfig-002-20260519    clang-23
um                    randconfig-002-20260519    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260519    gcc-14
x86_64      buildonly-randconfig-002-20260519    gcc-14
x86_64      buildonly-randconfig-003-20260519    gcc-14
x86_64      buildonly-randconfig-004-20260519    gcc-14
x86_64      buildonly-randconfig-005-20260519    gcc-14
x86_64      buildonly-randconfig-006-20260519    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260519    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260519    gcc-13
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260519    clang-20
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260519    clang-20
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260519    clang-20
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260519    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260519    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260519    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260519    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260519    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260519    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260519    clang-20
x86_64                randconfig-071-20260519    gcc-14
x86_64                randconfig-072-20260519    gcc-14
x86_64                randconfig-073-20260519    gcc-14
x86_64                randconfig-074-20260519    gcc-14
x86_64                randconfig-075-20260519    gcc-14
x86_64                randconfig-076-20260519    gcc-14
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
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260519    gcc-10.5.0
xtensa                randconfig-001-20260519    gcc-14.3.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260519    gcc-10.5.0
xtensa                randconfig-002-20260519    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

