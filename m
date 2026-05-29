Return-Path: <cgroups+bounces-16444-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGAwEay8GWq0yggAu9opvQ
	(envelope-from <cgroups+bounces-16444-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:19:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF16605759
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B37E3004922
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955253C8728;
	Fri, 29 May 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+ok9+ls"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32436344D8C;
	Fri, 29 May 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071581; cv=none; b=hewABN8ltMCr6N+AS1ugOqQWqukDUJ4nQNACpEV9GpkH4vmBE4M+D5hjwksrQpZn1riQqymrmStvoglPTRZD4sW6q1pZ4enwnDBEFemLB/gMt2yMRPEolgAVVFN+N/ZQnI+0vCIIE/I6OrIswXtk5RAW4PEMibEGjwJoE5HQjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071581; c=relaxed/simple;
	bh=EYp/jAynC172ymkPlBs938kKNz8BDeBeyLFCV6NsZSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIWaUjwXCR1df1A+fjgXpLCukIC1u/opdPbDDmk58cE+z9Dl0gjpR+Op+sfW0lHLMoxU44XDYhWB14i21Jql8zjkEph8B7hyIkF9ugXbWF7LtqdOuBOluV6fDy6kXjismAUj49O72vCsRsVwDyMiarKzxVBu1IKOanNOXuNOxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+ok9+ls; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780071580; x=1811607580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYp/jAynC172ymkPlBs938kKNz8BDeBeyLFCV6NsZSQ=;
  b=g+ok9+lsDycWf0giZaCMpG+cKYwTbrk3Yj710JDJZ7HQR53DZE5hPQeP
   oPQiTEjcKWdWIYbFPcglXgQmevwkjQ9WnE7CErG6wwDOVaZMcrTFpnl8+
   pkbLZPnUv3a8SWba62J70rw/NuS82k/8QRbyOFFIbgUJEPNFWrVimzjdD
   BHxPkXeOgSxGocX2O/i6dBwM3iR1bqsT5ix2ODXHzbP9Q47f0SjS5t9ry
   d/Ue8+eiZNjxOwTKsYIFfsAozlbHS27svLeg8uoF1x1byPZYmoqjWFvCQ
   mMxP4zsZ3s61NlGDwfHGy7RnGtKawNzTyWdWBi2ImHU/j9httNp5bpomU
   g==;
X-CSE-ConnectionGUID: GYX416i1Qke5Kh2RGpodCw==
X-CSE-MsgGUID: Z5L5RtQwReSWMs9uRVwwog==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80901041"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80901041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 09:19:39 -0700
X-CSE-ConnectionGUID: uTyt/F+0Q9G5VrvCvb6AiA==
X-CSE-MsgGUID: EfFBoTWxSZK9YE6bc6REDw==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 29 May 2026 09:19:37 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSzvr-000000000uj-2NX8;
	Fri, 29 May 2026 16:19:35 +0000
Date: Fri, 29 May 2026 18:18:49 +0200
From: kernel test robot <lkp@intel.com>
To: Tao Cui <cui.tao@linux.dev>, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, leon@kernel.org, jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH rdma-next v2 3/3] cgroup/rdma: update cgroup resource
 list for MR_MEM
Message-ID: <202605291816.15AyhoZE-lkp@intel.com>
References: <20260529090733.2242822-4-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529090733.2242822-4-cui.tao@linux.dev>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-16444-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Queue-Id: ACF16605759
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on next-20260528]
[cannot apply to linus/master v7.1-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Cui/cgroup-rdma-extend-charge-uncharge-API-with-s64-amount-parameter/20260529-171623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20260529090733.2242822-4-cui.tao%40linux.dev
patch subject: [PATCH rdma-next v2 3/3] cgroup/rdma: update cgroup resource list for MR_MEM
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260529/202605291816.15AyhoZE-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605291816.15AyhoZE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605291816.15AyhoZE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/cgroup/rdma.c:210 function parameter 'amount' not described in 'uncharge_cg_locked'
>> Warning: kernel/cgroup/rdma.c:312 function parameter 'amount' not described in 'rdmacg_uncharge_hierarchy'
>> Warning: kernel/cgroup/rdma.c:335 function parameter 'amount' not described in 'rdmacg_uncharge'
>> Warning: kernel/cgroup/rdma.c:210 function parameter 'amount' not described in 'uncharge_cg_locked'
>> Warning: kernel/cgroup/rdma.c:312 function parameter 'amount' not described in 'rdmacg_uncharge_hierarchy'
>> Warning: kernel/cgroup/rdma.c:335 function parameter 'amount' not described in 'rdmacg_uncharge'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

