Return-Path: <cgroups+bounces-15283-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOwxD+ev3WmLhwkAu9opvQ
	(envelope-from <cgroups+bounces-15283-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:09:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E43F529F
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683383039882
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 03:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBE318146;
	Tue, 14 Apr 2026 03:09:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6CA311C01
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776136149; cv=none; b=Gfbq+CGBv8hH2h/oXl1mmI+xbiRPCatR910WnDOs7AUUoyQve42sUZsJGmfBRW+zbOV3HZakBF3tHRJ0MQ5RceAHUi5Q/dQFtN0x41jGE0oQ6Pb+hKtsvxOvAPnOam35RzjIXUZEvapwaZ+XAVEKB/mTDmmKa2SGYLMnOpm1IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776136149; c=relaxed/simple;
	bh=y0o0JTSP6gGQ96STNTXKQmAB/WfbYk1NdkZRprMhCjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UljhtAdl1knkX/hZN7OOaY5A3zgm0VQ8WMA0RRNr76qkOpmUWGZ+WRZmpgT8mcjz+W7nQHBhzP+PlU6MCXK57o1rxjuWAjxQvNrxUfzxr6riB1KCi+TEbrFS0UXR/S16uOzQfUT6XcDBfAsTB+zhpnNL9evCFj0FFroLNRprN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 14 Apr 2026 12:09:06 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 14 Apr 2026 12:09:04 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, Liam.Howlett@oracle.com,
	akpm@linux-foundation.org, apopple@nvidia.com,
	axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
	hughd@google.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org,
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org,
	ryan.roberts@arm.com, shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org,
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <ad2v0LgMhgZwBmFS@yjaykim-PowerEdge-T330>
References: <20260320192735.748051-1-nphamcs@gmail.com>
 <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
 <acQvNRLpHwnHt7i+@yjaykim-PowerEdge-T330>
 <CAKEwX=Pt04pYfhYOwmtXJKU5OqcxBC14SAf1wpBxBo1D7rPpGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=Pt04pYfhYOwmtXJKU5OqcxBC14SAf1wpBxBo1D7rPpGw@mail.gmail.com>
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15283-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 897E43F529F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 06:03:04PM -0700, Nhat Pham wrote:
> On Wed, Mar 25, 2026 at 11:53 AM YoungJun Park <youngjun.park@lge.com> wrote:
> >
> > On Mon, Mar 23, 2026 at 11:32:57AM -0400, Nhat Pham wrote:
> >
> > > Interesting. Normally "lots of zero-filled page" is a very beneficial
> > > case for vswap. You don't need a swapfile, or any zram/zswap metadata
> > > overhead - it's a native swap backend. If production workload has this
> > > many zero-filled pages, I think the numbers of vswap would be much
> > > less alarming - perhaps even matching memory overhead because you
> > > don't need to maintain a zram entry metadata (it's at least 2 words
> > > per zram entry right?), while there's no reverse map overhead induced
> > > (so it's 24 bytes on both side), and no need to do zram-side locking
> > > :)
> > >
> > > So I was surprised to see that it's not working out very well here. I
> > > checked the implementation of memhog - let me know if this is wrong
> > > place to look:
> > >
> > > https://man7.org/linux/man-pages/man8/memhog.8.html
> > > https://github.com/numactl/numactl/blob/master/memhog.c#L52
> > >
> > > I think this is what happened here: memhog was populating the memory
> > > 0xff, which triggers the full overhead of a swapfile-backed swap entry
> > > because even though it's "same-filled" it's not zero-filled! I was
> > > following Usama's observation - "less than 1% of the same-filled pages
> > > were non-zero" - and so I only handled the zero-filled case here:
> > >
> > > https://lore.kernel.org/all/20240530102126.357438-1-usamaarif642@gmail.com/
> > >
> > > This sounds a bit artificial IMHO - as Usama pointed out above, I
> > > think most samefilled pages are zero pages, in real production
> > > workloads. However, if you think there are real use cases with a lot
> > > of non-zero samefilled pages, please let me know I can fix this real
> > > quick. We can support this in vswap with zero extra metadata overhead
> > > - change the VSWAP_ZERO swap entry type to VSWAP_SAME_FILLED, then use
> > > the backend field to store that value. I can send you a patch if
> > > you're interested.
> >
> > This brings back memories -- I'm pretty sure we talked about
> > exactly this at LPC. Our custom swap device already handles both
> > zero-filled and same-filled pages on its own, so what we really
> > wanted was a way to tell the swap layer "just skip the detection
> > and let it through."
> >
> > I looked at two approaches back then but never submitted either:
> >
> >   - A per-swap_info flag to opt out of zero/same-filled handling.
> >     But this felt wrong from vswap's perspective -- if even one
> >     device opts out of the zeromap, the model gets messy.
> >
> >   - Revisiting Usama's patch 2 approach.
> >     Sounded good in theory, but as you said,
> >     it's not as simple to verify in practice. And it is more clean design
> >     swapout time zero check as I see. So,  I gave up on it.
> >
> > Seeing this come up again is actually kind of nice :)
> >
> > One thought -- maybe a compile-time CONFIG or a boot param to
> > control the scope? e.g. zero-only, same-filled, or disabled.
> > That way vendors like us just turn it off, and setups like
> > Kairui's can opt into broader detection. Just an idea though --
> > open to other approaches if you have something in mind.
> 
> Yeah for vswap it's probably going to be a CONFIG or boot param.
> 
> But in the status quo, we can always add a swapfile flag. That one
> should work already, right?

I'm a bit hesitant about the swapfile flag approach. If vswap gets merged,
handling devices with this flag set might complicate the vswap design.

Moreover, exposing a new swap flag to the user interface (e.g., at swapon)
raises concerns about backward compatibility. Do you think that would be safe?

Since our use case isn't very common, we just need a simple knob to tune it.
That's why I still prefer a boot param or CONFIG approach.

Thanks :D
Youngjun Park

