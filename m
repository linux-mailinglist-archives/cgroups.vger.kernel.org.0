Return-Path: <cgroups+bounces-13622-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHl1ITd+gWnlGgMAu9opvQ
	(envelope-from <cgroups+bounces-13622-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 05:48:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0941D47BC
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 05:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F55F3006D4F
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F8207DE2;
	Tue,  3 Feb 2026 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtW/dPkF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E41C84DC
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094129; cv=none; b=hEg2ibLDiR6n34t2bXmT/EQNgEEwBsAzOEj5lxaCVuggGwjhbB9+WaQjkc3z7JN+Wb04lDmjpwYLFoT/P2AEyV+8SHqa5khjKCGlJnnK82rWt5iL4FF5+3MzcuMJ6cA0ws45DvQraOvvi0YZqfI/ZUsPib0WCcZq7iUjRlIxM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094129; c=relaxed/simple;
	bh=NJIR+qxfSLb3enSFtIEf1sMXyWE6apTfwvAT4BjkbCo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JyYLPy2jCFtjOsVjifaepk10iV6XafBQ5Ya1XcMvAZ7lqEknT4VWA0ZSwVtkcY940GFotIN7ccXZ3w0oqkOC1cbTEzb+WmuvVZsBZ7B3v7k8XQNn7Q/+46ydR3P5JuDqmHt5tY1HOuNZ00ciAwFYpR0pLhDkFgPn0JI7wgTVrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtW/dPkF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770094126; x=1801630126;
  h=date:from:to:cc:subject:message-id;
  bh=NJIR+qxfSLb3enSFtIEf1sMXyWE6apTfwvAT4BjkbCo=;
  b=TtW/dPkFfHMoRpQ6mLfckYhtsfo3YNGS6C04pXLyQ/U7dbX1qbredqry
   6j97LY6nbToCKp6U+iBX69uynahxA2nfd1wc92kns1xbn/0CoWS4A5qdv
   7EHX20W1IKfumMRahToa9OTzyIvQ7iZ5n8Cg9YPgNVuzrt7PdMM0ZS5XT
   +bEBy+Q9Fh2wxv5UGYESaxVtets2RuLQ85tzxReIJV8vJRkl+2i6h5Wc/
   Rm+luUQqsg6xZJMqP/eOXAD0DpDKcDpMi7+1HXVkjbKZ7JFx8QTp61j2I
   ydp+T2eAyNoSP0iWOiSReq192BRBsiVm0YY8w5rPTv5eU5DMj7armlUm9
   w==;
X-CSE-ConnectionGUID: hdwuZDpIT/qnF5jZlXNV3Q==
X-CSE-MsgGUID: Cb8R4gj9RWeReARnPCGQZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="96714880"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="96714880"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 20:48:46 -0800
X-CSE-ConnectionGUID: MAK7CFowTcqpgC5JXxr2qQ==
X-CSE-MsgGUID: 7aG0fs90RZK4Xueqf93iSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="247326291"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Feb 2026 20:48:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn8LC-00000000gFx-28Ja;
	Tue, 03 Feb 2026 04:48:42 +0000
Date: Tue, 03 Feb 2026 12:47:58 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 cdab91959f725a63396b947212e185556bc4539a
Message-ID: <202602031249.8w5sasKw-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13622-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: B0941D47BC
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: cdab91959f725a63396b947212e185556bc4539a  Merge branch 'for-6.19-fixes' into for-next

elapsed time: 734m

configs tested: 179
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
hexagon                          allmodconfig    clang-17
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
um                               allyesconfig    gcc-14
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

