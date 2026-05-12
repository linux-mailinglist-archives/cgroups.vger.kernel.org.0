Return-Path: <cgroups+bounces-15841-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL/AODL3AmqvzAEAu9opvQ
	(envelope-from <cgroups+bounces-15841-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:47:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7151E059
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65484301844D
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC94C042F;
	Tue, 12 May 2026 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hozECD2Q"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B73A7F55;
	Tue, 12 May 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579138; cv=none; b=dmVkzeqh/PEeZ42+ZQD0wWO1rkboWrKGkXWMbfZzhvmmd2j/jtRSDWsudVnVbvQm8DNGV/kkcl0l0HmN2disUK0k6tN5t7AplUi8Eibo/Z5KM+FHr4Rnq7+xzyJcr1nCa4hEfMwKRU+XOwloppdgw96lku+Vjyi26+njXoeZCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579138; c=relaxed/simple;
	bh=w6P4cfGa8E3yhLL5HqYEl94wez0KGkjBDU7T3me5XTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwdFj44N5GUhwNxEzmM828FcJ0GeSM70Z+jTHvy080gXEiUD6YtY6OWA3ogQ1hEQxogDoWhkJViGMPFqewkVaaxcPz0EloWZuOteaiVFreWozktiagFXSytgOfUdx5XRs6rkpPJrxdf3MPuuG2UiMlmFa/uGOhysDpkySsH7Qxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hozECD2Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jt/CLuqlgbeOXDSwTFLHwxVyHE3lnZwSDbOunpNCC6Y=; b=hozECD2QzkL1AavIK/jIjSkfSo
	ULgp7IKg27i3tOeNNyoKABQqJPvlv9jIwFLbSozcqD7rngFA3RyCdv8BfxjkVtQeG+9j/ht+fvego
	xXC8RCRemj+qhbm75HAz8hVk5y47HiSjgUj+VwAXE+JBlRyo6i0Js8rnbhwhnzcI4sfpDdWpwB3RL
	i1DyGirbzVBwqQzNqA/vQaH5HmLfqwqXKgxdoG67YVRGSJD682B2LTaUpl94c5zc1sZQMhV+3+WyO
	5+LD/D160DZ4M1nGG3jh2RkOYrx5xHFwvEWrRyLHdKDxKHQNXK5Tff90fFdb2NDdXdzTvHSIPUQx2
	f0NBJjdA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMjfq-0000000EJ5r-2CeD;
	Tue, 12 May 2026 09:45:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7C8D30075A; Tue, 12 May 2026 11:45:09 +0200 (CEST)
Date: Tue, 12 May 2026 11:45:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	qyousef@layalina.io
Subject: Re: [PATCH v2 08/10] sched/fair: Add newidle balance to
 pick_task_fair()
Message-ID: <20260512094509.GA1889694@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120627.944705718@infradead.org>
 <8c4d8466-eefc-45a8-a93c-bb66d5e9db83@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4d8466-eefc-45a8-a93c-bb66d5e9db83@amd.com>
X-Rspamd-Queue-Id: E8A7151E059
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15841-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:07:13AM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 5/11/2026 5:01 PM, Peter Zijlstra wrote:
> > @@ -9245,6 +9247,14 @@ static struct task_struct *pick_task_fai
> >  	if (unlikely(throttled))
> >  		task_throttle_setup_work(p);
> >  	return p;
> > +
> > +idle:
> > +	new_tasks = sched_balance_newidle(rq, rf);
> > +	if (new_tasks < 0)
> > +		return RETRY_TASK;
> > +	if (new_tasks > 0)
> > +		goto again;
> > +	return NULL;
> >  }
> 
> For core scheduling will now trigger a newidle balance during the pick
> when core_cookie is reset to 0 which can cause tasks to migrate only
> for them to find they cannot run on the CPU since core-wide selection
> leads to a cookie mismatch and it is kept hanging there.
> 
> Can we return early if sched_core_enabled() here or are the additional
> newidle balance okay?

This basically makes fair behave like every other class, so in that sense
this is probably okay. That said, fair is the most common case, so
perhaps.

Lets see if the people actually using this notice first though ;-)

