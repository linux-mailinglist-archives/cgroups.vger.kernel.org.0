Return-Path: <cgroups+bounces-15336-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIYLNlVS4Wl5rwAAu9opvQ
	(envelope-from <cgroups+bounces-15336-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 23:19:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EA414DDD
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 23:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400D430B2296
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 21:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29AB37267B;
	Thu, 16 Apr 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaE15Oaz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2904330678
	for <cgroups@vger.kernel.org>; Thu, 16 Apr 2026 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374244; cv=none; b=S7dR/n4pFx1sYzpFQaosT1BgXufp4IXv+GQ6ThWAhfjnkQUFn6ThEmdqbaE0H2shL3xSbMUa8V7N7Vexk0nfIueoogEJHLbI1x5pS08s3jV52B7my8WVv9b6kVbMpPIWdnPLlMtV1nlC1TBItqtojuzWHjzhSL1IGE70nhbmFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374244; c=relaxed/simple;
	bh=GNYNY2rgFxKGCCHYSALPoT0AL6dDYHuCBuvhkJTAeZY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YDSKU/YdTvX4l4+BACmUNHcCMhygMc4l9gcdpOoOJTY6jCGE68nzEzo7EIeqZBG9KaubS7L9V+QZRHLke5S5zR6EzbxEXI7kwxxxjCHip5nI/8eEPYaJV+7348eN3grDU5LCTnoCyze89F4Odd7ZFus+po64ehygR4Mlz1A/deQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaE15Oaz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776374243; x=1807910243;
  h=date:from:to:cc:subject:message-id;
  bh=GNYNY2rgFxKGCCHYSALPoT0AL6dDYHuCBuvhkJTAeZY=;
  b=YaE15Oaz+AVYNR6LUnIE8kSDXRKTajvH3+3751MtyyoVcB+c/+uPLTra
   2D7tJtuioRPkVrTCvIXcOS+/enb2SOX5rWc/jjrowhfhznFzKUg9zPFme
   ZT9k2yQcCXshwAYIF4F0NFygNcpSZja5mheGPRiVhHzj9opUKcdPtOlv7
   MO2s/Vt4N77u9vbY25fIhEHA/P6PHN5mJo/z4LqLQXcj68y4eWSpD8bWb
   tet/3TL7MtrBAb0N1nSn0+Muw2lO5AVAYQdngrhOldgdSojpXNhWiTGeE
   cGrq3Q2Hd3nTFQfagWg8lh5k/OMErIymfRL+m4D9BpYBnSIV5hlM/mn44
   g==;
X-CSE-ConnectionGUID: onPsoyvFRASmnhQ5DRHkQg==
X-CSE-MsgGUID: 1SQc7eYGQZOpH2BD20O2LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77568463"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77568463"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 14:17:23 -0700
X-CSE-ConnectionGUID: lUq0UbWbT8uV2HP83r+qig==
X-CSE-MsgGUID: 0bq3JZepT/6Dx+yNn6Fnig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="268853743"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Apr 2026 14:17:21 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDU5O-000000001xa-1HVf;
	Thu, 16 Apr 2026 21:17:18 +0000
Date: Fri, 17 Apr 2026 05:16:22 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-for-7.1] BUILD SUCCESS
 e3538ca09b059069ef9969f31142c909fe2707d9
Message-ID: <202604170514.mA82lIpV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-15336-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.958];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 425EA414DDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-7.1
branch HEAD: e3538ca09b059069ef9969f31142c909fe2707d9  Merge branch 'for-7.1' into test-merge-for-7.1

elapsed time: 786m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260416    gcc-14.3.0
arc                   randconfig-002-20260416    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260416    clang-23
arm                   randconfig-002-20260416    gcc-8.5.0
arm                   randconfig-003-20260416    gcc-8.5.0
arm                   randconfig-004-20260416    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260416    gcc-8.5.0
arm64                 randconfig-002-20260416    gcc-10.5.0
arm64                 randconfig-003-20260416    clang-23
arm64                 randconfig-004-20260416    clang-16
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260416    gcc-14.3.0
csky                  randconfig-002-20260416    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260416    clang-23
hexagon               randconfig-002-20260416    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260416    gcc-14
i386        buildonly-randconfig-002-20260416    gcc-12
i386        buildonly-randconfig-003-20260416    clang-20
i386        buildonly-randconfig-004-20260416    clang-20
i386        buildonly-randconfig-005-20260416    clang-20
i386        buildonly-randconfig-006-20260416    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260416    gcc-14
i386                  randconfig-002-20260416    clang-20
i386                  randconfig-003-20260416    clang-20
i386                  randconfig-004-20260416    clang-20
i386                  randconfig-005-20260416    clang-20
i386                  randconfig-006-20260416    clang-20
i386                  randconfig-007-20260416    gcc-14
i386                  randconfig-011-20260416    gcc-14
i386                  randconfig-012-20260416    gcc-14
i386                  randconfig-013-20260416    clang-20
i386                  randconfig-014-20260416    clang-20
i386                  randconfig-015-20260416    clang-20
i386                  randconfig-016-20260416    clang-20
i386                  randconfig-017-20260416    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260416    gcc-15.2.0
loongarch             randconfig-002-20260416    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260416    gcc-8.5.0
nios2                 randconfig-002-20260416    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260416    gcc-10.5.0
parisc                randconfig-002-20260416    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260416    clang-23
powerpc               randconfig-002-20260416    gcc-8.5.0
powerpc64             randconfig-001-20260416    clang-16
powerpc64             randconfig-002-20260416    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260416    gcc-11.5.0
riscv                 randconfig-002-20260416    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260416    clang-23
s390                  randconfig-002-20260416    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260416    gcc-9.5.0
sh                    randconfig-002-20260416    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260416    gcc-15.2.0
sparc                 randconfig-002-20260416    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260416    clang-23
sparc64               randconfig-002-20260416    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260416    clang-23
um                    randconfig-002-20260416    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260416    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260416    gcc-13
x86_64                randconfig-002-20260416    gcc-14
x86_64                randconfig-003-20260416    clang-20
x86_64                randconfig-004-20260416    clang-20
x86_64                randconfig-005-20260416    gcc-14
x86_64                randconfig-006-20260416    gcc-14
x86_64                randconfig-011-20260416    clang-20
x86_64                randconfig-012-20260416    gcc-14
x86_64                randconfig-013-20260416    gcc-14
x86_64                randconfig-014-20260416    gcc-12
x86_64                randconfig-015-20260416    clang-20
x86_64                randconfig-016-20260416    gcc-12
x86_64                randconfig-071-20260416    gcc-14
x86_64                randconfig-072-20260416    gcc-14
x86_64                randconfig-073-20260416    gcc-14
x86_64                randconfig-074-20260416    clang-20
x86_64                randconfig-075-20260416    clang-20
x86_64                randconfig-076-20260416    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260416    gcc-11.5.0
xtensa                randconfig-002-20260416    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

