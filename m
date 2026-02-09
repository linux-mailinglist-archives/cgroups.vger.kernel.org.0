Return-Path: <cgroups+bounces-13810-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNv+KJ8VimlrGAAAu9opvQ
	(envelope-from <cgroups+bounces-13810-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 18:13:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B29112F0B
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 18:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F54A300ACBC
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60089385ED9;
	Mon,  9 Feb 2026 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHC4m97+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7F385EC5;
	Mon,  9 Feb 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657176; cv=none; b=lH1E0IQQIcmmkfb3B4IuPbnqVV4wydRFHc7l+2t6rGR9rI0wni5iO0sDfG6PRP1sKpEJ5ulJ4z5FmBMbza9lmZzm7iglEhqIJv0EQVtmoDz0fgcvthFizd+eXwvUorOHz4Sx+Lxl9CZT7TZi5SrmAC3DWiYu1mKFy+Z8E2KYvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657176; c=relaxed/simple;
	bh=8Sub0P0wBitsQtcQWQoClr/YneNNLGxR7ML8aT1JB/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U27+Z+4QpBhMK1biKZkVUoOjT/hkdeVLENV3haARou8LADhi/aD+HjbiKDBYGg8Gs9f85NfLKN3Hz5h7AQuefcFwIeAQAtnX3jQeuc50ZvA0uuISGWyFNPLBbBcgW4afzzAW2B4ZTjvhGyOrWX4OPXy9Km4q4qmyZvTyB6uPbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHC4m97+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770657176; x=1802193176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Sub0P0wBitsQtcQWQoClr/YneNNLGxR7ML8aT1JB/s=;
  b=LHC4m97+tJGsyDyCZZ3EnrUVfgr0kLbTygoZ2taSLjVFlhpAXNASivlY
   A75UGqHUm2zM4qw79+sv6eq+/QWgB1R4LynYt5muKecY8khZnrcJ9zALz
   ie4+QSVrmzRsgcvLMnefgFONcIXUdR/JhmacPX6c2z1JO+/2OnxezXaWF
   vatCBZLwQBlPmI0OP2H2oFt2kLLeTOtzZSKfiUOvMz+Vky3iSmZMnI+yu
   jWCyJbNLcU4cxU/o9vvwKHNWfWqlLo438ILpEp6doAc5KOPPaN42PbVaW
   TRsEponN29Un3c5dX+s/3ebt/Mhe0+1rjl3x94YwfhAGfsUvLyGHJO8gj
   w==;
X-CSE-ConnectionGUID: PBu4U34OQGy2Kt+LFKftyQ==
X-CSE-MsgGUID: QY8JEh6hQ5iSsXuX1jcpPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71812466"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="71812466"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 09:12:56 -0800
X-CSE-ConnectionGUID: kodm8n0eQkyUGfi1VPkc5A==
X-CSE-MsgGUID: Q2xaUuuRTp+sireEBbIn9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="211699525"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 09:12:49 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpUoY-00000000o9a-0q0J;
	Mon, 09 Feb 2026 17:12:46 +0000
Date: Tue, 10 Feb 2026 01:12:17 +0800
From: kernel test robot <lkp@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	hannes@cmpxchg.org, hughd@google.com, yosry.ahmed@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com,
	joshua.hahnjy@gmail.com
Subject: Re: [PATCH v3 09/20] mm: swap: allocate a virtual swap slot for each
 swapped out page
Message-ID: <202602100110.Au8uHgc8-lkp@intel.com>
References: <20260208215839.87595-10-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208215839.87595-10-nphamcs@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13810-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 73B29112F0B
X-Rspamd-Action: no action

Hi Nhat,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.19]
[cannot apply to akpm-mm/mm-everything tj-cgroup/for-next tip/smp/core next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/swap-rearrange-the-swap-header-file/20260209-065842
base:   linus/master
patch link:    https://lore.kernel.org/r/20260208215839.87595-10-nphamcs%40gmail.com
patch subject: [PATCH v3 09/20] mm: swap: allocate a virtual swap slot for each swapped out page
config: s390-randconfig-r134-20260209 (https://download.01.org/0day-ci/archive/20260210/202602100110.Au8uHgc8-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260210/202602100110.Au8uHgc8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602100110.Au8uHgc8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/vswap.c:653:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t * @@
   mm/vswap.c:653:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/vswap.c:653:9: sparse:     got struct local_lock_t *
>> mm/vswap.c:653:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t * @@
   mm/vswap.c:653:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/vswap.c:653:9: sparse:     got struct local_lock_t *
   mm/vswap.c:665:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t * @@
   mm/vswap.c:665:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/vswap.c:665:9: sparse:     got struct local_lock_t *
   mm/vswap.c:665:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t * @@
   mm/vswap.c:665:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/vswap.c:665:9: sparse:     got struct local_lock_t *
   mm/vswap.c:182:36: sparse: sparse: context imbalance in 'vswap_iter' - unexpected unlock
   mm/vswap.c:284:17: sparse: sparse: context imbalance in 'vswap_alloc' - different lock contexts for basic block
   mm/vswap.c:413:19: sparse: sparse: context imbalance in 'vswap_free' - unexpected unlock
   mm/vswap.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'folio_alloc_swap' - unexpected unlock
   mm/vswap.c:570:9: sparse: sparse: context imbalance in 'swp_entry_to_swp_slot' - unexpected unlock

vim +653 mm/vswap.c

   643	
   644	static int vswap_cpu_dead(unsigned int cpu)
   645	{
   646		struct percpu_vswap_cluster *percpu_cluster;
   647		struct vswap_cluster *cluster;
   648		int order;
   649	
   650		percpu_cluster = per_cpu_ptr(&percpu_vswap_cluster, cpu);
   651	
   652		rcu_read_lock();
 > 653		local_lock(&percpu_cluster->lock);
   654		for (order = 0; order < SWAP_NR_ORDERS; order++) {
   655			cluster = percpu_cluster->clusters[order];
   656			if (cluster) {
   657				percpu_cluster->clusters[order] = NULL;
   658				spin_lock(&cluster->lock);
   659				cluster->cached = false;
   660				if (refcount_dec_and_test(&cluster->refcnt))
   661					vswap_cluster_free(cluster);
   662				spin_unlock(&cluster->lock);
   663			}
   664		}
   665		local_unlock(&percpu_cluster->lock);
   666		rcu_read_unlock();
   667	
   668		return 0;
   669	}
   670	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

