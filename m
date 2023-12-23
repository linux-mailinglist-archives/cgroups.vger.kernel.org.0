Return-Path: <cgroups+bounces-1009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B981D2E6
	for <lists+cgroups@lfdr.de>; Sat, 23 Dec 2023 08:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB40B21B62
	for <lists+cgroups@lfdr.de>; Sat, 23 Dec 2023 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0636FD7;
	Sat, 23 Dec 2023 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAFxTYbo"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5E6FB1;
	Sat, 23 Dec 2023 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703316416; x=1734852416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SB8ag3Z+A1hDt1rNrHNvwrQaIfdOL8/+s44LChvjjTw=;
  b=YAFxTYboeT6Bh3RlWclI4VX5t+BlcLXx6cflZYBZDYNoQ5PlNDI8+Jtn
   LOqSJVK1xrGyJMqPaQMlhIU4Hgm/nhKoDbJ0ZQA/PPjd5TTYRU4Q0eOSM
   Pz3e3XqW0V2tfl6YiScfqpECI9gogGHJbG2FOsQI0w9VAUwxugfmEFsff
   ltGsPj19mQfqOGi/PvILvfSh+omJa/slmbt8VaCPq5E5JtD4vQeFoOHTl
   ljkzSb/1GJv1nzJoQ7cHfXg75wgWLpLRlPDn4guvyfyLCjf/9A4ivIFxz
   0HWg66+CuVfOQYobWcjFxsm6w35yXwSDienFafhIApTkll+2ze0PoOL0i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="9678846"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="9678846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 23:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024468138"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="1024468138"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Dec 2023 23:26:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGwPG-000APt-3D;
	Sat, 23 Dec 2023 07:26:47 +0000
Date: Sat, 23 Dec 2023 15:26:20 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] cgroup, psi: Init PSI of root cgroup to
 psi_system
Message-ID: <202312231522.VWy0LXXY-lkp@intel.com>
References: <20231222113102.4148-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222113102.4148-2-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cgroup-psi-Init-PSI-of-root-cgroup-to-psi_system/20231222-193221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231222113102.4148-2-laoar.shao%40gmail.com
patch subject: [PATCH bpf-next 1/4] cgroup, psi: Init PSI of root cgroup to psi_system
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231223/202312231522.VWy0LXXY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231522.VWy0LXXY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231522.VWy0LXXY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:169:15: error: use of undeclared identifier 'psi_system'
           .cgrp.psi = &psi_system,
                        ^
   1 error generated.


vim +/psi_system +169 kernel/cgroup/cgroup.c

   165	
   166	/* the default hierarchy */
   167	struct cgroup_root cgrp_dfl_root = {
   168		.cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu,
 > 169		.cgrp.psi = &psi_system,
   170	};
   171	EXPORT_SYMBOL_GPL(cgrp_dfl_root);
   172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

