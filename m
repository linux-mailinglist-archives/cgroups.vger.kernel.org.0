Return-Path: <cgroups+bounces-16851-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F/qgHhG+KmotwAMAu9opvQ
	(envelope-from <cgroups+bounces-16851-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 15:54:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDEC6727C9
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 15:54:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=lsSj5vn5;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16851-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16851-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1A43443E21
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC713F4DC5;
	Thu, 11 Jun 2026 13:49:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805374C14;
	Thu, 11 Jun 2026 13:49:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185774; cv=none; b=KLLRT7hHWJXGGwMiklSXlPrd62/wyEoSucK07EmpefDa9ybDIzdRet9tMxo20QdqpLgnYQq1YK+nEXL7WenXju/wX7WZOhEqJCYX5SH0qN/Behbzx39OPHUFGhR6tB64l7NF/bbCpc7WgwZn5BdayY1V8zTOSDp57vwNcqQXpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185774; c=relaxed/simple;
	bh=MeugTFb8f8jktxp5AhnF5uBtyQHUj4bp70Uuuq513pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epiO8Ofj9cch+o9diGp/Gq002qRLsqy4lMNQDBMNJoBxVgUOZFPHSsXiA8zPGCk01FqhqN606qm4OcVrLccuGYrbzOQoDRLrPAjOCJIltzvm31BRgTVyll6AUUtN2Od0+xzs3Ihm9Taefgq/+C8R0VF1L62lFC7zTImLIuWWxQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lsSj5vn5; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MeugTFb8f8jktxp5AhnF5uBtyQHUj4bp70Uuuq513pQ=; b=lsSj5vn5mPNhXjUR4dSQy5gVYA
	uHmXZqGQZXWaeCPHnRf2W/lrcEqFS4pLyN3pq85alO7ERA9ZreVPSi8EapnWESGD0xGDfWkPjW/ng
	505gbZCiPsFhLluE9Z60TgKgLM7W0SRPY/Oqn8e2/4cePzpBVRgU5ebUekcw8laloJeSfJaGZNWGc
	5Ok9S4IFPZ1VuwAmCL+Kt8MX8b4IbHw5nZwrq/fILZMxkmlAxKcMec9TH9ZygtuCADYGPk9LOs/Ax
	KmPUZoKxCGN0n3MkJ/dG61cd/z3s9BYBN94Shg9Y0VBVR189wPkoF/9pc1FcO4S707DYYkeu5Amg1
	S2q0BaZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXfmM-00000001yzM-1jXa;
	Thu, 11 Jun 2026 13:49:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41CEF3002F0; Thu, 11 Jun 2026 15:49:06 +0200 (CEST)
Date: Thu, 11 Jun 2026 15:49:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: mingo@kernel.org, chenridong@huaweicloud.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v3 3/7] sched/fair: Add cgroup_mode: max
Message-ID: <20260611134906.GL48970@noisy.programming.kicks-ass.net>
References: <20260605105513.354837583@infradead.org>
 <20260605124051.589618504@infradead.org>
 <d4ca5fe7-fd76-47c8-949a-a69916bfcbd4@redhat.com>
 <0cbc8a90-8e88-4227-bea5-f12fb0f293db@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cbc8a90-8e88-4227-bea5-f12fb0f293db@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16851-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:mingo@kernel.org,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,noisy.programming.kicks-ass.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBDEC6727C9

On Wed, Jun 10, 2026 at 11:42:47AM -0400, Waiman Long wrote:

> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -4116,6 +4116,21 @@ bool cpuset_cpus_allowed_fallback(struct
> > >       return changed;
> > >   }
> > >   +int cpuset_num_cpus(struct cgroup *cgrp)
> > > +{
> > > +    int nr = num_online_cpus();
> > > +    struct cpuset *cs;
> > > +
> > > +    if (is_in_v2_mode()) {
> > > +        guard(rcu)();
> > > +        cs = css_cs(cgroup_e_css(cgrp, &cpuset_cgrp_subsys));
> > > +        if (cs)
> > > +            nr = cpumask_weight(cs->effective_cpus);
> > > +    }
> > > +
> > > +    return nr;
> > > +}

> FYI, you may have to take the callback_lock to ensure the stability of the
> effective_cpus mask.

That seems pointless, the moment we drop that lock, its changeable
again. Either way around nr is but a snapshot.

