Return-Path: <cgroups+bounces-13856-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHZEFKKHjGmHqgAAu9opvQ
	(envelope-from <cgroups+bounces-13856-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 14:44:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB7124E1B
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 14:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C105B301ECD2
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836E2DC781;
	Wed, 11 Feb 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPVjVjWD"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB9191F94;
	Wed, 11 Feb 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817416; cv=none; b=S+tzmVn0ClHLH33aCucEWqFxTLzdYV+1885Du3z+HVO2jzIb16lh4Ize1jVtOxAjvueY/0f6jHRqGFKD3XdrNivFc+P4i0p77OaiaK3ifqEvEYmKTZRyozpmWrfqagLGupDMyMznFAhVufAGv0A9Cr7ZZHe9VDaa5acJs9W4jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817416; c=relaxed/simple;
	bh=wEJz6UAJ/YDJm9FyFpIp7xlD4O0stl9h6zZkBnYZOxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8pG8ycnKDtg7e6rMlAmx0O+RcW5OMeFz0WyFbRiYZnaRo+B/ZT79RNUWkzMiA/U/4ZCNZl/waXQ/x8rbXNlzuN4vHzQO422AVFW5cyXgf+Os6rnFqK5zPkAnSJOAxmc9jLdFq3mT8MaqNpYA4paTntLv2PRKGWxMO5+t8lRkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPVjVjWD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770817414; x=1802353414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wEJz6UAJ/YDJm9FyFpIp7xlD4O0stl9h6zZkBnYZOxY=;
  b=JPVjVjWD4kyRd1qzcjvV4vKwQ9g65zCyTJ38jnksskggw1+kSlwzD64S
   gk8wjXLAjydS+YjDPXUz634XK0wGBilYlaYmTNpiZDTSNWqxgT4of9J4+
   Hv8+v5LdV+DY9g77r00QcBAwTie2ARNM6bjyTHVh+iV0bbIdqgotOTVVl
   xcOhxlSK+vIBZEw1w6BJk2UKcG8reyFewVs8fhRVvLCyvR0xEg96jm1Mw
   kVf85ibOWzbNF0BrC+VdT4Cw/9tRrB+6jm9B59PQpAMDJchKjPf3LMSXo
   rZHPVLQ6JCuDTInj7fdr6ufvpcYaY35FwhhrXGFtqy7zI/zT4+/3CdMxP
   g==;
X-CSE-ConnectionGUID: FTS3Gya0TeaMDlKI6fI4lg==
X-CSE-MsgGUID: TkP0yNLXQ26VGowlbX52lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72007570"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72007570"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:43:33 -0800
X-CSE-ConnectionGUID: R3H5VLSkRWCLn8vcnT5v2A==
X-CSE-MsgGUID: n5aq+60TScCI4U8b3U0n8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216757612"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 11 Feb 2026 05:43:26 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqAV2-0000000015Z-01aG;
	Wed, 11 Feb 2026 13:43:24 +0000
Date: Wed, 11 Feb 2026 14:42:24 +0100
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
Message-ID: <202602111445.rP38hmwx-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13856-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,01.org:url]
X-Rspamd-Queue-Id: AFEB7124E1B
X-Rspamd-Action: no action

Hi Nhat,

kernel test robot noticed the following build errors:

