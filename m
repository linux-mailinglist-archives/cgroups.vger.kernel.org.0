Return-Path: <cgroups+bounces-7864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9270EA9E803
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 08:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B618D3A90FE
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2FD1BD9C1;
	Mon, 28 Apr 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAQlzICX"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65C1714B3;
	Mon, 28 Apr 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820727; cv=none; b=fjnNSE0CC30pYkE+10xAQe+bWHDrJW0kgVr5dO2uJS9GBfTuQAwyyskLIuGr8/FDQjIfoskFWc8/YIrdXUsl+113AzLn+owi0RxMMcPVGHZbmHu5wPy5LAnSpGnNsQG/RioDFDXXrz16RYxedw4+Xux96cVKrf2tVsXC+FSTP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820727; c=relaxed/simple;
	bh=9VFKEeiK6JI4XVbE/KksWzGslEhHpjfYU+UURnodd6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a98uy6P8oGrnEmYpWPktxgIoytqqLrezveOKFPJmHEZuDG8mxI2qXIZ1Ol7Ng7jX6R45jFXHepS9p63bCLKLLtQF50JnF3qsL/9bBxGBeKk16F1bM7Oi0a1JAboNwNPp3Mz3bLAOlAWe9Gg3mzRebGV8V2AnXaKwGD1d2FyBywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAQlzICX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745820725; x=1777356725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VFKEeiK6JI4XVbE/KksWzGslEhHpjfYU+UURnodd6M=;
  b=RAQlzICXBchaNII48Xe0MgvbpNJAT8Q4VI7kWFXX2IQcWkiBIyVNg90i
   oB9Ij3ujtWpRrf9WCRfhk4XVipMCSWo8+Tat6E/SAkUAMKMh3wQtbPD3z
   hPdg4tkp+SoY3uPYwwMSr+veBc6N0ebKwQeEIR73gP0kLvXOfl7D0C99z
   QWQAs52WjrNh0R7WtyG/d6K3W+v0SKHhBdW/FBkTGX7yZrnF1HomyqK+R
   ikcihAPwSC7Y11AzX+rlSbq7iSD62Kge/swsW40Uy5C+u+jB4AP40f/Mc
   Y9yQb+BqZOlceoNAZqAjXPI75aqWI5eIp6rVDyi7rx2R9yOhO+oodtPcu
   A==;
X-CSE-ConnectionGUID: kZJl5FjwT8S1sZMyGyfjBA==
X-CSE-MsgGUID: H6N5xXFaTQ22j7EgEfKihw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="58380874"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="58380874"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 23:12:04 -0700
X-CSE-ConnectionGUID: 1+/wircxSC+zaa1j+jwsmw==
X-CSE-MsgGUID: i3LZolW/SKSAhNUcSdgi4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133730131"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Apr 2025 23:12:01 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u9Hig-0006fZ-25;
	Mon, 28 Apr 2025 06:11:58 +0000
Date: Mon, 28 Apr 2025 14:11:04 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH rfc 09/12] sched: psi: bpf hook to handle psi events
Message-ID: <202504281309.smYiDStM-lkp@intel.com>
References: <20250428033617.3797686-10-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428033617.3797686-10-roman.gushchin@linux.dev>

Hi Roman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Gushchin/mm-introduce-a-bpf-hook-for-OOM-handling/20250428-113742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250428033617.3797686-10-roman.gushchin%40linux.dev
patch subject: [PATCH rfc 09/12] sched: psi: bpf hook to handle psi events
config: sh-randconfig-001-20250428 (https://download.01.org/0day-ci/archive/20250428/202504281309.smYiDStM-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250428/202504281309.smYiDStM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504281309.smYiDStM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:94:
>> kernel/sched/psi.c:193:38: warning: 'bpf_psi_hook_set' defined but not used [-Wunused-const-variable=]
     193 | static const struct btf_kfunc_id_set bpf_psi_hook_set = {
         |                                      ^~~~~~~~~~~~~~~~


vim +/bpf_psi_hook_set +193 kernel/sched/psi.c

   192	
 > 193	static const struct btf_kfunc_id_set bpf_psi_hook_set = {
   194		.owner = THIS_MODULE,
   195		.set   = &bpf_psi_hooks,
   196	};
   197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

