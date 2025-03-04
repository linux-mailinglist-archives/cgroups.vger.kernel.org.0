Return-Path: <cgroups+bounces-6797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB194A4D218
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 04:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4004B7A6599
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455AE1EDA3E;
	Tue,  4 Mar 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyzkMGRh"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305361632C7;
	Tue,  4 Mar 2025 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059389; cv=none; b=nRkn9YJcMZwG5pB5g5fSTFqUSq0pMk9oHNE/Z/JdKFALagJBT6otMAXE/3Sr+UcnfckZm9baIs/9jyL3JKdCZYS0W7pGzWYCFxZ79hyG5VgzGMUd9q8ZKzLZGjkVZHGi6UZ/tiR//nhIL07vQsZ0AdGrjbDmIj1ajp/9HbgrEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059389; c=relaxed/simple;
	bh=zCg4gjw7d+J7qKHwjCgVMJEV1aJCXUZa2BZYOIr8pqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2qccx53YHPR/cdkFJ2CeHQdJxSeF8pc5xlgIjOVCNgnrqR2pI3sruhfgyLXTbXRxKR2fxSNB+f4WGg/ROTEGwln3/ipLNJdIb9jzUK5pizMMyiFI81YPqs26hC9y1LtNeSkaqwu8xb9DTnFTbmzOF6olgBwrTiyTZrk0gTCI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyzkMGRh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741059388; x=1772595388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCg4gjw7d+J7qKHwjCgVMJEV1aJCXUZa2BZYOIr8pqs=;
  b=TyzkMGRhrKlOiwXCMsPdt55LR5a/IJeBe1WYDGnw83SWtYav37MKbPOG
   nHkspBwbps38APoLVd+J72OFI6HOzTDPYLYEVIqwUXY2vI1LKSUahXbcN
   RIYtZ4UsO9emqwUdvTDRAeZQXU7H6eyweBvF9/x063iIgvIfCWQBuv2xz
   2kGrU5t6nQ2A9C8g7Soj6VcaUH4G2ap3JCCqRyUHm1cBVaovUzOwiWtL7
   TFitFK7W+TfsPUe2XmcHWqA7ZbyeNkGH3Rg0tlYEzNRNkQegRkf0JBfnl
   4nIJ6qGPTipn8jFZlEWQya4Y8RVfg4Dkg1uEoT2mavkyy3HXJZBjVA/id
   w==;
X-CSE-ConnectionGUID: u4VdekqDSdWavKdZS2N7/A==
X-CSE-MsgGUID: SzEU53/DSbaOAHTzzA2Otw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42149921"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42149921"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 19:36:27 -0800
X-CSE-ConnectionGUID: iqHCsxWDSEGfJEDbgn+hsQ==
X-CSE-MsgGUID: b7TqvsPlR/uLYeYKDGkUVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118247512"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2025 19:36:23 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpJ4u-000JDs-2c;
	Tue, 04 Mar 2025 03:36:20 +0000
