Return-Path: <cgroups+bounces-15113-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMt2NlXCymmL/wUAu9opvQ
	(envelope-from <cgroups+bounces-15113-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:35:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B435FC6B
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C31730172D2
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EC7392C3C;
	Mon, 30 Mar 2026 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivqQcR2d"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83F3845C2;
	Mon, 30 Mar 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895698; cv=none; b=dXPM8i0cmG6hD7N0arjvA3DHsC5A+0tKPpfo0btyoUuGHpyP/QlcWIQMz7QfpT0ldzpPLIeuAT/fYKDl1ht0QOC6ErP1MqtreBSBDRkOM0O5y0pcEttWH23LO8pjg9Tu4uWflpfxX2z4FhCJg3RQoaNoIkyE5BfXrzthi+Wq4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895698; c=relaxed/simple;
	bh=SRxxpeb3qYoWl6+GAc/aO0wc0VXuHzggDRH/rnKg21Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVomTF413d/s3uT0zu52R/aNQTaGJ/jAiY3srCEGUtOTxm65uCi0s7Gf1HI1WiUYWK8vHkcPnBq7FMCN5xGkkPN8sAsaz7OVafIeLJTH9NU43+WuihraJAdOcCK4OD02zC6Ia2rL6VI+/6MzcmvXQfABrCoMsTIoaZMuOyfQXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivqQcR2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4F7C4CEF7;
	Mon, 30 Mar 2026 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774895697;
	bh=SRxxpeb3qYoWl6+GAc/aO0wc0VXuHzggDRH/rnKg21Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivqQcR2dZy35lYabU0BBXKzj+XDUwkDqyBwMEtaqaUyM3k21UuHgbvPrCu7ZusHVr
	 ytprZXkVMFgMLhdj/VGJQHTMTI2piW0GLLVtC7zskwte6Gqc6C/CnEF7tuvFbzhrBg
	 xrQ1g0uibn4nPEwbmuA1ac4GkOIoIRESGZV7ygQIMR+2IGaHmvf4XdPXA9gbXaPbIn
	 mwoAaZFuHHvrcSHkVwbeuDpNtuJe4fKFqLNzVJZnheiBaNnYd+kgSH6jIbHUfvZ9Jc
	 HEN41kioO7XOqaqChUh0oT+h8cM3NYpOzyF82zaFJrB6WAlTFd+2ek6RAWvTp38BtX
	 3Kykii1gy2Ebw==
Date: Mon, 30 Mar 2026 08:34:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: peterz@infradead.org, longman@redhat.com, cgroups@vger.kernel.org,
	akpm@linux-foundation.org, anna-maria@linutronix.de,
	boqun.feng@gmail.com, bsegall@google.com, dietmar.eggemann@arm.com,
	frederic@kernel.org, hannes@cmpxchg.org, jackmanb@google.com,
	jiangshanlai@gmail.com, joelagnelf@nvidia.com,
	josh@joshtriplett.org, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, mathieu.desnoyers@efficios.com, mgorman@suse.de,
	mhocko@suse.com, mingo@kernel.org, mingo@redhat.com,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org,
	qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
	shuah@kernel.org, surenb@google.com, tglx@kernel.org,
	urezki@gmail.com, vbabka@suse.cz, vincent.guittot@linaro.org,
	vschneid@redhat.com, ziy@nvidia.com
Subject: Re: [PATCH 13/15] sched/isolation: Implement sysfs interface for
 dynamic housekeeping
Message-ID: <acrCUEsH5wi2qAx_@slm.duckdns.org>
References: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
 <20260330114620.104027-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330114620.104027-1-realwujing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15113-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,kernel.org,cmpxchg.org,nvidia.com,joshtriplett.org,kvack.org,efficios.com,suse.de,suse.com,linux.dev,goodmis.org,suse.cz,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 763B435FC6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cc'ing Waiman.

On Mon, Mar 30, 2026 at 07:46:20PM +0800, Qiliang Yuan wrote:
> On Wed, Mar 25, 2026 at 03:04:32PM +0100, Peter Zijlstra wrote:
> > Why? What was wrong with cpusets?
> 
> This is the central point of the architecture. The distinction I was 
> trying to address is:
> 
> 1. Task Isolation (Current CPUSets):
>    The `cpuset` subsystem (especially `cpuset.cpus.partition = isolated`) 
>    is excellent at managing task placement and load balancing. It 
>    ensures no user tasks are pushed to isolated CPUs.
> 
> 2. Kernel Overhead Isolation (Housekeeping):
>    Currently, `cpusets` do not manage kernel-internal overhead like RCU 
>    callbacks, timers, or unbound workqueues. These are managed by the 
>    global `housekeeping_cpumask`, which is settled at boot via 
>    `isolcpus`/`nohz_full` and is static.
> 
> DHEI fills this second gap by making the housekeeping mask dynamic. 
> However, I agree that a parallel sysfs interface is redundant.
> 
> In V13, I will move the control interface to `cpuset`. The root cpuset 
> will serve as the primary interface, allowing changes in the cpuset 
> partition state to automatically trigger the migration of kernel 
> housekeeping overhead. This achieves "Full Dynamic Isolation" (both tasks 
> and kernel overhead) through a single, unified interface.

Please discuss with Frederic and Waiman first because they have been working
towards making cpuset to cover what cpuisol does. I don't think we want two
separate mechanisms for the same thing and don't see why this would need to
be its own thing when it has to be coupled with task isolation anyway.

Thanks.

-- 
tejun

