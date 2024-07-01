Return-Path: <cgroups+bounces-3463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A028D91D5FA
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 04:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A8B1F21896
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908918BF7;
	Mon,  1 Jul 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEP1AA4L"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403E2C6A3
	for <cgroups@vger.kernel.org>; Mon,  1 Jul 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719800005; cv=none; b=nhDtf0Yvo/ZEk4fFwHQFLRn1jes5pHO2t8jOptn2TQ6rpe0wQpzv8UJc9+Whn4/BltO5ZQU7fn7mzxJdXNnB8LtNk6sYueRE31AZGreCW/9SjrFV/OMcQMESgCeTLGHvUtCuXgSD+XuQBy5UFdeHtL52vcuOHxY0g9pkoNkAKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719800005; c=relaxed/simple;
	bh=GXP2FjIPhVlz4wdt4jGz7dhIZ7zZoLDFG0JaHGfd77I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O/zwE5M+z51oi1W6BP/r+8oPsbTbjUeYbHo6G11Aoj4Q+OAdJWqeQpwxYFPSnl3MRFwNIY4aiF30e25ALVh/2DUxHMZpGyamAqCVH+0gVofZj8dhAjPBiH7sbcEGpB1mP6eGzjN4A2NUnOZ07Jp0OmHRRDUxrLQfz2vSlItSmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEP1AA4L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719800003; x=1751336003;
  h=date:from:to:cc:subject:message-id;
  bh=GXP2FjIPhVlz4wdt4jGz7dhIZ7zZoLDFG0JaHGfd77I=;
  b=EEP1AA4Lp7tG17lBkujURKV5Ogl58X8Q7uFvOWorYO29lrFuGQzKakFZ
   xXvgFYYuJOd10b8OArNu47Bc9rnkqdUP7J/AzWDXyenXfSn/9yGvY4C2d
   VqUdQj0VZ2xdYAwL3xfRxf0SPe4dEfZ7kxndOWErVVKA4ApBmlm4YwtIr
   7B7h2hAoUpcBHWj+3fUGryfNTLDUZfbFCP7Ba2hm+7dyDNk7Tqglqgz3h
   m9QRChb3hvzUjbpviq3UcOc2IKhPJbO/aRXoq7HxYGf9V3yNaXShUJhZ+
   O0TBdYXmxlPlsEUpCY3j0sE0VCOAD7qtEW7TB6TuPegMhAbP8232ELPjH
   Q==;
X-CSE-ConnectionGUID: bmZ3X6gCS+mHpkUN/v0ySw==
X-CSE-MsgGUID: Zj4JnRJPSl2simNPhCQ2ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="20773171"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="20773171"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 19:13:22 -0700
X-CSE-ConnectionGUID: U6V833naTqCOuhCt7NalBQ==
X-CSE-MsgGUID: rlJay6FnT9KU2EJr9LCLNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="50239258"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Jun 2024 19:13:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sO6Xf-000MJs-0k;
	Mon, 01 Jul 2024 02:13:19 +0000
Date: Mon, 01 Jul 2024 10:12:54 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 147b4f64b42f7709995c039703049ff9aea015e9
Message-ID: <202407011052.fRStDeI9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 147b4f64b42f7709995c039703049ff9aea015e9  Merge branch 'for-6.10-fixes' into for-next

elapsed time: 3384m

configs tested: 65
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240701   gcc-13.2.0
arc                   randconfig-002-20240701   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240701   gcc-13.2.0
arm                   randconfig-002-20240701   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
x86_64                                  kexec   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

