Return-Path: <cgroups+bounces-13717-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFCLAJqxhGk54wMAu9opvQ
	(envelope-from <cgroups+bounces-13717-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 16:04:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0264AF4642
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DB34303CD17
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65424218B4;
	Thu,  5 Feb 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRW2pN2a"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF22421895;
	Thu,  5 Feb 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303802; cv=none; b=kNw1/W5y0ncUH/K8IogbSgIXUvw9N4hpmZ9XDEvI9FmAk90Yi3PYKcMfH7LWgukbrH9+qA9uHTQLFM/qSMMiR4DJjWrrEabfFjrwc0v9BSQtHMenjM/MamKdhHTXAQ3mcfPtZ13a/HyIU6X2B3aGeIJ+TK6o05HReWRLcXIMQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303802; c=relaxed/simple;
	bh=QDQNj/v82AkaK8Fs++1Uo4hRK6o19qvCsj3OHG6VXJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/0I3nqsoh+l0gmIEVBFiS10tmH9/NVfO5HuzOwqVzF+YnU7YMqLi4nS2Dx/ZliGSSIraL6xGvCQxyNbqrT3hJyRXb1DsXCooqUJrwMgKaXVxTxndwLBOb+yD/zF5RW8GjLHffm6iPN81uBFj3H6L07GAnc1Lj3ULtSi2D5PTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRW2pN2a; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770303802; x=1801839802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QDQNj/v82AkaK8Fs++1Uo4hRK6o19qvCsj3OHG6VXJg=;
  b=jRW2pN2ai+4BUU4tICqcE+MrkJPSg12Hk4wM/4+QP63hSa3co7HGiIUI
   nMY5T/UM1yQh5+3sa5x6zbVbzaNSVbFWbngZNvdlD6K+kG+L0XyoemTVy
   j+9nkEeSgRAnmF4JMWhdxFrGnpA0XyBIa0fptZBJLJC1NVOCmm4NCnGo2
   gCSlHE6bmF6D2a7iwKFB84HCNo2YpnCmhjM0aygndosq/aozSQglTDWP1
   umuJXGgZBmyoDMOHgX6HGfYK0wbi3wqwgjTPv88gMHXdFCs/jjNKBqqfl
   rKJ9n9G35dpoMC111KXe3KG9+IC0URnKTLSLESq1xTpD9AA1U+h/4It0Q
   g==;
X-CSE-ConnectionGUID: 8+DzLAKsQQ6OEN2o+JgPvQ==
X-CSE-MsgGUID: b2P3OGsTQ1GNcTgN+EQ2bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82873862"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82873862"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 07:03:20 -0800
X-CSE-ConnectionGUID: 4pHOlflUQu6YP/w5VkWf2A==
X-CSE-MsgGUID: Ux6D/JXeROW/jL2EVGXy5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210468516"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2026 07:03:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo0sw-00000000juI-0xrD;
	Thu, 05 Feb 2026 15:03:10 +0000
Date: Thu, 5 Feb 2026 23:02:47 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
	mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 24/31] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <202602052203.U8hxsh2N-lkp@intel.com>
References: <e27edb311dda624751cb41860237f290de8c16ae.1770279888.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27edb311dda624751cb41860237f290de8c16ae.1770279888.git.zhengqi.arch@bytedance.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sea.lore.kernel.org:server fail,01.org:server fail,git-scm.com:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13717-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0264AF4642
X-Rspamd-Action: no action

