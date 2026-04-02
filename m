Return-Path: <cgroups+bounces-15163-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDtJNlEazml7lAYAu9opvQ
	(envelope-from <cgroups+bounces-15163-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 09:27:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B938526F
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 09:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C92DF30409AE
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA293387341;
	Thu,  2 Apr 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9pVp1Oz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970931F9B8
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114101; cv=none; b=p1aM+bt/FialSNRb6UmN3xmDchYI2pz747Fk2GIYpalaxcbbCSi8li8r4D2zt2bJbaiDdaIOGmpMd9OOJD7ylqN6D+jMqtaInkucQYjENhOrqjdtDI3PqVewl23JdbS6Zl7qNxB1hp/wAH/GSSeHQf5ENF0BrNQaG0i477YhB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114101; c=relaxed/simple;
	bh=Zz3QFolsBooTwj9/JGKVIxrmSpQaLZ/wWH76gYcnY2I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XkfjX52pyyYFlKk9O4Dc6GAuKYRHhDs6U9wtWDsU9+k+pWMotVAUCk3f7Zb8lyd2VcTzcrYgfmpxOj8y+qlA1SnevfB9J7nQLBn7lrGNsNHKid1dNrKg/3eWoRjB7s9Zre+GBkMPgIbYGG3xQhknPZ1zAgcPf085yHSflqyL/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9pVp1Oz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775114100; x=1806650100;
  h=date:from:to:cc:subject:message-id;
  bh=Zz3QFolsBooTwj9/JGKVIxrmSpQaLZ/wWH76gYcnY2I=;
  b=Q9pVp1OzIJGCC4qJd65OP+V6z2tFmNVY9fNvz+Kw5gd9mmacdCA9x/Yk
   ZxIXq8r2C7jkE4tuVuoW1rn4Ogzj7O/WjyhBYruOPkNSyHEff8INqSHU6
   YEh41BPj47IlcrMrSSemAtWM2Wtw1c/TX0zIsl4BLI6FW9A8fw9urAFK8
   vjDDi84FzbNVDjtCcxNDIvIVk2idvAyibvFHDcpJ0gbg0meXYnbg5p3SR
   kFkCRdCpuN3nzsIs0Ddf3rdo/56gDG4PWmJzgiQXUfseEmFpOUdK93MF7
   Z5Xjbk5RdHfGdnJfu3faqKnLF1RaRnQBRrH+uPgCyn1QMpuPhBIs7/1oV
   g==;
X-CSE-ConnectionGUID: cnJo3RVkSIWoIue4XffWjQ==
X-CSE-MsgGUID: D/JAZUGCRRSHGG4rRwRcZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75204307"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75204307"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:14:59 -0700
X-CSE-ConnectionGUID: m7xpED9fS9GRXb3ZXdk18A==
X-CSE-MsgGUID: AuR8z7o/QOC43y0lgX1Ihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231850113"
Received: from lkp-server02.sh.intel.com (HELO cedfeeed6c12) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:14:57 -0700
Received: from kbuild by cedfeeed6c12 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8CGU-000000000Z4-460H;
	Thu, 02 Apr 2026 07:14:54 +0000
Date: Thu, 02 Apr 2026 10:01:42 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 72156392efe9c6f7e7d801a66757af90d60240a1
Message-ID: <202604021036.fOlHbfll-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15163-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53B938526F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 72156392efe9c6f7e7d801a66757af90d60240a1  Merge branch 'for-7.0-fixes' into for-next

elapsed time: 1533m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                   randconfig-001-20260401    clang-23
arc                   randconfig-002-20260401    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-004-20260401    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    gcc-15.2.0
arm64                 randconfig-002-20260401    gcc-15.2.0
arm64                 randconfig-003-20260401    gcc-15.2.0
arm64                 randconfig-004-20260401    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-15.2.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260401    gcc-15.2.0
hexagon               randconfig-002-20260401    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-002-20260401    gcc-14
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-006-20260401    gcc-14
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-002-20260401    gcc-14
i386                  randconfig-003-20260401    gcc-14
i386                  randconfig-004-20260401    gcc-14
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    clang-20
i386                  randconfig-017-20260401    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260401    gcc-15.2.0
nios2                 randconfig-002-20260401    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                           allnoconfig    clang-23
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-002-20260401    gcc-8.5.0
powerpc64             randconfig-001-20260401    gcc-8.5.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260401    gcc-9.5.0
riscv                 randconfig-002-20260401    gcc-9.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-002-20260401    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260401    gcc-9.5.0
sh                    randconfig-002-20260401    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260401    clang-16
sparc                 randconfig-002-20260401    clang-16
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260401    clang-16
sparc64               randconfig-002-20260401    clang-16
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260401    clang-16
um                    randconfig-002-20260401    clang-16
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260401    gcc-12
x86_64      buildonly-randconfig-002-20260401    gcc-12
x86_64      buildonly-randconfig-003-20260401    gcc-12
x86_64      buildonly-randconfig-004-20260401    gcc-12
x86_64      buildonly-randconfig-005-20260401    gcc-12
x86_64      buildonly-randconfig-006-20260401    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260401    clang-20
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-003-20260401    clang-20
x86_64                randconfig-004-20260401    clang-20
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-014-20260401    gcc-14
x86_64                randconfig-015-20260401    gcc-14
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-072-20260401    gcc-14
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-075-20260401    gcc-14
x86_64                randconfig-076-20260401    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260401    clang-16
xtensa                randconfig-002-20260401    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

