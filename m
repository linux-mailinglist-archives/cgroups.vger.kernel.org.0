Return-Path: <cgroups+bounces-12650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAC6CDC123
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7409530080EF
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FCA29E101;
	Wed, 24 Dec 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+mUK5Q5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A02F1FED;
	Wed, 24 Dec 2025 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766574264; cv=none; b=fmc5vSk9WJWBdBDF9wQYU5bBMX2k1xJSEl0JKiX2IhsDKW/rcyCnkSZodPBYWPNnNjaB42WCjAIWW04kw0meJxgHC5e8X3LxgMW/LrQ/DltG6pqwkB6J10J2c07kTZ0+W4Ns/2qytqBN06PEQmO4oGieOwDq54jhLuMMeVQzQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766574264; c=relaxed/simple;
	bh=TGPVZM4nMD9x7twsQk25x9Irb9sq1hVIlqZT26us4zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS+AVK+DMhwkAsIVhLESeG4s/uBnXXqsroCP9cUwd9HnC4F2noZZdTYdPyv5FL68L27QOi5DeEYBEc0IblgadcsZrdf6et/q7Eo/sNHiOOCXKayfvAcJ588xNq30uySsqw/ehJo3a/znijIQSe/iEKbpZX4cNnkRuIaBvtT26+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+mUK5Q5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766574263; x=1798110263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TGPVZM4nMD9x7twsQk25x9Irb9sq1hVIlqZT26us4zU=;
  b=O+mUK5Q5gaYSl+XJjW9Gvr3LHT9mJU+NML6PieanDNj1F9IWensx+F4+
   9DaaXpW02pWlACq4QvOdseJSmM5WW7MbfwdvUUX2+yM6aTMG9Hic3oFnV
   3Zkz06Ijd/peh1zYIK0huJkRbiwJM/Bbn4HnvRg7h9Kmu3yFcRLvIfWwC
   no0EbDTy6fp9YoTNoqGRFcEhaKaWirmwULYPgk66/EW7JJjOEpAOKHTZS
   8Dmrwwe8jZSj3SH52edj/SzPLhl1mwagIhIVYvgKG56tvuxCDl+sHB6Fm
   BxB+LJHT6HiPiM0cy/e33NPJ5KFKiaD94EuaCp/HXp5auhBtFRpxisfyk
   Q==;
X-CSE-ConnectionGUID: /O1e7lqtS5iysYvwOuPmUA==
X-CSE-MsgGUID: Prz6IZO7Tq6Gjd8DgKR2ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79047423"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="79047423"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 03:04:22 -0800
X-CSE-ConnectionGUID: S95frWbtSnKrRpN0i0ynxQ==
X-CSE-MsgGUID: /Ljq0TLcS9yjarukWq32gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="200493602"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 24 Dec 2025 03:04:02 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYMeL-000000002y5-0HbK;
	Wed, 24 Dec 2025 11:03:29 +0000
Date: Wed, 24 Dec 2025 19:03:07 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
Message-ID: <202512241804.JAJl5a7k-lkp@intel.com>
References: <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223102124.738818-4-ptikhomirov@virtuozzo.com>

Hi Pavel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/cgroup-v2-freezer-allow-freezing-with-kthreads/20251223-182826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20251223102124.738818-4-ptikhomirov%40virtuozzo.com
patch subject: [PATCH 2/2] cgroup-v2/freezer: Print information about unfreezable process
config: arm64-randconfig-r134-20251224 (https://download.01.org/0day-ci/archive/20251224/202512241804.JAJl5a7k-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512241804.JAJl5a7k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512241804.JAJl5a7k-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/cgroup/freezer.c:144:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/cgroup/freezer.c:144:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/cgroup/freezer.c:144:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/cgroup/freezer.c:147:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/cgroup/freezer.c:147:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/cgroup/freezer.c:147:37: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/cgroup/freezer.c:416:5: sparse: sparse: symbol 'sysctl_freeze_timeout_us' was not declared. Should it be static?
   kernel/cgroup/freezer.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs/super_types.h, ...):
   include/linux/sched/signal.h:756:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:756:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:756:37: sparse:     got struct spinlock [noderef] __rcu *

vim +/sysctl_freeze_timeout_us +416 kernel/cgroup/freezer.c

   414	
   415	#define DEFAULT_FREEZE_RATELIMIT (30 * HZ)
 > 416	int sysctl_freeze_timeout_us;
   417	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

