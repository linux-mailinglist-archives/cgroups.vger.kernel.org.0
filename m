Return-Path: <cgroups+bounces-14981-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMQ1HdSmv2nY7AMAu9opvQ
	(envelope-from <cgroups+bounces-14981-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 09:22:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 297722E89D7
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 09:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA2F30107F2
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7812E5B21;
	Sun, 22 Mar 2026 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntB5Xq7u"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58E221FBD
	for <cgroups@vger.kernel.org>; Sun, 22 Mar 2026 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774167750; cv=none; b=VgXdMXgDL4t4AaPSb7hTpaYmkcqiqHbllTDFLGHO5h5x3ZtyoNk9iVD049hqIpojqIWGccq4bw5zNYctFsoa/8zZ1/HJ+/feXDE1DmAkuOJcmQoVCXB2VYMXrCEAxjrlI9B+GNM1XhePMYCcU64jyA5S9qzDiGOKMCo1a/54r28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774167750; c=relaxed/simple;
	bh=xyJiKWxGx+bgkVtT8953BUczBoKahmlW6wZtYi9/hEQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RE1H8xHhFfuEWAsUp+tAhiH7DAjRO7ggx1BMkxnRBtw0XKNVIHDzmqmf66szxwkeAFw9B9dfl9h0tJUOKivdBdxrPjioPKkyDovWk5WuDFFGYrtbwookJk1ZfplJaqqmytRTI4DpfjBur4Y5BbgSMvDLMsTEbz+PcEReSm96uD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntB5Xq7u; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774167749; x=1805703749;
  h=date:from:to:cc:subject:message-id;
  bh=xyJiKWxGx+bgkVtT8953BUczBoKahmlW6wZtYi9/hEQ=;
  b=ntB5Xq7uDOX3sU1XziwMARq+RdHesaiH4DKT/cdzdUIildo87RooXJri
   UGptW00KKni7g7GU4AGPh1MDzhpwEgLkrnn6xWIyChLH+uiDupBOIqwld
   hm+f3GZyOUTprmQJpXtirwVVyHLRRhonjZTJziQI7bTYnQiwZdL6yOBRW
   R3Aatq2giFE5CJ55Cj1PKJyrnSzUO3WWLTgVp6R8BQtCMTtNurCXyZGh3
   U8Oh0PsNiTuvy6zl4bsiYMYDcVJW8mzwl8bQLmO9pLkhK62UbKQPXXOSU
   UvXaI1VR+hcfKdt2XaJaA4CeotH/pETPkn33Mj3jaxxKZRC6S5LptiY6e
   g==;
X-CSE-ConnectionGUID: AlQ5LvByRnqN33SldRvWQg==
X-CSE-MsgGUID: hRQ4GS3xTWSVPXIEGwonDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="79106262"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="79106262"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 01:22:19 -0700
X-CSE-ConnectionGUID: FSl6aAsVRw2D1j+u3NQ7MA==
X-CSE-MsgGUID: UK4kr6UYRTigcUUA8Dg3ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="228655611"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 22 Mar 2026 01:22:17 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4E4U-000000001rN-2Mfa;
	Sun, 22 Mar 2026 08:22:08 +0000
Date: Sun, 22 Mar 2026 16:21:01 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.1] BUILD SUCCESS
 6675af9c1a3251ff95ef1290f9317ba0e83ce99d
Message-ID: <202603221655.7AzhQzEW-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-14981-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 297722E89D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.1
branch HEAD: 6675af9c1a3251ff95ef1290f9317ba0e83ce99d  cgroup/dmem: remove region parameter from dmemcg_parse_limit

elapsed time: 752m

configs tested: 190
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
arc                   randconfig-001-20260322    gcc-14.3.0
arc                   randconfig-002-20260322    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260322    gcc-14.3.0
arm                   randconfig-002-20260322    gcc-14.3.0
arm                   randconfig-003-20260322    gcc-14.3.0
arm                   randconfig-004-20260322    gcc-14.3.0
arm                           sama5_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260322    gcc-11.5.0
arm64                 randconfig-002-20260322    gcc-11.5.0
arm64                 randconfig-003-20260322    gcc-11.5.0
arm64                 randconfig-004-20260322    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260322    gcc-11.5.0
csky                  randconfig-002-20260322    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260322    gcc-11.5.0
hexagon               randconfig-002-20260322    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260322    clang-20
i386        buildonly-randconfig-002-20260322    clang-20
i386        buildonly-randconfig-003-20260322    clang-20
i386        buildonly-randconfig-004-20260322    clang-20
i386        buildonly-randconfig-005-20260322    clang-20
i386        buildonly-randconfig-006-20260322    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260322    gcc-14
i386                  randconfig-002-20260322    gcc-14
i386                  randconfig-003-20260322    gcc-14
i386                  randconfig-004-20260322    gcc-14
i386                  randconfig-005-20260322    gcc-14
i386                  randconfig-006-20260322    gcc-14
i386                  randconfig-007-20260322    gcc-14
i386                  randconfig-011-20260322    gcc-13
i386                  randconfig-012-20260322    gcc-13
i386                  randconfig-013-20260322    gcc-13
i386                  randconfig-014-20260322    gcc-13
i386                  randconfig-015-20260322    gcc-13
i386                  randconfig-016-20260322    gcc-13
i386                  randconfig-017-20260322    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    clang-23
loongarch             randconfig-001-20260322    gcc-11.5.0
loongarch             randconfig-002-20260322    gcc-11.5.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260322    gcc-11.5.0
nios2                 randconfig-002-20260322    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260322    clang-23
parisc                randconfig-002-20260322    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260322    clang-23
powerpc               randconfig-002-20260322    clang-23
powerpc64             randconfig-001-20260322    clang-23
powerpc64             randconfig-002-20260322    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260322    gcc-12.5.0
riscv                 randconfig-002-20260322    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260322    gcc-12.5.0
s390                  randconfig-002-20260322    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260322    gcc-12.5.0
sh                    randconfig-002-20260322    gcc-12.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260322    gcc-14
sparc                 randconfig-002-20260322    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260322    gcc-14
sparc64               randconfig-002-20260322    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260322    gcc-14
um                    randconfig-002-20260322    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260322    clang-20
x86_64      buildonly-randconfig-002-20260322    clang-20
x86_64      buildonly-randconfig-003-20260322    clang-20
x86_64      buildonly-randconfig-004-20260322    clang-20
x86_64      buildonly-randconfig-005-20260322    clang-20
x86_64      buildonly-randconfig-006-20260322    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260322    clang-20
x86_64                randconfig-002-20260322    clang-20
x86_64                randconfig-003-20260322    clang-20
x86_64                randconfig-004-20260322    clang-20
x86_64                randconfig-005-20260322    clang-20
x86_64                randconfig-006-20260322    clang-20
x86_64                randconfig-011-20260322    gcc-14
x86_64                randconfig-012-20260322    gcc-14
x86_64                randconfig-013-20260322    gcc-14
x86_64                randconfig-014-20260322    gcc-14
x86_64                randconfig-015-20260322    gcc-14
x86_64                randconfig-016-20260322    gcc-14
x86_64                randconfig-071-20260322    gcc-14
x86_64                randconfig-072-20260322    gcc-14
x86_64                randconfig-073-20260322    gcc-14
x86_64                randconfig-074-20260322    gcc-14
x86_64                randconfig-075-20260322    gcc-14
x86_64                randconfig-076-20260322    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260322    gcc-14
xtensa                randconfig-002-20260322    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

