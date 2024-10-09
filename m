Return-Path: <cgroups+bounces-5081-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D9996D58
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 16:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321CF1C2249C
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BAB19924D;
	Wed,  9 Oct 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="go94Nlyi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38E190059
	for <cgroups@vger.kernel.org>; Wed,  9 Oct 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483122; cv=none; b=i7SOSZIK0P0K/OOB0MsouKVrMvnz0jP0wMrLq2sgHsoVpAD7RnVHbhPJiQNegzUfFUAHgu1Gxew23X2s3l7AzT+uqCthDYlJC7AU2CEkDr54JCx/N3LnzLmirGtFcvwLNccjhJDhHzslPRKULZWhxYNZq7/CRJ1mkItZ/DnWJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483122; c=relaxed/simple;
	bh=QctqLD0ykyn/PFpS/fIKTW/E4Gj5JPsp+L6Fq/D3xGM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K1u+dR8fVodJHFWGfPinOCezmVvS9hFUATVjAqJdCQWNn7kWbAwQATn+Dbu4TfCNYIIHbw9brXT0zS3sOaXyJzVw76UTDiLIbQO5O1pbJUU7mF7a+MtJ+peppwpfcBWyo14VbPVn75ZfSIJVLjDFNWcPp0niiJ8J/ih+C42EOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=go94Nlyi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728483121; x=1760019121;
  h=date:from:to:cc:subject:message-id;
  bh=QctqLD0ykyn/PFpS/fIKTW/E4Gj5JPsp+L6Fq/D3xGM=;
  b=go94NlyiFipCyHTzRomLKH0ZXKT1oKKjkMJbho/pZQxOnI9z2kuodcEy
   2R1hUroD3N1vdhihMKnvPF2NW1vb1uZnFWHk2SOjEsENtUkswYkHg+mlh
   GMv0QAxTQFWHF00jqmI7nP2sqTnlpNgGETIAUuV5xd9MvqdMufWMpFVDj
   IVjT0JUCDB2cwIofNvszFQ8uhQ6HvZgPT6C4TSPgnxELUE5b/hjmGZXd7
   Q40urbtXCWMABZHPle5aPTvS8fxdUTqxWXFVIwd3C8vdCqqaBtTubOxFp
   irEYvBMHcc6ABI9wHFcT3h7dDIDpsRV1Pjr2MoR8so9TPXRtzG435nm7R
   w==;
X-CSE-ConnectionGUID: eebuvlp+RLG0r/gC7rE36Q==
X-CSE-MsgGUID: 6aRZWkmWSBOpckFpT//1yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="53192865"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="53192865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:11:58 -0700
X-CSE-ConnectionGUID: GhFoTZ2+RX6CclSLGCWGTQ==
X-CSE-MsgGUID: WkMMZ0BRTbSZfuCilMgC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="80255367"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Oct 2024 07:11:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syXPu-0009Ji-2l;
	Wed, 09 Oct 2024 14:11:54 +0000
Date: Wed, 09 Oct 2024 22:11:21 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.12-fixes] BUILD SUCCESS
 117932eea99b729ee5d12783601a4f7f5fd58a23
Message-ID: <202410092214.9mUGuaIl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.12-fixes
branch HEAD: 117932eea99b729ee5d12783601a4f7f5fd58a23  cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction

elapsed time: 1095m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    gcc-14.1.0
arm                          gemini_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                           sama5_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241009    clang-18
i386        buildonly-randconfig-002-20241009    clang-18
i386        buildonly-randconfig-003-20241009    clang-18
i386        buildonly-randconfig-004-20241009    clang-18
i386        buildonly-randconfig-005-20241009    clang-18
i386        buildonly-randconfig-006-20241009    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241009    clang-18
i386                  randconfig-002-20241009    clang-18
i386                  randconfig-003-20241009    clang-18
i386                  randconfig-004-20241009    clang-18
i386                  randconfig-005-20241009    clang-18
i386                  randconfig-006-20241009    clang-18
i386                  randconfig-011-20241009    clang-18
i386                  randconfig-012-20241009    clang-18
i386                  randconfig-013-20241009    clang-18
i386                  randconfig-014-20241009    clang-18
i386                  randconfig-015-20241009    clang-18
i386                  randconfig-016-20241009    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                           ci20_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                      malta_kvm_defconfig    gcc-14.1.0
mips                           rs90_defconfig    gcc-14.1.0
mips                           xway_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241009    clang-18
x86_64      buildonly-randconfig-002-20241009    clang-18
x86_64      buildonly-randconfig-003-20241009    clang-18
x86_64      buildonly-randconfig-004-20241009    clang-18
x86_64      buildonly-randconfig-005-20241009    clang-18
x86_64      buildonly-randconfig-006-20241009    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241009    clang-18
x86_64                randconfig-002-20241009    clang-18
x86_64                randconfig-003-20241009    clang-18
x86_64                randconfig-004-20241009    clang-18
x86_64                randconfig-005-20241009    clang-18
x86_64                randconfig-006-20241009    clang-18
x86_64                randconfig-011-20241009    clang-18
x86_64                randconfig-012-20241009    clang-18
x86_64                randconfig-013-20241009    clang-18
x86_64                randconfig-014-20241009    clang-18
x86_64                randconfig-015-20241009    clang-18
x86_64                randconfig-016-20241009    clang-18
x86_64                randconfig-071-20241009    clang-18
x86_64                randconfig-072-20241009    clang-18
x86_64                randconfig-073-20241009    clang-18
x86_64                randconfig-074-20241009    clang-18
x86_64                randconfig-075-20241009    clang-18
x86_64                randconfig-076-20241009    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

