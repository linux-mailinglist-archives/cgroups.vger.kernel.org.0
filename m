Return-Path: <cgroups+bounces-15776-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMd4MeYgAmocoAEAu9opvQ
	(envelope-from <cgroups+bounces-15776-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:33:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE15147FB
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8EFB304A08A
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA647AF75;
	Mon, 11 May 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMtAO8z1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A00472784;
	Mon, 11 May 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524095; cv=none; b=Cb3sfJoKxbqatSy0ce/s9CZSrvRblIZEs+/twR8cIUZ6Vaxwx3ugarb6yoGRrffRmO85I1HND1ndI22YKWeWog+vAOdlcnF/xk93gBObCdOni9c4M3yacxxUM+l/2F0bs7JNch2E9wRcQu17rXUhWJXbXTOUcnigyD/sAvMsHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524095; c=relaxed/simple;
	bh=RHouNHyLTDytJkqMaa1rIPFUAa72TNuQOafeBYRhoTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6vq888Zm90tZT3n00YfaUa0WqeQEKBdcPpeR4Zlw3AYJ6RMxDtd7vRv2an83e1FCQQSAsbSr0FnT2GJ0I4A36j/jMhj9UY3ZjFkglQYlvfsf4pbYntKv0G8Z4dq0nH8h+JEHtizv2nXB+LI13Qh37k2C8KwOH0h1pWHN+nGyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMtAO8z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA926C2BCB0;
	Mon, 11 May 2026 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778524095;
	bh=RHouNHyLTDytJkqMaa1rIPFUAa72TNuQOafeBYRhoTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMtAO8z1+sR2NwNLGrmMyvAqbR9qHhzFPyyt1pegS9H5VuzNTysWUtplmOc3fQdoz
	 pLgv9lV1+np3gmHmsbwrMK7rO77wdu77oBuG+f0fXmVVqedRRj+Rybfr43Ca8Kr4/4
	 LVL2cbUZ+AL7/eaZorVoPqEDabQ2yHOZ4wsyfiBrdbRL3DdzP4oAg48TR+9nVhBjT9
	 8sn6EZ66xJUWQipKXJqPfWLPAtunyZUQuXyNG8sD9D4qRIUqsGVFMxHWhZtgNSseiB
	 ClMVlIwgh1+siJWoMcTgRgDEs7mmwE2V464zSdikO0BNVjGDT+gxW12AKJiYZKslGM
	 HLJjllPqCKU9A==
Date: Mon, 11 May 2026 08:28:13 -1000
From: Tejun Heo <tj@kernel.org>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <agIfvZuvXEtK45em@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507163058.2c435922@nowhere>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507163058.2c435922@nowhere>
X-Rspamd-Queue-Id: 5CDE15147FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15776-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Action: no action

Hello,

On Thu, May 07, 2026 at 04:30:58PM +0200, luca abeni wrote:
...
> Just to better understand: would it make sense to allow non-{FIFO,RT}
> tasks to be in non-leaf cgroups (as allowed by the threaded CPU
> controller), while enforcing that FIFO/RR tasks can only be in leaf
> cgroups? Or would this be a hack that compromises the rt-CPU controller
> usefulness?

Code-wise, sure, but I don't think an interface like that would be a good
one. From user's pov, this amounts to adding restrictions on both whether a
controller can be enabled and whether tasks can be moved into some cgroups.
UNIX error reporting being what it is, this would come down to getting
-EINVAL or -EBUSY or whatever out of those operations. I don't think it's a
good idea to add subtle failure modes to these already pretty complex (but
currently w/ clearly-defined shared rules) operations. To users, this would
look like random arbitrary failures that are nearly impossible to decode
without tracing code.

If you want to enforce no-internal-threads, separating it out to its own
controller that doesn't support threaded mode would be the right direction.

Note that the only hard requirement here is that you don't want to get in
the way for people who are NOT interested in threaded rt control. If you
block enabling CPU control for e.g. cpu.max or block thread migration into a
cgroup, you'd be in the way; however, if all you say is "I don't support
sub-allocation in threaded mode" and e.g just fail writes to the knobs in
threaded cgroups, that does not get in the way. So, it's not like you *have*
to support full threaded mode. You just need to avoid hindering non-rt
operations.

> Yes, we have a bad default here.
> Would a default like "allow running FIFO/RR tasks without runtime
> enforcement" (this is what happens to FIFO/RR tasks running in the root
> control group) be acceptable?

Yes, if you can express that in a reasonable way in the config knobs, that'd
likely be an easier way. I don't know how to transition from
allowed-by-default to explicitly-allocated in such interface tho. Making
that reasonable and smooth would be the key factor in whether such approach
can be taken.

Thanks.

-- 
tejun

