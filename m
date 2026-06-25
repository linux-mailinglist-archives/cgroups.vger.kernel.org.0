Return-Path: <cgroups+bounces-17287-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDUVItIVPWo6wwgAu9opvQ
	(envelope-from <cgroups+bounces-17287-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 13:49:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C976C543E
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 13:49:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LmoOGNNI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17287-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17287-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0572301B154
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8DC34753A;
	Thu, 25 Jun 2026 11:49:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16C38422D
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 11:49:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388174; cv=none; b=J/p6/qzwkoC1bNFtxrV5OvrRpALxRgiJCjBC28TvLJv+zGVWwmU2ZmhYs5eyqHOA8KpooARdKa28mOvhLoN+m78vg8GLNmhasmDHCs1RP9kbzixD4VLBbGMoKqtnJuPU/JkXV5M5E671Ll+zt1qdf88GivrOrWV6XIxL7Lpsaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388174; c=relaxed/simple;
	bh=2gvEwTfdu2E9y4N7/XQsR5AnZDlm54XtAIU1iV7KIKk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZnuZ/2N7xgLGVacTQIg9Ys2icfngW3rR50uDY1ZhkQd1vt45mxBv+cXGa177Du/xd0jPQGExtnkclCqvFckiSdHVokUbiR9NrrJS7KH0S/aq33+1kG/Imfu4eZEYE8VLV7VF4GztT/HmqQfWXO1E3djh6pg+1ntcmlYfrhrbHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmoOGNNI; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782388173; x=1813924173;
  h=date:from:to:cc:subject:message-id;
  bh=2gvEwTfdu2E9y4N7/XQsR5AnZDlm54XtAIU1iV7KIKk=;
  b=LmoOGNNIUPWngELN7s9+uP+SGOU4SiE8Tgt7eigigolqWtzkSy437Am/
   I1lL5Th2QAa0vhGybpaj4Mo+0dRCB9xKTz9zIkCiPSH53fwoBXfwh3cVV
   3SAD3gxXZsJ9YIJsY5YvfTCYeLYMZT2AR4F/glKr777sb8PsJ4njeHNZb
   Y2884upyd3QE13BoDvK5/UeV20gqyqA9s65abEt+cb64wuYhtIulZOf2Z
   7s7qpUv1dThfCt5Pgdj0lEq0Y/E4T6z+yGiTautFU2bQYnQ1KZXtxtFSU
   Vp1MPpUItzBpiovR1PPeekPIckE4bg9j/1Vntea+DU5XRPQB6bowvXp/V
   w==;
X-CSE-ConnectionGUID: 4j9vhQVrSXGurwt6qSU6aw==
X-CSE-MsgGUID: DNEKdh/XQjqmA5Fo+lH5/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83285053"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83285053"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:49:32 -0700
X-CSE-ConnectionGUID: xeE8/j/iRHiCS9pueVlIpw==
X-CSE-MsgGUID: hX0z2kupRC2bYH5f3R4Iqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="280804486"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 04:49:29 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wciaF-0000000047Z-2b4G;
	Thu, 25 Jun 2026 11:49:27 +0000
Date: Thu, 25 Jun 2026 19:47:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.3] BUILD SUCCESS
 8a564dfdfd88f1c5262ad1a4957310fe907650fc
Message-ID: <202606251920.ZSONWiyJ-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17287-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9C976C543E

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.3
branch HEAD: 8a564dfdfd88f1c5262ad1a4957310fe907650fc  cgroup: Fix a typo of the function name in comment

elapsed time: 853m

configs tested: 268
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260625    clang-23
arc                   randconfig-001-20260625    gcc-16.1.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260625    clang-23
arc                   randconfig-002-20260625    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                         nhk8815_defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260625    clang-23
arm                   randconfig-001-20260625    gcc-16.1.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260625    clang-23
arm                   randconfig-002-20260625    gcc-16.1.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260625    clang-23
arm                   randconfig-003-20260625    gcc-16.1.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260625    clang-23
arm                   randconfig-004-20260625    gcc-16.1.0
arm                        shmobile_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260625    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260625    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260625    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260625    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260625    clang-23
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260625    clang-23
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260625    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260625    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260625    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260625    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260625    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260625    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260625    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260625    gcc-14
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260625    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260625    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260625    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260625    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260625    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260625    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260625    clang-22
i386                  randconfig-011-20260625    clang-22
i386                  randconfig-012-20260625    clang-22
i386                  randconfig-013-20260625    clang-22
i386                  randconfig-014-20260625    clang-22
i386                  randconfig-015-20260625    clang-22
i386                  randconfig-016-20260625    clang-22
i386                  randconfig-017-20260625    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260625    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260625    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                         nettel_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                          ath25_defconfig    clang-23
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260625    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260625    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260625    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260625    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260625    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260625    gcc-13.4.0
powerpc                     tqm5200_defconfig    gcc-16.1.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260625    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260625    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260625    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260625    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260625    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260625    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260625    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260625    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260625    gcc-8.5.0
sparc                 randconfig-002-20260625    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260625    gcc-8.5.0
sparc64               randconfig-002-20260625    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260625    gcc-8.5.0
um                    randconfig-002-20260625    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260625    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260625    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260625    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260625    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260625    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260625    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260625    gcc-14
x86_64                randconfig-002-20260625    gcc-14
x86_64                randconfig-003-20260625    gcc-14
x86_64                randconfig-004-20260625    gcc-14
x86_64                randconfig-005-20260625    gcc-14
x86_64                randconfig-006-20260625    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260625    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260625    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260625    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260625    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260625    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260625    clang-22
x86_64                         randconfig-071    clang-22
x86_64                randconfig-071-20260625    clang-22
x86_64                         randconfig-072    clang-22
x86_64                randconfig-072-20260625    clang-22
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260625    clang-22
x86_64                         randconfig-074    clang-22
x86_64                randconfig-074-20260625    clang-22
x86_64                         randconfig-075    clang-22
x86_64                randconfig-075-20260625    clang-22
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260625    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260625    gcc-8.5.0
xtensa                randconfig-002-20260625    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

