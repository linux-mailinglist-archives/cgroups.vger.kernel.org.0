Return-Path: <cgroups+bounces-13623-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H9hK6t+gWnlGgMAu9opvQ
	(envelope-from <cgroups+bounces-13623-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 05:50:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 250C0D47DA
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 05:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2255E30166F2
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B15207DE2;
	Tue,  3 Feb 2026 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFTex8Ke"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4B1C6FF5
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094249; cv=none; b=HN9SRUEHtmK8fpfqeOVo3Vp9UFci1ot1t+AZyQXdBsdv895pTOkCV53c907DYS6SM3AP4OFdOZzzfTk5vEFXVR28eGgYOfpcLX0WdNHD5J1Jcp6n0MHdzGpPEJTq/jnpVl74ovKz6bhjwMake2PJNnrtVOTZ4NUjxV/BPLrwfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094249; c=relaxed/simple;
	bh=p2LMewFQ3i4kX4XUxwIxccQrpYNrA0bjW/dGwJoisMY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MbqfuTb1VDhAjM1PCgfSWXDFvYusZCWs0AK5R7KSut/2kLqgYU+uGUMO4R+HeOYaq4HRkTD7Rx0UARaGhlQFaClZBzzbfq35O1y94MB1dinvPsnsLeC3oKoJPOjfEBGSDazy1amgGdA3uLgDnS8nDeFZBOgJ3SZg3ytns+ni08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFTex8Ke; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770094248; x=1801630248;
  h=date:from:to:cc:subject:message-id;
  bh=p2LMewFQ3i4kX4XUxwIxccQrpYNrA0bjW/dGwJoisMY=;
  b=nFTex8KeWZuQb9N1sq68uLFJb2nnRy6U20jekTmCGqtv4cVWyWeeju5h
   QD/Sbd1PS8JYq5Pt6pKukx1h9j0sKahVdQFhiDUIar6Ha27cdjQlRK5wq
   Po2Jqt1Vc9Orv/lyuFWYJRuVbjZxU/yIcd1WugtmXrOa8fXciI61UuKVB
   NmBEduhDsehoanm8H24IGPFJfLF/gRto+4gPfNWlQCkB7oq2uusfDkAtu
   NU9XdaecxIq3R/z6eyjx3QwGjMW1H+3FMJfY3Fj2jz6np00iKZzkdsgHa
   2TflR3tuMcz8mqJaZW4S9keOplsHfAgtH7pOd4Y2wbKqu6Cd35RxircB1
   g==;
X-CSE-ConnectionGUID: onwDJJD3R8WbReNMl7deKA==
X-CSE-MsgGUID: UeHfHFTiTl+zOyZSwVdWoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82368086"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82368086"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 20:50:47 -0800
X-CSE-ConnectionGUID: /Vr2RORHRxGKfqBzzA7J+w==
X-CSE-MsgGUID: WRhOw+W5QiWvWsieDYOKmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214495681"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Feb 2026 20:50:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn8N8-00000000gG7-2emc;
	Tue, 03 Feb 2026 04:50:42 +0000
Date: Tue, 03 Feb 2026 12:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19-fixes] BUILD SUCCESS
 99a2ef500906138ba58093b9893972a5c303c734
Message-ID: <202602031219.lwtZWs5V-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13623-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 250C0D47DA
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19-fixes
branch HEAD: 99a2ef500906138ba58093b9893972a5c303c734  cgroup/dmem: avoid pool UAF

elapsed time: 737m

configs tested: 177
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
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            hsdk_defconfig    gcc-15.2.0
arc                   randconfig-001-20260203    gcc-12.5.0
arc                   randconfig-002-20260203    gcc-12.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                           imxrt_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                   randconfig-001-20260203    gcc-12.5.0
arm                   randconfig-002-20260203    gcc-12.5.0
arm                   randconfig-003-20260203    gcc-12.5.0
arm                   randconfig-004-20260203    gcc-12.5.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260203    gcc-15.2.0
arm64                 randconfig-002-20260203    gcc-15.2.0
arm64                 randconfig-003-20260203    gcc-15.2.0
arm64                 randconfig-004-20260203    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260203    gcc-15.2.0
csky                  randconfig-002-20260203    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260203    clang-22
hexagon               randconfig-002-20260203    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260203    clang-20
i386        buildonly-randconfig-002-20260203    clang-20
i386        buildonly-randconfig-003-20260203    clang-20
i386        buildonly-randconfig-004-20260203    clang-20
i386        buildonly-randconfig-005-20260203    clang-20
i386        buildonly-randconfig-006-20260203    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260203    clang-20
i386                  randconfig-002-20260203    clang-20
i386                  randconfig-003-20260203    clang-20
i386                  randconfig-004-20260203    clang-20
i386                  randconfig-005-20260203    clang-20
i386                  randconfig-006-20260203    clang-20
i386                  randconfig-007-20260203    clang-20
i386                  randconfig-011-20260203    gcc-14
i386                  randconfig-012-20260203    gcc-14
i386                  randconfig-013-20260203    gcc-14
i386                  randconfig-014-20260203    gcc-14
i386                  randconfig-015-20260203    gcc-14
i386                  randconfig-016-20260203    gcc-14
i386                  randconfig-017-20260203    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260203    clang-22
loongarch             randconfig-002-20260203    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          atari_defconfig    gcc-15.2.0
m68k                       bvme6000_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                            mac_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       bmips_be_defconfig    gcc-15.2.0
mips                           ip32_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260203    clang-22
nios2                 randconfig-002-20260203    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260203    gcc-12.5.0
parisc                randconfig-002-20260203    gcc-12.5.0
parisc64                         alldefconfig    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260203    gcc-12.5.0
powerpc               randconfig-002-20260203    gcc-12.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260203    gcc-12.5.0
powerpc64             randconfig-002-20260203    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260203    gcc-8.5.0
riscv                 randconfig-002-20260203    gcc-8.5.0
s390                             alldefconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260203    gcc-8.5.0
s390                  randconfig-002-20260203    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260203    gcc-8.5.0
sh                    randconfig-002-20260203    gcc-8.5.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260203    gcc-13.4.0
sparc                 randconfig-002-20260203    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260203    gcc-13.4.0
sparc64               randconfig-002-20260203    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260203    gcc-13.4.0
um                    randconfig-002-20260203    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260203    clang-20
x86_64      buildonly-randconfig-002-20260203    clang-20
x86_64      buildonly-randconfig-003-20260203    clang-20
x86_64      buildonly-randconfig-004-20260203    clang-20
x86_64      buildonly-randconfig-005-20260203    clang-20
x86_64      buildonly-randconfig-006-20260203    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20260203    gcc-14
x86_64                randconfig-072-20260203    gcc-14
x86_64                randconfig-073-20260203    gcc-14
x86_64                randconfig-074-20260203    gcc-14
x86_64                randconfig-075-20260203    gcc-14
x86_64                randconfig-076-20260203    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260203    gcc-13.4.0
xtensa                randconfig-002-20260203    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

