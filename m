Return-Path: <cgroups+bounces-4654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13406967059
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7C9B2233E
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 08:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBD17084F;
	Sat, 31 Aug 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAMEyR4+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349816A940
	for <cgroups@vger.kernel.org>; Sat, 31 Aug 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725092936; cv=none; b=lHWcMVrDLvfCyphTDSWAqKzyyonLVbrd9qjbKex8Tz9Zri0kYEfRUmglL4eWt0aWPq4FWlQbO0BGNh99QREcjsdyyXzlXPRCU7PJX94ARxyUJyjG72Ui1mQWJX9qvernMg209EY8yODBI2t/pWGzD3kRzy6fKD+S75E6CJ+PgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725092936; c=relaxed/simple;
	bh=PMooKVe/dFs/vHDTNdD36EwKdgp+XCCIwNWbXJ9Krh8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pU1wWWc+2kvsI3RmDiFUpmo4/W3taYc+UUepDrlhQ0eMuPHseMwMCBvPCVWRiDlF1cm7J/e4z3hx1GJjA/y8K0h4tXIw2T9XQdYGWBeQN9zxOEldHeRLYPsfhfllYepf1RfKMJe150jbmD34lRl2dSmjLt4LhnvwcLlS8QkxMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAMEyR4+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725092935; x=1756628935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PMooKVe/dFs/vHDTNdD36EwKdgp+XCCIwNWbXJ9Krh8=;
  b=nAMEyR4+SBV0X5rH15TCJued5WSQtToIapuEpcQhrhMvorBYWkr6iUDH
   LXBmOFYfRImVM1jrENzIkH0m8LFF+4jGteFCJh1yM043r/5wZ2raFg2Aq
   jaZ9R7U2c6IBdSzFQQyOFp33/k3X4BMEb5mqIwAsc3xnxNG7Zwe0bu21N
   u5akvYX6QRZlLbR5WdTU9lB3ic/YfX2ku1iomEgx1xTvap/So0U3YsRSs
   EepGIAWg49wqZ4DBhZ+ha7QiE/B6/vxZNU8Mh7/MM4pt6NkBkv6CxDwFM
   Q9LYKYb0VymCCg3raxhgoKgciHD8RfKRNic7fMyv1YFU9jGIAANFWMjQJ
   A==;
X-CSE-ConnectionGUID: bWUbXP2nR56C7fxgQ6cEPQ==
X-CSE-MsgGUID: jdGkmz17SLiBCJZRHbY34Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23923585"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23923585"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 01:28:54 -0700
X-CSE-ConnectionGUID: 9KU3pOZCTEWricE8Uk0z+A==
X-CSE-MsgGUID: ikyZokA2TJC+fEDZLNeyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="64476378"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Aug 2024 01:28:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skJTV-0002Sx-2l;
	Sat, 31 Aug 2024 08:28:49 +0000
Date: Sat, 31 Aug 2024 16:28:44 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:test 23/31] kernel/cgroup/cpuset-v1.c:163:9: error:
 implicit declaration of function 'cpus_read_lock'; did you mean
 'rcu_read_lock'?
Message-ID: <202408311612.mQTuO946-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test
head:   a5ab7b05a3c825f23d74106f3304de7d024cff8a
commit: dd46bd00ab4c00f6126794c6b52fbc87a2c5c389 [23/31] cgroup/cpuset: move relax_domain_level to cpuset-v1.c
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240831/202408311612.mQTuO946-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311612.mQTuO946-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311612.mQTuO946-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/cpuset-v1.c: In function 'cpuset_write_s64':
>> kernel/cgroup/cpuset-v1.c:163:9: error: implicit declaration of function 'cpus_read_lock'; did you mean 'rcu_read_lock'? [-Wimplicit-function-declaration]
     163 |         cpus_read_lock();
         |         ^~~~~~~~~~~~~~
         |         rcu_read_lock
>> kernel/cgroup/cpuset-v1.c:178:9: error: implicit declaration of function 'cpus_read_unlock'; did you mean 'rcu_read_unlock'? [-Wimplicit-function-declaration]
     178 |         cpus_read_unlock();
         |         ^~~~~~~~~~~~~~~~
         |         rcu_read_unlock


vim +163 kernel/cgroup/cpuset-v1.c

   155	
   156	int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
   157				    s64 val)
   158	{
   159		struct cpuset *cs = css_cs(css);
   160		cpuset_filetype_t type = cft->private;
   161		int retval = -ENODEV;
   162	
 > 163		cpus_read_lock();
   164		cpuset_lock();
   165		if (!is_cpuset_online(cs))
   166			goto out_unlock;
   167	
   168		switch (type) {
   169		case FILE_SCHED_RELAX_DOMAIN_LEVEL:
   170			retval = update_relax_domain_level(cs, val);
   171			break;
   172		default:
   173			retval = -EINVAL;
   174			break;
   175		}
   176	out_unlock:
   177		cpuset_unlock();
 > 178		cpus_read_unlock();
   179		return retval;
   180	}
   181	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

