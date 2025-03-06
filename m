Return-Path: <cgroups+bounces-6868-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82310A5567D
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 20:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD57A7AA207
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AF26FA5E;
	Thu,  6 Mar 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMKZDb87"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9726E15E
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289030; cv=none; b=ZK3mubZV5JgColI60y+P9Wa0DHX2tan8sVjZrhmLjQUvODOa8eFKB8aOQPD+dfubQQ/4qkNAKRTO3gwda7z1CMprtwwC/YOiVDmestaaeWWG4sL0saUqLcw+HGqtfzN8+PYZbQ1BbAdpNbHzq0SaZRWchiuTV40Y/XOxHewVVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289030; c=relaxed/simple;
	bh=onsv1tPFOn8e3wKib2+8lSk0aX9APTq/eY7Z1SZ7hyE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jWX+OgW/EuiJaOpeAVTpVhT2MGzp+mDYp2eX5j4jLuuvj6+MS/ykYMHPJDE5sGozcjmdIhsYs66gAyNEjmd9oeuQ96j2KEqeA5J6H9EWq/v8RQb7+Qw7oK8XBqFfrodt9vXmvThHaGzSfqA/qGhMTgkG2uOdXkT/lYmqs3bpMn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMKZDb87; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741289028; x=1772825028;
  h=date:from:to:cc:subject:message-id;
  bh=onsv1tPFOn8e3wKib2+8lSk0aX9APTq/eY7Z1SZ7hyE=;
  b=IMKZDb871zARl9uC+CHsCWlH7w3465pL/piyhYexmF6ZI4yptoIR0TwZ
   0QBdfpf85ZbHqu2/rYyUfKhmyEgrGaGhR9uGgg0O532Qhj+xM91SKXk0O
   v4FvCctldwN0DuZ11x9mVW9RK8cW1Sb36qR5Eu/KCy5kjE4/WTipDLFW9
   7MbpCcns08VwYSok8+8sGboDKvP57RbBf28XTXEAMhxTznGXDUe1pyF5f
   Ja0HozHBqFx60UAiDowhr7lZVR69wk6QdTJBMuKZUj90EN/so1hk3M3YN
   zQ15XqlXp0kv402iKwMrrIGV8YTsAd6/gNXYRXoNnNskDTG8a4P5LrIGR
   w==;
X-CSE-ConnectionGUID: vbf30MPsTAmRFS3F6Q/X0w==
X-CSE-MsgGUID: LBaolt60QbWdgdJf0YEXww==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46093223"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="46093223"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 11:23:48 -0800
X-CSE-ConnectionGUID: YiEw7gTpRpigs0o1kSi+kQ==
X-CSE-MsgGUID: wJksA/p6RA6eYH5xIFjAUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="123712940"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Mar 2025 11:23:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqGoq-000NVW-2J;
	Thu, 06 Mar 2025 19:23:44 +0000
Date: Fri, 07 Mar 2025 03:22:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 34262c44e898e1008d1fb73562919dccd73deae3
Message-ID: <202503070350.KzbDoaiq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 34262c44e898e1008d1fb73562919dccd73deae3  Merge branch 'for-6.15' into for-next

elapsed time: 1449m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                   randconfig-001-20250306    gcc-13.2.0
arc                   randconfig-002-20250306    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-004-20250306    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-004-20250306    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250306    gcc-14.2.0
csky                  randconfig-002-20250306    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250306    clang-21
hexagon               randconfig-002-20250306    clang-19
i386        buildonly-randconfig-001-20250306    clang-19
i386        buildonly-randconfig-002-20250306    clang-19
i386        buildonly-randconfig-003-20250306    clang-19
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-006-20250306    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250306    gcc-14.2.0
loongarch             randconfig-002-20250306    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250306    gcc-14.2.0
nios2                 randconfig-002-20250306    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250306    gcc-14.2.0
parisc                randconfig-002-20250306    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250306    clang-21
powerpc               randconfig-002-20250306    clang-18
powerpc               randconfig-003-20250306    gcc-14.2.0
powerpc64             randconfig-001-20250306    clang-18
powerpc64             randconfig-002-20250306    clang-21
powerpc64             randconfig-003-20250306    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250306    clang-18
riscv                 randconfig-002-20250306    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-002-20250306    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250306    gcc-12
um                    randconfig-002-20250306    clang-16
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250306    gcc-11
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-006-20250306    gcc-12
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

