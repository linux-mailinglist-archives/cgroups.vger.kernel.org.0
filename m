Return-Path: <cgroups+bounces-3010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E78CF6E1
	for <lists+cgroups@lfdr.de>; Mon, 27 May 2024 01:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696C91F218CE
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E113A40C;
	Sun, 26 May 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eY+6Mtjk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38361D512
	for <cgroups@vger.kernel.org>; Sun, 26 May 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716767929; cv=none; b=mN1QmlBoFOEAtemzXqZF7zjW1q14ihRuAelm8+KPjfT44KvjOFoOqYUQLBWxqlQJ1MgaFYh/2+LbxZ/+GLT1kQNFt9aPbKZgaZHoKKdVieVIKxXSFxp3uk0MlUi+20EMo+j+p94uD5xMeyxNMS+yu5D+Xdp0CyVbK52/OtHLAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716767929; c=relaxed/simple;
	bh=SbZbio9Sc37XHGXEV3/d4tbuVxap0i6XYvMKszjtBIo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xb5d3AwNzJfBA26FovDcde0P28rTm/XeKzOT86K1xcuf9aMFEjztJPIlJR1XgUAoi7xocdp2JBxOiHHYoi6zqgh1QBxo6N8j9NZaT49Xpxm4qlGZ38fCcMMprWSq+PsNPENptsXw6GKZQF6bCzfR6rorJ3BxZL64uPlcQSwUo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eY+6Mtjk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716767928; x=1748303928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SbZbio9Sc37XHGXEV3/d4tbuVxap0i6XYvMKszjtBIo=;
  b=eY+6MtjknF7gf2TNPYatARZw3PD82QWV8IAOhHT9mvwjZxgOwsH2O8Fv
   RcBAz6JGXYwkCMTJMdMRBmIfOo5auGJwBE5DERhiT0suESlUNWAwqxHZ7
   W/r43pldy+j398IxrerlG0oMUWCszJErvNdkQyGvqhZTn4hukaUf4GB3a
   x1HQZEBTKsJ0/GsrXKGcwvpCwecAOaqKzR00A8HKZLfRM8EXeJbWTOm0K
   ZfDAZdnsQJHU7JJZYQdNtxBEApKITKwpOu2F3tgT7zFt7mWEjaP//wkj6
   obmsXfQQ3KMxhOrXLDlCxp1egif85U3x6yo12Ir3DeRgnMGzJrybaJemd
   Q==;
X-CSE-ConnectionGUID: qANfHRGgTsGe3XnAXS1Znw==
X-CSE-MsgGUID: q6Pl4gH1R3WAiOz/HrbLJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12893073"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="12893073"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 16:58:48 -0700
X-CSE-ConnectionGUID: FA6ZA30bTDGYGbhCuRSlKQ==
X-CSE-MsgGUID: 9MzMajzwSlKBSnahyU03YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39141342"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 26 May 2024 16:58:46 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBNlC-0008sP-2A;
	Sun, 26 May 2024 23:58:43 +0000
Date: Mon, 27 May 2024 07:55:01 +0800
From: kernel test robot <lkp@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:for-next 3/8] kernel/cgroup/pids.o: warning: objtool:
 __jump_table+0x0: special: can't find orig instruction
Message-ID: <202405270728.d1SabzhU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
head:   a8d55ff5f3acf52e6380976fb5d0a9172032dcb0
commit: 73e75e6fc352bdca08f7e0893d5b6bb37171bdd2 [3/8] cgroup/pids: Separate semantics of pids.events related to pids.max
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240527/202405270728.d1SabzhU-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405270728.d1SabzhU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405270728.d1SabzhU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/pids.o: warning: objtool: __jump_table+0x0: special: can't find orig instruction


objdump-func vmlinux.o __jump_table:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

