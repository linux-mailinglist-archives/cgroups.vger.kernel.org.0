Return-Path: <cgroups+bounces-15822-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MaQIDzhAmpEyQEAu9opvQ
	(envelope-from <cgroups+bounces-15822-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:13:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C951C85F
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EADD83026332
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1F48BD33;
	Tue, 12 May 2026 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YL0cslZb"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A7258CE5;
	Tue, 12 May 2026 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573425; cv=none; b=COIgvjdDmJVV1IDtPe7lEWNyXosgUI4mt/raBA+Yvlne0+2Ycvrt12pexpTkieo2aecjcli8HL7LJrilZy127uLgxtkckvfmHRBuXd4XOnzrZCI3gCiu1CGn5kJDo/8QMF9RIhU9UTgLYUs8jS+1xARVHOn5Ri7KEjcUK5v0ZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573425; c=relaxed/simple;
	bh=JdtqZMJDJnp28NUJSCgytxWm0x493TYcezg01A+7jSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyYXKLvzXaaCxTHE0FTaEVafmBoQOvsNcaxHvMyv6vYjO/1RnDq5jWPf1kVELwZS7h4Iqp4QbR8wntV5Nldre60Il0pyQGWLYygfEQxs28UyqLrWTbK01jFJ89rXURMrAvwzhDz4nSpRU16U3qc5iUwkzscOGEAdOGdrvxQJ+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YL0cslZb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=19TGBtKQmhIuXSKyT51dH+VsGeOUq2ku3XDV08szO4s=; b=YL0cslZbE6ZZ/7Tz1GBQdwXMc5
	zJQEaDoFZsjfFSnJUL72wbh2GRnZ4P5uqReFiFdFvl0505cn0lZ+ni3gsrvItJGiLR6oPY+rsqoRJ
	ukKxsYiFGCgv5dqK+A8DoHhp0/4Kb8/P3iTy5Bw7DDzgiMYSu5mDG09nYSbssx+sBVxsD6ROkBO3s
	tdMpPifDHo14ivNO+wV3Zpb+glGEZplZeFjhGx+A3WgPvpQUqL/Qlr777w1BNBR+pXRENg0DY8I4y
	uMJZBS/nF1Iwz+jnSpVYsjLEWJsNfcMq9ryFtdW+fmwdUKNR4y1DAJ/3TjCiOPtHD3l2952B5fP9O
	wm9K4BmA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMiBl-00000009PjW-2YTr;
	Tue, 12 May 2026 08:10:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00A7E3007E1; Tue, 12 May 2026 10:10:00 +0200 (CEST)
Date: Tue, 12 May 2026 10:10:00 +0200
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
Message-ID: <20260512081000.GL3102624@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <agIswZpCxlsQ2Xdk@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agIswZpCxlsQ2Xdk@slm.duckdns.org>
X-Rspamd-Queue-Id: C78C951C85F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15822-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 09:23:45AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Mon, May 11, 2026 at 01:31:04PM +0200, Peter Zijlstra wrote:
> > So cgroup scheduling has always been a pain in the arse. The problems start
> > with weight distribution and end with hierachical picks and it all sucks.
> > 
> > The problems with weight distribution are related to that infernal global
> > fraction:
> > 
> >              tg->w * grq_i->w
> >    ge_i->w = ----------------
> >              \Sum_j grq_j->w
> > 
> > which we've approximated reasonably well by now. However, the immediate
> > consequence of this fraction is that the total group weight (tg->w) gets
> > fragmented across all your CPUs. And at 64 CPUs that means your per-cpu cgroup
> > weight ends up being a nice 19 task worth. And more CPUs more tiny. Combine
> > with the fact that 256 CPU systems are relatively common these days, this
> > becomes painful.
> > 
> > The common 'solution' is to inflate the group weight by 'nr_cpus'; the
> > immediate problem with that is that when all load of a group gets concentrated
> > on a single CPU, the per-cpu cgroup weight becomes insanely large, easily
> > exceeding nice -20.
> > 
> > Additionally there are numerical limits on the max weight you can have before
> > the math starts suffering overflows. As such there is a definite limit on the
> > total group weight. Which has annoyed people ;-)
> > 
> > The first few patches add a knob /debug/sched/cgroup_mode and a few different
> > options on how to deal with this. My favourite is 'concur', but obviously that
> > is also the most expensive one :-/ It adds a tg->tasks counter which makes the
> > update_tg_load_avg() thing more expensive.
> 
> Ignoring fixed math accuracy problems, isn't the root problem here that
> every thread in the root cgroup competes as if each is its own cgroup? ie.
> Isn't the canonical solution here to create an enveloping group, at least
> for share calculation purposes, for root threads and then assign them some
> weight so that they compete in the same way that other cgroups do? Then, the
> different modes go away or rather whatever the user wants can be expressed
> via root's weight if that's to be made configurable.

As long as the total group weight is a fraction; and it sorta has to be.
You can run into trouble by stacking that fraction.

Take 256 CPUs and a group weight of 1024. Then each CPU gets a weight of
1/256 or 4. Even if we increase the internal accuracy to 20 bits (we do
on 64bit) then this becomes 4096, do this for 2 more levels in the
hierarchy and you're down to scraping the barrel again.

So if each level runs at a fraction f of the level above, then level n
runs at f^n. Moving root into a phantom group at level 1, only solves
the problem against other tasks at level 1, but then you have the same
problem again at level 2 and below.

Both the numerical problems and the scale problem of the root group can
be avoided if we can get the average/nominal fraction to be near 1.

The 'normal' way around this is to ensure the group weight is nr_cpus *
1024, then, when everybody is running, the per CPU weight is 1024 or 1
and the continued fraction is also 1-ish. This is why people like to
increase the max group weight.

Trouble is of course that if not all CPUs are busy, with the extreme
being only a single CPU carrying that weight of nr_cpus*1024, this then
causes trouble because that one CPU gets overloaded.

One of the options is to simply put a max on the single CPU load; which
is the crudest option to just make it 'work'. The one I favour though is
the one where we scale the group weight by: 'min(cpumas, nr_tasks)'.

Anyway, this is why I've been looking at these alternative weight
schemes, to get the nominal fraction near 1 and make these problems go
away. It is both the numerical issues and the disparity between levels
(with root being at level 0 being the most obvious).


Does that make sense?

