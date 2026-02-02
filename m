Return-Path: <cgroups+bounces-13592-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBwwDpg0gGmu4QIAu9opvQ
	(envelope-from <cgroups+bounces-13592-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 06:22:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF4C84B6
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 06:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39F2130053E1
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 05:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F38922F16E;
	Mon,  2 Feb 2026 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myU9v28I"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A41EA84
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770009749; cv=none; b=J7GOAYUl9LDK7ofMiN2fOcyMG+34/a9+dZCUcn1Kmp1AIOpV3xgolt/495NjsKtAPjg5zpKXH0o5njWJpwjisvZt/A+7hOPTN44WNArLzNd7j1dW9gFnShK2urpkH4K5MKQrTyuZuZDc6MrhQuRoXDIPAS0hqYW2fWfBCSBifXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770009749; c=relaxed/simple;
	bh=8AOgK+nCq/liIXloefu1zgEGlSj/4cPivz7FI4GMBjE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nkFluAMDR51K2rNcuHGLFrMXgyAvAw9VuZ8Bl5rF3xZuAjG96/XGqGgbfTZ4+OUWJrTlZJ7iJijy4wsGtLEGonNDUF6WaXZtO0bfFUpYBle2nDpKZk39akG8gHIB3voN4Hh7Sfz5XKM/7HpkKKmJVDrLgYsGSFu4w7h5e1mq1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myU9v28I; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770009748; x=1801545748;
  h=date:from:to:cc:subject:message-id;
  bh=8AOgK+nCq/liIXloefu1zgEGlSj/4cPivz7FI4GMBjE=;
  b=myU9v28IeuxY4fJfa6Xw3ZglNRJ24QlKDnRldkypSzeqM4TX/4Nx6/HZ
   c++SKuzfYnAfieNW4T6PWBb7K3qAKGyrTS0quLtH4shTD+yd2hmeyCd/W
   sh4fSL+sLaXGD0L/5BuBWQtl1v1D1O6YFw2FArJ/i5cmkWLnvHKs6ls5b
   2Hqyz7qIQVZsTo1SL/ZYFNsYHFxIktp78AFZ+jULHk7wnqQolGxMXFtkO
   xicZ8C9NK6pcV/se0yNcSg+f/kX5XPY6ZzhWiIfbbcFlGDAp5VN6/Dp5q
   Jg55GC8VzDGlAeoiqqn5sIr+De3XbAW26Q/Zf9jILEO+6GeTAMOYxRogV
   Q==;
X-CSE-ConnectionGUID: UfcbidXuSMifp2i16wiSpQ==
X-CSE-MsgGUID: 0VkCvzl0R/OfStL1nzNXhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71201083"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="71201083"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 21:22:27 -0800
X-CSE-ConnectionGUID: 1oxi1qpFSjW8ZkAH9uhIgQ==
X-CSE-MsgGUID: nAYTLUaDQ8+RQx47D5m52Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="209208882"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Feb 2026 21:22:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmmOF-00000000fFx-0jNX;
	Mon, 02 Feb 2026 05:22:23 +0000
Date: Mon, 02 Feb 2026 13:21:34 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.20] BUILD SUCCESS
 8b1f3c54f930c3aeda0b5bad97bc317fc80267fd
Message-ID: <202602021326.FhWQyT7m-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-13592-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 87DF4C84B6
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.20
branch HEAD: 8b1f3c54f930c3aeda0b5bad97bc317fc80267fd  cpuset: fix overlap of partition effective CPUs

elapsed time: 722m