Hi Qi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260204]
[cannot apply to akpm-mm/mm-everything brauner-vfs/vfs.all trace/for-next tj-cgroup/for-next linus/master dennis-percpu/for-next v6.19-rc8 v6.19-rc7 v6.19-rc6 v6.19-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-memcontrol-remove-dead-code-of-checking-parent-memory-cgroup/20260205-170812
base:   next-20260204
patch link:    https://lore.kernel.org/r/e27edb311dda624751cb41860237f290de8c16ae.1770279888.git.zhengqi.arch%40bytedance.com
patch subject: [PATCH v4 24/31] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260205/202602052203.U8hxsh2N-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602052203.U8hxsh2N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602052203.U8hxsh2N-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: mm/swap.o: in function `__page_cache_release.part.0':
   swap.c:(.text+0x4c): undefined reference to `lruvec_unlock_irqrestore'
>> swap.c:(.text+0x4c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
   nios2-linux-ld: mm/swap.o: in function `__folio_put':
   swap.c:(.text+0x2ac): undefined reference to `lruvec_unlock_irqrestore'
   swap.c:(.text+0x2ac): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
   nios2-linux-ld: mm/swap.o: in function `folios_put_refs':
   swap.c:(.text+0x384): undefined reference to `lruvec_unlock_irqrestore'
   swap.c:(.text+0x384): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
   nios2-linux-ld: mm/swap.o: in function `folio_batch_move_lru':
   swap.c:(.text+0x4ac): undefined reference to `lruvec_unlock_irqrestore'
   swap.c:(.text+0x4ac): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
>> nios2-linux-ld: swap.c:(.text+0x50c): undefined reference to `lruvec_unlock_irqrestore'
   swap.c:(.text+0x50c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
   nios2-linux-ld: mm/swap.o: in function `folio_activate':
   swap.c:(.text+0x21d8): undefined reference to `lruvec_unlock_irq'
>> swap.c:(.text+0x21d8): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
   nios2-linux-ld: mm/vmscan.o: in function `move_folios_to_lru':
   vmscan.c:(.text+0xa4c): undefined reference to `lruvec_unlock_irq'
>> vmscan.c:(.text+0xa4c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
>> nios2-linux-ld: vmscan.c:(.text+0xaa4): undefined reference to `lruvec_unlock_irq'
   vmscan.c:(.text+0xaa4): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
   nios2-linux-ld: vmscan.c:(.text+0xcac): undefined reference to `lruvec_unlock_irq'
   vmscan.c:(.text+0xcac): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
   nios2-linux-ld: vmscan.c:(.text+0xd8c): undefined reference to `lruvec_unlock_irq'
   vmscan.c:(.text+0xd8c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
   nios2-linux-ld: mm/vmscan.o: in function `shrink_active_list':
   vmscan.c:(.text+0x11e0): undefined reference to `lruvec_lock_irq'
   vmscan.c:(.text+0x11e0): additional relocation overflows omitted from the output
   nios2-linux-ld: vmscan.c:(.text+0x12a0): undefined reference to `lruvec_unlock_irq'
>> nios2-linux-ld: vmscan.c:(.text+0x144c): undefined reference to `lruvec_lock_irq'
   nios2-linux-ld: mm/vmscan.o: in function `check_move_unevictable_folios':
   vmscan.c:(.text+0x15d4): undefined reference to `lruvec_unlock_irq'
   nios2-linux-ld: vmscan.c:(.text+0x1958): undefined reference to `lruvec_unlock_irq'
   nios2-linux-ld: mm/vmscan.o: in function `shrink_inactive_list':
   vmscan.c:(.text+0x2f8c): undefined reference to `lruvec_lock_irq'
   nios2-linux-ld: vmscan.c:(.text+0x307c): undefined reference to `lruvec_unlock_irq'
   nios2-linux-ld: vmscan.c:(.text+0x31dc): undefined reference to `lruvec_lock_irq'
   nios2-linux-ld: mm/vmscan.o: in function `folio_isolate_lru':
   vmscan.c:(.text+0x48a4): undefined reference to `lruvec_unlock_irq'
   nios2-linux-ld: mm/mlock.o: in function `__munlock_folio':
   mlock.c:(.text+0x968): undefined reference to `lruvec_unlock_irq'
   nios2-linux-ld: mm/mlock.o: in function `__mlock_folio':
   mlock.c:(.text+0xe5c): undefined reference to `lruvec_unlock_irq'
   nios2-linux-ld: mm/mlock.o: in function `mlock_folio_batch.constprop.0':
   mlock.c:(.text+0x158c): undefined reference to `lruvec_unlock_irq'
>> nios2-linux-ld: mlock.c:(.text+0x1808): undefined reference to `lruvec_unlock_irq'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

