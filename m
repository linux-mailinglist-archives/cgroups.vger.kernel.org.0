Return-Path: <cgroups+bounces-10657-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E9FBD28B8
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F8E3B5245
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65E2FF154;
	Mon, 13 Oct 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGQYorAT"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3C1946AA;
	Mon, 13 Oct 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351042; cv=none; b=qXkgGSETkmli8PrYdVc2VpzcKUMjS2EDosRI2sceWeOKW4bfT0yBYM4S3NCKpz+GKPPDhrl5xBRHJjfVZkaQQzX0auZ2tTtm+/4EgzC3trCzidNh3cQ49dv5UCbfKrhmfjBdvEta5ZSAmSMxKZTpodSEvXGeeD0Jlq93Qo3g4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351042; c=relaxed/simple;
	bh=sScV2KPZkgkriilgKwRNLZq8s377U5ASqJ8TO4hXY1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Shsvg1ICmv24annIJMQM+M/DaDv4VLyn51sz+faTiNVe8IIZiuDsT2nGmpEqQVdnqy7qcsllJ0QyGcJ3gazBwcg92VVjqvu6kHkNerryV9GEkuF5IYJ6iSyf415iAgZMDBOWVn+uSBIknYKyjXMg5yG2zA2uDGYWoGYAh93VYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jGQYorAT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rronQgbUv5ut13en00I1NEaZfei/VBBBsa8mpaTADho=; b=jGQYorATM2sK1Kuyv68u/bznPv
	l+ocBdoORC3jyb8z4QtmpQbiX+/G9WBwvk8WdOkUXqJtsYCQoAfSgf8PD5G2AQbJEjbkTAGP+RWWY
	FMp0qjjG6dIXf+FF85bsN+Pyy/UtHwMAVoDkDFa/RhYtfzouEVgyIDpA2hoFlRTx1lCb7QKui6XtF
	sRDSHdYBPO+XQlMRG5kkEyn6d0tzW8tcPgjhueOXpeeGTEb43RWUvt32Y3Rc4WOsKdNN7Mw5ToDeU
	+0+MPttubZ8Wp/LiLH1RnEd97o3bVpTxR+X6HIveCvmp4ZkHybyorIG/RtCJcie5vB0Y8q4QiNJy6
	qw0FZLUg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8FiW-00000004Fz5-47py;
	Mon, 13 Oct 2025 10:23:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2D64300169; Mon, 13 Oct 2025 12:23:47 +0200 (CEST)
Date: Mon, 13 Oct 2025 12:23:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 03/12] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <20251013102347.GY3419281@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.861755244@infradead.org>
 <02452879-8998-47e0-9679-d2ff00503901@arm.com>
 <20251009135408.GD4067720@noisy.programming.kicks-ass.net>
 <20251009140925.GD4068168@noisy.programming.kicks-ass.net>
 <e611b632-0156-4204-a748-78d44b2d14c8@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e611b632-0156-4204-a748-78d44b2d14c8@arm.com>

On Thu, Oct 09, 2025 at 06:50:55PM +0200, Dietmar Eggemann wrote:

> Yes, but there seems to be more ... missing DEQUEUE_SAVE (a.k.a.
> ENQUEUE_RESTORE) in
> 
>   enqueue_dl_entity()
> 
>     if (flags & (ENQUEUE_RESTORE|ENQUEUE_MIGRATING))
>                  ^^^^^^^^^^^^^^^
>       ...
>       add_running_bw(dl_se, dl_rq)
> 
> and
> 
>   __sched_setscheduler()
> 
>     ...
>     if (prev_class != next_class)
>       queue_flags |= DEQUEUE_CLASS;
>       queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>                        ^^^^^^^^^^^^
> 
> as well as
> 
>   sched_change_begin()
> 
>     ...
>     if (flags & DEQUEUE_CLASS) {
>       if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
>         flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>                    ^^^^^^^^^^^^
> 

Urgh.. SAVE/RESTORE while changing CLASS is so weird.

But yeah, let me take that bit out for now -- I'll make a note in a
comment that we should look at perhaps cleaning that up instead.

