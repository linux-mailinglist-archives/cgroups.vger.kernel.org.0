Return-Path: <cgroups+bounces-15091-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4xVFBHMtyWmMvgUAu9opvQ
	(envelope-from <cgroups+bounces-15091-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 15:47:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68C3524AD
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD1F300FEEB
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE2379980;
	Sun, 29 Mar 2026 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0CY84cE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BC35AC09;
	Sun, 29 Mar 2026 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774792046; cv=none; b=eFa6N5lvbkb9pyA9Rqt7DJwA1YyFaAJ/fwjwc25klmKk6dVIzoxlrsLYQbmUU4PmvQBaHfwGjd2qMnEYeyKjl9Dd38MElJb7wu46cG6AsnPUEF7d6aCE3atFdLyuJNmW0Idb+FkpQ3gWhPdzGZCvzNeJmNMno7jlwg++UMZ9B+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774792046; c=relaxed/simple;
	bh=HxHwSqIXKIalnHUH4THevqlWy1d+jJeZ91RpHBQZutI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwr0GJgDlp981apbM2uqc9tNt2xAvqP1zTFADVDeQBwEJnkJVzaMtirGX7cKyLsOYeqbpXN5sl/Wg4vooZPR8I6djyW47w9TcbwpzYeOQdDaCZp42WEIVGu6MnF24XvqbUYoB09A/O8gKdXeZdAZ77pTcyqwdj2K9j1+HCHTz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0CY84cE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774792045; x=1806328045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HxHwSqIXKIalnHUH4THevqlWy1d+jJeZ91RpHBQZutI=;
  b=f0CY84cE1FuBiW1uULx5WaG5yIkWSC48Dv8AzC5hafbsHh0KcUm19djP
   IwOFnjcFB2DC+7y3Cdnvy+OI9ejVnDo41ie629AxEf6svEHEpWYeu7Tl7
   11kCUu7DoQ4Zq9zPp7Y74ydSjb8V1IYq9iTFooKOebHvu8A27VMe9M1Wk
   t/kRlhJEAoVm7xX2K2vLdE6dL6GogH0n1i7e6bzmTPONhn6qT45r2gnPs
   IWsvJ6tWMp5SdmgYpbb0S+ZJ2d4D8DeMhAMZiUA9wzVS5vRwLufZFLHVG
   cIigr2XYkwaorrOWOlbfkhDOzhNEfDaQqiET6U+kVMj5udV2C/vC8mS6a
   g==;
X-CSE-ConnectionGUID: vcEkh5s6QsSKk/rC5mPTMA==
X-CSE-MsgGUID: tJl427lXRiir8nL9xeGAXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75818110"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="75818110"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 06:47:25 -0700
X-CSE-ConnectionGUID: JmQ1czEGRdGH7uHasW2MIg==
X-CSE-MsgGUID: vgLPKTFjTu2hGP5+E8WFmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="219170287"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Mar 2026 06:47:21 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6qU1-00000000CPN-2Lmn;
	Sun, 29 Mar 2026 13:47:17 +0000
Date: Sun, 29 Mar 2026 21:46:55 +0800
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com
Subject: Re: [PATCH v5 1/4] mm: swap: introduce swap tier infrastructure
Message-ID: <202603292156.2V2nVz19-lkp@intel.com>
References: <20260325175453.2523280-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325175453.2523280-2-youngjun.park@lge.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15091-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kvack.org,kernel.org,lge.com,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 4E68C3524AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Youngjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6381a729fa7dda43574d93ab9c61cec516dd885b]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-introduce-swap-tier-infrastructure/20260327-203639
base:   6381a729fa7dda43574d93ab9c61cec516dd885b
patch link:    https://lore.kernel.org/r/20260325175453.2523280-2-youngjun.park%40lge.com
patch subject: [PATCH v5 1/4] mm: swap: introduce swap tier infrastructure
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20260329/202603292156.2V2nVz19-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603292156.2V2nVz19-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603292156.2V2nVz19-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/swap_tier.c: In function 'swap_tiers_sysfs_show':
>> mm/swap_tier.c:116:59: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'int' [-Wformat=]
     116 |                 len += sysfs_emit_at(buf, len, "%-16s %-5ld %-11d %-11d\n",
         |                                                       ~~~~^
         |                                                           |
         |                                                           long int
         |                                                       %-5d


vim +116 mm/swap_tier.c

   105	
   106	ssize_t swap_tiers_sysfs_show(char *buf)
   107	{
   108		struct swap_tier *tier;
   109		ssize_t len = 0;
   110	
   111		len += sysfs_emit_at(buf, len, "%-16s %-5s %-11s %-11s\n",
   112				 "Name", "Idx", "PrioStart", "PrioEnd");
   113	
   114		spin_lock(&swap_tier_lock);
   115		for_each_active_tier(tier) {
 > 116			len += sysfs_emit_at(buf, len, "%-16s %-5ld %-11d %-11d\n",
   117					     tier->name,
   118					     TIER_IDX(tier),
   119					     tier->prio,
   120					     TIER_END_PRIO(tier));
   121		}
   122		spin_unlock(&swap_tier_lock);
   123	
   124		return len;
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

