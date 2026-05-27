Return-Path: <cgroups+bounces-16345-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nh9HuC8FmqHqQcAu9opvQ
	(envelope-from <cgroups+bounces-16345-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 11:44:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4045E1F91
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 11:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4EEF3008510
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C93EBF19;
	Wed, 27 May 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DMQnz1bc"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE423C1F54;
	Wed, 27 May 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874951; cv=none; b=nD0G5xyyo06y9yrKWaEf4YL+yafVB6xtXT/qRDKQrIaD2LQoaULFrLTj+CK9IWBKwK/3toiK799yLUt+Km+ERCmcN83dXKUnYndf2ZYCwPq1dy1D0n+YrF2Rw54IH0ixa1rMO99L+8wfv8IYNmfANzb3NwxYc6JigfBCoXX6Pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874951; c=relaxed/simple;
	bh=+vGMVXR+NPWKz8cGfQUhXwbph1cZUCYSuedasX9zqwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a86AJIBfFTz8mIC6xvJMwixIdvRDKT4rJQjv0OlWaciRaI9OdMciEu8FS+LNlT4GM2cYj8UESrctLGo0bln/fSpWidHfzHs2FE0ndKGY3pp9aSeEfqeuqGCtGldErC0saGssBDmI19EuYs8GBx5ggF9I2kq5Xuuk4Z/BJpok73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DMQnz1bc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KYAyspqN8xegJ0uQzjnAhIaAXlOqaGb8oyevRGnRuJk=; b=DMQnz1bcANVv4GPs1wfKUZZvQE
	J10pS9tUyO4i3pspB2ZospXCmKj2047ml3JN5g1hIilwTcS8jMLdfXYx1/alVsDtt+cnFBVaEXESP
	It9xyRoo8HUJ09mxodPFZkToLLVwyyhrXYHqOK7CVW9UdEwlIKzmflpy/oFfsZlsDcs9mCChWM8+t
	vWI4rtfmfrZp0mgZkAcm0cT5cmB4GKPZiWFLqo1FXBsy0TsIzmNGHe8c7zkfIUWF0d4Pp8bT9r4cl
	4AufbjdP/j+nSSwA0z1S7IONlk7L9YkNWjIh6SObBnufkIh03Ik7al4dEv1J0o03C7DlQMjnFT1be
	sFDS+JAg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSAm1-0000000DS3V-0tgH;
	Wed, 27 May 2026 09:42:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B153930057C; Wed, 27 May 2026 11:41:59 +0200 (CEST)
Date: Wed, 27 May 2026 11:41:59 +0200
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
Message-ID: <20260527094159.GS3126523@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <agIswZpCxlsQ2Xdk@slm.duckdns.org>
 <20260512081000.GL3102624@noisy.programming.kicks-ass.net>
 <agN1QbsjFv2aXFhK@slm.duckdns.org>
 <20260518071456.GO3102624@noisy.programming.kicks-ass.net>
 <agtkR_kTkMW4Gc5d@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtkR_kTkMW4Gc5d@slm.duckdns.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16345-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D4045E1F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:11:03AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Mon, May 18, 2026 at 09:14:56AM +0200, Peter Zijlstra wrote:
> ...
> > So the current scheme will inflate the part of A to be double the weight
> > (of B), giving them 2 out of 3 parts on the contended CPUs, but then B
> > will still get complete / uncontested access to those extra 128 CPUs,
> > resulting in a 2:4 weight distribution.
> > 
> > Which also isn't as straight forward as one might think.
> 
> Right, the current behavior isn't quite what people would expect intuitively
> either.
> 
> ...
> > So for the one contended CPU A gets 256 out of 257 parts, while B gets
> > the full CPU for the remaining 255 CPUs, for a:
> > 
> >   256    1        257
> >   --- : --- + 255*--- = 256:65535 ~ 1:256
> >   257   257       257
> > 
> > distribution. While with the new scheme it would be:
> > 
> >  1   1       2
> >  - : - + 255*- = 1:511
> >  2   2       2
> > 
> > Which, realistically isn't all that different, except the old scheme has
> > this really large weight to deal with.
> > 
> > So from where I'm sitting, yes different, but it behaves better.

FWIW if the workload was single threads per CPU; the above is also the
exact behaviour we'd have without cgroups.

> I see. Thread cardinality and affinity problems make weight based
> distribution such a pain. I wonder whether this can be better solved by
> turning it into a two-layer allocation problem - groups to CPUs and then
> timeshare on CPUs as necessary. That comes with a lot of its own problems
> but it can, aspirationally at least, approximate global weight distribution
> and would have better locality properties.

If people want, they can already do this today. I don't see a reason to
mandate something like that. That is, combine cpuset and cpu in a v2
hierarchy and you get this.

The main problem with doing something like that is of course that it
isn't always clear how many CPUs will be needed for a particular 'job'.
So assigning groups to CPUs isn't a straight forward thing.

If I remember, Meta was actually doing some of this. It was dynamically
resizing cpusets based on load predictions and the like in order to
separate various worloads on the same large machine, right?


Anyway, while it is somewhat tedious to change behaviour, I do think it
is worth doing in this case.

