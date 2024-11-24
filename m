Return-Path: <cgroups+bounces-5673-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2800F9D6CCD
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 07:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16802813E1
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50641632E7;
	Sun, 24 Nov 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uwf+WcUE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BF3D0D5
	for <cgroups@vger.kernel.org>; Sun, 24 Nov 2024 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732429603; cv=none; b=DdpykUCXrJ0XFBQl40wfgMfWoTRcIiU/aNblwuuL+ocCiygExZe7YUhim8vvWpUa4a+rW+NIC9ySBewO3uN+p/I7PxYYD7T6mLb/jaf/oxxh2z8mEXaZlp03oHApR+1ZGkKmXXpqYgOqmtubZ1+TGGc+hOIEQbg0w6dylMWyr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732429603; c=relaxed/simple;
	bh=+y0CsPw7LLVNrgEeNos7kqugUqrqWjatS9edAZZf+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWc7JB3+9PolB9Ni7zofsBG4pFAAqkGPOb1dD5pDaomg9ql77CAzD3mqcJ7g1jwm6fjLeKUSS64ld0FhmIK9puV2FkFnFGEj2GgarjqctGxZmDWRvCfZt9gpdSrd9ciyMc/IPpG/VFRB9v5BAKUdzH2t2VgDSNCNcGdF99tYk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uwf+WcUE; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 22:26:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732429598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqwfti3Gig5keHs1oaBRmyx5dx91X6ka+Wihml4zKdY=;
	b=Uwf+WcUEC2Er69hyT7eqwu8RzNxIx8K8eAEdy3iLxohfghYpOY30mTJie8fxdGFf5G2Y/r
	K3LpmFbr/Sft5PI0C+yEPsgr0ADB8LAX2aGHiAIyRpQo61er1jP46EkAX8zKtuuPmSLgQp
	K4RTPYDNU9y4PSkF2PWSTqilYRKAb8c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <h7qapwdyg452s7k6qyhea42gp2dkqsvymm5iwe6wrjaltcq6z6@weqt46qywfbn>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
 <Z0IKhWfOr4ppnQem@casper.infradead.org>
 <i3joc4vme76imq2etk7gjfntsy2z5l5niyqobeun5e7m6jh4yi@adwzrxbvuc6l>
 <c3eb6f05-f857-4c3d-9ef8-2488baecb00c@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3eb6f05-f857-4c3d-9ef8-2488baecb00c@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 23, 2024 at 10:38:59PM +0100, Vlastimil Babka wrote:
> On 11/23/24 22:35, Shakeel Butt wrote:
> > On Sat, Nov 23, 2024 at 05:01:57PM +0000, Matthew Wilcox wrote:
> >> On Fri, Nov 22, 2024 at 10:09:39PM -0800, Shakeel Butt wrote:
> >> >  	TP_printk(
> >> > -		"mm=%p memcg_path=%s write=%s",
> >> > -		__entry->mm,
> >> > -		__get_str(memcg_path),
> >> > +		"mm=%p memcg_id=%llu write=%s",
> >> > +		__entry->mm, __entry->memcg_id,
> >> >  		__entry->write ? "true" : "false"
> >> 
> >> Is it actually useful to print out the (hashed) pointer of the mm?
> >> Wouldn't the PID be more useful so you could actually associate it with
> >> a task?
> >> 
> > 
> > For our usecase i.e. bpftrace, we don't really care about these prints
> > as we can directly access the arguments like mm in bpftrace. I wonder if
> > others are using this hased pointer in some other way. I don't mind
> > chaning it but I think that would be a separate patch.
> 
> I wonder if it's actually hashed when trace events are obtained in binary
> form, i.e. via trace-cmd. Might be hashed only when doing e.g. cat
> trace_pipe as that's when the kernel's printk with its hashing is used?
> 
> I guess that would be another argument for not using it in the tracepoint,
> as it would be a sidechannel...

Yup trace-cmd is showing the unhashed raw pointers for mm. If there is
agreement, I can remove the printk of mm pointer in next version.