[auto build test ERROR on 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/mm-swap-decouple-swap-cache-from-physical-swap-infrastructure/20260209-120606
base:   05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
patch link:    https://lore.kernel.org/r/20260208215839.87595-10-nphamcs%40gmail.com
patch subject: [PATCH v3 09/20] mm: swap: allocate a virtual swap slot for each swapped out page
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260211/202602111445.rP38hmwx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602111445.rP38hmwx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602111445.rP38hmwx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/local_lock.h:5,
                    from include/linux/mmzone.h:24,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/vswap.c:7:
   mm/vswap.c: In function 'vswap_cpu_dead':
>> include/linux/percpu-defs.h:221:45: error: initialization from pointer to non-enclosed address space
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:105:40: note: in definition of macro '__local_lock_acquire'
     105 |                 __l = (local_lock_t *)(lock);                           \
         |                                        ^~~~
   include/linux/local_lock.h:17:41: note: in expansion of macro '__local_lock'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:17:54: note: in expansion of macro 'this_cpu_ptr'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                                      ^~~~~~~~~~~~
   mm/vswap.c:653:9: note: in expansion of macro 'local_lock'
     653 |         local_lock(&percpu_cluster->lock);
         |         ^~~~~~~~~~
   include/linux/percpu-defs.h:221:45: note: expected 'const __seg_gs void *' but pointer is of type 'local_lock_t *'
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:105:40: note: in definition of macro '__local_lock_acquire'
     105 |                 __l = (local_lock_t *)(lock);                           \
         |                                        ^~~~
   include/linux/local_lock.h:17:41: note: in expansion of macro '__local_lock'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:17:54: note: in expansion of macro 'this_cpu_ptr'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                                      ^~~~~~~~~~~~
   mm/vswap.c:653:9: note: in expansion of macro 'local_lock'
     653 |         local_lock(&percpu_cluster->lock);
         |         ^~~~~~~~~~
>> include/linux/percpu-defs.h:221:45: error: initialization from pointer to non-enclosed address space
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:107:27: note: in definition of macro '__local_lock_acquire'
     107 |                 _Generic((lock),                                        \
         |                           ^~~~
   include/linux/local_lock.h:17:41: note: in expansion of macro '__local_lock'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:17:54: note: in expansion of macro 'this_cpu_ptr'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                                      ^~~~~~~~~~~~
   mm/vswap.c:653:9: note: in expansion of macro 'local_lock'
     653 |         local_lock(&percpu_cluster->lock);
         |         ^~~~~~~~~~
   include/linux/percpu-defs.h:221:45: note: expected 'const __seg_gs void *' but pointer is of type 'local_lock_t *'
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:107:27: note: in definition of macro '__local_lock_acquire'
     107 |                 _Generic((lock),                                        \
         |                           ^~~~
   include/linux/local_lock.h:17:41: note: in expansion of macro '__local_lock'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:17:54: note: in expansion of macro 'this_cpu_ptr'
      17 | #define local_lock(lock)                __local_lock(this_cpu_ptr(lock))
         |                                                      ^~~~~~~~~~~~
   mm/vswap.c:653:9: note: in expansion of macro 'local_lock'
     653 |         local_lock(&percpu_cluster->lock);
         |         ^~~~~~~~~~
>> include/linux/percpu-defs.h:221:45: error: initialization from pointer to non-enclosed address space
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:176:40: note: in definition of macro '__local_lock_release'
     176 |                 __l = (local_lock_t *)(lock);                           \
         |                                        ^~~~
   include/linux/local_lock.h:38:41: note: in expansion of macro '__local_unlock'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:38:56: note: in expansion of macro 'this_cpu_ptr'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                                        ^~~~~~~~~~~~
   mm/vswap.c:665:9: note: in expansion of macro 'local_unlock'
     665 |         local_unlock(&percpu_cluster->lock);
         |         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:221:45: note: expected 'const __seg_gs void *' but pointer is of type 'local_lock_t *'
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:176:40: note: in definition of macro '__local_lock_release'
     176 |                 __l = (local_lock_t *)(lock);                           \
         |                                        ^~~~
   include/linux/local_lock.h:38:41: note: in expansion of macro '__local_unlock'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:38:56: note: in expansion of macro 'this_cpu_ptr'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                                        ^~~~~~~~~~~~
   mm/vswap.c:665:9: note: in expansion of macro 'local_unlock'
     665 |         local_unlock(&percpu_cluster->lock);
         |         ^~~~~~~~~~~~
>> include/linux/percpu-defs.h:221:45: error: initialization from pointer to non-enclosed address space
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:179:27: note: in definition of macro '__local_lock_release'
     179 |                 _Generic((lock),                                        \
         |                           ^~~~
   include/linux/local_lock.h:38:41: note: in expansion of macro '__local_unlock'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:38:56: note: in expansion of macro 'this_cpu_ptr'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                                        ^~~~~~~~~~~~
   mm/vswap.c:665:9: note: in expansion of macro 'local_unlock'
     665 |         local_unlock(&percpu_cluster->lock);
         |         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:221:45: note: expected 'const __seg_gs void *' but pointer is of type 'local_lock_t *'
     221 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                             ^
   include/linux/local_lock_internal.h:179:27: note: in definition of macro '__local_lock_release'
     179 |                 _Generic((lock),                                        \
         |                           ^~~~
   include/linux/local_lock.h:38:41: note: in expansion of macro '__local_unlock'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                         ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:245:9: note: in expansion of macro '__verify_pcpu_ptr'
     245 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:256:27: note: in expansion of macro 'raw_cpu_ptr'
     256 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/local_lock.h:38:56: note: in expansion of macro 'this_cpu_ptr'
      38 | #define local_unlock(lock)              __local_unlock(this_cpu_ptr(lock))
         |                                                        ^~~~~~~~~~~~
   mm/vswap.c:665:9: note: in expansion of macro 'local_unlock'
     665 |         local_unlock(&percpu_cluster->lock);
         |         ^~~~~~~~~~~~


vim +221 include/linux/percpu-defs.h

62fde54123fb64 Tejun Heo 2014-06-17  207  
9c28278a24c01c Tejun Heo 2014-06-17  208  /*
6fbc07bbe2b5a8 Tejun Heo 2014-06-17  209   * __verify_pcpu_ptr() verifies @ptr is a percpu pointer without evaluating
6fbc07bbe2b5a8 Tejun Heo 2014-06-17  210   * @ptr and is invoked once before a percpu area is accessed by all
6fbc07bbe2b5a8 Tejun Heo 2014-06-17  211   * accessors and operations.  This is performed in the generic part of
6fbc07bbe2b5a8 Tejun Heo 2014-06-17  212   * percpu and arch overrides don't need to worry about it; however, if an
6fbc07bbe2b5a8 Tejun Heo 2014-06-17  213   * arch wants to implement an arch-specific percpu accessor or operation,
6fbc07bbe2b5a8 Tejun Heo 2014-06-17  214   * it may use __verify_pcpu_ptr() to verify the parameters.
9c28278a24c01c Tejun Heo 2014-06-17  215   *
9c28278a24c01c Tejun Heo 2014-06-17  216   * + 0 is required in order to convert the pointer type from a
9c28278a24c01c Tejun Heo 2014-06-17  217   * potential array type to a pointer to a single item of the array.
9c28278a24c01c Tejun Heo 2014-06-17  218   */
eba117889ac444 Tejun Heo 2014-06-17  219  #define __verify_pcpu_ptr(ptr)						\
eba117889ac444 Tejun Heo 2014-06-17  220  do {									\
9c28278a24c01c Tejun Heo 2014-06-17 @221  	const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;	\
9c28278a24c01c Tejun Heo 2014-06-17  222  	(void)__vpp_verify;						\
9c28278a24c01c Tejun Heo 2014-06-17  223  } while (0)
9c28278a24c01c Tejun Heo 2014-06-17  224  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

