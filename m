Return-Path: <cgroups+bounces-16161-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKfsCH8bD2qLFgYAu9opvQ
	(envelope-from <cgroups+bounces-16161-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:49:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 295455A7A4B
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD97931097DF
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980A93F4DD0;
	Thu, 21 May 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wU3sNHcB"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D53F4DC2;
	Thu, 21 May 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370763; cv=none; b=c13VW26JkcyDil2RW2CUvkf3MmIwH9hWAs2n/VO/oDfEegtTq45IQYz42dmTIoyI/mYpPV6xGfsgBx6IuWUYCcSmXEPS4NvlefR/gPxHTjvB0Z8Ynjc+I13ow9tVkNhmtlB9NPUNt3GQ2qNfV2vjTkuTZ4zKirsFwrH/mn+TfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370763; c=relaxed/simple;
	bh=YlD4I8OWfHiFnUt3sJcvfge34I7G+O4Lyya19MpbBaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bxcz58pIPtM0PheVTGQ3TVjxQ5ssBiRwnHBcrX0wguEwax4SQ8M6Mgf1jOWhp6asqmR1fdHm8O1Ky4cTY0U+CIznIbqsKhIRBAIg5eUVSTal7tBZztZAipxLQHujV+YH9hOpZ7PMyPMuVjQo1En7pT87YnoiX98eijt/PQjR25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wU3sNHcB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QjVAoIpA3RfrOdz2e+FJ7bmnlxWvh2OMwGxHPW/3t1Q=; b=wU3sNHcB77dBMw6o55MqykH3q4
	Tp/QKlafAFc9ssB2Rqoz61uK+PJWd4UoGQ1iYBsofGOwclfZFx1Dccyuz7cZEutkZElTeWuugEkmM
	+qqo7oIM8ANkGJ/Ex7v5q/MHz4/9A0ymBgUWU7+zsE/VHPoqG5jSDGgAr7vcvml1R+1OOZLESvBYF
	/1da23sBy5vhvThDvt7SIyN7eTJrJ6b2j6SJjim/MGIN5VBQSVkN1gGtHhOTWY0rc42dL4OsrVnfr
	CqlO1+wMPUknlry8BzAOIx+TnspINMZEwkLo4RD9Ud7bdHEpTtC9fk0VNHQmVVMCQIPedPswvxZdP
	/imyqHzg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3c8-00000008Xbj-2I87;
	Thu, 21 May 2026 13:39:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17CAA3005E5; Thu, 21 May 2026 15:39:04 +0200 (CEST)
Date: Thu, 21 May 2026 15:39:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
Message-ID: <20260521133904.GR3102924@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube>
 <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16161-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim]
X-Rspamd-Queue-Id: 295455A7A4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:31:17PM +0200, Peter Zijlstra wrote:

> Would it not be simpler to just move the update_entity_lag() call up a
> bit, like so?
> 
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7999,6 +7999,9 @@ static bool __dequeue_task(struct rq *rq
>  
>  	clear_buddies(cfs_rq, se);
>  
> +	update_curr(cfs_rq);
> +	update_entity_lag(cfs_rq, se);
> +
>  	if (flags & DEQUEUE_DELAYED) {
>  		WARN_ON_ONCE(!se->sched_delayed);
>  	} else {
> @@ -8022,7 +8025,6 @@ static bool __dequeue_task(struct rq *rq
>  
>  	dequeue_hierarchy(p, flags);
>  
> -	update_entity_lag(cfs_rq, se);
>  	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
>  		se->deadline -= se->vruntime;
>  		se->rel_deadline = 1;

FWIW, I pushed out a new queue:sched/flat with this on. I had to rebase
because of: 6d2051403d6c ("sched/fair: Update util_est after updating
util_avg during dequeue"), hopefully I didn't wreck that :/

