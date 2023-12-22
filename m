Return-Path: <cgroups+bounces-1008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050681D09C
	for <lists+cgroups@lfdr.de>; Sat, 23 Dec 2023 00:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7042854E9
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 23:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5735EF5;
	Fri, 22 Dec 2023 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPoyIwno"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECE35EE4;
	Fri, 22 Dec 2023 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703289097; x=1734825097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DJzPrVmx6lVGQm+j29sv1tuRrGlOjiJ2JwgbyD3nYGc=;
  b=dPoyIwnoL15Xs00lqDmmpflV6CtO0ylwA10RyLh9xbTP+oqDpK4TyyuP
   hmoK2bpFFqXCQUnCFvP4sEscKSnIXwAu7/M5CsEbR2f+T5QRz7V1g140L
   siF+KHdsVTjnSiWAbDF+/fTj5it/Tm/BTBZQhuWbINS1LUCeXMSPDAo4e
   cROn8xyG035rzCCvTf3Ao4gZ2S0AjoXaUCzCq0uSbWm7x19o5vY/mf9VR
   MM4gpX4a/TFIulc4zO1sDp3XxOotcrU+wxra8ewThfAk3LM6FUsopvmrG
   cDVYjfv965LeoJzb/dHaptpnTFoJPsCLMQS7a+cv8z6GXVzNQOfnfFbM5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="17738827"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="17738827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811470075"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="811470075"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Dec 2023 15:51:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGpIf-000A1D-1D;
	Fri, 22 Dec 2023 23:51:29 +0000
Date: Sat, 23 Dec 2023 07:49:44 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] cgroup, psi: Init PSI of root cgroup to
 psi_system
Message-ID: <202312230748.92S9ML64-lkp@intel.com>
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
config: s390-randconfig-r081-20231223 (https://download.01.org/0day-ci/archive/20231223/202312230748.92S9ML64-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230748.92S9ML64-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230748.92S9ML64-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:169:22: error: 'psi_system' undeclared here (not in a function)
     169 |         .cgrp.psi = &psi_system,
         |                      ^~~~~~~~~~


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

