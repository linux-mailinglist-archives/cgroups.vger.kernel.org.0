Return-Path: <cgroups+bounces-12822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D121CEA728
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 19:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC2D03005302
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA831A044;
	Tue, 30 Dec 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iWRHPxUK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B92D7801
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767118424; cv=none; b=RwvaA0eG7vSExlJHJ7fUwTE/YI1OPWClI3eIw3vMmMUlbVA1rLtxUBl4y1zoMY9PXirGAg1WKLEqKFFXFoNbkOtrJzxr4Yblbxm/PHtcB5MukTelpjnPV5N/H079sAz/RWrmHAas2FazmYeaTGs19KnGUMpYkzeu+5l3N80jkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767118424; c=relaxed/simple;
	bh=87nU3rT/CzP1cGjmFWMunLchiK/piftx6c6K33wN920=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1IVUcDqihEYjoA0SGP3RzBiICj2ZI6OTT7IsS+SzmKd5CtDQE3e/IWTAX1Frowat77KfGcpWnyE98x4g65fq1fruaBBSophibODLnVL1+Thkf/+PczfcyZqieQrfnqmuAXNGRGFrp6Z/7Yy106q/aAonqZHiAxSxanSJA8EcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iWRHPxUK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Dec 2025 10:13:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767118410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KIbte4AjguXPg7uu7NhV6x7iy3noJMlW4r9WgTskaI=;
	b=iWRHPxUK6bUIObUiOlm47FeYyctHwFJnt3AZeHE7kRDgg7NfSbQ/zb9FdNxilYaDhuey2q
	dbYCTZ5wzOJY9E53RProjDZDQtV6nCjKBijiZ7OAW5QC5xviyqhQLuAzPvqkzQb8/AAdN8
	46d5J5BuBO23NZsPaS3EiyWJLf2PTDM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com, 
	harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <slvvzxjhawqb5kkgfe2tll3owxjwtq2qkwd7m3lmpdslss73lo@hkewnkbik3qr>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev>
 <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
 <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
 <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 30, 2025 at 11:46:02AM -0500, Zi Yan wrote:
> On 29 Dec 2025, at 23:48, Shakeel Butt wrote:
> 
> > On Tue, Dec 30, 2025 at 12:25:31PM +0800, Qi Zheng wrote:
> >>
> >>
> > [...]
> >>>>
> >>>> Thank you for running the AI review for this patchset, but please do not
> >>>> directly send the raw data from the AI review to the community, as this
> >>>> is no different from automated review by a robot.
> >>>
> >>> Hi Qi,
> >>>
> >>> I don't know why you're so negative towards it. It's been great at
> >>
> >> No, I don't object to having a dedicated robot to do this.
> >>
> >>> finding pretty tricky bugs often missed by human reviewers. In no way
> >>> it's a replacement for human reviews, but if a robot can find real
> >>> issues and make the kernel more reliable and safe, I'm in.
> >>
> >> I just think you should do a preliminary review of the AI ​​review results
> >> instead of sending them out directly. Otherwise, if everyone does this,
> >> the community will be full of bots.
> >>
> >> No?
> >>
> >
> > We don't want too many bots but we definitely want at least one AI
> > review bot. Now we have precedence of BPF and networking subsystem and
> > the results I have seen are really good. I think the MM community needs
> > to come together and decide on the formalities of AI review process and
> > I see Roman is doing some early experimentation and result looks great.
> 
> Do you mind explaining why the result looks great? Does it mean you agree
> the regressions pointed out by the AI review?

The result looks great because the points raised are really thought
provoking and things I have not thought about when I reviewed the
series. The lru lock without irq or the possible infinite retry loop in
get_mem_cgroup_from_folio() are two such examples. Are these real
regressions? I am not sure.

> 
> If we want to do AI reviews, the process should be improved instead of
> just pasting the output from AI. In the initial stage, I think some human
> intervention is needed, at least adding some comment on AI reviews would
> be helpful.

Yes I agree and therefore I mentioned we should discuss how should we
(MM community) should adopt the AI reviews.

> Otherwise, it looks like you agree completely with AI reviews.
> In addition, “50% of the reported issues are real”, is the AI tossing
> a coin when reporting issues?
> 
> When I am looking into the prompt part, I have the following questions:
> 
> 1. What is “Prompts SHA: 192922ae6bf4 ("bpf.md: adjust the documentation
> about bpf kfunc parameter validation”)”? I got the actual prompts
> from irc: https://github.com/masoncl/review-prompts/tree/main, but it
> should be provided along with the review for others to reproduce.

I agree and I didn't know that Chris's review prompts are used here.

Ccing Chris for your following questions.

> 
> 2. Looking at the mm prompt: https://github.com/masoncl/review-prompts/blob/main/mm.md, are you sure the patterns are all right?
> 	a. Page/Folio States, Large folios require per-page state tracking for
> 		Reference counts. I thought we want to get rid of per page refcount.
>     b. Migration Invariants, NUMA balancing expects valid PTE combinations.
> 		PROTNONE PTEs are hardware invalid to trigger fault.
> 	c. TLB flushes required after PTE modifications. How about spurious fault
> 		handling?
> 
> 3. For a cgroup patchset, I was expecting some cgroup specific prompt rules,
> 	but could not find any. What am I missing?
> 
> 

