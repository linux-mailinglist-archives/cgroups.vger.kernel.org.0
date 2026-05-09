Return-Path: <cgroups+bounces-15686-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM/mETmP/mkiswAAu9opvQ
	(envelope-from <cgroups+bounces-15686-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 03:34:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD84FD521
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 03:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0DF03013249
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 01:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF51DA23;
	Sat,  9 May 2026 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaAKiI0S"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63C25D53B
	for <cgroups@vger.kernel.org>; Sat,  9 May 2026 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290484; cv=none; b=WRDZd8NIVrFQjM9xBAMHS1qZj9d7VScKVJ/UUrgfueBQgnkFIxvlFOsq/3S5llRlptMFUJSb4UVZUsaf1RBB+9FOpG0x6LZsjzTQRHFJQNwoJzKZeHRP+CQRjeK/MFEqXt/z6Id+CGJ9TrumML+UxEMSOfmy+t1YXXn6+ZyDYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290484; c=relaxed/simple;
	bh=nrfq7yzd0cyJLljpsFRiiO1iUHY+OZCXm5bKmhRsmZ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PlkbDTgFi//N7mOz6GWOzj7b7FakUuLZp+r4RWCgzMJESnjRR5YMtmjZhWrQFXP1Gyp5yoAH75pX8MnIewQwSFtcZ1+mFxcAIJqJ0MwlRcFdxbqgyRkXaGb1tkDoWfWSAnmihG7/+H+i/Xml5fTZD+KX1H9JKWxzckFNPaDyGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaAKiI0S; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778290481; x=1809826481;
  h=date:from:to:cc:subject:message-id;
  bh=nrfq7yzd0cyJLljpsFRiiO1iUHY+OZCXm5bKmhRsmZ8=;
  b=XaAKiI0S1oicbiFiOHx/T4gPvjJuH2IULdzS7n0idBf7Xg+3MDoi/rj6
   hDoZOXY48tchzBBSxSV6eQ5axefw1Wrv3M/dZqMTTxoyahkTRpm5Q3Gpt
   UkWZ/rUQF+HqsiMPG/mPQ7Kcmwu3uVfoojzBIPLvFF4FaOQl1rtDYGgFJ
   hPmY2zYKLsnzuCrH7+OjYlsvYdtuZhT/G2lyEYYC6FsQdNgwlYfOjylTd
   xXdp0nSlPtP8GknAFxLZvTrJWH1U3LDsnrduhNRPws2xw8SVLR1DCxqnw
   iXVg1hJL0kJHLuyRvWn9XnBxgxvRxO+b6cpZ9M191ql9hdVcCzWC2pFdt
   A==;
X-CSE-ConnectionGUID: WcIa/4oXQKqab//IMdC2Dw==
X-CSE-MsgGUID: b8UyUsPUROKvVXoiEt9Abg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="96836839"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="96836839"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 18:34:41 -0700
X-CSE-ConnectionGUID: 3FxzHL7yQqKmp918i5rq0g==
X-CSE-MsgGUID: DxmO2OkqQny4Z0C3ST208g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="232407160"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2026 18:34:39 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLWaT-000000000Zk-0rkw;
	Sat, 09 May 2026 01:34:37 +0000
Date: Sat, 09 May 2026 09:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 c8c84430640e5210140eb0b6d7b4ae06883c0bd1
Message-ID: <202605090938.UgbRorur-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0CBD84FD521
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
	TAGGED_FROM(0.00)[bounces-15686-lists,cgroups=lfdr.de];
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
branch HEAD: c8c84430640e5210140eb0b6d7b4ae06883c0bd1  Merge branch 'for-7.1-fixes' into for-next

elapsed time: 1448m

configs tested: 344
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    clang-23
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
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
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
hexagon                          allmodconfig    gcc-15.2.0
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
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
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
sh                        apsh4ad0a_defconfig    gcc-15.2.0
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

