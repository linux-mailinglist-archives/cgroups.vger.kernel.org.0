Return-Path: <cgroups+bounces-10062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3945B56918
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 15:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6431542047A
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F120B800;
	Sun, 14 Sep 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYFpfuWd"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED81BD9D0;
	Sun, 14 Sep 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855015; cv=none; b=J/Nb+xgHGiqseznbf7IzSdIsD/45WtthrRKVushURnEw/ufKZy8mTu+ckFgvPyGjw15GUIjjo7rh8uEoQMXlt6oXMerhBhAJfcZZAr2Vf0OCpxXIkbmul8bDovyCjMBROwxzyhN9zD1KfrYxLI2Cj/r/CaHYRe0fMXm64RWB5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855015; c=relaxed/simple;
	bh=YvQSGv3+ITrtWtqX0tQjYwlbtPwK+65J7QAVpMnWBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOZ1620KNAj+i9SMdMvFmL4UlO54lNYclUY2u623vCXZHyf2DTV100etFaaKDv4EAPZW52PasyUE1yA3Npc6/WCnnWoaEk9iKLgydHPZ93AY51yavFow/zKSqs4uF13kPwApVkxHC+poHZNWKJ+qJnWb5eIeagxcMFKW4LLEAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYFpfuWd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757855014; x=1789391014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YvQSGv3+ITrtWtqX0tQjYwlbtPwK+65J7QAVpMnWBSs=;
  b=gYFpfuWdHSpDcl592Q5yDacAkuMkjeZG82MfvTKqaWmh8zaE82aQ3X7q
   l3QLAa0y8xl8qgBs9fMm7c7GRcV7iu+rb1W+3i2H5VJu5f5iHOrxx+qmz
   T1iDvMZxDEMSB0L9FdWHNB70id/gjP9PVElZ7v0/lJj332qj8S9WcMihi
   /oNSD+WlVm2J/46qrbkpwgWcMM3rhipLAnypqS2yyr+BQ4jKMPBE4btlw
   vrJaE0md0a9S1qI1s0XAncHNd4/rDPcqaYLPx2RFVkiaMY0tfXPyd49Jb
   32T3SSKMrjImud/5+bVJCLqD6KwS6yhjgLSGtXxa+SLA2MEGnZA2gsjRN
   A==;
X-CSE-ConnectionGUID: r0cvCS0LRWipBpGKESpF3A==
X-CSE-MsgGUID: CmA34tHHRKSjS3BqEk6UKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="63950943"
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="63950943"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 06:03:33 -0700
X-CSE-ConnectionGUID: XsGtmFeASWi9vAkPUg6x/Q==
X-CSE-MsgGUID: /KpYDJz7Tqulsy/cge9/1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="173941581"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 14 Sep 2025 06:03:30 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxmO7-0002PM-1p;
	Sun, 14 Sep 2025 13:03:27 +0000
Date: Sun, 14 Sep 2025 21:02:38 +0800
From: kernel test robot <lkp@intel.com>
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, david@redhat.com,
	chengming.zhou@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH v2 4/5] memcg: add per-memcg ksm_profit
Message-ID: <202509142046.QatEaTQV-lkp@intel.com>
References: <20250914180750448qMRz3iTon78DoExPyZusD@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914180750448qMRz3iTon78DoExPyZusD@zte.com.cn>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tj-cgroup/for-next linus/master v6.17-rc5 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xu-xin16-zte-com-cn/memcg-add-per-memcg-ksm_rmap_items-stat/20250914-181132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250914180750448qMRz3iTon78DoExPyZusD%40zte.com.cn
patch subject: [PATCH v2 4/5] memcg: add per-memcg ksm_profit
config: um-randconfig-001-20250914 (https://download.01.org/0day-ci/archive/20250914/202509142046.QatEaTQV-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 21857ae337e0892a5522b6e7337899caa61de2a6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250914/202509142046.QatEaTQV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509142046.QatEaTQV-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/bin/ld: mm/ksm.o: in function `evaluate_memcg_ksm_stat':
>> mm/ksm.c:3335:(.ltext+0x163d): undefined reference to `ksm_process_profit'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +3335 mm/ksm.c

  3324	
  3325	static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
  3326	{
  3327		struct mm_struct *mm;
  3328		struct memcg_ksm_stat *ksm_stat = arg;
  3329	
  3330		mm = get_task_mm(task);
  3331		if (mm) {
  3332			ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
  3333			ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
  3334			ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
> 3335			ksm_stat->ksm_profit += ksm_process_profit(mm);
  3336			mmput(mm);
  3337		}
  3338	
  3339		return 0;
  3340	}
  3341	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

