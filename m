Return-Path: <cgroups+bounces-14633-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCAtLB01qWlH3AAAu9opvQ
	(envelope-from <cgroups+bounces-14633-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:47:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A8520CDFD
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2A063020218
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DDE31F983;
	Thu,  5 Mar 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HIUBD1Is"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A514EC73
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696852; cv=none; b=NEkuVLrHub9fgj9jYZfa9eZFlTRbhTxEpWd6hKdhZ+Nk5Q6jELzKCItj8/B3J/DZ5X0S2Kfa9fkLvhfTVU2r6GxsaBP50Nq7S5B4oCbXt+4Gf9ovEpAh5B60d4BHXisrX3yJX3oFCsHMkmmKgBnpORX6NmreNPBIooOcfj1D12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696852; c=relaxed/simple;
	bh=A7r5JUDLIbWdZBIBfoX0e7lLv65Mt+iLGAcydteV/cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYcY6v+ENpNbtp05/SSsONNdIoFc7l+3ndjyek58QPkcmsiTx4l4sbBgVg5c2mUNGlF1AsMwMmH8EoOHMmd+0pzzjpHtIF4cYfIo6pcCSq9/lMs10zWgmuPNYadJiNA0mglY8OxnwdKGMhf5+FGjzwiqJlKHSirIA8eSdJsMhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HIUBD1Is; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Mar 2026 15:47:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772696846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKeJ7rMALYTbebsY+kRx+KAJHf7HkxWsA8p9wEo81Rc=;
	b=HIUBD1IsTFwPZ4qEjY/0K3tu4spsSjCBv9LEDoadmVWlxoimJNXZbtQnZuhYoozLN9lIh6
	yX2QtLVwxcO6I5E87dHbUAbmbSGOloHzhyD7Qe1JWS/A4YNXr4vCjWgcoOnlyVX0c7p90u
	0xThu9wpor+iBCIhzgduOWfywjKUr5Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, vbabka@suse.cz, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, cl@gentwo.org, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com, pfalcato@suse.de
Subject: Re: [PATCH] mm/slab: change stride type from unsigned short to
 unsigned int
Message-ID: <osbee2ajebflm2rlcyh6qe5yhra6zulmjyz5j775z4pcmsxrmy@qgs6pi4s4fpd>
References: <20260303135722.2680521-1-harry.yoo@oracle.com>
 <41f1c856-2c41-4d11-96e6-079d95d8efbb@linux.ibm.com>
 <aakrMQ9fKG52WtxE@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aakrMQ9fKG52WtxE@hyeyoo>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A1A8520CDFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14633-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,oracle.com:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 04:05:21PM +0900, Harry Yoo wrote:
> On Thu, Mar 05, 2026 at 12:24:08PM +0530, Venkat Rao Bagalkote wrote:
> > On 03/03/26 7:27 pm, Harry Yoo wrote:
> > > Commit 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > > defined the type of slab->stride as unsigned short, because the author
> > > initially planned to store stride within the lower 16 bits of the
> > > page_type field, but later stored it in unused bits in the counters
> > > field instead.
> > > 
> > > However, the idea of having only 2-byte stride turned out to be a
> > > serious mistake. On systems with 64k pages, order-1 pages are 128k,
> > > which is larger than USHRT_MAX. It triggers a debug warning because
> > > s->size is 128k while stride, truncated to 2 bytes, becomes zero:
> > > 
> > >    ------------[ cut here ]------------
> > >    Warning! stride (0) != s->size (131072)
> > >    WARNING: mm/slub.c:2231 at alloc_slab_obj_exts_early.constprop.0+0x524/0x534, CPU#6: systemd-sysctl/307
> > >    Modules linked in:
> > >    CPU: 6 UID: 0 PID: 307 Comm: systemd-sysctl Not tainted 7.0.0-rc1+ #6 PREEMPTLAZY
> > >    Hardware name: IBM,9009-22A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.E0 (VL950_179) hv:phyp pSeries
> > >    NIP:  c0000000008a9ac0 LR: c0000000008a9abc CTR: 0000000000000000
> > >    REGS: c0000000141f7390 TRAP: 0700   Not tainted  (7.0.0-rc1+)
> > >    MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28004400  XER: 00000005
> > >    CFAR: c000000000279318 IRQMASK: 0
> > >    GPR00: c0000000008a9abc c0000000141f7630 c00000000252a300 c00000001427b200
> > >    GPR04: 0000000000000004 0000000000000000 c000000000278fd0 0000000000000000
> > >    GPR08: fffffffffffe0000 0000000000000000 0000000000000000 0000000022004400
> > >    GPR12: c000000000f644b0 c000000017ff8f00 0000000000000000 0000000000000000
> > >    GPR16: 0000000000000000 c0000000141f7aa0 0000000000000000 c0000000141f7a88
> > >    GPR20: 0000000000000000 0000000000400cc0 ffffffffffffffff c00000001427b180
> > >    GPR24: 0000000000000004 00000000000c0cc0 c000000004e89a20 c00000005de90011
> > >    GPR28: 0000000000010010 c00000005df00000 c000000006017f80 c00c000000177a00
> > >    NIP [c0000000008a9ac0] alloc_slab_obj_exts_early.constprop.0+0x524/0x534
> > >    LR [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534
> > >    Call Trace:
> > >    [c0000000141f7630] [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534 (unreliable)
> > >    [c0000000141f76c0] [c0000000008aafbc] allocate_slab+0x154/0x94c
> > >    [c0000000141f7760] [c0000000008b41c0] refill_objects+0x124/0x16c
> > >    [c0000000141f77c0] [c0000000008b4be0] __pcs_replace_empty_main+0x2b0/0x444
> > >    [c0000000141f7810] [c0000000008b9600] __kvmalloc_node_noprof+0x840/0x914
> > >    [c0000000141f7900] [c000000000a3dd40] seq_read_iter+0x60c/0xb00
> > >    [c0000000141f7a10] [c000000000b36b24] proc_reg_read_iter+0x154/0x1fc
> > >    [c0000000141f7a50] [c0000000009cee7c] vfs_read+0x39c/0x4e4
> > >    [c0000000141f7b30] [c0000000009d0214] ksys_read+0x9c/0x180
> > >    [c0000000141f7b90] [c00000000003a8d0] system_call_exception+0x1e0/0x4b0
> > >    [c0000000141f7e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> > > 
> > > This leads to slab_obj_ext() returning the first slabobj_ext or all
> > > objects and confuses the reference counting of object cgroups [1] and
> > > memory (un)charging for memory cgroups [2].
> > > 
> > > Fortunately, the counters field has 32 unused bits instead of 16
> > > on 64-bit CPUs, which is wide enough to hold any value of s->size.
> > > Change the type to unsigned int.
> > > 
> > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com
> > > Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com
> > > Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > > 
> > > Hi Venkat, could you please test this on top of 7.0-rc2 (instead of
> > > 7.0-rc1) and see if the bugs [1] [2] are reproduced on your machine?
> > 
> > 
> > Hello Harry,
> > 
> > Apologizes for delayed response,
> 
> No worries.
> 
> > I was out sick.
> 
> Ouch :( hope you feel better now.
> 
> > I have tested this patch on top of 7.0-rc2, and confirm, this patch fixes
> > both the reported issue.
> >
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> Thanks a lot for testing & confirming!

Indeed!
What a counterintuitive issue!

-- 
Thanks,
Hao

