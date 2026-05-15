Return-Path: <cgroups+bounces-15980-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHGDDRksB2oLsgIAu9opvQ
	(envelope-from <cgroups+bounces-15980-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 16:22:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D05514C1
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7C7305EA99
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D1337BB0;
	Fri, 15 May 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI8gaqAq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0D33D4FD
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854608; cv=none; b=HnhmbBD4Q2UTp3Q1YO9WmaJcoU78QCOKLitVW2eVSroPGbW8AhICRNAPv8G4lmgIxe6UDQYyRmZ2VWc5OEjGxhNIc8/Ba/rvl8GMgBvDFidXsxJpFdSbRmXN8xhXOrZA1RpyZUE8waSWU21r1rePGj8kkyRLd1GtPVJQeBJ2QZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854608; c=relaxed/simple;
	bh=xa25gq5wJcoKYb0v21GC7jyyih2NfRM9SDFcQ9Z/edk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=esyhT+txqtCsWz4CIKLiORSWq20PV3SotP+Pbg6Gj3mvpGFM31ZQ1PwFm0ADQDLRCed+ZU511MFi1oiizLf99l9ahAvDrBYhN9pqYXm8KjEyev0F42gfNbxRKetm1jfuhv4Nqjfv4rWTL2e0cysUtr2g8sLt4YoUabotHL9jQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iI8gaqAq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778854607; x=1810390607;
  h=date:from:to:cc:subject:message-id;
  bh=xa25gq5wJcoKYb0v21GC7jyyih2NfRM9SDFcQ9Z/edk=;
  b=iI8gaqAqAZez0t3PikiD49BarmRzg/yPmnTwaQOME+7JxtqNyReTcUJh
   epBOOeQKR4o92PFJ7vTLF4F9hXuLJHRk7ddP7XjobfSGd+RjybP0womxs
   lUOI87BZu+UAcuTzG5Zt15AijNSkQCxhz6A0z89m9jSZCDGnUlrWerxX/
   WW3besp4gX7POq3AoMX+MryJ/jslPajU9qOVRilunszfumD/Dm7IfWPgy
   JSLsE2qr2FyEvGrHQcdPE1j+8LMvjPAkk2BWZTH8PIuZeYQ4pfTIEd+Yx
   WckSZl9bcYyerFlYyXAIuM506KsaVkMZVrqs1Ry9cj7qzlkDgTo8zj9QK
   w==;
X-CSE-ConnectionGUID: WeUUWbDsSyik2+ekWNDSnQ==
X-CSE-MsgGUID: eu79ky+DSdauPqEjaHSrBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="78948040"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="78948040"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 07:16:46 -0700
X-CSE-ConnectionGUID: ChBiKcalQA2GETna4vT+Sw==
X-CSE-MsgGUID: se40bNBkS5mbvmh9WkhHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238960845"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 15 May 2026 07:16:45 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNtKv-000000001oF-1PtJ;
	Fri, 15 May 2026 14:16:28 +0000
Date: Fri, 15 May 2026 22:09:42 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 732823fa1fe926424401bd71d63c8cd49738d67e
Message-ID: <202605152221.RDLV9DvI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1C1D05514C1
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-15980-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 732823fa1fe926424401bd71d63c8cd49738d67e  Merge branch 'for-7.2' into for-next

elapsed time: 983m

configs tested: 216
configs skipped: 4

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
arc                                 defconfig    gcc-15.2.0
arc                            hsdk_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260515    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260515    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260515    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260515    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260515    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260515    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260515    clang-16
arm64                 randconfig-001-20260515    gcc-11.5.0
arm64                 randconfig-002-20260515    gcc-10.5.0
arm64                 randconfig-002-20260515    gcc-11.5.0
arm64                 randconfig-003-20260515    gcc-11.5.0
arm64                 randconfig-004-20260515    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260515    gcc-10.5.0
csky                  randconfig-001-20260515    gcc-11.5.0
csky                  randconfig-002-20260515    gcc-11.5.0
csky                  randconfig-002-20260515    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260515    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260515    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260515    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260515    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260515    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260515    gcc-14
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260515    clang-20
i386                           randconfig-002    clang-20
i386                  randconfig-002-20260515    clang-20
i386                           randconfig-003    clang-20
i386                  randconfig-003-20260515    clang-20
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260515    clang-20
i386                           randconfig-005    clang-20
i386                  randconfig-005-20260515    clang-20
i386                           randconfig-006    clang-20
i386                  randconfig-006-20260515    clang-20
i386                           randconfig-007    clang-20
i386                  randconfig-007-20260515    clang-20
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260515    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260515    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260515    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260515    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260515    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260515    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260515    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
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
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260515    gcc-8.5.0
parisc                randconfig-002-20260515    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260515    gcc-8.5.0
powerpc               randconfig-002-20260515    gcc-8.5.0
powerpc64             randconfig-001-20260515    gcc-8.5.0
powerpc64             randconfig-002-20260515    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260515    gcc-15.2.0
riscv                 randconfig-002-20260515    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260515    gcc-15.2.0
s390                  randconfig-002-20260515    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260515    gcc-15.2.0
sh                    randconfig-002-20260515    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260515    gcc-8.5.0
sparc                 randconfig-002-20260515    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260515    gcc-8.5.0
sparc64               randconfig-002-20260515    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260515    gcc-8.5.0
um                    randconfig-002-20260515    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260515    gcc-14
x86_64      buildonly-randconfig-002-20260515    gcc-14
x86_64      buildonly-randconfig-003-20260515    gcc-14
x86_64      buildonly-randconfig-004-20260515    gcc-14
x86_64      buildonly-randconfig-005-20260515    gcc-14
x86_64      buildonly-randconfig-006-20260515    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260515    clang-20
x86_64                randconfig-012-20260515    clang-20
x86_64                randconfig-013-20260515    clang-20
x86_64                randconfig-014-20260515    clang-20
x86_64                randconfig-015-20260515    clang-20
x86_64                randconfig-016-20260515    clang-20
x86_64                         randconfig-071    gcc-12
x86_64                randconfig-071-20260515    gcc-12
x86_64                         randconfig-072    gcc-12
x86_64                randconfig-072-20260515    gcc-12
x86_64                         randconfig-073    gcc-12
x86_64                randconfig-073-20260515    gcc-12
x86_64                         randconfig-074    gcc-12
x86_64                randconfig-074-20260515    gcc-12
x86_64                         randconfig-075    gcc-12
x86_64                randconfig-075-20260515    gcc-12
x86_64                         randconfig-076    gcc-12
x86_64                randconfig-076-20260515    gcc-12
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
xtensa                randconfig-001-20260515    gcc-8.5.0
xtensa                randconfig-002-20260515    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