Date: Tue, 4 Mar 2025 11:35:30 +0800
From: kernel test robot <lkp@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <202503041133.n9Zlxnda-lkp@intel.com>
References: <20250228165216.339407-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228165216.339407-1-mkoutny@suse.com>

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on dd83757f6e686a2188997cb58b5975f744bb7786]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Koutn/netfilter-Make-xt_cgroup-independent-from-net_cls/20250301-005409
base:   dd83757f6e686a2188997cb58b5975f744bb7786
patch link:    https://lore.kernel.org/r/20250228165216.339407-1-mkoutny%40suse.com
patch subject: [PATCH] netfilter: Make xt_cgroup independent from net_cls
config: arm-omap2plus_defconfig (https://download.01.org/0day-ci/archive/20250304/202503041133.n9Zlxnda-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503041133.n9Zlxnda-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503041133.n9Zlxnda-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/netfilter/xt_cgroup.c: In function 'cgroup_mt_v0':
   net/netfilter/xt_cgroup.c:132:29: error: implicit declaration of function 'sock_cgroup_classid' [-Wimplicit-function-declaration]
     132 |         return (info->id == sock_cgroup_classid(&skb->sk->sk_cgrp_data)) ^
         |                             ^~~~~~~~~~~~~~~~~~~
   net/netfilter/xt_cgroup.c: In function 'cgroup_mt_v1':
   net/netfilter/xt_cgroup.c:147:45: error: implicit declaration of function 'sock_cgroup_ptr'; did you mean 'obj_cgroup_put'? [-Wimplicit-function-declaration]
     147 |                 return cgroup_is_descendant(sock_cgroup_ptr(skcd), ancestor) ^
         |                                             ^~~~~~~~~~~~~~~
         |                                             obj_cgroup_put
>> net/netfilter/xt_cgroup.c:147:45: error: passing argument 1 of 'cgroup_is_descendant' makes pointer from integer without a cast [-Wint-conversion]
     147 |                 return cgroup_is_descendant(sock_cgroup_ptr(skcd), ancestor) ^
         |                                             ^~~~~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             int
   In file included from include/net/netprio_cgroup.h:11,
                    from include/linux/netdevice.h:42,
                    from include/linux/netfilter/x_tables.h:6,
                    from net/netfilter/xt_cgroup.c:16:
   include/linux/cgroup.h:511:56: note: expected 'struct cgroup *' but argument is of type 'int'
     511 | static inline bool cgroup_is_descendant(struct cgroup *cgrp,
         |                                         ~~~~~~~~~~~~~~~^~~~
   net/netfilter/xt_cgroup.c: In function 'cgroup_mt_v2':
   net/netfilter/xt_cgroup.c:165:45: error: passing argument 1 of 'cgroup_is_descendant' makes pointer from integer without a cast [-Wint-conversion]
     165 |                 return cgroup_is_descendant(sock_cgroup_ptr(skcd), ancestor) ^
         |                                             ^~~~~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             int
   include/linux/cgroup.h:511:56: note: expected 'struct cgroup *' but argument is of type 'int'
     511 | static inline bool cgroup_is_descendant(struct cgroup *cgrp,
         |                                         ~~~~~~~~~~~~~~~^~~~


vim +/cgroup_is_descendant +147 net/netfilter/xt_cgroup.c

82a37132f300ea Daniel Borkmann 2013-12-29  135  
c38c4597e4bf3e Tejun Heo       2015-12-07  136  static bool cgroup_mt_v1(const struct sk_buff *skb, struct xt_action_param *par)
c38c4597e4bf3e Tejun Heo       2015-12-07  137  {
c38c4597e4bf3e Tejun Heo       2015-12-07  138  	const struct xt_cgroup_info_v1 *info = par->matchinfo;
c38c4597e4bf3e Tejun Heo       2015-12-07  139  	struct sock_cgroup_data *skcd = &skb->sk->sk_cgrp_data;
c38c4597e4bf3e Tejun Heo       2015-12-07  140  	struct cgroup *ancestor = info->priv;
f564650106a6e8 Flavio Leitner  2018-06-27  141  	struct sock *sk = skb->sk;
c38c4597e4bf3e Tejun Heo       2015-12-07  142  
f564650106a6e8 Flavio Leitner  2018-06-27  143  	if (!sk || !sk_fullsock(sk) || !net_eq(xt_net(par), sock_net(sk)))
c38c4597e4bf3e Tejun Heo       2015-12-07  144  		return false;
c38c4597e4bf3e Tejun Heo       2015-12-07  145  
c38c4597e4bf3e Tejun Heo       2015-12-07  146  	if (ancestor)
c38c4597e4bf3e Tejun Heo       2015-12-07 @147  		return cgroup_is_descendant(sock_cgroup_ptr(skcd), ancestor) ^
c38c4597e4bf3e Tejun Heo       2015-12-07  148  			info->invert_path;
c38c4597e4bf3e Tejun Heo       2015-12-07  149  	else
c38c4597e4bf3e Tejun Heo       2015-12-07  150  		return (info->classid == sock_cgroup_classid(skcd)) ^
c38c4597e4bf3e Tejun Heo       2015-12-07  151  			info->invert_classid;
c38c4597e4bf3e Tejun Heo       2015-12-07  152  }
c38c4597e4bf3e Tejun Heo       2015-12-07  153  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

