Return-Path: <cgroups+bounces-15838-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EuzA/DxAmoozAEAu9opvQ
	(envelope-from <cgroups+bounces-15838-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:25:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF2751D9A9
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C591C301584A
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89848C8BA;
	Tue, 12 May 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1cYlWRw"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BB3A545C;
	Tue, 12 May 2026 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577665; cv=none; b=HKE16CfVu1qUCCSufMJnHsP0Z/CFU6LgtVtZHQe2jr6ry5qFIa5VjCeTxnVNBl29rdGfMAWbT6LWPvdUli6ps4RE3OtIIt646XXTFj66XqmBzrIQEx8leBhD37mVTRdfZvN5I28tFim2hRLBPVxeDYR1kuje69O6rRTQ1ug8sjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577665; c=relaxed/simple;
	bh=I258KXDlBOPbLpKTjlWvEvH+QZm8Pa5TcELdSEgQdYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bul9wP/z/kTzxL8hXTlf3Jl6K+qB56KCTfSgjL9Z7jeMGv8h0jJWrx0bdAskPmdTE1q+IccwYtR+uGmowh8p5qx7UP9FDLFjkA47Qj3n1E/WSZYmwegFBQBubU32oHk6VvVeAjFr67lhGBdvj+lZxeSqSfPDC+8fCmdtdno/9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q1cYlWRw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r1noIgol6YRgrrmBWyBp/qexYp9bKrMg/AqV0MRqYVU=; b=q1cYlWRwiHXiE8xg3nfhaeeRbs
	PkNVEhYfZmPvW1gpObBnvEemhNfvfjm1bwBW0Hg+AaLk5zYGnsLK30js+l0qjifggkCGAsT0vs4lx
	5teYnelbmnIzhN+rhLsOKHjwmNoMff+VNQO1CZd689DvvsmCe10dr/NG2FzUGade+12NPRiAjwdvN
	x7L5YKTd6Nhda+CDcSubqdhefKw8HVOXJVnTC5RnCsTPQ1fs0KYWUGJyDKxUQnZ7bfd6VUzCJ16pU
	TI9baKUNpyns43yxvyV144ajETlv/c5ZwZ1pL7aC+vxioy/oawYVY7cBPpfzeDyR3764oK5XUJkQL
	YJGGc+VA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMjI9-00000009ULy-1b2a;
	Tue, 12 May 2026 09:20:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1CF7530095A; Tue, 12 May 2026 11:20:40 +0200 (CEST)
Date: Tue, 12 May 2026 11:20:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
Message-ID: <20260512092040.GN3102624@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
X-Rspamd-Queue-Id: 7EF2751D9A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15838-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:

> 
> I haven't reviewed the patches yet but I ran some tests with it while
> testing sched latency related changes for short slice wakeup
> preemption. I have some large hackbench regressions with this series
> on HMP system with and without EAS. those figures are unexpected
> because the benchs run on root cfs
> 
> One example with hackbench 8 groups thread pipe
> tip/sched/core  tip/sched/core          +this patchset          +this patchset
> slice 2.8ms     16ms                    2.8ms                   16ms
> dragonboard rb5 with EAS
> 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> 0,689(+/- 9.1%) +8%
> 
> radxa orion6 HMP without EAS
> 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> 1,071(+/-5.9%) -82%
> 
> Increasing the slice partly removes regressions but tis is surprising
> because the bench runs at root cfs and I thought that results will not
> change in such a case
> 
> I will review the patchset and try to get what is going wrong

Yeah, that is unexpected. Let me go have another look too.

