Return-Path: <cgroups+bounces-15773-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOzmJqEZAmognwEAu9opvQ
	(envelope-from <cgroups+bounces-15773-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:02:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3B513FFC
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3BF23030F98
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53646AF24;
	Mon, 11 May 2026 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PST++QM6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99632143D;
	Mon, 11 May 2026 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521959; cv=none; b=D37Mcrq5CsNKEYzyZZKDqOZWzT+0VNzxQi1tAK7XYEboqctdCtvAmO1ZzqktqCiRmM8+/Txl6yUYdWpO8azZO4ywzTmifi7sNf9btMk8gdD3gWUC+NfOc8yhxpsZupVfgDKMX7cjtZYYbR0D9fNjCswaPTQq6rNyi4zutylI+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521959; c=relaxed/simple;
	bh=l6B+rqGZ5/Zt8k7HOC+8wI+SYXF0Yo7x5fXG3U1HbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg1uKHHo/lrK5jj1hLqROaXceQNYDPyzJh5X0ZvedPHEABkIda2rTHPROWqO1TjbozHQ8pC6uzKufE8k0vFqcY+V76iLtWq0WWynkeh/PabD5wu8iRF9xoZ/DaWZjsFOR7ZZEfSAmX8pmXvGx10KAt1XBPEmUwcjuHUz0vP0iAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PST++QM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD841C2BCB0;
	Mon, 11 May 2026 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521958;
	bh=l6B+rqGZ5/Zt8k7HOC+8wI+SYXF0Yo7x5fXG3U1HbeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PST++QM6GYsCgVFZqaUlK3WSL4FnDuHnM4EmXv6BPqZ6xpPUggFz0DepEarH8u5ON
	 dSAFlUOWZKCp0XB4sZkHe2kUMuwCcP/MMBJiGXqCdD64nLNZvuFd02rjeCjUSZ0fQ3
	 zhsC/jPaSt160bNj2a7RVCkGEzN/K+FHkPUCyH/ETpwhvc+sNeahHl+nvW58uY15Uj
	 4DEAErSKUqNM4uGS+SDXJekCFywjDh+2u9ikbYewT5/5iBbQhjI2fTgE6VZSAtamFN
	 /K3VdEGcPkjXD5yZqKgfCffYOO0o2Q6Se4NHI2rqeAX2U0WHDUeFcwIvdtDItLnc1e
	 +eBi83Gk7svGg==
Date: Mon, 11 May 2026 07:52:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: luca abeni <luca.abeni@santannapisa.it>,
	Peter Zijlstra <peterz@infradead.org>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <agIXZU9E2OwPfeX3@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
 <afypzfyH0M7Rcge2@jlelli-thinkpadt14gen4.remote.csb>
 <20260507183931.3915dc59@nowhere>
 <agGhi9_SG6vRnDVq@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agGhi9_SG6vRnDVq@jlelli-thinkpadt14gen4.remote.csb>
X-Rspamd-Queue-Id: 94A3B513FFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15773-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

On Mon, May 11, 2026 at 11:29:47AM +0200, Juri Lelli wrote:
...
> While I like the automatic approach, I also fear that it might be more
> difficult to maintain/use from a systemd admin perspective, e.g. I
> cannot make a subgroup reservation bigger because there are threads
> running in the parent group which consume all the remaining (internal)
> bandwidth. If we make it explicit it seems easier to see where bandwidth
> is allocated at all levels.
> 
> Peter? Tejun? What do we want to do with this interface?

blkcg on cgroup1 did soemthing similar for a while. It had a separate subdir
for knobs that apply to "internal threads". Effectivley, this becomes
creating a separate controller group for every cgroup as a sibling to its
children. It does work obviously but it is pretty ugly and unintuitive, both
in interface and implementation, and I'm skeptical this was actually useful
in any meaningful way. Nobody complained when we ripped it out.

If rt were to become its own cgroup controller, maybe one can just side-step
this by not supporting threaded mode at least at the beginning. If people
ask for it, hopefully we'll be able to develop better understanding of their
usecases and drive design that way. In practice, I don't think threaded mode
gets used all that much because usually only application processes
themselves know about their own threads, are not in the business of creating
their own cgroups (delegation to each application isn't common), and have
other ways of controlling their own threads. So, there's some chance that
this may not actually come up.

If rt stays as a part of cpu controller, my preference would be keeping the
config implicit for threaded mode at least at the beginning. ie. Don't get
in the way of people using threaded mode by blocking it but having some
reasonable and clear default (e.g. internal tasks have priority as suggested
or internal tasks get whatever is left over which may make more sense in the
allocation model) may be sufficient. If not, like in the other case, we can
make specific design decisions based on concrete use cases later.

Thanks.

-- 
tejun

