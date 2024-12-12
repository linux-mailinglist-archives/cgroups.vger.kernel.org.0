Return-Path: <cgroups+bounces-5875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EE9EFE67
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 22:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E353C16BF35
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A51DB37C;
	Thu, 12 Dec 2024 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjQhHwsW"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3721D9694
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039405; cv=none; b=m1rRfhttYFkqTvlpXGdDTvN0+uFN4SB/Y/CNKQ2LczczoN7s4fCNRbuRTdJCbAElo6Wi24wZ9WyWd6fi8SPNfRnIP/Y+NkS0ZaLF/xTl4CSmLt9r1ypk6RD1yPw13Yca2VrVlJB7Nd0wiLUxcElmiZ6PiXwP8ERZl8m3uHlGcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039405; c=relaxed/simple;
	bh=34I13B2/QmEGhURmRylhVRgm+iONv41xXZHDoECiU1c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZkWGceYV5DxwfCmYhFEy1MMGCR1L/0x5pEY52bJA3dcNlVd73ORHcjvyAUfUSbDu49nQXrSIP/GNmCPxC3CG7M28ijgK5l7vgUPW+5G92RZnyEb6mRhIsQxq5mGnnVKvtv+d0gAlsPsYVwkQNcenK97WkxXVSViy5ofg3sclchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjQhHwsW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734039403; x=1765575403;
  h=date:from:to:cc:subject:message-id;
  bh=34I13B2/QmEGhURmRylhVRgm+iONv41xXZHDoECiU1c=;
  b=TjQhHwsWqObuGj98t5fvS92E/2lcGclG1ccqG3XZcdOXK9R9hxbjIg4Z
   H4UM79uOMPXZDDWdHL54Tcmge/rWtEsJ5wf4mENA9YZXif7/KUvyEzMWY
   J1pv96VT4GcHrbin7cqyp9AOViQX3YJ2ANs4C6Nwr00usxS7ALCx5d9w5
   AI1coJcJ1hcbC00SURd/6pmuQdaEZbDri8fC0aZwjBYO46F48nviWKg4K
   ubXW/lUV3PBB/zndAj1OLD3rxwfpgfNrdBHGf+GuwuuqVUS2gFPfi4P6I
   KuXz7GckA8tY96cek/UaAyZFXX6Bc+BcOQfbwt9eEmQ1kmdiEOK0n94ce
   g==;
X-CSE-ConnectionGUID: 1xatys/vTZWUVg01XxhMfA==
X-CSE-MsgGUID: qaxZJH55QympGFDG/l3O3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="56952466"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="56952466"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:36:43 -0800
X-CSE-ConnectionGUID: WEOXT7b4Qu+91tGymZQJFg==
X-CSE-MsgGUID: OWVFSF8GRT2Gjv+wMlVssA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96782849"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Dec 2024 13:36:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLqrP-000BOQ-1r;
	Thu, 12 Dec 2024 21:36:39 +0000
Date: Fri, 13 Dec 2024 05:35:48 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.13-fixes-test] BUILD SUCCESS
 e0dac4f3fa343682fc7cc7c420eed1dd5d0f551d
Message-ID: <202412130542.VcqXvB1u-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.13-fixes-test
branch HEAD: e0dac4f3fa343682fc7cc7c420eed1dd5d0f551d  test

elapsed time: 1445m

configs tested: 57
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241212    gcc-13.2.0
arc                  randconfig-002-20241212    gcc-13.2.0
arm                  randconfig-001-20241212    gcc-14.2.0
arm                  randconfig-002-20241212    clang-20
arm                  randconfig-003-20241212    clang-19
arm                  randconfig-004-20241212    clang-20
arm64                randconfig-001-20241212    clang-20
arm64                randconfig-002-20241212    clang-15
arm64                randconfig-003-20241212    clang-20
arm64                randconfig-004-20241212    gcc-14.2.0
csky                 randconfig-001-20241212    gcc-14.2.0
csky                 randconfig-002-20241212    gcc-14.2.0
hexagon              randconfig-001-20241212    clang-14
hexagon              randconfig-002-20241212    clang-16
i386       buildonly-randconfig-001-20241212    clang-19
i386       buildonly-randconfig-002-20241212    clang-19
i386       buildonly-randconfig-003-20241212    clang-19
i386       buildonly-randconfig-004-20241212    clang-19
i386       buildonly-randconfig-005-20241212    clang-19
i386       buildonly-randconfig-006-20241212    gcc-12
loongarch            randconfig-001-20241212    gcc-14.2.0
loongarch            randconfig-002-20241212    gcc-14.2.0
nios2                randconfig-001-20241212    gcc-14.2.0
nios2                randconfig-002-20241212    gcc-14.2.0
parisc               randconfig-001-20241212    gcc-14.2.0
parisc               randconfig-002-20241212    gcc-14.2.0
powerpc              randconfig-001-20241212    gcc-14.2.0
powerpc              randconfig-002-20241212    clang-20
powerpc              randconfig-003-20241212    clang-15
powerpc64            randconfig-001-20241212    clang-20
powerpc64            randconfig-002-20241212    gcc-14.2.0
powerpc64            randconfig-003-20241212    gcc-14.2.0
riscv                randconfig-001-20241212    clang-17
riscv                randconfig-002-20241212    clang-20
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241212    clang-18
s390                 randconfig-002-20241212    clang-20
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241212    gcc-14.2.0
sh                   randconfig-002-20241212    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241212    gcc-14.2.0
sparc                randconfig-002-20241212    gcc-14.2.0
sparc64              randconfig-001-20241212    gcc-14.2.0
sparc64              randconfig-002-20241212    gcc-14.2.0
um                   randconfig-001-20241212    gcc-12
um                   randconfig-002-20241212    clang-20
x86_64     buildonly-randconfig-001-20241212    clang-19
x86_64     buildonly-randconfig-002-20241212    gcc-12
x86_64     buildonly-randconfig-003-20241212    clang-19
x86_64     buildonly-randconfig-004-20241212    clang-19
x86_64     buildonly-randconfig-005-20241212    gcc-11
x86_64     buildonly-randconfig-006-20241212    clang-19
xtensa               randconfig-001-20241212    gcc-14.2.0
xtensa               randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

