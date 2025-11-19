Return-Path: <cgroups+bounces-12102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC12C71799
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 00:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5F27D28F5B
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D542EAB83;
	Wed, 19 Nov 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqTtxuTi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F99136351
	for <cgroups@vger.kernel.org>; Wed, 19 Nov 2025 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596617; cv=none; b=XpASMKRJMapcGG+UYLlC0pA4EtTlC9ihOHfLB0IN0vAqA47xZUuFxPTPpmQ4MH8CAcvddbwCaHbwYxW07pplahQTGpIZV8W2FdPaw4VfcAqX2mfbTS+URDp79SlnxDTJo1heCz4DOj9l4uWJX3WKcS93GcIWxlYAnCeC/CxG2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596617; c=relaxed/simple;
	bh=GNh3FyoFBJlOR/mAK51P2ciWgupLSIO1q8hmqs7/P9c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pocBE+C3hfMpLNpyMVGDK5+Mw+zdfJvIfAqA/riOyb+LwDxOeiKhVKrLNqmJ0Bd9l6WD7lqWDj2iodF1F+P1yhGVMHeGdo+JaUeRKKCTU2xtL1cBvRZnlHBi7PbVwjqwfBGLRn+spUNHg/xu3fG1p11hv+wkxtqKARxP2y4ubDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqTtxuTi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763596617; x=1795132617;
  h=date:from:to:cc:subject:message-id;
  bh=GNh3FyoFBJlOR/mAK51P2ciWgupLSIO1q8hmqs7/P9c=;
  b=EqTtxuTiBdceonUmXZhAd1qgwiHFs6aeiWqURuD5heQmD4s9BZQS9EKz
   0KAnaR0/2M9rzycMech1LsrMFn/iPjcbVs05Grh7c5kJUi6WHucWz5PXS
   lC71Uy5wRKlDC93DWsYrj41j0ORyXDgcF1TF6dt5MvQRUSrPD5PeWLUIg
   I6aUR0l/5mbPiJaVXxyiDf4ikGsz74Vwysanp+HEdT3dKe4wNIq+YvlSc
   QNdMgJpKa6sVwQUrCq2LPQQUDqrEhpywyf9iupDrK5ouwQ6meZ5bE7Act
   LxClV8D0TxaUuXfW9HoPeyRomLUAQjYNeujzlav7edljHHKZ4xiHLcEhk
   Q==;
X-CSE-ConnectionGUID: Ueaub81eS0u/NukD9RkjNQ==
X-CSE-MsgGUID: SrbXu1m5QruqMeHTZmEtXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65687035"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65687035"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:56:56 -0800
X-CSE-ConnectionGUID: HkcaFOOUSd+NfqcPCv6yCg==
X-CSE-MsgGUID: 148ymubXQsaq9MnMff1DaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="196330505"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Nov 2025 15:56:55 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLs2d-0003Qh-2x;
	Wed, 19 Nov 2025 23:56:51 +0000
Date: Thu, 20 Nov 2025 07:56:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19] BUILD SUCCESS
 a0131c39270de634c33950a799d8870da2191974
Message-ID: <202511200734.PDZ7qCdM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19
branch HEAD: a0131c39270de634c33950a799d8870da2191974  docs: cgroup: No special handling of unpopulated memcgs

elapsed time: 7315m

configs tested: 62
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251115    gcc-13.4.0
arc         randconfig-002-20251115    gcc-11.5.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251115    clang-22
arm         randconfig-002-20251115    gcc-8.5.0
arm         randconfig-003-20251115    gcc-10.5.0
arm         randconfig-004-20251115    clang-22
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251116    gcc-12.5.0
arm64       randconfig-002-20251116    gcc-10.5.0
arm64       randconfig-003-20251116    clang-22
arm64       randconfig-004-20251116    gcc-8.5.0
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251116    gcc-12.5.0
csky        randconfig-002-20251116    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251116    clang-22
hexagon     randconfig-002-20251116    clang-17
i386                    allnoconfig    gcc-14
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251116    gcc-15.1.0
loongarch   randconfig-002-20251116    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251116    gcc-11.5.0
nios2       randconfig-002-20251116    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc      randconfig-001-20251116    gcc-12.5.0
parisc      randconfig-002-20251116    gcc-14.3.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc     randconfig-001-20251116    gcc-10.5.0
powerpc     randconfig-002-20251116    clang-22
powerpc64   randconfig-001-20251116    clang-22
powerpc64   randconfig-002-20251116    gcc-10.5.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251115    clang-22
riscv       randconfig-002-20251115    gcc-8.5.0
s390                    allnoconfig    clang-22
s390        randconfig-001-20251115    clang-17
s390        randconfig-002-20251115    gcc-8.5.0
sh                      allnoconfig    gcc-15.1.0
sh          randconfig-001-20251115    gcc-12.5.0
sh          randconfig-002-20251115    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                      allnoconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

