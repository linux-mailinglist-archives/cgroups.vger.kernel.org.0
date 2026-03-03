Return-Path: <cgroups+bounces-14581-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KILOHS9lp2mghAAAu9opvQ
	(envelope-from <cgroups+bounces-14581-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 23:48:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2A1F825A
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 23:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BF8130361A0
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 22:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108AF390231;
	Tue,  3 Mar 2026 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYPo28Qd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750138F623;
	Tue,  3 Mar 2026 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578089; cv=none; b=m1C6zApBob1csiP0ru4XVdpyvX8mryxs610W6wlWka80MC/F5AZU3Ypa3cChH67W558L3C4naX78WT8WtsZG3rz+uOYOdZliQ1z5tLkAsX4zzaQag8VhwhDimAPsFm+w7FFr3fJlVwgyAXjdwbff/MmsfzR6u/F+isql/PwjbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578089; c=relaxed/simple;
	bh=+3u0vuEv0aAMm6fFkAuHq8DmR9NFPBItVEP1FJB7NMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvuM/7pjE+iPSt5/WarGqzpjOY0ecVgJV96G/68/wihjRM/sT6LB7Uuh6t7DKjOgzuwpmozGWPWKo/qgHr45mnFlGmxnTfX12qQR9O/thLwOxO7byfLzc4Uy47rcIX42Z3XxkWX2iEdH0br0ZcL9be2WhfEG0fshmyytzlHVox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYPo28Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22838C116C6;
	Tue,  3 Mar 2026 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772578089;
	bh=+3u0vuEv0aAMm6fFkAuHq8DmR9NFPBItVEP1FJB7NMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYPo28QdPMvq+JEX6+2vmkyAGuQz8kgDlS/8fYWGlG+nas8EizG1iAr32duDw0Vjo
	 gmaNGqM2XoyR7Cnde+v9GJcOWFbN+e1xQAyWogGxr4nLQHc8ETbhb4EsIcp7fTsPZM
	 lW3sKfbiSWf87PHoarJH7FnB8ntHV63Zwu5cr2ZvHJCkB1di8AZT9MbPqogemfaj7h
	 E9nBvlgIt3l8uPOIKR1Y3o4V3qGqjgsghSbG6AAF2eWOtQB1O9X4jmohFhrjuURWEU
	 VZLlSzZADzma6pEr7CfrXIDInIE5vmzGoitbHzuw7eTXAuBQFfiGEQ88/xXo1xGZEI
	 3ZL5BxKvdjW4g==
Date: Tue, 3 Mar 2026 23:48:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
Message-ID: <aadlJm2aUekJdIwS@pavilion.home>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
 <aaBvc4ikB1H-WQDd@localhost.localdomain>
 <c999838a-cfdf-4556-8416-cb21aa2b69e7@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c999838a-cfdf-4556-8416-cb21aa2b69e7@redhat.com>
X-Rspamd-Queue-Id: F2E2A1F825A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14581-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Le Tue, Mar 03, 2026 at 11:00:54AM -0500, Waiman Long a écrit :
> On 2/26/26 11:06 AM, Frederic Weisbecker wrote:
> If you look at the work function, it will make a copy of HK_TYPE_DOMAIN
> cpumask while holding rcu_read_lock().

Where?

> So the current hotplug operation must
> have finished at that point.

I'm confused. This is called from sched_cpu_deactivate(), right?
So the work is scheduled at that point. But the work does cpuset_full_lock()
which includes cpu hotplug read lock, so the sched domain rebuild can only
happen at the end of cpu_down().

This means that between CPUHP_TEARDOWN_CPU and CPUHP_OFFLINE, the offline
CPU still appears in the scheduler topology because the scheduler domains
haven't been rebuilt.

And even if the work wouldn't cpu hotplug read lock, what guarantees that
it executes before reaching CPUHP_TEARDOWN_CPU?

> Of course, if there is another hot-add/remove
> operation right after the rcu_read_lock is released, the cpumask passed down
> to housekeeping_update() may not be the latest one. In this case, another
> work will be scheduled to call housekeeping_update() with the new cpumask
> again.

I'm not so much worried about housekeeping_update() (yet). I'm worried about
topology rebuild to happen before CPUHP_TEARDOWN_CPU. Offline CPUs shouldn't
exist in the topology.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

