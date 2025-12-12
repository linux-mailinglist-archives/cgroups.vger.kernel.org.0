Return-Path: <cgroups+bounces-12343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4549CCB7B5B
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 03:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 730783006D83
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305C29ACF6;
	Fri, 12 Dec 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPqwZ4+H"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F283299947;
	Fri, 12 Dec 2025 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765508128; cv=none; b=QZS3n2uNO+lG0CnmdrGLQVezOwo4h5WtsRRWMEuUSRLwliIQrzhMOrojjR3hRvSb2gnJHuL6pcsm09HWnmnvd/b5rBqbXLnTu4g6MtxZBdqNLgyzCSWmICBz7unS828J5a8JokoQe3pwv7k5t1YRPVL5mAjl0VAms4xUveMiB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765508128; c=relaxed/simple;
	bh=t84hamvCTNn8P6GklBvJVrOeaVIe6R0pGBpn8MhDhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph4WmOVc3m1bwtHer7VndEXNrwO/iVMTVSRQV7OsWX4qVre0eH4i2JSx3WdgiIX55z1PW2spUjvDoKHl2B+gxcNf2SAh5ejLkwOM8rQGr70p3qGoeFvgMCN60sOVSE8jmDlld1Eb4sbcVOUcfmRZwj+jsdGuDRw3+6RM3WBEqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPqwZ4+H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765508126; x=1797044126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t84hamvCTNn8P6GklBvJVrOeaVIe6R0pGBpn8MhDhdA=;
  b=nPqwZ4+HHgKLXjPX8+mysUvE5lr94cKjinA0DhHFnKR6qR8kRQmfMiZ4
   xtx3gdWUEdvnnLyFUpPvArlhQzDuJIudWjEh3tyy/L5knHBxFRid/r6/w
   g778JxvDC2vVL17vuUr4Upj5HkOICzFxQiQLG7qOUedB//bWmZSidFGrC
   Uc1/qbjl63yp1H0Z80aNf56AKQK8IeXYKUVrisNbBiPdOYDbxwXnZVvrl
   C4ErQ+3c0s0Af//Ec9vCQ+auLdzja9YtKQxvcXPkPOqCbLkUI3LCBzlnm
   aByYX6JWlgcRxkrzOEvfpjgs0eck/g/Mlvv0r2vq+cKaR00UULovneLSL
   g==;
X-CSE-ConnectionGUID: e8ItgmSETMmAXRlpgOk/9A==
X-CSE-MsgGUID: 4Hp3uQpyQEe/ZElHv3bIWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67429720"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67429720"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:55:20 -0800
X-CSE-ConnectionGUID: 6LZGlbssSyWqRzU6u0sSjQ==
X-CSE-MsgGUID: yv0vBOInTSuW28cqNqT7qw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Dec 2025 18:55:13 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTtJG-000000005PB-3q4X;
	Fri, 12 Dec 2025 02:55:10 +0000
Date: Fri, 12 Dec 2025 10:55:04 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	zhengqi.arch@bytedance.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huaweicloud.com, zhongjinji@honor.com
Subject: Re: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen
 and non-lrugen
Message-ID: <202512121027.03z9qd08-lkp@intel.com>
References: <20251209012557.1949239-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209012557.1949239-4-chenridong@huaweicloud.com>

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/mm-mglru-use-mem_cgroup_iter-for-global-reclaim/20251209-094913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251209012557.1949239-4-chenridong%40huaweicloud.com
patch subject: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen and non-lrugen
config: x86_64-randconfig-004-20251212 (https://download.01.org/0day-ci/archive/20251212/202512121027.03z9qd08-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121027.03z9qd08-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512121027.03z9qd08-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/vmscan.o: warning: objtool: shrink_one+0xeb2: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

