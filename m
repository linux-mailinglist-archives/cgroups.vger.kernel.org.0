Return-Path: <cgroups+bounces-17294-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YlYeDwRqPWpy2wgAu9opvQ
	(envelope-from <cgroups+bounces-17294-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 19:48:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428D6C800D
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 19:48:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fU6I3ZqD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17294-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17294-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E84314B090
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BF3F0752;
	Thu, 25 Jun 2026 17:39:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098E3EDE72
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 17:39:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409189; cv=none; b=PbioE1j+Zm4kLZnjH6ESQ8AORkkcgkGRV/2uxpJr4hKZGsxoOmLHl5yRmB5KSe3u0wfCKAjF95rp4/b41lfmcNcIFM0mzhiN8sxElgyyE2qB9KG82CT99MPBLNF07vijKOvsaXkbZoB2OL05E96AuCJSCrM4SbWJAnA9rAOygNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409189; c=relaxed/simple;
	bh=itSSjQk/39U4mcaYzAtU+nVQK4YmleV2dMYmZAMIjG0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ejccl6VMTKdw/b6FAHusAKJHmsot0vleghDRrDYvnF5WsTJGTb7Sng5LXBIAYdIPwgajWKy+V+fpKV1qczEHqBcMKlr9nKpxcVAtVjNCovgzzMZLNq46gqllcB3ebyQw6wvLdCalx5ZIcdeKwiq36HIdfxvvgxVJiOANCczyToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU6I3ZqD; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782409186; x=1813945186;
  h=date:from:to:cc:subject:message-id;
  bh=itSSjQk/39U4mcaYzAtU+nVQK4YmleV2dMYmZAMIjG0=;
  b=fU6I3ZqD3eY3Ov48U0CjGyI6Lzvn/cnu+M9FCg3SeCK0aUJ27QeHIl8J
   b1NYo5e7yZsarNLD8jCMzRTmcu6o07Jox0TVHe23qCIHySRh/myYTLeaX
   MC3tst5E89+POHTpye8ARzn3KQO2elbodpOyaM53x2BwYVLifnlP6sm/9
   7SMsOne6PyAZIIa40M7TANV8/oLmx4ida6h2DVU1PQsJ2/i75BfQnx7Lg
   TijZjTvsuWk4vwwWBfJef+BdXCQ/D7KhcKschY0O9J3IP+mXjNIWCUSu/
   w1X1Omd2gGTomYOFXtzF1D78Zg69+uOSIFytl4aBi+iPePwYhDhbVmb/P
   Q==;
X-CSE-ConnectionGUID: UQ9zXp2OQK+I/oQRm82htA==
X-CSE-MsgGUID: m59/nBQVSUihLtL4xrQKfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93848511"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93848511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:39:45 -0700
X-CSE-ConnectionGUID: Fr+F42l6RcisKNrwkj8SgQ==
X-CSE-MsgGUID: hqVz0PKSQwW5MqEDUaI/Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="244531109"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Jun 2026 10:39:44 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wco3A-000000004M1-18AS;
	Thu, 25 Jun 2026 17:39:40 +0000
Date: Fri, 26 Jun 2026 01:39:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 1d172eb1a5eaf53a214bd88370e8110337a9cafa
Message-ID: <202606260159.DCvjtQ9O-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17294-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8428D6C800D

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 1d172eb1a5eaf53a214bd88370e8110337a9cafa  Merge branch 'for-7.3' into for-next

elapsed time: 1204m

configs tested: 282
configs skipped: 7

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
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260625    clang-23
arc                   randconfig-001-20260625    gcc-16.1.0
arc                   randconfig-001-20260626    gcc-13.4.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260625    clang-23
arc                   randconfig-002-20260625    gcc-16.1.0
arc                   randconfig-002-20260626    gcc-13.4.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                         nhk8815_defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260625    clang-23
arm                   randconfig-001-20260625    gcc-16.1.0
arm                   randconfig-001-20260626    gcc-13.4.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260625    clang-23
arm                   randconfig-002-20260625    gcc-16.1.0
arm                   randconfig-002-20260626    gcc-13.4.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260625    clang-23
arm                   randconfig-003-20260625    gcc-16.1.0
arm                   randconfig-003-20260626    gcc-13.4.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260625    clang-23
arm                   randconfig-004-20260625    gcc-16.1.0
arm                   randconfig-004-20260626    gcc-13.4.0
arm                        shmobile_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260625    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260625    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260625    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260625    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260625    clang-23
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260625    clang-23
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260625    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260625    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260625    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260625    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260625    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260625    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260625    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260625    gcc-14
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260625    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260625    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260625    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260625    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260625    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260625    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260625    clang-22
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260625    clang-22
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260625    clang-22
i386                           randconfig-013    clang-22
i386                  randconfig-013-20260625    clang-22
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260625    clang-22
i386                           randconfig-015    clang-22
i386                  randconfig-015-20260625    clang-22
i386                           randconfig-016    clang-22
i386                  randconfig-016-20260625    clang-22
i386                           randconfig-017    clang-22
i386                  randconfig-017-20260625    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260625    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260625    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                         nettel_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                          ath25_defconfig    clang-23
mips                       rbtx49xx_defconfig    gcc-16.1.0
mips                           xway_defconfig    clang-19
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260625    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260625    gcc-11.5.0
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
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260625    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260625    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     kmeter1_defconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260625    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260625    gcc-13.4.0
powerpc                     tqm5200_defconfig    gcc-16.1.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260625    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260625    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260625    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260625    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260625    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260625    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260625    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260625    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260625    gcc-8.5.0
sparc                 randconfig-002-20260625    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260625    gcc-8.5.0
sparc64               randconfig-002-20260625    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260625    gcc-8.5.0
um                    randconfig-002-20260625    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260625    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260625    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260625    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260625    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260625    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260625    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260625    gcc-14
x86_64                randconfig-002-20260625    gcc-14
x86_64                randconfig-003-20260625    gcc-14
x86_64                randconfig-004-20260625    gcc-14
x86_64                randconfig-005-20260625    gcc-14
x86_64                randconfig-006-20260625    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260625    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260625    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260625    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260625    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260625    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260625    clang-22
x86_64                         randconfig-071    clang-22
x86_64                randconfig-071-20260625    clang-22
x86_64                         randconfig-072    clang-22
x86_64                randconfig-072-20260625    clang-22
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260625    clang-22
x86_64                         randconfig-074    clang-22
x86_64                randconfig-074-20260625    clang-22
x86_64                         randconfig-075    clang-22
x86_64                randconfig-075-20260625    clang-22
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260625    clang-22
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
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260625    gcc-8.5.0
xtensa                randconfig-002-20260625    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

