Return-Path: <cgroups+bounces-16232-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI09Bfa/EWoNpgYAu9opvQ
	(envelope-from <cgroups+bounces-16232-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 16:55:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B8A5BF7C6
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFEC6301BF7A
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCC2DCBE3;
	Sat, 23 May 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2ndsnEL"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2A184
	for <cgroups@vger.kernel.org>; Sat, 23 May 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548104; cv=none; b=jdHJ9dihHVflj4gyVKhdflXcnIJeKdvd15ENMIVbERFuGJ8jsC1OmgzewGYYLnMty/T3D+bq+x+hgPUJHaKCIKSWIpqsmZPVA7EVI2PKPuzrNar4T3ruBKnsZecViR4L89zynAVwrUYj+CUyXJgLH9Su2Kh3EZ7krwlFL/n3VVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548104; c=relaxed/simple;
	bh=DXXA6d9Wkq6svW86MAOrYHRw7YFNEspGgP6pIjX+gEU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R01JTFFu3zCn3u4zadPPimq46gmtSikdvMvWVMmR2+Z0c4heA2l2eZ/78ZHpSCZhDjLaqgPgasSo17rIqmwcdYiQrewiKlw7v6J/ILHoVKIPaKPE6dXhkNQGo5Y8kpd/ZzRWsXdTIqK54XT9/mp8WjdlS44vRkdI/6jDbE65h2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2ndsnEL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779548103; x=1811084103;
  h=date:from:to:cc:subject:message-id;
  bh=DXXA6d9Wkq6svW86MAOrYHRw7YFNEspGgP6pIjX+gEU=;
  b=k2ndsnELftozlnGS5JUtgpzUH/8pAT13N8muuJdkxH/VTwUk5xT1ouWU
   6UrAs5ZThx1EXU+9MYN9Zt5lKnmiXxjmQ9bfZ8yLYDeRKfo/s7rRA8yq7
   NSeN2o618DIjuv53p+jkuDLm4IipBR6sQMCEAAlgqJLK0Gifm3fMTcQn/
   1rjt9BEeKXMlkgzaPCnIv6dQ7/qIR8wkBrmx85jcJ9wWJkgFVZZOe8xT7
   Yb1LaNZPYMtAmp573QjYPPPTFGKs5LdaFW7BjY8A/hTPtHDVTF9gylnx9
   kdkeiKeg9HTo5mMiOsGvAJLnIVmMobIFw0rDC8SvvEO6oGdV5njhHVl1a
   A==;
X-CSE-ConnectionGUID: 7pIfxCuqQRWe8a+Cx44vOg==
X-CSE-MsgGUID: iaYSrymbRueSWvt4S1H8KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="91558632"
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="91558632"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 07:55:03 -0700
X-CSE-ConnectionGUID: ltrOrxqcRKOYJR8VPWSwPg==
X-CSE-MsgGUID: UWUoooF+SYeZuxjxpINHgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="246151916"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 May 2026 07:55:02 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQnke-00000000028-0DsI;
	Sat, 23 May 2026 14:54:57 +0000
Date: Sat, 23 May 2026 22:51:57 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.2] BUILD SUCCESS
 98f0adb2284a0a4599a40337a30bef429167bb7b
Message-ID: <202605232249.4cpo2VxZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16232-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 74B8A5BF7C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.2
branch HEAD: 98f0adb2284a0a4599a40337a30bef429167bb7b  selftests/cgroup: enable memory controller in hugetlb memcg test

elapsed time: 1339m

configs tested: 101
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
alpha                     defconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc                       defconfig    gcc-15.2.0
arc         randconfig-001-20260523    gcc-10.5.0
arc         randconfig-002-20260523    gcc-14.3.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-001-20260523    gcc-10.5.0
arm         randconfig-002-20260523    clang-19
arm         randconfig-003-20260523    clang-23
arm         randconfig-004-20260523    gcc-10.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
arm64                randconfig-001    gcc-8.5.0
arm64       randconfig-001-20260523    gcc-15.2.0
arm64                randconfig-002    gcc-14.3.0
arm64       randconfig-002-20260523    gcc-8.5.0
arm64                randconfig-003    clang-23
arm64       randconfig-003-20260523    gcc-9.5.0
arm64                randconfig-004    clang-23
arm64       randconfig-004-20260523    clang-23
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
csky                      defconfig    gcc-15.2.0
csky                 randconfig-001    gcc-10.5.0
csky        randconfig-001-20260523    gcc-9.5.0
csky                 randconfig-002    gcc-10.5.0
csky        randconfig-002-20260523    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon                   defconfig    clang-23
hexagon     randconfig-001-20260523    clang-23
hexagon     randconfig-002-20260523    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
i386                      defconfig    clang-20
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch   randconfig-001-20260523    gcc-15.2.0
loongarch   randconfig-002-20260523    gcc-15.2.0
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20260523    gcc-11.5.0
nios2       randconfig-002-20260523    gcc-9.5.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
powerpc       mpc836x_rdk_defconfig    clang-23
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20260523    gcc-8.5.0
riscv       randconfig-002-20260523    gcc-8.5.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390        randconfig-001-20260523    clang-23
s390        randconfig-002-20260523    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sh          randconfig-001-20260523    gcc-15.2.0
sh          randconfig-002-20260523    gcc-11.5.0
sparc                   allnoconfig    gcc-15.2.0
sparc       randconfig-001-20260523    gcc-8.5.0
sparc       randconfig-002-20260523    gcc-8.5.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    clang-20
sparc64     randconfig-001-20260523    clang-23
sparc64     randconfig-002-20260523    gcc-15.2.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um          randconfig-001-20260523    gcc-14
um          randconfig-002-20260523    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64      randconfig-005-20260523    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa      randconfig-001-20260523    gcc-15.2.0
xtensa      randconfig-002-20260523    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

