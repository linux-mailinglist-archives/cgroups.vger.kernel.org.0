Return-Path: <cgroups+bounces-16750-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aGWYD4GBJ2peyQIAu9opvQ
	(envelope-from <cgroups+bounces-16750-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 04:59:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7165BED9
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 04:59:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=N2p5iG8S;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16750-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16750-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B117C306519E
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980B3603D3;
	Tue,  9 Jun 2026 02:59:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64782F7F0C
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 02:59:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780973949; cv=none; b=YQkJA+u4EAdGNbFi2GndGwfApMsAWFGDN8hXcx60r1q4SiQS9i+2VJezE4D/yyzWKUTVXBm67JIcqCcjRs8dV8XALFOqlP2LE1ZkcFD2PmICdH/Hi2W9EtKYkmqtTvcfL5G70WCs0nSXnVYgwJ0GUqSD9sZoNd8USccwyeDzDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780973949; c=relaxed/simple;
	bh=VDoSfHAmsuQiVN0285M6sKin2+Jfn5jHlFcoZMY1hIE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FQS8/TdtEE2qaz2o8jHOJP/90xTPzOH7SpUT6YTLxKmJq5NuUY1zbqacMapgKLB0g+ikJ0BPNYpHk54pp96EM0Cmme5sHmZoTz5XTu6HqFuoO4pjmi5AOHK+yhIu66JG9SeVBF2FGTFYIoAbtlq4U+unv4Jq8JczvGapODpqZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2p5iG8S; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780973947; x=1812509947;
  h=date:from:to:cc:subject:message-id;
  bh=VDoSfHAmsuQiVN0285M6sKin2+Jfn5jHlFcoZMY1hIE=;
  b=N2p5iG8SB6iAEElD4BMpnvB1zSKUCy1k4II+cjksUNk6/9aoNVgUH92X
   V/wpuCHw0Y6jK7XI1z5ooDCHDOrxlHPrU0bDJ0hf6w7FwX2oW2W43KGA0
   mgpryvUEyg/qdvtuspqeslME+/+OFCmA/lR8MxCavP6D4IbiZOgedslIr
   u+rLN4JGh7xnVRlgR1qkKTfWCea4sgPqAKNfy6xWfes+hLvK6xd63azxw
   JAxOlK47yR1xD6tzT/fZsZuzStsV+UGZ1UqUk7wt0tY6pzt+Ft13Yy+uB
   MJAO6rZuPrY8kR/vg0SLDvm5quoaIDCB5qG4CNxhGZJl8WbIRnwFtNTI6
   w==;
X-CSE-ConnectionGUID: +eJq9ejXSIyrlHBdRqLkqQ==
X-CSE-MsgGUID: LWLwIfYzRz6KV5Pfj5e1CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="107162758"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="107162758"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 19:59:06 -0700
X-CSE-ConnectionGUID: uTGXtqz5Ql6ylFbrbSpYIg==
X-CSE-MsgGUID: BUsqPWsbTLKfkwkL0XG/QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="244593021"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Jun 2026 19:59:05 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wWmgA-00000000JXs-0kiv;
	Tue, 09 Jun 2026 02:59:02 +0000
Date: Tue, 09 Jun 2026 10:58:49 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-7.1-fixes] BUILD SUCCESS
 57aff991119693e09b414aff3267c0eae5e81da0
Message-ID: <202606091041.wfl0CpU2-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16750-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2F7165BED9

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-7.1-fixes
branch HEAD: 57aff991119693e09b414aff3267c0eae5e81da0  cgroup/cpuset: Change Ridong's email

elapsed time: 8965m

configs tested: 66
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                     allnoconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-16.1.0
arm64                  allmodconfig    clang-23
arm64                   allnoconfig    gcc-16.1.0
csky                   allmodconfig    gcc-16.1.0
csky                    allnoconfig    gcc-16.1.0
csky        randconfig-001-20260609    gcc-9.5.0
csky        randconfig-002-20260609    gcc-11.5.0
hexagon                allmodconfig    clang-23
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-20
m68k                   allmodconfig    gcc-16.1.0
m68k                    allnoconfig    gcc-16.1.0
m68k                   allyesconfig    gcc-16.1.0
microblaze              allnoconfig    gcc-16.1.0
microblaze             allyesconfig    gcc-16.1.0
mips                   allmodconfig    gcc-16.1.0
mips                    allnoconfig    gcc-16.1.0
mips                   allyesconfig    gcc-16.1.0
mips                 jazz_defconfig    clang-23
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-16.1.0
openrisc                allnoconfig    gcc-16.1.0
openrisc                  defconfig    gcc-16.1.0
parisc                 allmodconfig    gcc-16.1.0
parisc                  allnoconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
powerpc                allmodconfig    gcc-16.1.0
powerpc                 allnoconfig    gcc-16.1.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-16.1.0
riscv                  allyesconfig    clang-23
riscv                     defconfig    clang-23
s390                   allmodconfig    clang-23
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-16.1.0
s390                      defconfig    clang-18
s390        randconfig-002-20260609    gcc-16.1.0
sh                     allmodconfig    gcc-16.1.0
sh                      allnoconfig    gcc-16.1.0
sh                     allyesconfig    gcc-16.1.0
sh          randconfig-001-20260609    gcc-13.4.0
sh          randconfig-002-20260609    gcc-11.5.0
sparc                   allnoconfig    gcc-16.1.0
sparc                     defconfig    gcc-16.1.0
sparc64                allmodconfig    clang-20
um                     allmodconfig    clang-23
um                      allnoconfig    clang-16
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-22
x86_64                  allnoconfig    clang-22
x86_64                 allyesconfig    clang-22
x86_64                rhel-9.4-rust    clang-22
xtensa                  allnoconfig    gcc-16.1.0
xtensa                 allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

