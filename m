Return-Path: <cgroups+bounces-13716-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOXYMUWxhGk54wMAu9opvQ
	(envelope-from <cgroups+bounces-13716-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 16:03:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF14F4614
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 16:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 216F73001F83
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51894421898;
	Thu,  5 Feb 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKrljSHf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96B41324C;
	Thu,  5 Feb 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303802; cv=none; b=K7RyGW58QiAKSybFQNsa3HXnf93isaMYUhSbucW3rQ+5QX1FugeD8SIveF8yrPIvbBFBWLHPxbqwlK9zyobuTov5MTezWizNqiS2aool7WCcRs7E5aKGddzlbpcN4XmrGVGyDqiySZNEIk0sK0FUDPQOPo5RgM4DgvgvuZFkuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303802; c=relaxed/simple;
	bh=Zpzmafaxz3oopy0yMeDp4c8Ycv/ED5wfk9nLDnD++1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4MHz5K7yvil5dsp4ptz5MCX84KAQFbtTKzxO496PWXl/I3YVGR1TxV0H0SFrMxJKh/Zo9TMxzCGnt29hi5nToa6JPwzUUe24bbJn4NCF1B4qeXAFujSNRBcRRYQybM8rlyb7HnRkMn1EqcbKXQ7d0oqZAyzQsCAVdtWMqj1Xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKrljSHf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770303801; x=1801839801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zpzmafaxz3oopy0yMeDp4c8Ycv/ED5wfk9nLDnD++1Y=;
  b=XKrljSHfUCvLEJv1roHJv82TjRL61o+o9zvoG+piHj1Jm/kvC32QIc/P
   LNySdWzmW5eaCAtGCZxvj/aU2LxxM/K+YyPuPUoKzPYCs3fcxQwHVg2aX
   QLpcG8LvE4JhvrrJQewIeWXYUgCxu6gNFsopxAuYiFL/59d7UYL36UG+1
   GmAJvX/fqHAE2GaGKhSPZW/Ta23Il19lkTy4/QT/U7expnCpdBzMy2ToK
   PgRUMlPQG132IxXN55L62HXEgif3zHBpGdXSgVyKn7A+5hPcUgu9GH1yu
   2cyCi9z3aWUng3/6tzSixtOttSYkAJpIVwZu+fz5bBEINrGzTvIB2azJ3
   g==;
X-CSE-ConnectionGUID: 6Ns3AljzS8uPIXL6FdUZVQ==
X-CSE-MsgGUID: BYqP3lCOSoiE07SPudfgaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82873876"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82873876"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 07:03:20 -0800
X-CSE-ConnectionGUID: R/yYo2qkSN2DEOwemuREZg==
X-CSE-MsgGUID: D0Ua/ykVQeCWN8y2HdhW9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210468515"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2026 07:03:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo0sw-00000000juG-0Y00;
	Thu, 05 Feb 2026 15:03:10 +0000
Date: Thu, 5 Feb 2026 23:02:46 +0800
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
Message-ID: <202602052247.VAoEwR9g-lkp@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13716-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[git-scm.com:query timed out,intel.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[lkp.intel.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2BF14F4614
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
config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20260205/202602052247.VAoEwR9g-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602052247.VAoEwR9g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602052247.VAoEwR9g-lkp@intel.com/

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: mm/swap.o:(.text+0x40): undefined reference to `lruvec_unlock_irqrestore'
   xtensa-linux-ld: mm/swap.o: in function `__page_cache_release.part.0':
   swap.c:(.text+0x60): undefined reference to `lruvec_unlock_irqrestore'
   xtensa-linux-ld: mm/swap.o: in function `__folio_put':
   swap.c:(.text+0x1a6): undefined reference to `lruvec_unlock_irqrestore'
   xtensa-linux-ld: mm/swap.o: in function `folios_put_refs':
   swap.c:(.text+0x276): undefined reference to `lruvec_unlock_irqrestore'
   xtensa-linux-ld: mm/swap.o: in function `folio_batch_move_lru':
   swap.c:(.text+0x31a): undefined reference to `lruvec_unlock_irqrestore'
   xtensa-linux-ld: mm/swap.o:swap.c:(.text+0x354): more undefined references to `lruvec_unlock_irqrestore' follow
   xtensa-linux-ld: mm/swap.o: in function `lru_note_cost_refault':
   swap.c:(.text+0x1340): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: mm/swap.o: in function `folio_activate':
   swap.c:(.text+0x136c): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: mm/vmscan.o: in function `check_move_unevictable_folios':
   vmscan.c:(.text+0x762): undefined reference to `lruvec_unlock_irq'
>> xtensa-linux-ld: vmscan.c:(.text+0x972): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: mm/vmscan.o: in function `move_folios_to_lru':
   vmscan.c:(.text+0xa22): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: mm/vmscan.o:vmscan.c:(.text+0xa58): more undefined references to `lruvec_unlock_irq' follow
   xtensa-linux-ld: mm/vmscan.o: in function `move_folios_to_lru':
   vmscan.c:(.text+0xc40): undefined reference to `lruvec_lock_irq'
   xtensa-linux-ld: mm/vmscan.o: in function `shrink_active_list':
   vmscan.c:(.text+0xc9b): undefined reference to `lruvec_lock_irq'
   xtensa-linux-ld: vmscan.c:(.text+0xcfc): undefined reference to `lruvec_unlock_irq'
>> xtensa-linux-ld: vmscan.c:(.text+0xe39): undefined reference to `lruvec_lock_irq'
   xtensa-linux-ld: mm/vmscan.o: in function `shrink_inactive_list':
   vmscan.c:(.text+0x1d32): undefined reference to `lruvec_lock_irq'
   xtensa-linux-ld: vmscan.c:(.text+0x1e46): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: vmscan.c:(.text+0x1f3a): undefined reference to `lruvec_lock_irq'
   xtensa-linux-ld: mm/vmscan.o: in function `folio_isolate_lru':
   vmscan.c:(.text+0x2eb4): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: mm/mlock.o: in function `__munlock_folio':
   mlock.c:(.text+0x5cc): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: mm/mlock.o: in function `__mlock_folio':
   mlock.c:(.text+0x8b3): undefined reference to `lruvec_unlock_irq'
   xtensa-linux-ld: mm/mlock.o: in function `mlock_folio_batch.constprop.0':
   mlock.c:(.text+0xd15): undefined reference to `lruvec_unlock_irq'
>> xtensa-linux-ld: mlock.c:(.text+0xe70): undefined reference to `lruvec_unlock_irq'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

