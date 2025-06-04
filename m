Return-Path: <cgroups+bounces-8434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B9ACE4D3
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 21:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0483A8676
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E220CCCC;
	Wed,  4 Jun 2025 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcSHHzSo"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F24211C
	for <cgroups@vger.kernel.org>; Wed,  4 Jun 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065669; cv=none; b=nhvGfcW4JO6+HL3aKvuoD46yUShueYOKmSbpS6ZkDg72l3UZJ/+OmxUHUsfzYJeOqhMNQI1YAQ2QpvBysmNuc/K6DF/neLEWcN5+DGaWsj7yk4dcixVZqj7HnE5ZaQKUWr79oSAeYixFgx0hoxbLTAyqqt237hvLpJc52M6TlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065669; c=relaxed/simple;
	bh=OG7KSeUiBxnqMbvcYAqDg4DlfG+jnyqAbOXxEjLBNz4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XYq3GvTKRlD4LV6/yvkTbblihQJzjJUwFrQHy2lOECukNnGlbdYnqUiTIqg7AdkFxRBnUiUirdRRigUtpjOE0qDpfcbT2uHRgMSMpGFWefSDpN+weK+pb4/PwkHH0gLjSz97m8lsaCD9ROy0BxrgqJwpFlkWofsZxam/tXQECMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcSHHzSo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749065669; x=1780601669;
  h=date:from:to:cc:subject:message-id;
  bh=OG7KSeUiBxnqMbvcYAqDg4DlfG+jnyqAbOXxEjLBNz4=;
  b=BcSHHzSoBoWbD+eYRj5RqxjDCpK/rwbXY33YK3D5UnnzBkRjm4G1Kaaf
   rijS6hCm+kAQnyAj3T17vIH/EsmsNfmNnYLS4oMScRyx5bGSC7Im/Q61/
   hdU+c8J1hrnIrhu10o6gYTNdGp/LyXEdjS49VluQ3OBv2h6r3G2EeN+Es
   dFkfdI9oyxyYBNV6qx7QY0QK34ly5pDV/rKUIkdZlvpUeddl13rCYRWfC
   4JiToxC4swsvZR/6Dgn7j+NqBKf4S1qnwOMtYhgMWqkdupeykjBzfuVqO
   SRP6+cEboR63uXkB/grAj0c8gBF+FQRuMblhAleRQ84wq4c+b3XrIeloq
   w==;
X-CSE-ConnectionGUID: 7Bpb37UmR2aOZq0pG797Pg==
X-CSE-MsgGUID: jhyUd7kGSAiLKF3hW2Wf7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50859631"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="50859631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 12:34:28 -0700
X-CSE-ConnectionGUID: ca0gu3zVS8WN8gOX08RUiA==
X-CSE-MsgGUID: uQ2jJGxrQ8S/z8XEOUBHng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150437387"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Jun 2025 12:34:26 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMtsW-0003Ph-21;
	Wed, 04 Jun 2025 19:34:24 +0000
Date: Thu, 05 Jun 2025 03:34:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 d7c1439faed666068a8bac8d3de2ae29c5f9f722
Message-ID: <202506050301.68crfs9e-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: d7c1439faed666068a8bac8d3de2ae29c5f9f722  Merge branch 'for-6.17' into for-next

elapsed time: 1448m

configs tested: 34
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm          allmodconfig    gcc-15.1.0
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
hexagon      allmodconfig    clang-17
hexagon      allyesconfig    clang-21
i386         allmodconfig    gcc-12
i386          allnoconfig    gcc-12
i386         allyesconfig    gcc-12
i386            defconfig    clang-20
loongarch    allmodconfig    gcc-15.1.0
m68k         allmodconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze   allmodconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
openrisc     allyesconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc      allyesconfig    clang-21
riscv        allmodconfig    clang-21
s390         allmodconfig    clang-18
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc        allmodconfig    gcc-15.1.0
um           allmodconfig    clang-19
um           allyesconfig    gcc-12
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64          defconfig    gcc-11
x86_64      rhel-9.4-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