configs tested: 212
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260202    gcc-14.3.0
arc                   randconfig-002-20260202    gcc-14.3.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                        multi_v7_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    clang-22
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20260202    gcc-14.3.0
arm                   randconfig-002-20260202    gcc-14.3.0
arm                   randconfig-003-20260202    gcc-14.3.0
arm                   randconfig-004-20260202    gcc-14.3.0
arm                          sp7021_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260202    gcc-9.5.0
arm64                 randconfig-002-20260202    gcc-9.5.0
arm64                 randconfig-003-20260202    gcc-9.5.0
arm64                 randconfig-004-20260202    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260202    gcc-9.5.0
csky                  randconfig-002-20260202    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260202    clang-19
hexagon               randconfig-002-20260202    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260202    gcc-14
i386        buildonly-randconfig-002-20260202    gcc-14
i386        buildonly-randconfig-003-20260202    gcc-14
i386        buildonly-randconfig-004-20260202    gcc-14
i386        buildonly-randconfig-005-20260202    gcc-14
i386        buildonly-randconfig-006-20260202    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260202    gcc-14
i386                  randconfig-002-20260202    gcc-14
i386                  randconfig-003-20260202    gcc-14
i386                  randconfig-004-20260202    gcc-14
i386                  randconfig-005-20260202    gcc-14
i386                  randconfig-006-20260202    gcc-14
i386                  randconfig-007-20260202    gcc-14
i386                  randconfig-011-20260202    clang-20
i386                  randconfig-012-20260202    clang-20
i386                  randconfig-013-20260202    clang-20
i386                  randconfig-014-20260202    clang-20
i386                  randconfig-015-20260202    clang-20
i386                  randconfig-016-20260202    clang-20
i386                  randconfig-017-20260202    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260202    clang-19
loongarch             randconfig-002-20260202    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        stmark2_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    clang-22
mips                           ip27_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    gcc-15.2.0
nios2                         3c120_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260202    clang-19
nios2                 randconfig-002-20260202    clang-19
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260202    gcc-8.5.0
parisc                randconfig-002-20260202    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                     mpc512x_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260202    gcc-8.5.0
powerpc               randconfig-002-20260202    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20260202    gcc-8.5.0
powerpc64             randconfig-002-20260202    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                     magicpanelr2_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    clang-22
sh                   rts7751r2dplus_defconfig    gcc-15.2.0
sh                          sdk7780_defconfig    clang-22
sh                           se7206_defconfig    clang-22
sh                           se7206_defconfig    gcc-15.2.0
sh                           se7751_defconfig    gcc-15.2.0
sh                             sh03_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                              ul2_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260202    gcc-12.5.0
sparc                 randconfig-002-20260202    gcc-12.5.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260202    gcc-12.5.0
sparc64               randconfig-002-20260202    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260202    gcc-12.5.0
um                    randconfig-002-20260202    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260202    gcc-14
x86_64      buildonly-randconfig-002-20260202    gcc-14
x86_64      buildonly-randconfig-003-20260202    gcc-14
x86_64      buildonly-randconfig-004-20260202    gcc-14
x86_64      buildonly-randconfig-005-20260202    gcc-14
x86_64      buildonly-randconfig-006-20260202    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260202    gcc-14
x86_64                randconfig-002-20260202    gcc-14
x86_64                randconfig-003-20260202    gcc-14
x86_64                randconfig-004-20260202    gcc-14
x86_64                randconfig-005-20260202    gcc-14
x86_64                randconfig-006-20260202    gcc-14
x86_64                randconfig-011-20260202    gcc-14
x86_64                randconfig-012-20260202    gcc-14
x86_64                randconfig-013-20260202    gcc-14
x86_64                randconfig-014-20260202    gcc-14
x86_64                randconfig-015-20260202    gcc-14
x86_64                randconfig-016-20260202    gcc-14
x86_64                randconfig-071-20260202    clang-20
x86_64                randconfig-072-20260202    clang-20
x86_64                randconfig-073-20260202    clang-20
x86_64                randconfig-074-20260202    clang-20
x86_64                randconfig-075-20260202    clang-20
x86_64                randconfig-076-20260202    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                       common_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260202    gcc-12.5.0
xtensa                randconfig-002-20260202    gcc-12.5.0
xtensa                    xip_kc705_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

