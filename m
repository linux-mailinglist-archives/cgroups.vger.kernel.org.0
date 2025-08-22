Return-Path: <cgroups+bounces-9341-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED0B32525
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 00:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D90B63885
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79F2C029C;
	Fri, 22 Aug 2025 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqvoyGx4"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3D293B73
	for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902719; cv=none; b=CfOU5gED5/GL0x1nnsCLtPFm1V7xPw6KWxh01loKuybiXQmDJ+sVE7ReCmNaKe/AAZX7NB1W6/BXnUGn1wZP3m3CNwlBwyvAFzYOyCheF/yVSUxRTvJyTVmeamxAupSqUSGcgpJfn0Rm3sYrTpQwFycoP2Ko0noo0BODSu8ypvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902719; c=relaxed/simple;
	bh=7XUqMfThaX0PghlRgyzp+9hdRZanOKtTrNSrMlwidTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lH/frNcLX16caY/HTtvYl+w+bT9cOfvENAPhm3HM6R45SqlowrZyPKWrY3G2VfHtVQzXH0RnxkY1o5RIAo0PWmElFPo5KnyjVQDRB88YLmfsixF4CW6cpMJ529mCjZ/xG/amEY2Hrbgo1fdqKb0qWcXXHZHmr/KwLJJpG1e9r14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqvoyGx4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902719; x=1787438719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7XUqMfThaX0PghlRgyzp+9hdRZanOKtTrNSrMlwidTQ=;
  b=RqvoyGx4ZEODkAHH+FUeoCyZfPqoZ9KsAtgFQlcq22M0DZUx3Y9cgs4d
   LshnyVsWLGpl1W93O3GcusNTSAtaVKjmtxsLVSLvucI3xEfWUCIjcVKT4
   Kx4wjPYuh5oUB9cDaobfeikD6sEU5J0/UbLPeyxcJDqsUhWZk/K4Vu1aM
   8btOmpXtYGvhSeLbLZI9Vu74lrJjP4908QLBPk0XdkWxPnTxRbITZDH7b
   D4XXvIFd1HdjEQPEwosVnBDt4QuSfD+IE5+CLtXZTZ/z5PgmXmbM9JH7d
   fplqZcpggRBshOUVkMKZ0+cOlmDTLLk/z8MUIZysagvVcWYGQENvZRudM
   Q==;
X-CSE-ConnectionGUID: OQQ0XIhZQ2mY3nMnFV/Zkw==
X-CSE-MsgGUID: tHb30woeT/yBTEi5oCm3Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80813621"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="80813621"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:45:18 -0700
X-CSE-ConnectionGUID: TikXTbHQRcaNHvdMiQD58Q==
X-CSE-MsgGUID: g87Ng2GTR/qQQxMTCmGc6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173005516"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Aug 2025 15:45:17 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upaVW-000Lth-2J;
	Fri, 22 Aug 2025 22:45:14 +0000
Date: Sat, 23 Aug 2025 06:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:for-6.18 7/8] kernel/cgroup/cgroup.c:3781:undefined
 reference to `__aeabi_uldivmod'
Message-ID: <202508230604.KyvqOy81-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
head:   7b281a4582c4408add22cc99f221886b50dd0548
commit: afa3701c0e45ecb9e4d160048ca4e353c7489948 [7/8] cgroup: cgroup.stat.local time accounting
config: arm-randconfig-002-20250823 (https://download.01.org/0day-ci/archive/20250823/202508230604.KyvqOy81-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508230604.KyvqOy81-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508230604.KyvqOy81-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/cgroup/cgroup.o: in function `cgroup_core_local_stat_show':
>> kernel/cgroup/cgroup.c:3781:(.text+0x28f4): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: (__aeabi_uldivmod): Unknown destination type (ARM/Thumb) in kernel/cgroup/cgroup.o
>> kernel/cgroup/cgroup.c:3781:(.text+0x28f4): dangerous relocation: unsupported relocation


vim +3781 kernel/cgroup/cgroup.c

  3765	
  3766	static int cgroup_core_local_stat_show(struct seq_file *seq, void *v)
  3767	{
  3768		struct cgroup *cgrp = seq_css(seq)->cgroup;
  3769		unsigned int sequence;
  3770		u64 freeze_time;
  3771	
  3772		do {
  3773			sequence = read_seqcount_begin(&cgrp->freezer.freeze_seq);
  3774			freeze_time = cgrp->freezer.frozen_nsec;
  3775			/* Add in current freezer interval if the cgroup is freezing. */
  3776			if (test_bit(CGRP_FREEZE, &cgrp->flags))
  3777				freeze_time += (ktime_get_ns() -
  3778						cgrp->freezer.freeze_start_nsec);
  3779		} while (read_seqcount_retry(&cgrp->freezer.freeze_seq, sequence));
  3780	
> 3781		seq_printf(seq, "frozen_usec %llu\n",
  3782			   (unsigned long long) freeze_time / NSEC_PER_USEC);
  3783	
  3784		return 0;
  3785	}
  3786	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

