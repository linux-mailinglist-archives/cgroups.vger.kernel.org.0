Return-Path: <cgroups+bounces-14685-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAp2DkAEq2nDZQEAu9opvQ
	(envelope-from <cgroups+bounces-14685-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 17:43:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834062254CE
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 17:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD623014BD4
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F01607A4;
	Fri,  6 Mar 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOpQPG59"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5F3ACF0C
	for <cgroups@vger.kernel.org>; Fri,  6 Mar 2026 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815284; cv=none; b=k1shV0KfEFSeU2/wrlFqP9QifwKMn+ZQaBFZCf6XlxvF60yjBFs30cafQqnh+I/vsf30/Lpdq2IHNhY4By5aY9BIlEUjvN5jqmss3AMmMn2VyJYt4hFirQRU4i19yxV5cFHFyJ8j1B5x1+8h7G2a1p9JHsyA2kudbjnAXcxlYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815284; c=relaxed/simple;
	bh=A8xC+8KCUaWziVjUgeA+oZQBDbIvtUL9Hfwg7ObTMQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pyLFFxVLE0Zw8klo8CpDuHkt6D0rlHg/ENcvd7kYn2kIm16/S1eYwuBIISFS0xyWBPi4hTQra6p6Fio3Jl4pL+Ieb5cCWaevpsDyY/WoB0CwQ1XPnqn3H+lB0XHs2IdOd/+tHneD4YNb4UZ1Qqhs1qkWPhOQ9rB7uPBIhGjrjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOpQPG59; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772815282; x=1804351282;
  h=date:from:to:cc:subject:message-id;
  bh=A8xC+8KCUaWziVjUgeA+oZQBDbIvtUL9Hfwg7ObTMQA=;
  b=NOpQPG598eTUQO9flksW52WS4DnRJiQyyKpcH54zq5yP9jUpG7btQaNL
   TjMPrGOKqKvOB4i2tnDWw4NISyIMDjAUtTnO27EJEH/Y5kchRBVaAn/jM
   0lZPdke6vH6MltqQuQ6EqLfgZmknJYNCii+hvKuMxIEWSEqvrbml+vcYa
   T6xUBYVJ25KndN49OMZMIjcjK/rLMkl/uj9ZtMj/E63dS3+nPj+L9XUl4
   BnTgMMQOQw/IJmGQxR9z3JH+wsaH1/oHBlS+msxi54/RGLbEmnX4518JR
   wyWPsJ115S0lZkrHibPWYm99qdVn7RV0Q0Kub31brcb7E9+2T6OCbq3+N
   w==;
X-CSE-ConnectionGUID: 0jKCE/OSTEu9UXnUj3tbBA==
X-CSE-MsgGUID: RyUOtQwqTSyHmm1H/i6D9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84251819"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="84251819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 08:41:19 -0800
X-CSE-ConnectionGUID: Z+zpfa1MQRG0Nlgux2ncBQ==
X-CSE-MsgGUID: dXkSWBVNShKUkf9w0Qff3A==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Mar 2026 08:41:17 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyYEk-0000000015Q-3910;
	Fri, 06 Mar 2026 16:41:14 +0000
Date: Sat, 07 Mar 2026 00:40:57 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 5b30afc20b3fea29b9beb83c6415c4ff06f774aa
Message-ID: <202603070050.z62ZrIaF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 834062254CE
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
	TAGGED_FROM(0.00)[bounces-14685-lists,cgroups=lfdr.de];
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 5b30afc20b3fea29b9beb83c6415c4ff06f774aa  cgroup: Expose some cgroup helpers

elapsed time: 726m

configs tested: 158
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260306    gcc-14.3.0
arc                   randconfig-002-20260306    gcc-14.3.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260306    gcc-14.3.0
arm                   randconfig-002-20260306    gcc-14.3.0
arm                   randconfig-003-20260306    gcc-14.3.0
arm                   randconfig-004-20260306    gcc-14.3.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260306    clang-23
hexagon               randconfig-002-20260306    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260306    gcc-14
i386        buildonly-randconfig-002-20260306    gcc-14
i386        buildonly-randconfig-003-20260306    gcc-14
i386        buildonly-randconfig-004-20260306    gcc-14
i386        buildonly-randconfig-005-20260306    gcc-14
i386        buildonly-randconfig-006-20260306    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260306    clang-20
i386                  randconfig-002-20260306    clang-20
i386                  randconfig-003-20260306    clang-20
i386                  randconfig-004-20260306    clang-20
i386                  randconfig-005-20260306    clang-20
i386                  randconfig-006-20260306    clang-20
i386                  randconfig-007-20260306    clang-20
i386                  randconfig-011-20260306    gcc-14
i386                  randconfig-012-20260306    gcc-14
i386                  randconfig-013-20260306    gcc-14
i386                  randconfig-014-20260306    gcc-14
i386                  randconfig-015-20260306    gcc-14
i386                  randconfig-016-20260306    gcc-14
i386                  randconfig-017-20260306    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260306    clang-23
loongarch             randconfig-002-20260306    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260306    clang-23
nios2                 randconfig-002-20260306    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260306    gcc-14.3.0
parisc                randconfig-002-20260306    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260306    gcc-14.3.0
powerpc               randconfig-002-20260306    gcc-14.3.0
powerpc64             randconfig-001-20260306    gcc-14.3.0
powerpc64             randconfig-002-20260306    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260306    clang-19
riscv                 randconfig-002-20260306    clang-19
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260306    clang-19
s390                  randconfig-002-20260306    clang-19
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260306    clang-19
sh                    randconfig-002-20260306    clang-19
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260306    gcc-9.5.0
sparc                 randconfig-002-20260306    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260306    gcc-9.5.0
sparc64               randconfig-002-20260306    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260306    gcc-9.5.0
um                    randconfig-002-20260306    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260306    clang-20
x86_64      buildonly-randconfig-002-20260306    clang-20
x86_64      buildonly-randconfig-003-20260306    clang-20
x86_64      buildonly-randconfig-004-20260306    clang-20
x86_64      buildonly-randconfig-005-20260306    clang-20
x86_64      buildonly-randconfig-006-20260306    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260306    gcc-14
x86_64                randconfig-002-20260306    gcc-14
x86_64                randconfig-003-20260306    gcc-14
x86_64                randconfig-004-20260306    gcc-14
x86_64                randconfig-005-20260306    gcc-14
x86_64                randconfig-006-20260306    gcc-14
x86_64                randconfig-011-20260306    gcc-14
x86_64                randconfig-012-20260306    gcc-14
x86_64                randconfig-013-20260306    gcc-14
x86_64                randconfig-014-20260306    gcc-14
x86_64                randconfig-015-20260306    gcc-14
x86_64                randconfig-016-20260306    gcc-14
x86_64                randconfig-071-20260306    gcc-14
x86_64                randconfig-072-20260306    gcc-14
x86_64                randconfig-073-20260306    gcc-14
x86_64                randconfig-074-20260306    gcc-14
x86_64                randconfig-075-20260306    gcc-14
x86_64                randconfig-076-20260306    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260306    gcc-9.5.0
xtensa                randconfig-002-20260306    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

