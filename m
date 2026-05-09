Return-Path: <cgroups+bounces-15687-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FzAOTyP/mkiswAAu9opvQ
	(envelope-from <cgroups+bounces-15687-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 03:34:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C94FD528
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 03:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7A93015CBB
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 01:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F70279DB1;
	Sat,  9 May 2026 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceCUCAPb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B15274FE8
	for <cgroups@vger.kernel.org>; Sat,  9 May 2026 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290486; cv=none; b=UcsfFXtEVTGsKhFkNaGcHtO+MvDlvd8xToBv3noLtTvtnHFM4cPT1bBHwc6WNOnEaQYOJAWLFcPzCC338Z0cUusc6gwBAbZ1iPfmiWkNF6h2TvH/MqOKp4/m4EL3l0aNzaejYmPxV6BtEtIVa6pbb/WJEwZMPSLLwbCH8JH2aBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290486; c=relaxed/simple;
	bh=Hwin+ZaOJf0SEGarb2zY7QxOQUgk1HEy9HdYrTiWu4E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LJzG6t01sYsHL/o//jdCyAU7Sy10qOaL8LoQursC3Uh8TbLWkhGQiLgcrCShDEZdtG5FZh5gYNOzdFgjk6+2wWi0OFr2R0JfJkvbKIWt/aWxNVWOQoeUOxBYEqe46LtZDIusSrsNOhCYuaxv1YawMUHqKfDibLWXkVQoNJL582Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceCUCAPb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778290484; x=1809826484;
  h=date:from:to:cc:subject:message-id;
  bh=Hwin+ZaOJf0SEGarb2zY7QxOQUgk1HEy9HdYrTiWu4E=;
  b=ceCUCAPbnmvt64x2QlFLV4TcjSOnPGL4Jc+vThGhQyO5QjH90IQnam8l
   VesWO6rTQwKGcR65j1ApcJE4uewDc7BwgTiODnd9UcWii+sYsoEefaM6u
   u6EKDOez7KTCb26tkEmG4k8lGz5ZUVKZtTpWIE+Ak7dp3HxEhoe2ALD43
   FvBHgOzmqyXKfK07AVMBsSzDCZGwnYBEU2sKEKeSFbWgqAQjdrZ4ctaJz
   zq8RUjDXwTwACuUPxtzTdyycvzABng2dQcrC6FkANJGFVwMv+BAv3juPi
   OhlUVJU6cdF259SYCU8/zq9zePQ11xG1TeLgkeltOgyjr8qsXnki2nPYr
   w==;
X-CSE-ConnectionGUID: PI2HLB5HQqKzObaUmKJXWQ==
X-CSE-MsgGUID: 962vTcg5QIC0fIQxdEPx4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="96836841"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="96836841"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 18:34:41 -0700
X-CSE-ConnectionGUID: wxkdAis0QzmNQMV19NxvnA==
X-CSE-MsgGUID: ETPLF0bzT2uS+gIR7cerqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="232407162"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2026 18:34:39 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLWaT-000000000Zi-0hTT;
	Sat, 09 May 2026 01:34:37 +0000
Date: Sat, 09 May 2026 09:34:22 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.1-fixes] BUILD SUCCESS
 dde2f938d02f2c740d49bb5113dea941f941026a
Message-ID: <202605090916.FYWVNDr8-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8F2C94FD528
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
	TAGGED_FROM(0.00)[bounces-15687-lists,cgroups=lfdr.de];
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.1-fixes
branch HEAD: dde2f938d02f2c740d49bb5113dea941f941026a  cgroup/cpuset: move PF_EXITING check before __GFP_HARDWALL in cpuset_current_node_allowed()

elapsed time: 1448m

