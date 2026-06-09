Return-Path: <cgroups+bounces-16751-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4eekLoSBJ2pfyQIAu9opvQ
	(envelope-from <cgroups+bounces-16751-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 04:59:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BB265BEDC
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 04:59:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=I8PKv9NX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16751-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16751-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7195301DA58
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F0360EEE;
	Tue,  9 Jun 2026 02:59:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A035FF6E
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 02:59:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780973950; cv=none; b=uTGZql2ZWa8EeDyriu0ScXCIFf8c6xnUqf335qf+XT7WfU2d0KHno5bdvdiYWy6Uj2Fy9dGKzEa9gvc/62RrRosozTBZXJdEy+cS/HamlEPxNliqubnRQB20cUpsEekNdPZADzYIGWf5JA2x4uhiSLFKywBdF9XnJkWss7u6JmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780973950; c=relaxed/simple;
	bh=aNB0ERxMfPo+y7t2/BSEqLcMjZeIC9Q/IWl1XSOiVR4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TKrmjY/Nv7cK7kGqThZUcDmFFO34Zn2nO//G2U0cJVnSTceD2wCFcuVCRYpJPOUWyuITJiMHqEq3Mt3cKmI4rIiI3awGmOeQCnPJ2GCpj20e9LJ+LesyjadADx+KZQ3B5AwZPsVkOwb2R5HUDWokGN8GiyQCigcoum6QeeKvKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8PKv9NX; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780973949; x=1812509949;
  h=date:from:to:cc:subject:message-id;
  bh=aNB0ERxMfPo+y7t2/BSEqLcMjZeIC9Q/IWl1XSOiVR4=;
  b=I8PKv9NXUfe17BeXOVle6de6g1nhuP55EeTNE8C1mVerjOTtebwcuR2x
   y0n/xZOZtGki3wRBcoTXsP4l0iWDnMXCSHTl3hEUtSvVuwQV2wbt7WEnc
   zcmRIU0DCcloWN+6ijL52HCi8PHxPuyKSqH/eT6RjSUnsTGVv/D8X4Du4
   BE4c1dYUw1o1/0qC57AQGEJtq/xHzNTQLft6b0OtG4oSxbZos9PFE1MH6
   1fV+YLeLxll0+orF3cqZ8tn0T4feUl6QsRCNske3SJCYvRW2tjKr34yq4
   yhxEmFGi+4YKj0pdtHPlRXqnMK864KyU5SVty9kGeToLSTG0TL0WjoDzl
   Q==;
X-CSE-ConnectionGUID: xtnCQdyJRZKL/N37jnDnsQ==
X-CSE-MsgGUID: rZwLI+VOSs2qesZieSCGNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="107162760"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="107162760"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 19:59:06 -0700
X-CSE-ConnectionGUID: Ll39nwr/R6KrO47NmoLfWw==
X-CSE-MsgGUID: zwUpu5WySLacwDdlLCEpQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="244593023"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Jun 2026 19:59:06 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wWmgA-00000000JXu-0zRZ;
	Tue, 09 Jun 2026 02:59:02 +0000
Date: Tue, 09 Jun 2026 10:58:26 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.2] BUILD SUCCESS
 a99ce697ea5e27b867c9ba4ee55fa5ba3b8d1188
Message-ID: <202606091018.9kT3BmUk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
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
	TAGGED_FROM(0.00)[bounces-16751-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9BB265BEDC

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.2
branch HEAD: a99ce697ea5e27b867c9ba4ee55fa5ba3b8d1188  cgroup: Migrate tasks to the root css when a controller is rebound

elapsed time: 8964m

configs tested: 86
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                  randconfig-001-20260609    gcc-9.5.0
csky                  randconfig-002-20260609    gcc-11.5.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260609    gcc-14
i386        buildonly-randconfig-002-20260609    gcc-14
i386        buildonly-randconfig-003-20260609    clang-22
i386        buildonly-randconfig-004-20260609    clang-22
i386        buildonly-randconfig-005-20260609    gcc-14
i386        buildonly-randconfig-006-20260609    clang-22
i386                  randconfig-011-20260609    clang-22
i386                  randconfig-012-20260609    clang-22
i386                  randconfig-013-20260609    clang-22
i386                  randconfig-014-20260609    gcc-14
i386                  randconfig-015-20260609    clang-22
i386                  randconfig-016-20260609    clang-22
i386                  randconfig-017-20260609    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               mpc834x_itxgp_defconfig    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-002-20260609    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260609    clang-23
s390                  randconfig-002-20260609    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                    randconfig-001-20260609    gcc-13.4.0
sh                    randconfig-002-20260609    gcc-11.5.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260609    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64               randconfig-001-20260609    clang-23
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                    randconfig-002-20260609    gcc-12
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260609    gcc-16.1.0
xtensa                randconfig-002-20260609    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

