Return-Path: <cgroups+bounces-14696-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE8LIEldrGl/pAEAu9opvQ
	(envelope-from <cgroups+bounces-14696-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 18:15:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D62A222CDB9
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 18:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321F2300C904
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976317BED0;
	Sat,  7 Mar 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCO9svbo"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0533689C
	for <cgroups@vger.kernel.org>; Sat,  7 Mar 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903749; cv=none; b=hZoAjKCe3sbV4EsJki2UsHLGixopnYOOtLeJI+U3Yd2SRVi77UcQvykU8eo/YcV7L1sqjvZjuM5l5ZDEYaezAOyyKn3vk8tQZdWQ8W/U3OByAJa0IvOV+yCWEM5WCR2Kr1WeNC5fZpDqlTXLgKc8kuaf1aImZH5wK1Id6IdXPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903749; c=relaxed/simple;
	bh=a3X+QqCDfmoH3tv/Jzovq2+Uy8UEVb+E6t2R5U11OYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SwtpaAUyWjJDuQbVKMmycGaqWtp/jXYEgnVJ9E2FS+737Qr3P+aCu6Wqh/ggItGcVHxK82se+UBD79dsD/MCrhnl0H0meLTCckj4gr/RhGIf/7gIU7sSoppy+ZdDKBLh/mrbGpvz3gIf2X1L7YvGAxmhOo4Gk791F9rb8O9MsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCO9svbo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772903747; x=1804439747;
  h=date:from:to:cc:subject:message-id;
  bh=a3X+QqCDfmoH3tv/Jzovq2+Uy8UEVb+E6t2R5U11OYM=;
  b=FCO9svboeqYipr+2blOVGh33dPMYFHl5OKGacD+yDp3ojvj2JwHds9VG
   rZ/YT5euA9xuS/LdcygNpnf+5puT1Tj/VKNO0T67C6SlHXGzEetQNsLiV
   zGbI5zpyMio9YJsDgY9nhMAj/qxyFv6PT+L2SgQAt5qnTYWuiO/uqEOV+
   SIduTjI9g5JUan3hUYpzfDPK0MDpU0Fx7TV/fzn2GnOy7Z33TwKParnqR
   mExk775ywVHrxND1aMD0JzzOz35jQW8eoAz3U1PLdP0XhPhslFnKupZWf
   XE5T00BnccLRhcBcC+f8E2wuQqWoqt0R7NB8OvrZPCAKhxtVgjzawP2f7
   A==;
X-CSE-ConnectionGUID: aiNhgNU2RTCDD9HXIaLJRQ==
X-CSE-MsgGUID: aGUBo+MoSYy+MB24oUJe5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="85340074"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="85340074"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 09:15:46 -0800
X-CSE-ConnectionGUID: yQgjanrYRB2HvT7iX4Y8ZQ==
X-CSE-MsgGUID: M4PEspV8SQWZhjEf2h8EhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="215921464"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Mar 2026 09:15:45 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyvFe-000000002NJ-3j1R;
	Sat, 07 Mar 2026 17:15:42 +0000
Date: Sun, 08 Mar 2026 01:15:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.0-fixes] BUILD SUCCESS
 a72f73c4dd9b209c53cf8b03b6e97fcefad4262c
Message-ID: <202603080132.zsne00Bz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: D62A222CDB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14696-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.0-fixes
branch HEAD: a72f73c4dd9b209c53cf8b03b6e97fcefad4262c  cgroup: Don't expose dead tasks in cgroup

elapsed time: 1092m

configs tested: 112
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260307    gcc-14.3.0
arc                   randconfig-002-20260307    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260307    clang-23
arm                   randconfig-002-20260307    gcc-15.2.0
arm                   randconfig-003-20260307    gcc-13.4.0
arm                   randconfig-004-20260307    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260307    gcc-8.5.0
arm64                 randconfig-002-20260307    gcc-11.5.0
arm64                 randconfig-003-20260307    gcc-15.2.0
arm64                 randconfig-004-20260307    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260307    gcc-15.2.0
csky                  randconfig-002-20260307    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260307    clang-23
hexagon               randconfig-002-20260307    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260307    gcc-14
i386        buildonly-randconfig-002-20260307    gcc-14
i386        buildonly-randconfig-003-20260307    gcc-12
i386        buildonly-randconfig-004-20260307    clang-20
i386        buildonly-randconfig-005-20260307    gcc-14
i386        buildonly-randconfig-006-20260307    clang-20
i386                  randconfig-011-20260307    clang-20
i386                  randconfig-012-20260307    clang-20
i386                  randconfig-013-20260307    clang-20
i386                  randconfig-014-20260307    clang-20
i386                  randconfig-015-20260307    gcc-14
i386                  randconfig-016-20260307    gcc-14
i386                  randconfig-017-20260307    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260307    gcc-15.2.0
loongarch             randconfig-002-20260307    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20260307    gcc-10.5.0
nios2                 randconfig-002-20260307    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260307    gcc-12.5.0
parisc                randconfig-002-20260307    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260307    gcc-8.5.0
powerpc               randconfig-002-20260307    gcc-11.5.0
powerpc64             randconfig-001-20260307    gcc-8.5.0
powerpc64             randconfig-002-20260307    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260307    clang-17
riscv                 randconfig-002-20260307    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260307    clang-23
s390                  randconfig-002-20260307    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260307    gcc-15.2.0
sh                    randconfig-002-20260307    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260307    gcc-15.2.0
sparc                 randconfig-002-20260307    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260307    clang-23
sparc64               randconfig-002-20260307    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                    randconfig-001-20260307    gcc-14
um                    randconfig-002-20260307    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260307    gcc-14
x86_64      buildonly-randconfig-002-20260307    gcc-14
x86_64      buildonly-randconfig-003-20260307    gcc-14
x86_64      buildonly-randconfig-004-20260307    clang-20
x86_64      buildonly-randconfig-005-20260307    clang-20
x86_64      buildonly-randconfig-006-20260307    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260307    gcc-8.5.0
xtensa                randconfig-002-20260307    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

