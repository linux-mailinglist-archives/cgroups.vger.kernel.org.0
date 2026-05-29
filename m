Return-Path: <cgroups+bounces-16413-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA9IAn03GWrzswgAu9opvQ
	(envelope-from <cgroups+bounces-16413-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 08:51:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 004185FE2F0
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 08:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80A62304EC28
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899413AC0FC;
	Fri, 29 May 2026 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE4JeyCu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D40329E79;
	Fri, 29 May 2026 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037332; cv=none; b=rOFyHvoV31Z7VHI2KnutxUgR3e26EsFHLQTU2zOs9Els18GGjpjqYzWSqeifbQ4BmmCfaFtRkDsuNQiAqSWUYZn3ztkA1sajocehR4+e/8d94sZJK5ztM0N6s9Ayl0ozYoYri6EFw6D8yZbptwVh1G1J8Vtyujm1c3VCFLQgKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037332; c=relaxed/simple;
	bh=QCcYSlDs2edHMkTkgzHoNlccYhjpsFhCqp7gDvxMZAw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AcDAI0aQM02aCkDQmJd2u40pYuBMYd5o2aRKLu9UULJpUM/eEF/rf0xfmimye0lfj6ZOhqC65vrm9876DSws8E5Qai0cSHm2VKnnFzrFKlC3iipDpg7MAia/AgBJ6b9azhMkE8J1lIwMr1Nbc8XABeFDC1Ea6x4rpQVJ6uCoG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE4JeyCu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780037331; x=1811573331;
  h=date:from:to:cc:subject:message-id;
  bh=QCcYSlDs2edHMkTkgzHoNlccYhjpsFhCqp7gDvxMZAw=;
  b=jE4JeyCuJSzM6cCigeIyHcR/xUWzDbv49dZ0nAg+tjVehfLQHTXpZYae
   7+wzLdXLdr1p0hpFrITL8ixYWZdlKykwQ8C6OPP77Q2ELa+u7GMzIhlqh
   3lAjNFhEkLoHH+NSdTX7jiCjANVprFYFm+LceojBY4uaXBzV0R8/rZXx3
   n1T9oGQhkCYb8kUo+5hmmEZntQLivH3avpRtDItSVdrtaEBQHmbMcquMi
   WVXd3rmscw5s2tJ6s0wbOOl99exAXP+LW/0LPXIH533fU3Ckqm5j+7z2U
   Lu6egH0v8t+Q9gV+Ik+MZEaVP+E5g+bRcDMxTLu3PM9rTkSKbcV+duAnN
   A==;
X-CSE-ConnectionGUID: lfXFN682Rt+Cl03M/YQRhw==
X-CSE-MsgGUID: 5P27J2FzRleLqE3ZglS54w==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84511731"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="84511731"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:48:50 -0700
X-CSE-ConnectionGUID: l+MX/Lq1QZ2yKqNjfMTvfQ==
X-CSE-MsgGUID: utlMrY4/QJyJJQH7e33U1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="236415580"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 May 2026 23:48:47 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSr1Q-000000006rO-1JFF;
	Fri, 29 May 2026 06:48:44 +0000
Date: Fri, 29 May 2026 14:48:19 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 cgroups@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD REGRESSION
 f7af91adc230aa99e23330ecf85bc9badd9780ad
Message-ID: <202605291459.sRvqvCtT-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16413-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:mid,intel.com:dkim,final.cc:url]
X-Rspamd-Queue-Id: 004185FE2F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: f7af91adc230aa99e23330ecf85bc9badd9780ad  Add linux-next specific files for 20260528

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202605290432.Pyzd4kuW-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202605291041.seNEWvLQ-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202605291334.abNeADbG-lkp@intel.com

    drivers/net/arcnet/com20020-pci.c:225:52: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
    mm/memcontrol-v1.c:651:31: error: implicit declaration of function 'swp_cluster_offset' [-Wimplicit-function-declaration]
    samples/rust/rust_driver_auxiliary.o: warning: objtool: _RINvXs5_NtNtCshc5sK6KjdJJ_6kernel5alloc4kboxINtB6_3BoxINtNtNtCsbsbRiabPlh9_4core3mem12maybe_uninit11MaybeUninitINtNtBa_9auxiliary16RegistrationDataNtCseULRbgTYaTO_21rust_driver_auxiliary4DataEENtNtB8_9allocator7KmallocEINtCs57PXBekmiam_8pin_init12InPlaceWriteB1L_E14write_pin_initNtNtBa_5error5ErrorINtNtB3y_10___internal11InitClosureNCINvYIBH_B1L_B35_EINtNtBa_4init11InPlaceInitB1L_E8pin_initB4u_IB4O_NCINvMsc_B1O_INtB1O_12RegistrationB2l_E3newNtNtBX_7convert10InfallibleB2l_Es_0B1L_B4u_EE0B1L_B4u_EEB2n_: symbol name too long, can't create __pfx_ symbol

