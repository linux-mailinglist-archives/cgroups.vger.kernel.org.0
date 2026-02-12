Return-Path: <cgroups+bounces-13875-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO/sK6MtjWkEzwAAu9opvQ
	(envelope-from <cgroups+bounces-13875-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 02:32:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15844128FD2
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 02:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9933031339
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA4153598;
	Thu, 12 Feb 2026 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FY+TTj8H"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350471EBA19
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770859904; cv=none; b=nrJVUYVh+zyNdrYUT+CoRKpMtCQ1zpOp2PrPawjaO/3oP3YGzjZA5b8YRlohJuNyXJLBYk9pKAsOZSONIjwR78yzgZ0uCqrATNbTLX7ch/wKS9l7zwUVnlgkk6/E/hFolFe8Q0YPeZoQROmjIfaoIVc4XKjJ7i/4JhpSmcZAUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770859904; c=relaxed/simple;
	bh=pZiYxf+c5ZITNbFUO+shyOEPQgky0pXj2sicj4sT0nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0N2+QNTbVRrMk8oXD5Jm6lYxqc2sH4w2L2xH44auclrb347uIKpuDO1rxdGYjVt2hU57E614tVws3J48OvpvQ+Vqpg7Fk2fAPn0vpyhtoCYRAhB5UHlayhrUI7MpMUIWcSiH58t5GHRWhwjeV1nnLxCTuxaiSNgRi7QrqCjVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FY+TTj8H; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Feb 2026 17:31:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770859890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXoRO4v4rHvgrYKgkmZGAeu/KgPPkLUT0T4HFcXiuVc=;
	b=FY+TTj8H8AHJJcKbeySIehPXIDj8Ixtxz/MVGG8esxlLyrRndxYaSxY1uPNJoYv7dejEGd
	te9wGLgCNVZT1THR2FtJyl6scAwHIxhuGzezgZOLZXdWMD+4l4RWlFz8Gj0wSg3a5FSyFK
	wW7/BZhcvm7bHdcwvESThaiDvJ1ArFM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>, Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, shy828301@gmail.com, cl@gentwo.org
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aY0szfVYWR_eWdpn@linux.dev>
References: <20251110232008.1352063-2-shakeel.butt@linux.dev>
 <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
 <aYAmGc6lu973jRwu@linux.dev>
 <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
 <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
 <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
 <aYOuCmjQ5lGm8Mup@linux.dev>
 <4847c300-c7bb-4259-867c-4bbf4d760576@arm.com>
 <aYQuj6Ot-JS4tXvY@hyeyoo>
 <7df681ae0f8254f09de0b8e258b909eaacafadf4@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df681ae0f8254f09de0b8e258b909eaacafadf4@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13875-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,suse.cz,kvack.org,vger.kernel.org,meta.com,gmail.com,gentwo.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:url,linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15844128FD2
X-Rspamd-Action: no action

+Yang Shi and Christoph Lameter

On Thu, Feb 05, 2026 at 05:58:44AM +0000, Shakeel Butt wrote:
> > 
> > On Thu, Feb 05, 2026 at 10:50:06AM +0530, Dev Jain wrote:
> > 
> > > 
> > > On 05/02/26 2:08 am, Shakeel Butt wrote:
> > >  On Mon, Feb 02, 2026 at 02:23:54PM +0530, Dev Jain wrote:
> > >  On 02/02/26 10:24 am, Shakeel Butt wrote:
> > >  Hello Shakeel,
> > > 
> > >  We are seeing a regression in micromm/munmap benchmark with this patch, on arm64 -
> > >  the benchmark mmmaps a lot of memory, memsets it, and measures the time taken
> > >  to munmap. Please see below if my understanding of this patch is correct.
> > > 
> > >  Thanks for the report. Are you seeing regression in just the benchmark
> > >  or some real workload as well? Also how much regression are you seeing?
> > >  I have a kernel rebot regression report [1] for this patch as well which
> > >  says 2.6% regression and thus it was on the back-burner for now. I will
> > >  take look at this again soon.
> > > 
> > >  The munmap regression is ~24%. Haven't observed a regression in any other
> > >  benchmark yet.
> > >  Please share the code/benchmark which shows such regression, also if you can
> > >  share the perf profile, that would be awesome.
> > >  https://gitlab.arm.com/tooling/fastpath/-/blob/main/containers/microbench/micromm.c
> > >  You can run this with
> > >  ./micromm 0 munmap 10
> > > 
> > >  Don't have a perf profile, I measured the time taken by above command, with and
> > >  without the patch.
> > > 
> > >  Hi Dev, can you please try the following patch?
> > > 
> > >  From 40155feca7e7bc846800ab8449735bdb03164d6d Mon Sep 17 00:00:00 2001
> > >  From: Shakeel Butt <shakeel.butt@linux.dev>
> > >  Date: Wed, 4 Feb 2026 08:46:08 -0800
> > >  Subject: [PATCH] vmstat: use preempt disable instead of try_cmpxchg
> > > 
> > >  Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >  ---
> > > 
> > [...snip...]
> > 
> > > 
> > > Thanks for looking into this.
> > >  
> > >  But this doesn't solve it :( preempt_disable() contains a compiler barrier,
> > >  probably that's why.
> > > 
> > I think the reason why it doesn't solve the regression is because of how
> > arm64 implements this_cpu_add_8() and this_cpu_try_cmpxchg_8().
> > 
> > On arm64, IIUC both this_cpu_try_cmpxchg_8() and this_cpu_add_8() are
> > implemented using LL/SC instructions or LSE atomics (if supported).
> > 
> > See:
> > - this_cpu_add_8()
> >  -> __percpu_add_case_64
> >  (which is generated from PERCPU_OP)
> > 
> > - this_cpu_try_cmpxchg_8()
> >  -> __cpu_fallback_try_cmpxchg(..., this_cpu_cmpxchg_8)
> >  -> this_cpu_cmpxchg_8()
> >  -> cmpxchg_relaxed()
> >  -> raw_cmpxchg_relaxed()
> >  -> arch_cmpxchg_relaxed()
> >  -> __cmpxchg_wrapper()
> >  -> __cmpxchg_case_64()
> >  -> __lse_ll_sc_body(_cmpxchg_case_64, ...)
> > 
> 
> Oh so it is arm64 specific issue. I tested on x86-64 machine and it solves
> the little regression it had before. So, on arm64 all this_cpu_ops i.e. without
> double underscore, uses LL/SC instructions. 
> 
> Need more thought on this. 
>

It seems like Yang Shi is looking into improving this_cpu_ops for arm64.

https://lore.kernel.org/CAHbLzkpcN-T8MH6=W3jCxcFj1gVZp8fRqe231yzZT-rV_E_org@mail.gmail.com/

