Return-Path: <cgroups+bounces-7441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C97A81956
	for <lists+cgroups@lfdr.de>; Wed,  9 Apr 2025 01:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F34A1055
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 23:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08872566D7;
	Tue,  8 Apr 2025 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XR1mTUeU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903723FC4B
	for <cgroups@vger.kernel.org>; Tue,  8 Apr 2025 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154712; cv=none; b=SRYp+irsybtTm4AC9yXFqeGL5QhL2tMoWFzSkwXVi7EIxLMyisD/Xo5A3G9aPAb4WMpnmKeVI2jYvXU5DAlGw7J1EzxbYzXHSNOU9YeQyHBJ3+phyjMuEtrtLz6L4iUPjpIIRAIuXFW2OK8CZHlqBB0zoDwx3EtqC0SIgAEui3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154712; c=relaxed/simple;
	bh=JCwokt0v1yaOmE0N9B5CjKaRJpkKPOMcGN4zCFHNN+8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VbMoFIpOPWmolDYr6UMuEWcIoGSQliltGj0k5jEV1oU6dTptl9n4FTT43uCpGOGEq/xknBMsCre6wDzQVWsiZLnl11ZjrT2YJ64VB/AkdyfTvBJBrpm1N+N7Irb9jpVoQQctTPp15/RxdQSPks9oYjYVu/Ju8q+jXwOMp9wktiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XR1mTUeU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744154711; x=1775690711;
  h=date:from:to:cc:subject:message-id;
  bh=JCwokt0v1yaOmE0N9B5CjKaRJpkKPOMcGN4zCFHNN+8=;
  b=XR1mTUeUg061S00C95exmmDRMRQGKMhJ9oxbHowe/BGQPcEy/HFAR58H
   qHxB/17BfvymAn0pEGT2plmueF37DdYtZ+nT1GQDmbFSY8gzl+O3Tsg5I
   Gzsv/AfI8bPHxt6FBhgF7qA1YlKAQrOAU10TFufP8StbH47otAHKk3xTt
   6MCqRDWsuPaOiJjUwek/NNU6Aa6YoRJWSDfTOxkxHeo5jw8pNkwofrCzi
   SVgTWeyNKXzHw3mh+Ogm4skFrL2FUzpWyqI9CWNVxczOrXRqnofFgZaZE
   e6P6NOyuF7sVzs4mhXcjYQ/aVVWSNPC36V2iTzvDNzeJNEO/l4n3GILWz
   g==;
X-CSE-ConnectionGUID: WSsBPpKNT+SA15bi51OTzQ==
X-CSE-MsgGUID: IbcxzYG0SrOE7OWym+/fIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45731701"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45731701"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 16:25:10 -0700
X-CSE-ConnectionGUID: AMOrXCa1SvKqCyGz+JpEjQ==
X-CSE-MsgGUID: 1xm/77hmRRS6BZFkz0afeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="128145827"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Apr 2025 16:25:09 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2IJW-00084Z-1g;
	Tue, 08 Apr 2025 23:25:06 +0000
Date: Wed, 09 Apr 2025 07:24:13 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.16] BUILD SUCCESS
 86888c7bd117c29eab169c37e5f6bbbf583da983
Message-ID: <202504090700.DRE9j5Pw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16
branch HEAD: 86888c7bd117c29eab169c37e5f6bbbf583da983  cgroup/cpuset: Add warnings to catch inconsistency in exclusive CPUs

elapsed time: 1465m

configs tested: 82
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250408    gcc-14.2.0
arc                   randconfig-002-20250408    gcc-14.2.0
arm                   randconfig-001-20250408    clang-21
arm                   randconfig-002-20250408    gcc-10.5.0
arm                   randconfig-003-20250408    clang-17
arm                   randconfig-004-20250408    gcc-6.5.0
arm64                 randconfig-001-20250408    clang-21
arm64                 randconfig-002-20250408    gcc-9.5.0
arm64                 randconfig-003-20250408    gcc-9.5.0
arm64                 randconfig-004-20250408    clang-20
csky                  randconfig-001-20250408    gcc-14.2.0
csky                  randconfig-002-20250408    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250408    clang-21
hexagon               randconfig-002-20250408    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250408    clang-20
i386        buildonly-randconfig-002-20250408    clang-20
i386        buildonly-randconfig-003-20250408    gcc-12
i386        buildonly-randconfig-004-20250408    gcc-12
i386        buildonly-randconfig-005-20250408    gcc-12
i386        buildonly-randconfig-006-20250408    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250408    gcc-14.2.0
loongarch             randconfig-002-20250408    gcc-13.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250408    gcc-13.3.0
nios2                 randconfig-002-20250408    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250408    gcc-6.5.0
parisc                randconfig-002-20250408    gcc-8.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250408    gcc-5.5.0
powerpc               randconfig-002-20250408    gcc-9.3.0
powerpc               randconfig-003-20250408    gcc-5.5.0
powerpc64             randconfig-001-20250408    clang-21
powerpc64             randconfig-002-20250408    gcc-5.5.0
powerpc64             randconfig-003-20250408    gcc-7.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250408    gcc-9.3.0
riscv                 randconfig-002-20250408    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250408    gcc-8.5.0
s390                  randconfig-002-20250408    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250408    gcc-13.3.0
sh                    randconfig-002-20250408    gcc-13.3.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250408    gcc-10.3.0
sparc                 randconfig-002-20250408    gcc-6.5.0
sparc64               randconfig-001-20250408    gcc-6.5.0
sparc64               randconfig-002-20250408    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250408    clang-21
um                    randconfig-002-20250408    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250408    clang-20
x86_64      buildonly-randconfig-002-20250408    clang-20
x86_64      buildonly-randconfig-003-20250408    clang-20
x86_64      buildonly-randconfig-004-20250408    gcc-12
x86_64      buildonly-randconfig-005-20250408    clang-20
x86_64      buildonly-randconfig-006-20250408    clang-20
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250408    gcc-6.5.0
xtensa                randconfig-002-20250408    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

