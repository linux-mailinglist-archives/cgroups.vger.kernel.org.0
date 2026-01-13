Return-Path: <cgroups+bounces-13162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E68D1ACE5
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 19:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D993036AE9
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304832E120;
	Tue, 13 Jan 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0HM/vfR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209EA30DD1E
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328018; cv=none; b=jpF8wHxasZ/FUdh4hhPiy63qsRy+LpyemcHrccUP874rmLgmNRzs3KuzkbGquJOhw+0a53IK0egGQta1pRgWvH+Rmm3CQgBsL3E4N7WgGUuELju5qerYTG3TWoiI1t0URTDQRYYoJpSKzIJ5Mz+bjX/pfAIN5YsjfY9X0QQhdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328018; c=relaxed/simple;
	bh=ZdCLIO2Ox/sZtcs53afAaPS0XChRB4NarvXVQW4ax7Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kQiCUa6L5l7o/PkTky4i0pKxFUu8P9dlpPyX7MbCRTRWKAd9EGK5WCDAjnMuBhBHKM822DZ0zZscs7JzA9XkvaYiXu3E5VK0Rt+quaylrce6a+oaQYnFTh00FGZSnhcekGZRjV1+wcFP9H7I5SQqQQ2Vd84zfD83Hm6qD9kkXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0HM/vfR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768328017; x=1799864017;
  h=date:from:to:cc:subject:message-id;
  bh=ZdCLIO2Ox/sZtcs53afAaPS0XChRB4NarvXVQW4ax7Q=;
  b=N0HM/vfRMoWPA2ROaJ/pgHKKTcNKzP7jyRuqhNicta03FhAgBG75XG0U
   THBk9q469/bbnqJxaeWX5KK5liNd7ZwevLDa/byB0BRaoZ3lLPedAzHw3
   aDw0yX6aacF8ml+9mqzDrNzoYFp35/kkSv7UBrIA0oc2cfjbuI4Cft4qK
   FNQ+ed8SOvl5vUGvj2UxKRwQmFCAnMHU/VDnqk2mggh9X6CjiizQejkN0
   OykG2hMtNsD3M8ityuQPwjHwyMrZcnkS0wwJgK43csxsGV9V93wtvkxhf
   RazKrd3eqWI5PEbAvuT3WAjy5qjx4EQ/d4WD8cGIZv/tZvf7rd7i1Ss86
   g==;
X-CSE-ConnectionGUID: W3kqJH3xQvOfuRhApax0jg==
X-CSE-MsgGUID: y+/9d/MjTCOIIK4TQ8To/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69541930"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69541930"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:13:36 -0800
X-CSE-ConnectionGUID: /PR14+/ERcKzUI3qZVSsjQ==
X-CSE-MsgGUID: wzx3DtcjQv+gyKcUs/Ifog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204343020"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 10:13:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfitZ-00000000FDZ-0MmD;
	Tue, 13 Jan 2026 18:13:33 +0000
Date: Wed, 14 Jan 2026 02:12:57 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19-fixes] BUILD SUCCESS
 ef56578274d2b98423c8ef82bb450223f5811b59
Message-ID: <202601140252.JBRFAlCD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19-fixes
branch HEAD: ef56578274d2b98423c8ef82bb450223f5811b59  cgroup: Eliminate cgrp_ancestor_storage in cgroup_root

elapsed time: 8200m

configs tested: 54
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

