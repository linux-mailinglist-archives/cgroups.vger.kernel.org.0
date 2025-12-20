Return-Path: <cgroups+bounces-12547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF0BCD25CF
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 03:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934713014DA5
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E11D5CFB;
	Sat, 20 Dec 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3g7S1gi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C367E0E4
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766199038; cv=none; b=laFP9kQozfDaN7SOl47mYIeGd1G9GaNupdELte6iJmNh8r+5rJdwgi13mABCAOoU9hbuSB/wGMLRwEgZk1Y+xqBUPmKYK0J4VnR0pDUhuZ5XYVygE8HZpxXYsY0+cQpSbiLdsuxSwIj3IERJrxXkR1mcOQHiMUyWmzwzMFGPxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766199038; c=relaxed/simple;
	bh=/ioEnX2sXSyMCN5pAQjMWBbcZUPXRkC/cSjZ33Bqnqk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KyybrquiHb1e432aWR0qk+mGozQLVE94tYCyncOIEtTPgGhcE1yQHkdow8G5ft+92DkPJACgDzVJm4BYGmXZM7eBOVTt8zn/iDSyH6k4+7H8EVvwu4srA56mXPeAzPAecgWiutPEVh0j8SrE7y+EPXZh6kheHqENVIdRQw9iBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3g7S1gi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766199037; x=1797735037;
  h=date:from:to:cc:subject:message-id;
  bh=/ioEnX2sXSyMCN5pAQjMWBbcZUPXRkC/cSjZ33Bqnqk=;
  b=S3g7S1gi2AjCQys+ZfjRqtwpKy0DLGjPPxct1mrE08mfhRvejrWkQm03
   4C7/Ws0jyvl28o5ddS4ldsEPakwV+Fgdd2kclTjKbZId/v3jDDtIR/4nh
   sSShf6jJj+2zI5tjgKUbFcYa4dEatDaK3LVgddC1E9HlvZ93lYLWLdCDb
   IPt3a5HiwFKKfHCCxgbj7r2W6Ig1+pG7ads2FzPt40w0mGbRGime/OEAF
   IRDkdxzyqaIxPbV3vQ0kzCujNnIj2sJB9T1s3CuuzxDHPzA3wLrRHdZdR
   OBstjQDm+c+icMyu4I90VsqKKCRXGn9IKYpFh09D7aYXi4rMxVe17LyLw
   w==;
X-CSE-ConnectionGUID: QfvvLdgsSBuS6pPh/PHfkw==
X-CSE-MsgGUID: aRTEn647TSO/cwpwacHmUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="67153740"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="67153740"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 18:50:37 -0800
X-CSE-ConnectionGUID: r/Zn/n0ORaOpoXlplDb8UA==
X-CSE-MsgGUID: qz2miLxeTCOI41YtOu7+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="222435298"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Dec 2025 18:50:35 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWn3B-000000004Gz-2KwD;
	Sat, 20 Dec 2025 02:50:33 +0000
Date: Sat, 20 Dec 2025 10:49:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.20] BUILD SUCCESS
 7cc1720589d8cc78752cdf83a687422bb7838268
Message-ID: <202512201042.FOryRvQ7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.20
branch HEAD: 7cc1720589d8cc78752cdf83a687422bb7838268  cpuset: remove v1-specific code from generate_sched_domains

elapsed time: 1911m

configs tested: 61
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-15.1.0
alpha         allyesconfig    gcc-15.1.0
arc            allnoconfig    gcc-15.1.0
arc           allyesconfig    clang-22
arm            allnoconfig    clang-22
arm            allnoconfig    gcc-15.1.0
arm64         allmodconfig    clang-22
arm64          allnoconfig    gcc-15.1.0
csky          allmodconfig    gcc-15.1.0
csky           allnoconfig    gcc-15.1.0
hexagon       allmodconfig    gcc-15.1.0
hexagon        allnoconfig    clang-22
hexagon        allnoconfig    gcc-15.1.0
i386          allmodconfig    clang-20
i386          allmodconfig    gcc-14
i386           allnoconfig    gcc-14
i386           allnoconfig    gcc-15.1.0
i386          allyesconfig    clang-20
i386          allyesconfig    gcc-14
loongarch     allmodconfig    clang-22
loongarch      allnoconfig    clang-22
loongarch      allnoconfig    gcc-15.1.0
m68k          allmodconfig    gcc-15.1.0
m68k           allnoconfig    gcc-15.1.0
microblaze     allnoconfig    gcc-15.1.0
microblaze    allyesconfig    gcc-15.1.0
mips           allnoconfig    gcc-15.1.0
mips          allyesconfig    gcc-15.1.0
nios2         allmodconfig    clang-22
nios2          allnoconfig    clang-22
nios2          allnoconfig    gcc-11.5.0
openrisc      allmodconfig    clang-22
openrisc       allnoconfig    clang-22
openrisc       allnoconfig    gcc-15.1.0
parisc         allnoconfig    clang-22
parisc         allnoconfig    gcc-15.1.0
powerpc        allnoconfig    clang-22
powerpc        allnoconfig    gcc-15.1.0
riscv         allmodconfig    clang-22
riscv          allnoconfig    clang-22
riscv          allnoconfig    gcc-15.1.0
s390           allnoconfig    clang-22
sh            allmodconfig    gcc-15.1.0
sh             allnoconfig    clang-22
sh             allnoconfig    gcc-15.1.0
sparc          allnoconfig    clang-22
sparc          allnoconfig    gcc-15.1.0
sparc64       allmodconfig    clang-22
um             allnoconfig    clang-22
um            allyesconfig    gcc-15.1.0
x86_64        allmodconfig    clang-20
x86_64         allnoconfig    clang-20
x86_64         allnoconfig    clang-22
x86_64        allyesconfig    clang-20
x86_64        rhel-9.4-bpf    gcc-14
x86_64      rhel-9.4-kunit    gcc-14
x86_64        rhel-9.4-ltp    gcc-14
x86_64       rhel-9.4-rust    clang-20
xtensa         allnoconfig    clang-22
xtensa         allnoconfig    gcc-15.1.0
xtensa        allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

