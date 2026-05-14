Return-Path: <cgroups+bounces-15940-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJAwIuWVBWpLYwIAu9opvQ
	(envelope-from <cgroups+bounces-15940-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 11:29:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078AA53FC5D
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 11:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090C5302DA09
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACAD3A3E70;
	Thu, 14 May 2026 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/7n6ouW"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C139EB59
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750887; cv=none; b=iKIOtyx1JDQ2CvALq316UPMb6NE03HSBccvFo+ON8UATbsSoxjUdwWU5cFCM0DH1QX+dLTNcO1VvEmgNR6OvSCnDlAm1FrQYEvdHGm5kofgYYmpClmTgdu4DnULI0it7RsbWcc3a1TVBU32LJB/jtkoCSLst4s0x/w+f7vGOIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750887; c=relaxed/simple;
	bh=26CCMIa6mol2RAIfYvwothGstPSJelXcUI9BGLHuGfQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iL418+HHJQ0TiWpPJk1/XN9+jS2vntdeNW8WLOqgBWzPTnrzLrL0X8RV0avYc6g3HlL/C1Bvv61D68qnZF+3bkYpDOijQ77FUUmk1+SLjLcToskVGr3qaGd46K5OzDj3VC3yJqUIw6pr3MZ52ARu/7iLqGrY1tDFFsb2LYLK+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/7n6ouW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778750886; x=1810286886;
  h=date:from:to:cc:subject:message-id;
  bh=26CCMIa6mol2RAIfYvwothGstPSJelXcUI9BGLHuGfQ=;
  b=T/7n6ouWGM+efF7rzvor61dXW69cMn1NAOp2Z9j2Wny0cez+XP9bH2UN
   oBGijMXs7R5Sc1+Ot/uyvGRwFgi3UMpSu+G7k6PLzswW21UadI6yqrtcF
   4W/1P3yWCwSkSDAi6pKQMXF5P2gBUenno8ucSJvtsPa7Dyzx9di6mh+QM
   oOVC9eBFV/Wi1MBZfeqpR1G6g/dzuClB4aghQ2NBkHGXEH0izN2AQAHBJ
   x2kBYmgDbU5TieGvFoNa46kV2aC6S9wkuBPyas6atcKeUkNNB016EPNaX
   dSUUOfDfKmCLAOFOT6Vu3XnUYjDT3nprlc+tFr/XZMddhrelZ0hf+/hri
   Q==;
X-CSE-ConnectionGUID: QWCVBgxoQqy7fTxXapeCtQ==
X-CSE-MsgGUID: Pid7oM1ST1G3qkpnPuvqXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="105148496"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="105148496"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 02:28:06 -0700
X-CSE-ConnectionGUID: ZANzFLAKS4eNaYIhLN+vww==
X-CSE-MsgGUID: m5KcKZ8FT+GY2ULYLt0TMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="240175236"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 May 2026 02:28:04 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNSMM-000000006Hl-0e6e;
	Thu, 14 May 2026 09:28:02 +0000
Date: Thu, 14 May 2026 17:27:03 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 a234764e334b01b4b4a631b1c94df3458f3f57cb
Message-ID: <202605141752.A11u7KKR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 078AA53FC5D
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-15940-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: a234764e334b01b4b4a631b1c94df3458f3f57cb  Merge branch 'for-7.1-fixes' into for-next

elapsed time: 869m

configs tested: 114
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260514    clang-23
arm64                 randconfig-002-20260514    gcc-8.5.0
arm64                 randconfig-003-20260514    clang-23
arm64                 randconfig-004-20260514    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260514    gcc-15.2.0
csky                  randconfig-002-20260514    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260514    clang-16
hexagon               randconfig-002-20260514    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-004-20260514    clang-20
i386                           randconfig-015    gcc-14
i386                           randconfig-016    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260514    gcc-14.3.0
loongarch             randconfig-002-20260514    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20260514    gcc-11.5.0
nios2                 randconfig-002-20260514    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260514    gcc-13.4.0
parisc                randconfig-002-20260514    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260514    gcc-8.5.0
powerpc               randconfig-002-20260514    gcc-13.4.0
powerpc64             randconfig-002-20260514    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260514    gcc-12.5.0
riscv                 randconfig-002-20260514    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260514    gcc-11.5.0
s390                  randconfig-002-20260514    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260514    gcc-10.5.0
sh                    randconfig-002-20260514    gcc-14.3.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260514    gcc-15.2.0
sparc                 randconfig-002-20260514    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260514    clang-23
sparc64               randconfig-002-20260514    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260514    gcc-14
um                    randconfig-002-20260514    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260514    gcc-14
x86_64      buildonly-randconfig-002-20260514    clang-20
x86_64      buildonly-randconfig-003-20260514    gcc-14
x86_64      buildonly-randconfig-004-20260514    clang-20
x86_64      buildonly-randconfig-005-20260514    clang-20
x86_64      buildonly-randconfig-006-20260514    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260514    clang-20
x86_64                randconfig-002-20260514    clang-20
x86_64                randconfig-003-20260514    gcc-14
x86_64                randconfig-004-20260514    gcc-14
x86_64                randconfig-005-20260514    clang-20
x86_64                randconfig-006-20260514    gcc-14
x86_64                randconfig-011-20260514    clang-20
x86_64                randconfig-012-20260514    gcc-14
x86_64                randconfig-013-20260514    clang-20
x86_64                randconfig-014-20260514    clang-20
x86_64                randconfig-015-20260514    clang-20
x86_64                randconfig-016-20260514    clang-20
x86_64                randconfig-071-20260514    clang-20
x86_64                randconfig-072-20260514    gcc-14
x86_64                randconfig-073-20260514    clang-20
x86_64                randconfig-074-20260514    gcc-14
x86_64                randconfig-075-20260514    clang-20
x86_64                randconfig-076-20260514    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260514    gcc-13.4.0
xtensa                randconfig-002-20260514    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