configs tested: 356
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260508    gcc-12.5.0
arc                   randconfig-001-20260508    gcc-8.5.0
arc                   randconfig-001-20260509    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260508    gcc-12.5.0
arc                   randconfig-002-20260508    gcc-8.5.0
arc                   randconfig-002-20260509    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260508    gcc-12.5.0
arm                   randconfig-001-20260508    gcc-8.5.0
arm                   randconfig-001-20260509    gcc-9.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260508    gcc-12.5.0
arm                   randconfig-002-20260508    gcc-8.5.0
arm                   randconfig-002-20260509    gcc-9.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260508    gcc-12.5.0
arm                   randconfig-003-20260508    gcc-8.5.0
arm                   randconfig-003-20260509    gcc-9.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260508    gcc-12.5.0
arm                   randconfig-004-20260508    gcc-8.5.0
arm                   randconfig-004-20260509    gcc-9.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260508    gcc-14.3.0
arm64                 randconfig-001-20260509    gcc-10.5.0
arm64                 randconfig-002-20260508    gcc-14.3.0
arm64                 randconfig-002-20260509    gcc-10.5.0
arm64                 randconfig-003-20260508    gcc-14.3.0
arm64                 randconfig-003-20260509    gcc-10.5.0
arm64                 randconfig-004-20260508    gcc-14.3.0
arm64                 randconfig-004-20260509    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260508    gcc-14.3.0
csky                  randconfig-001-20260509    gcc-10.5.0
csky                  randconfig-002-20260508    gcc-14.3.0
csky                  randconfig-002-20260509    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260508    clang-23
hexagon               randconfig-001-20260508    gcc-11.5.0
hexagon               randconfig-001-20260509    clang-17
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260508    clang-23
hexagon               randconfig-002-20260508    gcc-11.5.0
hexagon               randconfig-002-20260509    clang-17
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260508    gcc-14
i386        buildonly-randconfig-001-20260509    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260508    gcc-14
i386        buildonly-randconfig-002-20260509    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260508    gcc-14
i386        buildonly-randconfig-003-20260509    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260508    gcc-14
i386        buildonly-randconfig-004-20260509    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260508    gcc-14
i386        buildonly-randconfig-005-20260509    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260508    gcc-14
i386        buildonly-randconfig-006-20260509    gcc-14
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260508    gcc-14
i386                  randconfig-001-20260509    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260508    gcc-14
i386                  randconfig-002-20260509    clang-20
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260508    gcc-14
i386                  randconfig-003-20260509    clang-20
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260508    gcc-14
i386                  randconfig-004-20260509    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260508    gcc-14
i386                  randconfig-005-20260509    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260508    gcc-14
i386                  randconfig-006-20260509    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260508    gcc-14
i386                  randconfig-007-20260509    clang-20
i386                  randconfig-011-20260508    gcc-13
i386                  randconfig-011-20260509    gcc-14
i386                  randconfig-012-20260508    gcc-13
i386                  randconfig-012-20260509    gcc-14
i386                  randconfig-013-20260508    gcc-13
i386                  randconfig-013-20260509    gcc-14
i386                  randconfig-014-20260508    gcc-13
i386                  randconfig-014-20260509    gcc-14
i386                  randconfig-015-20260508    gcc-13
i386                  randconfig-015-20260509    gcc-14
i386                  randconfig-016-20260508    gcc-13
i386                  randconfig-016-20260509    gcc-14
i386                  randconfig-017-20260508    gcc-13
i386                  randconfig-017-20260509    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260508    clang-23
loongarch             randconfig-001-20260508    gcc-11.5.0
loongarch             randconfig-001-20260509    clang-17
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260508    clang-23
loongarch             randconfig-002-20260508    gcc-11.5.0
loongarch             randconfig-002-20260509    clang-17
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
mips                      loongson3_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-23
mips                         rt305x_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260508    clang-23
nios2                 randconfig-001-20260508    gcc-11.5.0
nios2                 randconfig-001-20260509    clang-17
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260508    clang-23
nios2                 randconfig-002-20260508    gcc-11.5.0
nios2                 randconfig-002-20260509    clang-17
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-9.5.0
parisc                randconfig-001-20260508    gcc-9.5.0
parisc                randconfig-001-20260509    gcc-11.5.0
parisc                         randconfig-002    gcc-9.5.0
parisc                randconfig-002-20260508    gcc-9.5.0
parisc                randconfig-002-20260509    gcc-11.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                        randconfig-001    gcc-9.5.0
powerpc               randconfig-001-20260508    gcc-9.5.0
powerpc               randconfig-001-20260509    gcc-11.5.0
powerpc                        randconfig-002    gcc-9.5.0
powerpc               randconfig-002-20260508    gcc-9.5.0
powerpc               randconfig-002-20260509    gcc-11.5.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64                      randconfig-001    gcc-9.5.0
powerpc64             randconfig-001-20260508    gcc-9.5.0
powerpc64             randconfig-001-20260509    gcc-11.5.0
powerpc64                      randconfig-002    gcc-9.5.0
powerpc64             randconfig-002-20260508    gcc-9.5.0
powerpc64             randconfig-002-20260509    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260508    clang-23
riscv                 randconfig-001-20260509    clang-23
riscv                 randconfig-002-20260508    clang-23
riscv                 randconfig-002-20260509    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260508    clang-23
s390                  randconfig-001-20260509    clang-23
s390                  randconfig-002-20260508    clang-23
s390                  randconfig-002-20260509    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                     magicpanelr2_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260508    clang-23
sh                    randconfig-001-20260509    clang-23
sh                    randconfig-002-20260508    clang-23
sh                    randconfig-002-20260509    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-12
sparc                 randconfig-001-20260508    gcc-12
sparc                 randconfig-001-20260509    clang-23
sparc                          randconfig-002    gcc-12
sparc                 randconfig-002-20260508    gcc-12
sparc                 randconfig-002-20260509    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12
sparc64               randconfig-001-20260508    gcc-12
sparc64               randconfig-001-20260509    clang-23
sparc64                        randconfig-002    gcc-12
sparc64               randconfig-002-20260508    gcc-12
sparc64               randconfig-002-20260509    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-12
um                    randconfig-001-20260508    gcc-12
um                    randconfig-001-20260509    clang-23
um                             randconfig-002    gcc-12
um                    randconfig-002-20260508    gcc-12
um                    randconfig-002-20260509    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260508    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260508    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260508    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260508    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260508    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260508    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    clang-20
x86_64                randconfig-001-20260508    clang-20
x86_64                randconfig-001-20260509    gcc-14
x86_64                         randconfig-002    clang-20
x86_64                randconfig-002-20260508    clang-20
x86_64                randconfig-002-20260509    gcc-14
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260508    clang-20
x86_64                randconfig-003-20260509    gcc-14
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260508    clang-20
x86_64                randconfig-004-20260509    gcc-14
x86_64                         randconfig-005    clang-20
x86_64                randconfig-005-20260508    clang-20
x86_64                randconfig-005-20260509    gcc-14
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260508    clang-20
x86_64                randconfig-006-20260509    gcc-14
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260508    gcc-14
x86_64                randconfig-011-20260509    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260508    gcc-14
x86_64                randconfig-012-20260509    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260508    gcc-14
x86_64                randconfig-013-20260509    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260508    gcc-14
x86_64                randconfig-014-20260509    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260508    gcc-14
x86_64                randconfig-015-20260509    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260508    gcc-14
x86_64                randconfig-016-20260509    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260508    gcc-14
x86_64                randconfig-071-20260509    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260508    gcc-14
x86_64                randconfig-072-20260509    clang-20
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260508    gcc-14
x86_64                randconfig-073-20260509    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260508    gcc-14
x86_64                randconfig-074-20260509    clang-20
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260508    gcc-14
x86_64                randconfig-075-20260509    clang-20
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260508    gcc-14
x86_64                randconfig-076-20260509    clang-20
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
xtensa                         randconfig-001    gcc-12
xtensa                randconfig-001-20260508    gcc-12
xtensa                randconfig-001-20260509    clang-23
xtensa                         randconfig-002    gcc-12
xtensa                randconfig-002-20260508    gcc-12
xtensa                randconfig-002-20260509    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

