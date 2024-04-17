Return-Path: <cgroups+bounces-2552-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8ED8A79CE
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 02:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86633284C97
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 00:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA817EB;
	Wed, 17 Apr 2024 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG7ynyAy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EA37B
	for <cgroups@vger.kernel.org>; Wed, 17 Apr 2024 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313281; cv=none; b=KLYG67CBhUWLbd1wYUk8p1HTSKIvtEucHbjaOqqyvezWaXOUYLeb9yxHukk48eCOdjYcYN1Y1CnYXhSXIR50Tl/APqVYEoI35T9xQcCkYA/T2aI6kSjr0NsLg/F3VlHZGDeOjCjb1nkuqYSJjI+NlIduQlfe7Ch4ST4K39i7d14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313281; c=relaxed/simple;
	bh=K2ZFtuGnRYBMp4zqpkPAY0ZwBh7cc4jMlO0Ey57ysoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fwJF8nBVOSwlnaUSX+JF3gE6jjJLM7R33nO6KHm+euowLpyU44xZU/SknQqFTWcTwsiI8kaqr37REIMJKqXIn8mw3D1bkhjcJXQEHE5TMIpvGDTIx4zrQbDyWv975nYeq8e5e/qY7hYRrkCVenVnILnoM7GrA2MetDI7DFdv/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HG7ynyAy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713313280; x=1744849280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K2ZFtuGnRYBMp4zqpkPAY0ZwBh7cc4jMlO0Ey57ysoQ=;
  b=HG7ynyAyarR3UO12xqt6QvluA+Qgy+rLzgZ+wZXB4kn036MbOgw4/j9w
   x0d1wxkPJgeIVoWc2ExiUYg01Z2jVW8FOa+txN5KmgIEKRDgJVjRGu91Y
   MY8UrZoAx4C8zCyb0apj+MmNBFla5wqOEFzNWUDuR1uqN1x4gUOo1YAe0
   8g63SyeBz8vaHCSfISSLWjj8ZKFHzk0bwoEg51AXaFt0COHE11jmfICPX
   RqBHzo9tsNxgRJp8qDuTBViGrW5nYoFOzd7pNg/M7qnb5Zg/BiO/6ebvo
   TJTrfg4gpyimvZr1TX11ze5/pNSbumWHnUYL8H8JX0y1cW/59pJRVeH/Q
   A==;
X-CSE-ConnectionGUID: J7hcHzpRRvylH1rAySTRsw==
X-CSE-MsgGUID: oI4/sdyUSmmrUP/cm9oMSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12625222"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12625222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:21:20 -0700
X-CSE-ConnectionGUID: WSAKRmfRSIOZQIgB7anLXA==
X-CSE-MsgGUID: cxPnTlcoRRqqdgd2jBfXyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22495129"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 16 Apr 2024 17:21:18 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwt36-0005si-0M;
	Wed, 17 Apr 2024 00:21:16 +0000
Date: Wed, 17 Apr 2024 08:20:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:for-next 7/7] kernel/cgroup/rstat.c:334: warning:
 Function parameter or struct member 'cgrp' not described in
 'cgroup_rstat_flush_release'
Message-ID: <202404170821.HwZGISTY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
head:   fc29e04ae1ad4c99422c0b8ae4b43cfe99c70429
commit: fc29e04ae1ad4c99422c0b8ae4b43cfe99c70429 [7/7] cgroup/rstat: add cgroup_rstat_lock helpers and tracepoints
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240417/202404170821.HwZGISTY-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404170821.HwZGISTY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170821.HwZGISTY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/rstat.c:334: warning: Function parameter or struct member 'cgrp' not described in 'cgroup_rstat_flush_release'


vim +334 kernel/cgroup/rstat.c

6162cef0f741c7 Tejun Heo              2018-04-26  328  
6162cef0f741c7 Tejun Heo              2018-04-26  329  /**
6162cef0f741c7 Tejun Heo              2018-04-26  330   * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
6162cef0f741c7 Tejun Heo              2018-04-26  331   */
fc29e04ae1ad4c Jesper Dangaard Brouer 2024-04-16  332  void cgroup_rstat_flush_release(struct cgroup *cgrp)
0fa294fb1985c0 Tejun Heo              2018-04-26  333  	__releases(&cgroup_rstat_lock)
6162cef0f741c7 Tejun Heo              2018-04-26 @334  {
fc29e04ae1ad4c Jesper Dangaard Brouer 2024-04-16  335  	__cgroup_rstat_unlock(cgrp, -1);
6162cef0f741c7 Tejun Heo              2018-04-26  336  }
6162cef0f741c7 Tejun Heo              2018-04-26  337  

:::::: The code at line 334 was first introduced by commit
:::::: 6162cef0f741c70eb0c7ac7e6142f85808d8abc4 cgroup: Factor out and expose cgroup_rstat_*() interface functions

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

