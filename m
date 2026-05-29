Return-Path: <cgroups+bounces-16409-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA2eF03zGGoMpQgAu9opvQ
	(envelope-from <cgroups+bounces-16409-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:00:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B3B5FC3E9
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002943016CB5
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 01:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86C361640;
	Fri, 29 May 2026 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6H5VEuw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7C3603E9
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019967; cv=none; b=ooOiMnFOkPflG4gqGPQpfAwP86i9zQcfREK2OMLoDUY75eP9d/1DgfLf8NbZkVCrkUXJ6rPe7QwOma0pET0t/L+LLiYA/EimoilJEuXGOyVXtrO0ULAG9Rpw5NT9JOUbp7pkIJG+IFVGvDe8srtcSBjayJqahx0EZvnAPhhuEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019967; c=relaxed/simple;
	bh=TsAH1VOz9Nl8y7phr6CajfjBfxXAOY3XpgoA4G2RGNU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LlDG0JNDbOcuewVDaBqFSaG1UPnzoDATiQB3Fromp7g6gqFRvl6tmaxQOVrHzcGyYfmaMIaYVRucwwRLgWKtvfiZ6uIlHjd8vupucS+31iJd5mpOv6bpejzrNypdlC8siQiMfL81rqudYcOWuFjTIdh2pirMDk5WvRd19sPlv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6H5VEuw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780019965; x=1811555965;
  h=date:from:to:cc:subject:message-id;
  bh=TsAH1VOz9Nl8y7phr6CajfjBfxXAOY3XpgoA4G2RGNU=;
  b=W6H5VEuwKiOpsdZU9I94IgrgHXr/jmC0cwKz7GdhqwfVPMzL5oz+Z38n
   MAA7S5KUNkeFI8nXSyNQvZJ4ffm0V0jTy6gpLWjaSlRmShkdijBC/PsQl
   BQ7Zdl1MkrMPD5RjjYLw8Ke4VUmZH/+W/7O+7nHxKL40fi2MbUsG3n+YK
   WLWqaAvU4OCurCmGfh4Wi7wRtGwzQbTIBU7UkGloHA4WZS8v3Dc3F6Uf0
   M93J6iKQaNR98O9o2ox9a03exMuoXbuggDC0rI8OifwH8lneKZbgkx7cU
   IqUj/AyKAHFvYrFiRUlQ/jNQ1mxsJSsLUiFyCwmxTYwa0RNxELMJ65u9C
   Q==;
X-CSE-ConnectionGUID: 08ca8RXeT+KzxhAC9IQogA==
X-CSE-MsgGUID: Amzrq8vURuiPERdFBCCYag==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91983151"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91983151"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 18:59:25 -0700
X-CSE-ConnectionGUID: 6xNL1KHKR5asB0WleyjJNQ==
X-CSE-MsgGUID: mihjsyVmRBCNxqA5DannZQ==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="241670379"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 May 2026 18:59:24 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSmVM-000000006fS-31nC;
	Fri, 29 May 2026 01:59:20 +0000
Date: Fri, 29 May 2026 09:59:01 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.1-fixes] BUILD SUCCESS
 645c3b7ef1a7eed9627664bd11d7a8eb4519ee15
Message-ID: <202605290953.r8fFbNjo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16409-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: B0B3B5FC3E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.1-fixes
branch HEAD: 645c3b7ef1a7eed9627664bd11d7a8eb4519ee15  cgroup/cpuset: Add test cases for sibling CPU exclusion on partition update

elapsed time: 1853m

configs tested: 71
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
openrisc                  defconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc                    defconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv                     defconfig    clang-23
riscv       randconfig-001-20260529    gcc-8.5.0
riscv       randconfig-002-20260529    gcc-9.5.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390                      defconfig    clang-23
s390        randconfig-001-20260529    gcc-8.5.0
s390        randconfig-002-20260529    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh          randconfig-001-20260529    gcc-15.2.0
sh          randconfig-002-20260529    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc                     defconfig    gcc-15.2.0
sparc       randconfig-001-20260529    gcc-8.5.0
sparc       randconfig-002-20260529    gcc-15.2.0
sparc64                allmodconfig    clang-23
sparc64     randconfig-001-20260529    gcc-11.5.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um          randconfig-001-20260529    gcc-14
um          randconfig-002-20260529    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa      randconfig-001-20260529    gcc-11.5.0
xtensa      randconfig-002-20260529    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

