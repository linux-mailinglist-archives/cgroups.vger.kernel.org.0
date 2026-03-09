Return-Path: <cgroups+bounces-14721-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AXP7NyxUr2mYUQIAu9opvQ
	(envelope-from <cgroups+bounces-14721-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 00:13:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBD2429A2
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 00:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C15F31225CC
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82034D392;
	Mon,  9 Mar 2026 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ppc3tLui"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABA38E131
	for <cgroups@vger.kernel.org>; Mon,  9 Mar 2026 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097819; cv=none; b=XgVfvxam8Trn5KsKjgavgWFbPb4IkrHqYSafAvz9ay6H2qNHQLLHELokggkpCMOPnseumwd8m7nxk+2m8osY3Kl01Ak6EeS0v+HN5/q8w7okfSr48Xr3oxiHs7U0LI5FFFV3jzUHJT5pUYJFVND3B2sGITBgm7UfAD7oM9zJFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097819; c=relaxed/simple;
	bh=Ix0d+ac05OD9T1RkL4YfhSns1dE7VmBZIj6JdTSaDVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goLNPKMBPU6ILF/XLVcfhA2OAzVW+4KiyE84aIEeAr3K2Qn+1/uGynf7v8VgnqilxSarVM/FbedxXCRX7p66bn6ywb6Kx43/9x/WRstk+3HktEuNPsdFCJt7mtL2b+m6GFz8lMhPwrIDpsV89iDC+1obuoM6KtPbRJcc9K0yqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ppc3tLui; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Mar 2026 16:09:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773097804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pf/BuL+OuQCj3Lebv/TwYfAfcvP2u/9LGqWeh7qGx4=;
	b=ppc3tLuikjtXxy4J11OJ8dMyczJdQBJfufqnlr8I9Ar3PaiXdi5OyYO9RawkpH+xg8f2jn
	+gFF+nyi18gbqEfQ1LKl+LF/alRYARItsibw8lX4K5suMEck031JVQxcdHRKK4X2FMr/BF
	TdyV3fnvqRGusRJAQERAWFjfOJQ9ibk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Hui Zhu <hui.zhu@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Muchun Song <muchun.song@linux.dev>, Geliang Tang <geliang@kernel.org>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Emil Tsalapatis <emil@etsalapatis.com>, 
	David Rientjes <rientjes@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, willy@infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
Message-ID: <aa9SB6OzocfwL9kO@linux.dev>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
 <87sea8zo0t.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sea8zo0t.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 36DBD2429A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14721-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:33:22PM -0700, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
[...]
> 
> This is fantastic, thanks Shakeel!
> 
> I'd be very interested to discuss it! I suggested a somewhat
> similar/related topic to the bpf track (bpf use cases in mm), we might
> think of joining them.
> 

Awesome, we can request to have a joint session between MM and BPF to discuss
these topics. I know Emil and Tal are also interested in upstreaming
cached_ext. So, we have multiple topics in the intersection of MM and BPF.


