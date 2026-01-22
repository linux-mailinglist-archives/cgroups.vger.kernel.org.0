Return-Path: <cgroups+bounces-13370-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGGzOAk8cmnTfAAAu9opvQ
	(envelope-from <cgroups+bounces-13370-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 16:02:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6968461
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 16:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB5BC300072C
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A662C326A;
	Thu, 22 Jan 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zf1FUXWu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76632D839E
	for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094017; cv=none; b=aM2+AMxNuLXDtUgAoSfVJKhc0/j6tqaG8AqsCJRSG8Dv3d5uLI9CtGj5ZUD0/o4y96gJ/jYcJIh7yrjjhGh932NOYCNRF4oz7RdswmfYjKiY5d3Qz5KZzQaMjm35QmIIKP+BX7nxXWMb5t/28YZ6r5Hd3Au+Zhr0g2sNkjuPOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094017; c=relaxed/simple;
	bh=eUw0C/9b7d7cUjQ+J8RmNBp1/shckjhAWGCNjsMvkEc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B4XM1v7Ud6K0sD+W6uMVGoy0k5au8Gqdo4q45Rr596a7ao8MSTnWycNARgxJPEibeTDegxwH1qtMs2ifGmMByhaL+kWuzsaf1UJMP27L1jJehJafxbiqB2xErXwoeWfgPNzynneZsMOw/g9C8Sc64rTKewEMXvv5GtZkYjMKzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zf1FUXWu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769094016; x=1800630016;
  h=date:from:to:cc:subject:message-id;
  bh=eUw0C/9b7d7cUjQ+J8RmNBp1/shckjhAWGCNjsMvkEc=;
  b=Zf1FUXWuGOdFQOMKQmX0G9scPwUpSKFx826ac/PUnGP0nq97RUGfticW
   bmvMIeq5ApiHSe9kmvNwx3Ky7Dqlb860UY7qtucHTgWfj6C9tZQfVSjSY
   WZQlEfS5X98+IOQc6O1btdw4jQkiBnJg2cq9JeLITRhOIiJ+x9rkeAcCg
   oa+N5jeQ3P/6jW2foPlgdl8c0D07mVbi8PVl4INQoF0t5U2hW0+SACk7V
   pc0RNpdqYzr6zUIIMMOrtbGhjgvabXfFx1sy/WgC3XYf1lBRJ+fWwgs8W
   R4oAJTq57NSpueNHWDuD/M2MYyJRmTT2ENZpvMLQs4ORxgkk+9haA283R
   g==;
X-CSE-ConnectionGUID: uR2AHee3RYa+tpJkfbX+TA==
X-CSE-MsgGUID: wLnTuymETn+MU5wjKLD+Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="80640395"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="80640395"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:00:07 -0800
X-CSE-ConnectionGUID: Py5k6s+nTRaLIWHMVHLYJQ==
X-CSE-MsgGUID: PQjqJe+EQ4uoCKfnjlv+OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="207089533"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 Jan 2026 07:00:05 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viwAF-00000000SwN-1KxJ;
	Thu, 22 Jan 2026 15:00:03 +0000
Date: Thu, 22 Jan 2026 22:59:34 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 5a821777cae1bc3273b366a8e4cfa6ef8058b433
Message-ID: <202601222229.yKLlg01X-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-13370-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 8DA6968461
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 5a821777cae1bc3273b366a8e4cfa6ef8058b433  Merge branch 'for-6.20' into for-next

elapsed time: 857m

configs tested: 235
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260122    gcc-15.2.0
arc                   randconfig-002-20260122    gcc-15.2.0
arc                           tb10x_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260122    gcc-15.2.0
arm                   randconfig-002-20260122    gcc-15.2.0
arm                   randconfig-003-20260122    gcc-15.2.0
arm                   randconfig-004-20260122    gcc-15.2.0
arm                           sama7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260122    gcc-15.2.0
arm64                 randconfig-002-20260122    gcc-15.2.0
arm64                 randconfig-003-20260122    gcc-15.2.0
arm64                 randconfig-004-20260122    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260122    gcc-15.2.0
csky                  randconfig-002-20260122    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260122    clang-20
hexagon               randconfig-001-20260122    gcc-15.2.0
hexagon               randconfig-002-20260122    clang-22
hexagon               randconfig-002-20260122    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260122    clang-20
i386        buildonly-randconfig-002-20260122    clang-20
i386        buildonly-randconfig-002-20260122    gcc-14
i386        buildonly-randconfig-003-20260122    clang-20
i386        buildonly-randconfig-003-20260122    gcc-14
i386        buildonly-randconfig-004-20260122    clang-20
i386        buildonly-randconfig-004-20260122    gcc-14
i386        buildonly-randconfig-005-20260122    clang-20
i386        buildonly-randconfig-005-20260122    gcc-14
i386        buildonly-randconfig-006-20260122    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260122    gcc-14
i386                  randconfig-002-20260122    clang-20
i386                  randconfig-002-20260122    gcc-14
i386                  randconfig-003-20260122    gcc-12
i386                  randconfig-003-20260122    gcc-14
i386                  randconfig-004-20260122    gcc-14
i386                  randconfig-005-20260122    gcc-14
i386                  randconfig-006-20260122    gcc-14
i386                  randconfig-007-20260122    gcc-14
i386                  randconfig-011-20260122    clang-20
i386                  randconfig-012-20260122    clang-20
i386                  randconfig-013-20260122    clang-20
i386                  randconfig-014-20260122    clang-20
i386                  randconfig-015-20260122    clang-20
i386                  randconfig-016-20260122    clang-20
i386                  randconfig-017-20260122    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260122    gcc-15.2.0
loongarch             randconfig-002-20260122    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260122    gcc-11.5.0
nios2                 randconfig-001-20260122    gcc-15.2.0
nios2                 randconfig-002-20260122    gcc-15.2.0
nios2                 randconfig-002-20260122    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           alldefconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260122    gcc-10.5.0
parisc                randconfig-002-20260122    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-22
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260122    gcc-10.5.0
powerpc               randconfig-002-20260122    gcc-10.5.0
powerpc64             randconfig-001-20260122    gcc-10.5.0
powerpc64             randconfig-002-20260122    gcc-10.5.0
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260122    clang-18
riscv                 randconfig-002-20260122    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260122    clang-18
s390                  randconfig-002-20260122    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.2.0
sh                    randconfig-001-20260122    clang-18
sh                    randconfig-002-20260122    clang-18
sh                           se7206_defconfig    clang-22
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7721_defconfig    gcc-15.2.0
sh                             sh03_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260122    gcc-8.5.0
sparc                 randconfig-002-20260122    gcc-8.5.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260122    gcc-8.5.0
sparc64               randconfig-002-20260122    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260122    gcc-8.5.0
um                    randconfig-002-20260122    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260122    clang-20
x86_64      buildonly-randconfig-002-20260122    clang-20
x86_64      buildonly-randconfig-003-20260122    clang-20
x86_64      buildonly-randconfig-004-20260122    clang-20
x86_64      buildonly-randconfig-005-20260122    clang-20
x86_64      buildonly-randconfig-006-20260122    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260122    clang-20
x86_64                randconfig-002-20260122    clang-20
x86_64                randconfig-003-20260122    clang-20
x86_64                randconfig-004-20260122    clang-20
x86_64                randconfig-005-20260122    clang-20
x86_64                randconfig-006-20260122    clang-20
x86_64                randconfig-011-20260122    clang-20
x86_64                randconfig-011-20260122    gcc-14
x86_64                randconfig-012-20260122    clang-20
x86_64                randconfig-012-20260122    gcc-14
x86_64                randconfig-013-20260122    clang-20
x86_64                randconfig-014-20260122    clang-20
x86_64                randconfig-015-20260122    clang-20
x86_64                randconfig-016-20260122    clang-20
x86_64                randconfig-016-20260122    gcc-14
x86_64                randconfig-071-20260122    clang-20
x86_64                randconfig-072-20260122    clang-20
x86_64                randconfig-073-20260122    clang-20
x86_64                randconfig-074-20260122    clang-20
x86_64                randconfig-075-20260122    clang-20
x86_64                randconfig-076-20260122    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260122    gcc-8.5.0
xtensa                randconfig-002-20260122    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

