Return-Path: <cgroups+bounces-3285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E00D91374F
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 04:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB26B283466
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 02:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E62321D;
	Sun, 23 Jun 2024 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsh1qPf6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5AA23
	for <cgroups@vger.kernel.org>; Sun, 23 Jun 2024 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719109154; cv=none; b=l/b4hW02+go5Ib8omvXHMXb5nLDkXUtZKrAHhlMvF9frKHa9FcCQXcKz9qTR8K4/2FHZ3AQhEj01NONn/Gxgu1SaCpwNe/zi8Z51Acz8WYaeyvVTk8anBWXlkI54Ac1mb8BPTUyxJuTTHqTsjYMXdxK82f1LSTKyrBdFT8+GRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719109154; c=relaxed/simple;
	bh=Q0yeRpTOXBlOKJ/7CP/TgpmD600GIfuaDQiVmFGGfVY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DuUUpbkcQG5Toc6iNacFR2tNNcJ8kvprZZUSliFuvZkdu6AsC7IgHWX8TEemoIayjwRLr1LldsNaRo5tWa+oM1LV0IuFXoNsNlMD1Y0fCf4+VloclA6IHRbPIZMwrRrITjHqx6JiGXKpFPISoMZOgok/Zr7qWqpTU/1TW11xAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsh1qPf6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719109152; x=1750645152;
  h=date:from:to:cc:subject:message-id;
  bh=Q0yeRpTOXBlOKJ/7CP/TgpmD600GIfuaDQiVmFGGfVY=;
  b=hsh1qPf6Pc6cCpySNqN3rmT1bnRhyhLqT/2rQc7nwqHQYW0GD9mLcm3A
   BbR/kb/R6q2Z1i7AxoGvvhsdFpDJHzxcmBlUo26E3xmiUWJr4i3noMXHB
   IiF0EodsCvPveKoClo9PAZ0Wx73WYQhs8js7Jx7BIEQlqtLNpnNdp+4k1
   9COawFehWGU89loG+3ndV0CTOUH9o6h824TbQraC1ig/mfK2NinT4JLqz
   T/rM7DxPIQo75ATgJwTUy9Utazwwni+Qri9y4xlkL9dyC/OOfR9ZTHEbb
   0TdSyRugCs66TgA2Ap2L8FJWo2xJR0lVocVW+woa1WGTVlLUlnhNu77p5
   Q==;
X-CSE-ConnectionGUID: syaiKZmcS4yw7Tn/O/gfxg==
X-CSE-MsgGUID: 1VmNznBWTMKNq2gklXCCew==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="15986234"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="15986234"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 19:19:11 -0700
X-CSE-ConnectionGUID: 1HREaXLHTBKvy2ODdrNSlg==
X-CSE-MsgGUID: Aqywzg67QuaQ2P0LkYFITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="43630199"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Jun 2024 19:19:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLCou-000AAk-0a;
	Sun, 23 Jun 2024 02:19:08 +0000
Date: Sun, 23 Jun 2024 10:18:41 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD REGRESSION
 1c0be3f7b2f0dcca5dd237233f02a44e7af8c23a
Message-ID: <202406231037.8U7eyNva-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 1c0be3f7b2f0dcca5dd237233f02a44e7af8c23a  selftest/cgroup: Update test_cpuset_prs.sh to match changes

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- loongarch-defconfig
    `-- kernel-cgroup-pids.o:warning:objtool:__jump_table:special:can-t-find-orig-instruction

elapsed time: 4818m

configs tested: 41
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

