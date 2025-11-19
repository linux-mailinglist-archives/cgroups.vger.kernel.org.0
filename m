Return-Path: <cgroups+bounces-12101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F8C7171E
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 00:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A15422B62E
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31A27381E;
	Wed, 19 Nov 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkkqA0OI"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545572522B6
	for <cgroups@vger.kernel.org>; Wed, 19 Nov 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595055; cv=none; b=GNMFPBL3Nm5cMDXdax51jZ4IV0qZq7TU2vd4hnc9krZyCPZjEWKfVkpEIwSLE33PhLvlampFjnL5UOZeCNY84eghi3GeIh7u2u8hZCgPERjtP/tTWfClGGgV5X/jIAbS5r3JmvK2Ow4G26JYMtvPJBEw9Zrjlq3QlbFgW7ad5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595055; c=relaxed/simple;
	bh=cY9zHlo3o+hhdOWlQnaGbb/DOYAPtCVVwD0+FD+XGy4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OMVsjTZuyfrFbTsdUiuWeiuppiJ7n1nBPt0ZzMyafQSwBK81VZxdZMBwAYcXOOzO6/LwAayAeRB8hlCflmalyNkQQigJYKqFuJ/RJSe6xdBS45h7g/ZYrz3zLJoJOLOUk29Q5reVedjAksNAROBZVjsLuJ6X8pjRmLcTyklj56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkkqA0OI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763595054; x=1795131054;
  h=date:from:to:cc:subject:message-id;
  bh=cY9zHlo3o+hhdOWlQnaGbb/DOYAPtCVVwD0+FD+XGy4=;
  b=FkkqA0OIfpsNbsK0JqlZlgYlEmkfmUva9Cx+bi1/I1rLpvDy8CddAKAg
   DvdCwOxLhsXdn8Kvy8MjUNqpeYWkd+B+QHy3h1S3wY7J6q3hCx9lqWg/R
   pNPoEFcWxjwAyp7ZhtkwIxh/WohmRpd/33SiM9MeotQGtuaIZN/+yuF53
   uo4u2vRP+Vl+0VDrHgC8XkbTPowF7UDnJj0zTsD//6nF5c6dc2+5QS7DT
   lun7AzH+fIdlfZ4ZsdTeKMLrUdgCVoiwFsNcB+ulKZTV7qGL8YnxYb75w
   xZzlOXytVPRQTqdzcW/kcXx/WaIA/pPKE2UxKaueN6n4SMLVsO+XzjQJ3
   w==;
X-CSE-ConnectionGUID: JcNaQSkuSxC58FQ6oOl6Vw==
X-CSE-MsgGUID: aQ4oSZ0ISGmFLA+MV5ehqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65548773"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65548773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:30:53 -0800
X-CSE-ConnectionGUID: CzibEMc9Sp6p9NGn/alyqg==
X-CSE-MsgGUID: gtyZDBwjRfqWMGX7LfrRHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191000024"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Nov 2025 15:30:52 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLrdR-0003Pb-2u;
	Wed, 19 Nov 2025 23:30:49 +0000
Date: Thu, 20 Nov 2025 07:30:19 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 7587adebe583e9ea2063771d489962be9c50b66a
Message-ID: <202511200713.jsqSMD4I-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 7587adebe583e9ea2063771d489962be9c50b66a  Merge branch 'for-6.19' into for-next

elapsed time: 7289m

configs tested: 60
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
m68k                    allnoconfig    gcc-15.1.0
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

