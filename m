Return-Path: <cgroups+bounces-9711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C86B44819
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 23:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DC01C82E0E
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9C299950;
	Thu,  4 Sep 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McqKLhn7"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593527991E
	for <cgroups@vger.kernel.org>; Thu,  4 Sep 2025 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020232; cv=none; b=J3z376aprYDQaNmgwUIlOixF9Cmh8Gw2nSHRAQRWEobwZsOL7OXvdeUofvdnktAeidklVoeodo8tIOVGWcTEQuknXwwmgyHikRS1aaFhXVp2KDpQmLVbnz0PKpr9XQYUOJy+3e7x+5YXwmrzDpabrcdAmvm0PC2QSixAGIyPrto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020232; c=relaxed/simple;
	bh=3epT3pamOe0lVDQuEH1DZKMn89bAcvXi5Ix/lheBIz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IcFLUOwsq2n4I3SDmYnmjt0wivFz69/ajTAsJIKi+AMXQXLyQLM9/YRB0wsZXCaKjHIGC19xDjc2zxloOkqggxenNaTroP+HAul/YX5jH7mdLNhvWZW0TG6ZzpAa1qRdrG6EjfbiWbvTPorAc+cW/A5ngzlAAKNdNeAGLUCZSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McqKLhn7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757020231; x=1788556231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3epT3pamOe0lVDQuEH1DZKMn89bAcvXi5Ix/lheBIz0=;
  b=McqKLhn7Ja9BhoYWBKuHS4j3rcotqUFNtrt3BcF+e24DRn4Y6Dh6ehb5
   Fo9e3PNeHoiO+ZoTEiK0bJBhfx+palEuE2G91os7TAlYEWrsh6zmzMXgU
   cFhB9sG/rTvg/Bs7xa5RNV43pcWpjtuEypdq2rRIaCz68T0MxOwupxOCl
   I7xnC8Ih4sHE9Mwtq8xNZoBg67aQ3VN5ot1bd1ADxhqQ1SrwJSDD8QUaM
   Qw6OWAKV69Cq5qlHWKou7fPwXmFORqM546k2TTNZn4Qakf95qlmka9mIK
   cDVMROtu7nB8d26kGCzeRoZqkqpHnQWJrIyJpxzCUjOHlDocNhc6kM0j9
   A==;
X-CSE-ConnectionGUID: vVJGuCHBRvy0T4ftjT/48A==
X-CSE-MsgGUID: 6FGO9tHpRCiFFParvbf0jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="76980331"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="76980331"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:10:30 -0700
X-CSE-ConnectionGUID: 95KdcKTiTaCabr60RobxUQ==
X-CSE-MsgGUID: dR5iXm3WSfGVPq3AXdIWsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="176115103"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 04 Sep 2025 14:10:28 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuHDu-0005vP-08;
	Thu, 04 Sep 2025 21:10:26 +0000
Date: Fri, 5 Sep 2025 05:10:25 +0800
From: kernel test robot <lkp@intel.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:for-6.18 17/17] kernel/cgroup/cgroup.c:3029:24: warning:
 unused variable 'ss'
Message-ID: <202509050527.YEPZiaXZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
head:   d8b269e009bbc471cb2735b5f737839495efce3b
commit: d8b269e009bbc471cb2735b5f737839495efce3b [17/17] cgroup: Remove unused cgroup_subsys::post_attach
config: i386-buildonly-randconfig-003-20250905 (https://download.01.org/0day-ci/archive/20250905/202509050527.YEPZiaXZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509050527.YEPZiaXZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509050527.YEPZiaXZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:3029:24: warning: unused variable 'ss' [-Wunused-variable]
    3029 |         struct cgroup_subsys *ss;
         |                               ^~
>> kernel/cgroup/cgroup.c:3030:6: warning: unused variable 'ssid' [-Wunused-variable]
    3030 |         int ssid;
         |             ^~~~
   2 warnings generated.


vim +/ss +3029 kernel/cgroup/cgroup.c

bbcb81d09104f0 kernel/cgroup.c        Paul Menage 2007-10-18  3026  
4f7e7236435ca0 kernel/cgroup/cgroup.c Tejun Heo   2022-08-15  3027  void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked)
715c809d9a9e38 kernel/cgroup/cgroup.c Tejun Heo   2017-05-15  3028  {
715c809d9a9e38 kernel/cgroup/cgroup.c Tejun Heo   2017-05-15 @3029  	struct cgroup_subsys *ss;
715c809d9a9e38 kernel/cgroup/cgroup.c Tejun Heo   2017-05-15 @3030  	int ssid;
081aa458c38ba5 kernel/cgroup.c        Li Zefan    2013-03-13  3031  
715c809d9a9e38 kernel/cgroup/cgroup.c Tejun Heo   2017-05-15  3032  	/* release reference from cgroup_procs_write_start() */
715c809d9a9e38 kernel/cgroup/cgroup.c Tejun Heo   2017-05-15  3033  	put_task_struct(task);
3014dde762f618 kernel/cgroup.c        Tejun Heo   2015-09-16  3034  
4f7e7236435ca0 kernel/cgroup/cgroup.c Tejun Heo   2022-08-15  3035  	cgroup_attach_unlock(threadgroup_locked);
af351026aafc8d kernel/cgroup.c        Paul Menage 2008-07-25  3036  }
af351026aafc8d kernel/cgroup.c        Paul Menage 2008-07-25  3037  

:::::: The code at line 3029 was first introduced by commit
:::::: 715c809d9a9e38d8fb9476757ddaf64c1a9f767f cgroup: reorganize cgroup.procs / task write path

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

