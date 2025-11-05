Return-Path: <cgroups+bounces-11592-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF65C36160
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACEC3BE517
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B732D7D7;
	Wed,  5 Nov 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+VwTs8F"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AB32D44E
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353354; cv=none; b=HcQ6KbLjCn4lh0yctU9ldgY0mlNBGKJzD/a7Ktfdqc9utKmj/yw0QnGxRLH9DBjFuKh5lTBSUawBdg4lLz8D5o62CsXaUZfUxBu88Y/bo7ooLNjz7fY70J0P7Uhr5JpDJZItwHrUVvVD0tNozd7d5D0lFVxHul9Vg2QvXebzXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353354; c=relaxed/simple;
	bh=PT1AMkkS6hwWq+KD99ToQJhMxhSKHQC6L4S1mqQ264M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GXSEJFzNCGtNxDHdxQ+Rh8J7O4teZ6/f2WG7I8rr0NCyAkkMnhxM4QjeANxtVgkWBSsD2hTX6SFgrb80LvIzN+XW5Xx8cLTWJqM+xXVLJmyPsNcg3m9uosmOjZbhNjwFkqqWr9j16BBnqy6C0vnfgXUCZelQJ/MWn5EHEWQo3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+VwTs8F; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762353353; x=1793889353;
  h=date:from:to:cc:subject:message-id;
  bh=PT1AMkkS6hwWq+KD99ToQJhMxhSKHQC6L4S1mqQ264M=;
  b=N+VwTs8FoNd4EqrddgImMJEDYLr9goCJLYXM75ShckCT2I4fYCmfplQ0
   qu1qyH8zlliZBlpYzsG3uKQKEd4S1g4Rs+e9BXFKGlNsUn8zklXzsL92h
   66/q3RkyMO55UNPRqr7kI4XYP2PMTnQvUDVf4Ag9aOKEbjbW8GwgKzzgV
   wNLMjUHadS4ThzIK6Cs2Z+vBzw3EM2P5xJ/SJ7MmqnaeN5VGxYqBkshD5
   F5NSmOS4hJs26gZGSCaXRueqcmfp2mYhehI+P0nsRxJE4jWg3D0xt6/Fr
   bY5NTRyfM+fuJfJ8YD7UIZDpMh0E2C9Pxfxt6HiibDkvE19IUNmO7ChO8
   Q==;
X-CSE-ConnectionGUID: g32Rm0WMQtCyUv2zjZpquQ==
X-CSE-MsgGUID: 4gF7osNgSymmEhgpOnQEWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75916349"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75916349"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:35:53 -0800
X-CSE-ConnectionGUID: c52z1HwfSbifM6IU9+z/BA==
X-CSE-MsgGUID: C0gNaOGXRlOUmH6XFMru1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="191827543"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 05 Nov 2025 06:35:51 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGebM-000Sh8-23;
	Wed, 05 Nov 2025 14:35:13 +0000
Date: Wed, 05 Nov 2025 22:34:14 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 dbdfa16e5c4cd48f4ec5958c8e123093ce4e98f8
Message-ID: <202511052208.Fhy1CHKG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: dbdfa16e5c4cd48f4ec5958c8e123093ce4e98f8  Merge branch 'for-6.19' into for-next

elapsed time: 2135m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    clang-19
arc                    allmodconfig    clang-19
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    clang-19
arc         randconfig-001-20251104    gcc-12.5.0
arc         randconfig-002-20251104    gcc-9.5.0
arm                    allmodconfig    clang-19
arm                     allnoconfig    clang-22
arm                    allyesconfig    clang-19
arm         randconfig-001-20251104    gcc-14.3.0
arm         randconfig-002-20251104    gcc-10.5.0
arm         randconfig-003-20251104    clang-22
arm         randconfig-004-20251104    gcc-8.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-19
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-19
hexagon     randconfig-001-20251104    clang-22
hexagon     randconfig-002-20251104    clang-16
i386                   allmodconfig    clang-20
i386                    allnoconfig    gcc-14
i386                   allyesconfig    clang-20
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
loongarch   randconfig-001-20251104    gcc-15.1.0
loongarch   randconfig-002-20251104    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                  allmodconfig    clang-22
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                  allyesconfig    clang-22
nios2                  allyesconfig    gcc-11.5.0
nios2       randconfig-001-20251104    gcc-8.5.0
nios2       randconfig-002-20251104    gcc-11.5.0
openrisc               allmodconfig    clang-22
openrisc               allmodconfig    gcc-15.1.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
parisc      randconfig-001-20251104    gcc-8.5.0
parisc      randconfig-002-20251104    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    gcc-15.1.0
powerpc     randconfig-001-20251104    gcc-15.1.0
powerpc     randconfig-002-20251104    clang-22
powerpc64   randconfig-001-20251104    clang-22
riscv                  allmodconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    gcc-15.1.0
s390                   allmodconfig    gcc-15.1.0
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                  allyesconfig    clang-22
sparc                  allyesconfig    gcc-15.1.0
sparc64                allmodconfig    clang-22
sparc64                allyesconfig    clang-22
sparc64                allyesconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    clang-19
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0
xtensa                 allyesconfig    clang-22
xtensa                 allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