Unverified Error/Warning (likely false positive, kindly check if interested):

    block/partitions/ldm.c:1487:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/base/bus.c:801:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/dpll/dpll_core.c:238:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/hwtracing/intel_th/msu.c:1277:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/infiniband/hw/mthca/mthca_memfree.c:220:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/media/common/siano/smscoreapi.c:744:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/misc/eeprom/at25.c:466:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/pinctrl/core.c:2168:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/regulator/core.c:6262:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/staging/greybus/uart.c:917:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/usb/core/../misc/onboard_usb_dev_pdevs.c:124:1: internal compiler error: in final_scan_insn_1, at final.c:3073
    drivers/usb/dwc3/gadget.c:3474:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/jfs/jfs_logmgr.c:1417:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/notify/fanotify/fanotify_user.c:1746:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/ntfs/super.c:2537:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    net/rxrpc/sendmsg.c:497:1: internal compiler error: in final_scan_insn_1, at final.cc:2813

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-randconfig-r072-20260529
|   `-- drivers-net-arcnet-com20020-pci.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|-- csky-randconfig-001-20260529
|   |-- drivers-base-bus.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-misc-eeprom-at25.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-pinctrl-core.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-regulator-core.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-staging-greybus-uart.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-usb-dwc3-gadget.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-jfs-jfs_logmgr.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   `-- fs-notify-fanotify-fanotify_user.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- csky-randconfig-002
|   `-- drivers-usb-core-..-misc-onboard_usb_dev_pdevs.c:internal-compiler-error:in-final_scan_insn_1-at-final.c
|-- csky-randconfig-r112-20260528
|   |-- block-partitions-ldm.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-dpll-dpll_core.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-media-common-siano-smscoreapi.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   `-- fs-ntfs-super.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- csky-randconfig-r122-20260528
|   |-- drivers-hwtracing-intel_th-msu.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-infiniband-hw-mthca-mthca_memfree.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   `-- net-rxrpc-sendmsg.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- sh-allyesconfig
|   `-- mm-memcontrol-v1.c:error:implicit-declaration-of-function-swp_cluster_offset
`-- x86_64-randconfig-004-20260529
    `-- samples-rust-rust_driver_auxiliary.o:warning:objtool:_RINvXs5_NtNtCshc5sK6KjdJJ_6kernel5alloc4kboxINtB6_3BoxINtNtNtCsbsbRiabPlh9_4core3mem12maybe_uninit11MaybeUninitINtNtBa_9auxiliary16RegistrationDat

elapsed time: 753m

configs tested: 178
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260529    gcc-14.3.0
arc                   randconfig-002-20260529    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260529    gcc-14.3.0
arm                   randconfig-002-20260529    gcc-8.5.0
arm                   randconfig-003-20260529    gcc-13.4.0
arm                   randconfig-004-20260529    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260529    gcc-8.5.0
arm64                 randconfig-002-20260529    clang-23
arm64                 randconfig-003-20260529    clang-23
arm64                 randconfig-004-20260529    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260529    gcc-15.2.0
csky                  randconfig-002-20260529    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260529    clang-23
hexagon               randconfig-002-20260529    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260529    gcc-12
i386        buildonly-randconfig-002-20260529    clang-20
i386        buildonly-randconfig-003-20260529    gcc-12
i386        buildonly-randconfig-004-20260529    gcc-14
i386        buildonly-randconfig-005-20260529    gcc-14
i386        buildonly-randconfig-006-20260529    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260529    gcc-14
i386                  randconfig-002-20260529    gcc-12
i386                  randconfig-003-20260529    clang-20
i386                  randconfig-004-20260529    clang-20
i386                  randconfig-005-20260529    gcc-14
i386                  randconfig-006-20260529    clang-20
i386                  randconfig-007-20260529    gcc-12
i386                  randconfig-011-20260529    clang-20
i386                  randconfig-012-20260529    clang-20
i386                  randconfig-013-20260529    clang-20
i386                  randconfig-014-20260529    clang-20
i386                  randconfig-015-20260529    gcc-14
i386                  randconfig-016-20260529    clang-20
i386                  randconfig-017-20260529    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260529    gcc-15.2.0
loongarch             randconfig-002-20260529    gcc-15.2.0
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
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260529    gcc-8.5.0
nios2                 randconfig-002-20260529    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260529    gcc-8.5.0
parisc                randconfig-002-20260529    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260529    gcc-12.5.0
powerpc               randconfig-002-20260529    clang-19
powerpc64             randconfig-001-20260529    gcc-15.2.0
powerpc64             randconfig-002-20260529    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260529    gcc-8.5.0
riscv                 randconfig-002-20260529    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260529    gcc-8.5.0
s390                  randconfig-002-20260529    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260529    gcc-15.2.0
sh                    randconfig-002-20260529    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260529    gcc-8.5.0
sparc                 randconfig-002-20260529    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260529    gcc-11.5.0
sparc64               randconfig-002-20260529    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260529    gcc-14
um                    randconfig-002-20260529    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260529    gcc-14
x86_64      buildonly-randconfig-002-20260529    gcc-14
x86_64      buildonly-randconfig-003-20260529    gcc-14
x86_64      buildonly-randconfig-004-20260529    clang-20
x86_64      buildonly-randconfig-004-20260529    gcc-14
x86_64      buildonly-randconfig-005-20260529    clang-20
x86_64      buildonly-randconfig-005-20260529    gcc-14
x86_64      buildonly-randconfig-006-20260529    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260529    gcc-14
x86_64                randconfig-002-20260529    clang-20
x86_64                randconfig-003-20260529    gcc-14
x86_64                randconfig-004-20260529    clang-20
x86_64                randconfig-005-20260529    clang-20
x86_64                randconfig-006-20260529    clang-20
x86_64                randconfig-011-20260529    gcc-14
x86_64                randconfig-012-20260529    gcc-14
x86_64                randconfig-013-20260529    clang-20
x86_64                randconfig-014-20260529    clang-20
x86_64                randconfig-015-20260529    gcc-14
x86_64                randconfig-016-20260529    clang-20
x86_64                randconfig-071-20260529    gcc-14
x86_64                randconfig-072-20260529    clang-20
x86_64                randconfig-073-20260529    clang-20
x86_64                randconfig-074-20260529    gcc-14
x86_64                randconfig-075-20260529    gcc-14
x86_64                randconfig-076-20260529    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260529    gcc-11.5.0
xtensa                randconfig-002-20260529    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

