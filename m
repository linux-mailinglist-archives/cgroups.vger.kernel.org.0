Return-Path: <cgroups+bounces-16026-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIv1M828Cmrb7AQAu9opvQ
	(envelope-from <cgroups+bounces-16026-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 09:16:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9CF5674CE
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 09:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F999303CF85
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAED35DA79;
	Mon, 18 May 2026 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZ6rkO+2"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D053264FC;
	Mon, 18 May 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088522; cv=none; b=lmr+BC9XUgWrToqLJQJv5+AEg29dFCm6XykOi8x0GTJwzhZlsqQp2ba+j1hYD0z2bXUe4oAKVh4aNzm09FAFiJZbyqgTEA4vOhRJTAYOTZVUKR80Ocg9DOkwmP3njoeIjLda+jXkF98XWxvR/NCfcNlOLSv8kvKulllEDazXry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088522; c=relaxed/simple;
	bh=8M+uYC2suQsYrzWQJJE+5uKTIQCzP7BWOOQIRTLVACA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFgKQEso81a6bbkygCsRSBh/uUE38VwhuEFArxL7NzAQX+sLKV3U/BZw1CFOqp3tOBIf4qZ6bvuwtRKssApy/TEsuM5E5ztUez4hOE9W/VgAZwZx7ow/zKWNBA0nFLmXu1MMJDsD/aisISgsfT1k1NpD7tvzaiRuzN6ikum3/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EZ6rkO+2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kE84bpMAJimsO/2Y8gv/DmoOqTHldl6qIZRaW5AO+jw=; b=EZ6rkO+2qNGDOY/2dQfNvC615D
	MzyCGvN+9rkakhniTyxkwvVg8fhMdsPdHFqyPH1V+thx7L4uPACnm7MxWGz0gU8DrbLdpcvYzuGT3
	XRON7NkdPh8Gl2WxaJ30UdPauKfLONf6+Zb2r+OJ6YyWmTtIUsMoGHY3RlIa1f6rl+iQCVI8+N2Kw
	2LerFjvrZPTda/g70b8zGcXqp0wcGkJXF2LCAyZWvtjrM+DedwcixGD6paPE0KJWgKDYqELlWWc4C
	P8j2fN1lFaF6KiafqoPz19P3YoeXUDtT16PJX9YAL8T7yqBnv5QYfh+pASrANeI0NjzmmJO/ZotIP
	g98sJW6g==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOsBl-0000000A88A-3Tnw;
	Mon, 18 May 2026 07:14:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2097A3012C6; Mon, 18 May 2026 09:14:56 +0200 (CEST)
Date: Mon, 18 May 2026 09:14:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
Message-ID: <20260518071456.GO3102624@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <agIswZpCxlsQ2Xdk@slm.duckdns.org>
 <20260512081000.GL3102624@noisy.programming.kicks-ass.net>
 <agN1QbsjFv2aXFhK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agN1QbsjFv2aXFhK@slm.duckdns.org>
X-Rspamd-Queue-Id: 3B9CF5674CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16026-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:45:21AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Tue, May 12, 2026 at 10:10:00AM +0200, Peter Zijlstra wrote:
> ...
> > Anyway, this is why I've been looking at these alternative weight
> > schemes, to get the nominal fraction near 1 and make these problems go
> > away. It is both the numerical issues and the disparity between levels
> > (with root being at level 0 being the most obvious).
> 
> I see. I think what bothers me is that I'm unsure what the weight config
> would mean when the shares are scaled by the number of active cpus in that
> cgroup. 

Relative weight per active cpu :-), but yes, that is a somewhat more
difficult concept I suppose.

> Here's a simple example:
> 
> - There are 256 cpus.
> - /cgroup-A has weight 100 and 128 active threads. No pinning.
> - /cgroup-B has weight 100 and 256 active thredas. No pinning.
> 
> In the current code, assuming math holds up, cgroup-A and B would get about
> the same shares - ~128 CPUs each. However, if we scale the share by active
> CPUs in each cgroup, B's tasks would end up with the same weight as A's on
> CPUs that they end up competing on, which would lead to ~ 1:3 distribution.
> Is that the right reading of the code?

Indeed. So both A and B will get ~1024 weight per (active) CPU, such
that on the CPUs they contend they will get 1:1 and then B will get the
full CPU on the uncontested CPUs, resulting in a total of 1:3
distribution.

This can of course be compensated by increasing the relative
weight of A, if that is so desired. But the alternative view is that for
those 128 CPUs they overlap, A and B will get equal parts, it is just
that B consumes another 128 CPUs and will not have contention there.

So the current scheme will inflate the part of A to be double the weight
(of B), giving them 2 out of 3 parts on the contended CPUs, but then B
will still get complete / uncontested access to those extra 128 CPUs,
resulting in a 2:4 weight distribution.

Which also isn't as straight forward as one might think.

So perhaps 'weight on the CPUs you contest on' isn't as unintuitive as
it seems on first glance, its just different.

And it has tremendous advantages as outlined before; it is naturally
normalized -- the disparity between nesting levels goes away, and the
edge case of a single CPU active will be sane.

Eg. consider your example except now A will have 1 active thread. Then A
will get the full group weight (1024) on its one CPU, while B will get
(1024/256=8) on each CPU.

So for the one contended CPU A gets 256 out of 257 parts, while B gets
the full CPU for the remaining 255 CPUs, for a:

  256    1        257
  --- : --- + 255*--- = 256:65535 ~ 1:256
  257   257       257

distribution. While with the new scheme it would be:

 1   1       2
 - : - + 255*- = 1:511
 2   2       2

Which, realistically isn't all that different, except the old scheme has
this really large weight to deal with.

So from where I'm sitting, yes different, but it behaves better.

