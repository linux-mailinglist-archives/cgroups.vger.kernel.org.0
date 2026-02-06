Return-Path: <cgroups+bounces-13757-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLyvLoZ6hmm2NwQAu9opvQ
	(envelope-from <cgroups+bounces-13757-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 00:34:30 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39337104285
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 00:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3476D3031B36
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8430BB85;
	Fri,  6 Feb 2026 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UfeA1jSy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C823C8A0
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770420865; cv=none; b=aNy+RLXopEAY/7zIhxt9qPaNyA8ooCin8x+iYt38mHqxNMY/OaZFZQHBiWFtDnUnoD2uyi2IXIOizqWd63Y09N//2RXLVAAIDmcZ5CNoixzBGTPst7fAfQYV8/LJOiUJ/UQ5fjS0kkUv1JUXA4QKGxI6qkKjeGYeZXbCOzMtoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770420865; c=relaxed/simple;
	bh=pt1gW3EwtCjeyEcc4JRb95CY67YKCerkoRsDTy2gRUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcN3cwhuvmudlkQkg/35ZXrzqitgppKBohJZFphFb5PvhFxhpEkOU9uXDpOYDbxr0SctKaWrdwYxaCJ6Mjy1+UxrP/5TFFgE/7YX6CntDOpG6TpOwKZkcncpq7Ik0IQHMxGpJvUN2zG9nKuIjQa3gxzQWlqx8E/vSl0UZRo+CS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UfeA1jSy; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Feb 2026 15:34:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770420863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/95J67fXqSWtWPcMB6TuDp3d6eu7CAewNBLcn/8dhY=;
	b=UfeA1jSyV+OqIfwBh0CAxmexGOP9K7hGF9UiD7EqHITc68VhZE8JBYzCyE3Z1tXBTGs9m+
	tPTk66jat6OESVZQjq6oEK+ewBXmonqtlxK8P/fZm/Tr5lhiz/6l+2FHg7++359oEQDrVD
	V37sykWOiA8qulJHzJAyipLGHm06vRk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: kernel test robot <lkp@intel.com>, hannes@cmpxchg.org, 
	hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com, 
	oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 24/31] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <aYZ6PxkkLj3aNGuk@linux.dev>
