Return-Path: <cgroups+bounces-7022-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DCA5E583
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 21:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E561897AF7
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A31EE00D;
	Wed, 12 Mar 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yq0n5cFV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587A1E32B7
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812083; cv=none; b=Kz3etrVbbgbYPgTOhR8GjkExaBX3l/O9i1q/1GvVPEWP0Q+/LGp7tAxsY8H0OT+4wFsx+yfO4kLdLXU0fZRKJVkuFC+HkxZfCkLQDFCaeVVFXGTridPm64gFrePKYCeMj4QbY/OlyjFdjvz0QOzSK3xTXiYhR5m93Lo5WBcPEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812083; c=relaxed/simple;
	bh=AdpU2GY9xGHToWxzBU1sjNk4XiN2oYU8n4s0ieY/1J0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DMxHHyotObepNgGAhhmSG9JiB++n3Tciwg9eSWOnUmgNqv3a/fu4WdjHuAW6/oqDZlFBl/buHenkkpAtiRbL0fICvqQbqDYydgKRBpXz/8dRE7IyqtTPmbIvin4qYToiBC9pxjpbl7Wx+q06Lz8vg2tG0HdtF3wxpy4tTZpARaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yq0n5cFV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741812082; x=1773348082;
  h=date:from:to:cc:subject:message-id;
  bh=AdpU2GY9xGHToWxzBU1sjNk4XiN2oYU8n4s0ieY/1J0=;
  b=Yq0n5cFVxdGzI8Hybim2npTg2X5fJ3pKXxVb/63UP5v5J7JCugKav+Vz
   jo+J7HlEZRwSoZM1zbpnwcVigOV8Txppg/aXsVIYw8KBFiiyRDRDAvxKB
   DVJDgX3uhhyCXLJtssIpFcw+JFHCkDs5z/pjUBcEjKeYiA28l+HIs5ajd
   VVA7U704gHL43Bj4vXra1hopl5kpTBIcXZJDgl/h/M5ZaUTGN4R7bj2FF
   HeNM9Ur1gbw2es7R5W3ILLimLGFrOGsJEO2ylSmptuvymMg2o3CDf8h0P
   TOx4yGHzmfKT113WCpjfPewnWGaxpDjAYFfobqRyP04C+h9tqLSZMKzhT
   w==;
X-CSE-ConnectionGUID: 6e0AOIHSTYi+O4jooP/2lw==
X-CSE-MsgGUID: ffTl9HC/QFKLhVfTPHkplA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46820567"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="46820567"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:41:21 -0700
X-CSE-ConnectionGUID: 3ebQOe/eS7iUGhkKMjRsKw==
X-CSE-MsgGUID: asL1+1wqR5Gl/lQUzJ8/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125924353"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 12 Mar 2025 13:41:20 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsStB-0008tE-1I;
	Wed, 12 Mar 2025 20:41:17 +0000
Date: Thu, 13 Mar 2025 04:40:33 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:tmp] BUILD REGRESSION
 153926208f7777e220dec1156a44a5fa06623ac1
Message-ID: <202503130426.YQUVldWd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tmp
branch HEAD: 153926208f7777e220dec1156a44a5fa06623ac1  blk-cgroup: Simplify policy files registration

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503120710.guZkJx0h-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202503120719.47sOvfVx-lkp@intel.com

    include/asm-generic/rwonce.h:59:1: error: expected ';' before 'do'
    mm/memcontrol-v1.c:1860:58: error: expected ';' after expression

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- arc-allmodconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- arc-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- arm-allmodconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- arm-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- arm64-allmodconfig
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- arm64-randconfig-004-20250312
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- hexagon-allmodconfig
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- hexagon-allyesconfig
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- hexagon-randconfig-001-20250312
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- i386-allmodconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- i386-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- openrisc-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- parisc-allmodconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- parisc-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- powerpc-allmodconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- powerpc-randconfig-001-20250312
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- powerpc-randconfig-003-20250312
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- s390-allmodconfig
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- s390-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- sh-allmodconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- sh-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- sparc-allmodconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- sparc64-randconfig-002-20250312
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- um-allmodconfig
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
|-- um-allyesconfig
|   `-- include-asm-generic-rwonce.h:error:expected-before-do
|-- x86_64-allyesconfig
|   `-- mm-memcontrol-v1.c:error:expected-after-expression
`-- x86_64-buildonly-randconfig-005-20250312
    `-- mm-memcontrol-v1.c:error:expected-after-expression

elapsed time: 1458m

configs tested: 91
configs skipped: 1

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250312    gcc-13.2.0
arc                   randconfig-002-20250312    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250312    clang-19
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250312    clang-19
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250312    gcc-14.2.0
arm64                 randconfig-003-20250312    gcc-14.2.0
arm64                 randconfig-004-20250312    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250312    clang-21
hexagon               randconfig-002-20250312    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250312    clang-19
i386        buildonly-randconfig-002-20250312    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250312    clang-19
i386                                defconfig    clang-19
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250312    clang-21
powerpc               randconfig-002-20250312    clang-21
powerpc               randconfig-003-20250312    clang-21
powerpc64             randconfig-001-20250312    clang-17
powerpc64             randconfig-002-20250312    clang-15
powerpc64             randconfig-003-20250312    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250312    clang-21
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250312    clang-15
s390                  randconfig-002-20250312    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250312    gcc-12
um                    randconfig-002-20250312    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250312    clang-19
x86_64      buildonly-randconfig-002-20250312    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250312    clang-19
x86_64      buildonly-randconfig-005-20250312    clang-19
x86_64      buildonly-randconfig-006-20250312    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

