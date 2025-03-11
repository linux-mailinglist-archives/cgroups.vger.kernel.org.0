Return-Path: <cgroups+bounces-6993-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B9A5D358
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 00:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D383A9C6C
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 23:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC5233159;
	Tue, 11 Mar 2025 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv/edoJz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1C199FBA
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736840; cv=none; b=BSjI3GTg8kfonuiaGa+w45MbVlQj6s7vjFs2+Dpm+I3JOvyCeQEtC+8hpEucXpNrDjC390hlbE+dqDdK8B8Onono/tZhWh6GBgNiAe2QwyEm6JdBeINYzBu4OfM4dhNjn7NqDQXaYvUZnnFXhWkhfGggMbj8KIdV4FXfztFSxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736840; c=relaxed/simple;
	bh=Y6R5ochXZjO0aw+ypmRlwg4ApKaPVzeVljwxvwsY0gs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bSKCpisSv3NLP/Q7+1UJ+owt4ZSbhwJj/0IB0jHNE7pPA7nQ3fPiJuCklBu8YcRzGtgcYso97i8OxRxk3O7QhdmkKHtX5Ibsis9MvpPbhPS8duPLNIiKgQadMuJjrnUwafvNcpkFxWJQKJKRKbS+Bz5M+y0zEqTd89+MNrm9PEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv/edoJz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741736839; x=1773272839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y6R5ochXZjO0aw+ypmRlwg4ApKaPVzeVljwxvwsY0gs=;
  b=mv/edoJzr1FwtqwyvngpSrhMegsUUhQ5gLMchsl5S2eN3/D/rFxc6FyS
   baNKd+gKobH2ImOULszlUwcr9hcTzAcMgOuuC5O59yjFC3dNom/tTy5dL
   eYpB5phkXB2q7atP+qC7DlxAGqA485LUcysEDHvG/gqi+ch3Y+UO3H9Gy
   jCO4IX6TjSkSO3DYcuMAQ5KRiRK0S+BUTFnU+U97pXSErXC45Cvu4BrQr
   9Zjqlv7NP/O25Hn7Ha3nGNoadesr10siyoXZZivdFr9mv8NFvok0e3JpY
   RYo5zhOt1gSzyhU2lNtNhMgo+i6mfjAP8hrduNsfSVtEVzVjYd596RDDz
   A==;
X-CSE-ConnectionGUID: s/rMH+pyTnGT4fuoQoKuFw==
X-CSE-MsgGUID: 8zTOUCNaSCaoglK0Pe0XSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46711324"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="46711324"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 16:47:18 -0700
X-CSE-ConnectionGUID: fgIgXBXPQu6OLHRgtLP/eg==
X-CSE-MsgGUID: 9PDSeaBqQ/yJ4MIzewbUew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120174077"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 11 Mar 2025 16:47:16 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts9JX-0007xC-2R;
	Tue, 11 Mar 2025 23:47:12 +0000
Date: Wed, 12 Mar 2025 07:46:23 +0800
From: kernel test robot <lkp@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:tmp 13/16] include/asm-generic/rwonce.h:59:1: error:
 expected ';' before 'do'
Message-ID: <202503120719.47sOvfVx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tmp
head:   153926208f7777e220dec1156a44a5fa06623ac1
commit: c359863bfd828fd03999c17d9bad87e767708fa0 [13/16] mm: Add transformation message for per-memcg swappiness
config: sparc64-randconfig-002-20250312 (https://download.01.org/0day-ci/archive/20250312/202503120719.47sOvfVx-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120719.47sOvfVx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120719.47sOvfVx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/sparc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:339,
                    from include/asm-generic/bug.h:5,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from include/linux/cgroup.h:12,
                    from include/linux/memcontrol.h:13,
                    from mm/memcontrol-v1.c:3:
   mm/memcontrol-v1.c: In function 'mem_cgroup_swappiness_write':
>> include/asm-generic/rwonce.h:59:1: error: expected ';' before 'do'
      59 | do {                                                                    \
         | ^~
   mm/memcontrol-v1.c:1861:17: note: in expansion of macro 'WRITE_ONCE'
    1861 |                 WRITE_ONCE(memcg->swappiness, val);
         |                 ^~~~~~~~~~


vim +59 include/asm-generic/rwonce.h

e506ea451254ab1 Will Deacon 2019-10-15  57  
e506ea451254ab1 Will Deacon 2019-10-15  58  #define WRITE_ONCE(x, val)						\
e506ea451254ab1 Will Deacon 2019-10-15 @59  do {									\
e506ea451254ab1 Will Deacon 2019-10-15  60  	compiletime_assert_rwonce_type(x);				\
e506ea451254ab1 Will Deacon 2019-10-15  61  	__WRITE_ONCE(x, val);						\
e506ea451254ab1 Will Deacon 2019-10-15  62  } while (0)
e506ea451254ab1 Will Deacon 2019-10-15  63  

:::::: The code at line 59 was first introduced by commit
:::::: e506ea451254ab17e0bf918ca36232fec2a9b10c compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

