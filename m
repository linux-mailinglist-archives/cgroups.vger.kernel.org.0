Return-Path: <cgroups+bounces-8435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3127ACE4EB
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 21:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8287C172011
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B6E214223;
	Wed,  4 Jun 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaGSAuzb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8720E03C
	for <cgroups@vger.kernel.org>; Wed,  4 Jun 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065790; cv=none; b=nv1XrRBPzvOqbap5ksRSH19044zoNkJ83Eg1Ef0O4rJSA8vft8I3eIc8IiIypz+X6zG3yuQEk27T1MMoF329COPbpCIAO8WcTowvPD7K5RM/EumfcwUqKbMtA5MBg28bFasLWYiUms9s4Cjygmi40gz5UwrHiZse7bQxTwc8nTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065790; c=relaxed/simple;
	bh=+wlEcUbm9eqeXTec8Ywxmy+qdvNa5zi+eyUT4ONT5RA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AJBW1BH13tul6GtQEcY9BxB9NjAK1HrlF74ksI5DYNs0vDghzISywcyh18oRPOF+VwDvjN1HlhZ2kN/wLnyyYmNPooI7jdrvpjtZLwBNWEnlYg69uX7PApKDF2ZXt4ZPkxgTZ49aw+5pl/HRjUzUscYfGaXl2BQ8qdRPzEgK0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaGSAuzb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749065788; x=1780601788;
  h=date:from:to:cc:subject:message-id;
  bh=+wlEcUbm9eqeXTec8Ywxmy+qdvNa5zi+eyUT4ONT5RA=;
  b=kaGSAuzbfAc0um2X1rz8R3jOL3amtXNB5eaLoQfDaEB/zlkeKPP0RE8Z
   29yxeHEjpCCFfx8+chJAd2baKsR9+HCVMTui7IwTaI0EQ1h2t8Ym86dN2
   2vCdvngZH9kNDCDm9jfRDUPVoqsxnxwz8liO1dRewGXUi3hYaqfv/lVGh
   KPWtxQ+mI048HnvMBIzsI+V0wYcpKKzjCT3q+9W51VMsyxrcbYcbNFUNn
   EppSo3v4IK30CoYfbu/E+4y6qesvELvhp1PBQR+UK1eGWCFGwtGofx847
   E4bsH+dXmHh1gebpy0qyp/W9JisyvUSn32VE19hwHgWWg5tc6jd9hyiH1
   g==;
X-CSE-ConnectionGUID: 7/qHcrwoQuehcsO1smQOrA==
X-CSE-MsgGUID: RF4gHIPNTletaNRdBYGzew==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="53797402"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="53797402"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 12:36:27 -0700
X-CSE-ConnectionGUID: vLqNwgHeSGK4WGib94gCjg==
X-CSE-MsgGUID: yVwjNKjKRGuaUMW1j6sP7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150072443"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Jun 2025 12:36:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMtuS-0003Pl-2U;
	Wed, 04 Jun 2025 19:36:24 +0000
Date: Thu, 05 Jun 2025 03:35:28 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.17] BUILD SUCCESS
 edfc4c8a1edffa6849e19ffade1be8dd824989d0
Message-ID: <202506050318.LIIF7xTd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.17
branch HEAD: edfc4c8a1edffa6849e19ffade1be8dd824989d0  cgroup: Drop sock_cgroup_classid() dummy implementation

elapsed time: 1449m

configs tested: 29
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha       allyesconfig    gcc-15.1.0
arc         allmodconfig    gcc-15.1.0
arc         allyesconfig    gcc-15.1.0
arm         allmodconfig    gcc-15.1.0
arm         allyesconfig    gcc-15.1.0
arm64       allmodconfig    clang-19
hexagon     allmodconfig    clang-17
hexagon     allyesconfig    clang-21
loongarch   allmodconfig    gcc-15.1.0
m68k        allmodconfig    gcc-15.1.0
m68k        allyesconfig    gcc-15.1.0
microblaze  allmodconfig    gcc-15.1.0
microblaze  allyesconfig    gcc-15.1.0
openrisc    allyesconfig    gcc-15.1.0
parisc      allmodconfig    gcc-15.1.0
parisc      allyesconfig    gcc-15.1.0
powerpc     allmodconfig    gcc-15.1.0
powerpc     allyesconfig    clang-21
riscv       allmodconfig    clang-21
riscv       allyesconfig    clang-16
s390        allmodconfig    clang-18
s390        allyesconfig    gcc-15.1.0
sh          allmodconfig    gcc-15.1.0
sh          allyesconfig    gcc-15.1.0
sparc       allmodconfig    gcc-15.1.0
um          allmodconfig    clang-19
um          allyesconfig    gcc-12
x86_64       allnoconfig    clang-20
x86_64         defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

