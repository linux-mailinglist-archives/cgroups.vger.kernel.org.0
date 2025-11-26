Return-Path: <cgroups+bounces-12209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C6C889EF
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 09:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B0A3B3459
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0C83148C5;
	Wed, 26 Nov 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CASHqbEi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40618311C1D
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145601; cv=none; b=ZInNqr0wIe8Si95cCVo5+TxRFwd5l4kx2Vj9qqgpzqw5TgxEaHOVYpxfPBwaA8TrEk8Bswn+nGlimmeS3aarhcqtpy0cmGFauj2ymhi0m6emmqYjYZfgOGqCanUfnnk6irSqnUK+JLrh3LSQE5IkO03Sc3jCL8qO+VdZKcdG4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145601; c=relaxed/simple;
	bh=8bfuJMXLTJXwFfStRnVuQtSbYVpsfePOCI6pDogradM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DvzM9x6lv1oahhts134873crSv+KPPoyxpJkJiZctowg2CysbmWz4KCP6uPLR7BRx82LNv5VtqbjW3IvtDFI0nOAkPhdVRbAkOe4tKgaUj7e2XJyQ+Isoa8PabE90xDdJcoqHlACBOXdtGYTCRg6yQAsGZIuzvV4GfswtNuh/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CASHqbEi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764145600; x=1795681600;
  h=date:from:to:cc:subject:message-id;
  bh=8bfuJMXLTJXwFfStRnVuQtSbYVpsfePOCI6pDogradM=;
  b=CASHqbEirIxSb16kwqLj/BfQhy5ukD6ONWT1/HhLxSbZwexZ8a49dXPY
   hM/vNmJHhf3e62zm+1217OhB8VmlSyfXbHWj6+5/H7b3jCp87vk3Q64nG
   qKIsdRrfoMFwEASshSjRIfSXjNfq6HQ7ERFD9s/KLObht94ifPcKNbQm7
   V0aeaIilwbZEKzwlX5CKNRmGoe1KIcvTcXqh400ApNBhhuj8Fngoa1O8X
   WjC5d8S/khLiONXHdfMGtGXUVLZ4pW3zp2aK5hDzNkL32uwGymSRLQsKP
   31HacfKrGPCCHHD08tABL4/pqs50dZyFRroDBdrVRVb3xlOvIC/kjBgMC
   w==;
X-CSE-ConnectionGUID: fB8ruBPWTIqoq/ct20tyfA==
X-CSE-MsgGUID: 0AZ4lIMUT9eExmPyB0AnmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76859623"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="76859623"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 00:26:39 -0800
X-CSE-ConnectionGUID: fKX8oVeRRk+HRpcZIEba7g==
X-CSE-MsgGUID: PWYoYbCsSLK7pnuu9+s1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192966054"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Nov 2025 00:26:38 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOArE-000000002d2-0X5q;
	Wed, 26 Nov 2025 08:26:36 +0000
Date: Wed, 26 Nov 2025 16:26:16 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 004d6fbaf4fce1eda2974f44362c0722be52da54
Message-ID: <202511261610.xpHoOSXL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 004d6fbaf4fce1eda2974f44362c0722be52da54  Merge branch 'for-6.19' into for-next

elapsed time: 7556m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0
xtensa       allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

