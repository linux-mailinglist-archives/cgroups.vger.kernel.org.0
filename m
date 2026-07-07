Return-Path: <cgroups+bounces-17565-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3P6qLs1LTWo/xwEAu9opvQ
	(envelope-from <cgroups+bounces-17565-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 20:56:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B825B71EC73
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 20:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fj1uEbKa;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17565-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17565-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A860B3008D13
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5E3939B9;
	Tue,  7 Jul 2026 18:56:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C733921F0
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 18:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450567; cv=none; b=cwF7GlrlLA2101LprR3RLEVOzCWVeHlFdVPEeWor63uvFa6tckzm7Qbho+zEnqrS3hrOKvfaDBOINIHQaswMw2niJFq0UD9lIoUxphUUzECvlYZU08RcMmrDDxG9lR4eC8nInyhB32C+znwT2Ulc86MfoZdOYKV4CtLvXQY687I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450567; c=relaxed/simple;
	bh=U/+M3E3EPHIelz0qJWKA5nFnQ/pyXTu+8uvC1CCRi0A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Yi4aBI0QxSPpIICZmXtTassIMCDBQnWXmrMWmkAPttOC81uHvINmmg3Pwe/A/Vu7Y2GEmG4UgRHiWJZPPz/AeqErFd3FoqAhuOPZM3SpqQAXP0Q9cF7zFBX3ZqhooFourlW4BcD6eOrwKOctGI0SUAjzdDPvMOcuLDTTWeGmVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fj1uEbKa; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783450566; x=1814986566;
  h=date:from:to:cc:subject:message-id;
  bh=U/+M3E3EPHIelz0qJWKA5nFnQ/pyXTu+8uvC1CCRi0A=;
  b=fj1uEbKaLgXS9Uqmi6NYl1Snz0ND8cpa2nJ7JEeal+5L9b24+sxdBqd2
   R1XHnuUlzRhjoRIZD9WAEsN/4ZSCX2JLTTAU6Efhe3BDX6T2MfeqomzVQ
   cHiW9fDcIgm15niTv8eHVW4KmfI9nQyZJOvlw+NM3dX9gZ51kCgvAo+RN
   cUCXU85+jo/obO/psPBDbMfk/YOXJEg9CDTNlZy2r7IfbFgstVP3CiCUJ
   57kmSTdVJcijoZActkhMMWH1mSx5e3LkNXSv1nH61eVnRiwvKSTVQyYWA
   DQzcPo43HtRf/XQln1MD4XjlKcx8HswQFdTZbITjohThVKTAmCkX+ZN4k
   w==;
X-CSE-ConnectionGUID: cAJhsLAdTv+Wc+h1FHn9CA==
X-CSE-MsgGUID: N4sXD0RNQcKq8QPizxinJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84163128"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84163128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:56:06 -0700
X-CSE-ConnectionGUID: UHce9+a1TVS+k83YRrlq9A==
X-CSE-MsgGUID: XBflQOxwQbOqNipizC0/VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257955936"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 07 Jul 2026 11:56:04 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whAx7-00000000FaV-2xWj;
	Tue, 07 Jul 2026 18:55:36 +0000
Date: Wed, 08 Jul 2026 02:55:21 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 cc7d3289c11ad52984c350ad1d7f23cbfc58bc9c
Message-ID: <202607080210.dWaLnUgB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17565-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B825B71EC73

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: cc7d3289c11ad52984c350ad1d7f23cbfc58bc9c  Merge branch 'for-7.3' into for-next

elapsed time: 1023m

configs tested: 107
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
arc                    allmodconfig    clang-23
arc                    allmodconfig    gcc-16.1.0
arc                     allnoconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
arm                     allnoconfig    clang-17
arm                     allnoconfig    gcc-16.1.0
arm                    allyesconfig    clang-23
arm                    allyesconfig    gcc-16.1.0
arm64                  allmodconfig    clang-23
arm64                   allnoconfig    gcc-16.1.0
csky                   allmodconfig    gcc-16.1.0
csky                    allnoconfig    gcc-16.1.0
hexagon                allmodconfig    clang-23
hexagon                 allnoconfig    clang-23
hexagon                 allnoconfig    gcc-16.1.0
hexagon     randconfig-001-20260707    clang-18
hexagon     randconfig-002-20260707    clang-18
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                    allnoconfig    gcc-16.1.0
i386                   allyesconfig    gcc-14
i386                 randconfig-011    gcc-14
i386        randconfig-011-20260707    gcc-14
i386                 randconfig-012    gcc-14
i386        randconfig-012-20260707    gcc-14
i386                 randconfig-013    gcc-14
i386        randconfig-013-20260707    gcc-14
i386                 randconfig-014    gcc-14
i386        randconfig-014-20260707    gcc-14
i386                 randconfig-015    gcc-14
i386        randconfig-015-20260707    gcc-14
i386                 randconfig-016    gcc-14
i386        randconfig-016-20260707    gcc-14
i386                 randconfig-017    gcc-14
i386        randconfig-017-20260707    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-20
loongarch               allnoconfig    gcc-16.1.0
loongarch   randconfig-001-20260707    clang-18
loongarch   randconfig-002-20260707    clang-18
m68k                   allmodconfig    gcc-16.1.0
m68k                    allnoconfig    gcc-16.1.0
m68k                   allyesconfig    clang-23
m68k                   allyesconfig    gcc-16.1.0
microblaze              allnoconfig    gcc-16.1.0
microblaze             allyesconfig    gcc-16.1.0
mips                   allmodconfig    gcc-16.1.0
mips                    allnoconfig    gcc-16.1.0
mips                   allyesconfig    gcc-16.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    clang-23
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20260707    clang-18
nios2       randconfig-002-20260707    clang-18
openrisc               allmodconfig    gcc-16.1.0
openrisc                allnoconfig    clang-23
openrisc                allnoconfig    gcc-16.1.0
parisc                 allmodconfig    gcc-16.1.0
parisc                  allnoconfig    clang-23
parisc                  allnoconfig    gcc-16.1.0
parisc                 allyesconfig    clang-17
parisc                 allyesconfig    gcc-16.1.0
parisc      randconfig-001-20260707    clang-22
parisc      randconfig-002-20260707    clang-22
powerpc                allmodconfig    gcc-16.1.0
powerpc                 allnoconfig    clang-23
powerpc                 allnoconfig    gcc-16.1.0
powerpc     randconfig-001-20260707    clang-22
powerpc     randconfig-002-20260707    clang-22
powerpc64   randconfig-001-20260707    clang-22
powerpc64   randconfig-002-20260707    clang-22
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    clang-23
riscv                   allnoconfig    gcc-16.1.0
riscv                  allyesconfig    clang-23
riscv       randconfig-001-20260708    clang-23
riscv       randconfig-002-20260708    clang-23
s390                   allmodconfig    clang-17
s390                   allmodconfig    clang-23
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-16.1.0
s390        randconfig-001-20260708    clang-23
s390        randconfig-002-20260708    clang-23
sh                     allmodconfig    gcc-16.1.0
sh                      allnoconfig    clang-23
sh                      allnoconfig    gcc-16.1.0
sh                     allyesconfig    clang-17
sh                     allyesconfig    gcc-16.1.0
sh          randconfig-001-20260708    clang-23
sh          randconfig-002-20260708    clang-23
sparc                   allnoconfig    clang-23
sparc                   allnoconfig    gcc-16.1.0
sparc64                allmodconfig    clang-20
um                     allmodconfig    clang-17
um                      allnoconfig    clang-17
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-22
x86_64                  allnoconfig    clang-22
x86_64                  allnoconfig    clang-23
x86_64                 allyesconfig    clang-22
x86_64                rhel-9.4-rust    clang-22
xtensa                  allnoconfig    clang-23
xtensa                  allnoconfig    gcc-16.1.0
xtensa                 allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