References: <e27edb311dda624751cb41860237f290de8c16ae.1770279888.git.zhengqi.arch@bytedance.com>
 <202602052203.U8hxsh2N-lkp@intel.com>
 <cbb1ba53-134b-487f-87c0-85ca4791773e@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbb1ba53-134b-487f-87c0-85ca4791773e@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13757-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:mid,linux.dev:dkim,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39337104285
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 02:13:32PM +0800, Qi Zheng wrote:
> 
> 
> On 2/5/26 11:02 PM, kernel test robot wrote:
> > Hi Qi,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on next-20260204]
> > [cannot apply to akpm-mm/mm-everything brauner-vfs/vfs.all trace/for-next tj-cgroup/for-next linus/master dennis-percpu/for-next v6.19-rc8 v6.19-rc7 v6.19-rc6 v6.19-rc8]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-memcontrol-remove-dead-code-of-checking-parent-memory-cgroup/20260205-170812
> > base:   next-20260204
> > patch link:    https://lore.kernel.org/r/e27edb311dda624751cb41860237f290de8c16ae.1770279888.git.zhengqi.arch%40bytedance.com
> > patch subject: [PATCH v4 24/31] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
> > config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260205/202602052203.U8hxsh2N-lkp@intel.com/config)
> > compiler: nios2-linux-gcc (GCC) 11.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602052203.U8hxsh2N-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202602052203.U8hxsh2N-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >     nios2-linux-ld: mm/swap.o: in function `__page_cache_release.part.0':
> >     swap.c:(.text+0x4c): undefined reference to `lruvec_unlock_irqrestore'
> > > > swap.c:(.text+0x4c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
> >     nios2-linux-ld: mm/swap.o: in function `__folio_put':
> >     swap.c:(.text+0x2ac): undefined reference to `lruvec_unlock_irqrestore'
> >     swap.c:(.text+0x2ac): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
> >     nios2-linux-ld: mm/swap.o: in function `folios_put_refs':
> >     swap.c:(.text+0x384): undefined reference to `lruvec_unlock_irqrestore'
> >     swap.c:(.text+0x384): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
> >     nios2-linux-ld: mm/swap.o: in function `folio_batch_move_lru':
> >     swap.c:(.text+0x4ac): undefined reference to `lruvec_unlock_irqrestore'
> >     swap.c:(.text+0x4ac): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
> > > > nios2-linux-ld: swap.c:(.text+0x50c): undefined reference to `lruvec_unlock_irqrestore'
> >     swap.c:(.text+0x50c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irqrestore'
> >     nios2-linux-ld: mm/swap.o: in function `folio_activate':
> >     swap.c:(.text+0x21d8): undefined reference to `lruvec_unlock_irq'
> > > > swap.c:(.text+0x21d8): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
> >     nios2-linux-ld: mm/vmscan.o: in function `move_folios_to_lru':
> >     vmscan.c:(.text+0xa4c): undefined reference to `lruvec_unlock_irq'
> > > > vmscan.c:(.text+0xa4c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
> > > > nios2-linux-ld: vmscan.c:(.text+0xaa4): undefined reference to `lruvec_unlock_irq'
> >     vmscan.c:(.text+0xaa4): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
> >     nios2-linux-ld: vmscan.c:(.text+0xcac): undefined reference to `lruvec_unlock_irq'
> >     vmscan.c:(.text+0xcac): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
> >     nios2-linux-ld: vmscan.c:(.text+0xd8c): undefined reference to `lruvec_unlock_irq'
> >     vmscan.c:(.text+0xd8c): relocation truncated to fit: R_NIOS2_CALL26 against `lruvec_unlock_irq'
> >     nios2-linux-ld: mm/vmscan.o: in function `shrink_active_list':
> >     vmscan.c:(.text+0x11e0): undefined reference to `lruvec_lock_irq'
> >     vmscan.c:(.text+0x11e0): additional relocation overflows omitted from the output
> >     nios2-linux-ld: vmscan.c:(.text+0x12a0): undefined reference to `lruvec_unlock_irq'
> > > > nios2-linux-ld: vmscan.c:(.text+0x144c): undefined reference to `lruvec_lock_irq'
> >     nios2-linux-ld: mm/vmscan.o: in function `check_move_unevictable_folios':
> >     vmscan.c:(.text+0x15d4): undefined reference to `lruvec_unlock_irq'
> >     nios2-linux-ld: vmscan.c:(.text+0x1958): undefined reference to `lruvec_unlock_irq'
> >     nios2-linux-ld: mm/vmscan.o: in function `shrink_inactive_list':
> >     vmscan.c:(.text+0x2f8c): undefined reference to `lruvec_lock_irq'
> >     nios2-linux-ld: vmscan.c:(.text+0x307c): undefined reference to `lruvec_unlock_irq'
> >     nios2-linux-ld: vmscan.c:(.text+0x31dc): undefined reference to `lruvec_lock_irq'
> >     nios2-linux-ld: mm/vmscan.o: in function `folio_isolate_lru':
> >     vmscan.c:(.text+0x48a4): undefined reference to `lruvec_unlock_irq'
> >     nios2-linux-ld: mm/mlock.o: in function `__munlock_folio':
> >     mlock.c:(.text+0x968): undefined reference to `lruvec_unlock_irq'
> >     nios2-linux-ld: mm/mlock.o: in function `__mlock_folio':
> >     mlock.c:(.text+0xe5c): undefined reference to `lruvec_unlock_irq'
> >     nios2-linux-ld: mm/mlock.o: in function `mlock_folio_batch.constprop.0':
> >     mlock.c:(.text+0x158c): undefined reference to `lruvec_unlock_irq'
> > > > nios2-linux-ld: mlock.c:(.text+0x1808): undefined reference to `lruvec_unlock_irq'
> 
> Ouch, I move lruvec_lock_irq() and its firends to memcontrol.c to fix
> the compilation errors related to __acquires/__releases, but I forgot
> that memcontrol.c will only be compiled under CONFIG_MEMCG.
> 
> Hi Shakeel, for simplicity, perhaps keeping lruvec_lock_irq() and its
> firends in memcontrol.h and drop __acquires/__releases would be a
> better option?

Yes, let's proceed with that for now. We can always improve this later.


