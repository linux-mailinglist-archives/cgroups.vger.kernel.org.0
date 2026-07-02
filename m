Return-Path: <cgroups+bounces-17455-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fib6NVLvRmrDfgsAu9opvQ
	(envelope-from <cgroups+bounces-17455-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 01:08:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0736FD586
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 01:08:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TM3ZVI8X;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17455-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17455-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC6F300EAA3
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2026 23:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D73C4B84;
	Thu,  2 Jul 2026 23:07:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094C7081A;
	Thu,  2 Jul 2026 23:07:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033676; cv=none; b=ihkbahXvSUr0Ju13MznmCOSdRQNCEjTmbmni8nSyL2sClwED+L4sabESiyevxyquFtHp2XeT2xg+wZ0qX88z2TfRWOmA8U+PQ/O+MG4ImOVqqYZucdNXDiw/cSJA4UYl/o1hb4ZqIV5Xur/ZXp8cBAWhY1xEZBsWG5nBaI/Z6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033676; c=relaxed/simple;
	bh=rRbSD2vEtisoQx5CG/V63p7eIDmoUm1jVkc8/pAIAsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW5bk+QA/HUwL0zHMn+7zkBE8nzyVnq+tAVeztI2YPijJfsh2dNfyCp7KcyjvhiebyjBlklnlyG82ps9/hjQiC5BpzKymfynmc8j+OFBMkcz+hDSkfFkKnSrXFPKPcPJex515rN12w5pq5kuiWRiLLl4Ua94UMnCD6tKR5m/E4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM3ZVI8X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED141F000E9;
	Thu,  2 Jul 2026 23:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783033675;
	bh=UXgR7WUYEdirfupUiPI5AAV5n8HF9Vx5UVHFEHYBgUg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=TM3ZVI8XFsO5FaNDR5/NB97MJ0/lJ/GpdzkLuvjhR4A2IjinAxUIbwDQMGlPw59Ec
	 kUgAHhgW0sWtJkuT9aRcyeMw+BIWxi9z2NNWQgQRauHjIUneQW8X6sZVXWxE7hN2D2
	 +v9qsH91zhpIKxUnXbCTqmExgA0PYD+HkmDGH8PzU66dsFdnAhzFOWksJJvx3bTtU9
	 Xp69Khh5bSu7SmbQEsSpu84ojwU5B+OFpAX2KMDHSG9zeGopMzV6ZObP6DX5XCJyRz
	 yy/kMHumgYgEnJAli63grdxykIZ1cUhg78FRu82wurJq+EQ1rRy3vz6GjeQUU4wiXZ
	 kI7gbeBf+oe3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12C73CE1E72; Thu,  2 Jul 2026 16:07:55 -0700 (PDT)
Date: Thu, 2 Jul 2026 16:07:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>, Jing Wu <realwujing@gmail.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	cgroups@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of
 nohz_full and managed_irq CPUs
Message-ID: <4b9bfc1b-2724-4507-b2b2-81d71eb79841@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260421030351.281436-1-longman@redhat.com>
 <20260624063404.2106807-1-realwujing@gmail.com>
 <4ad24488-9cc1-4f1c-8dc5-6830ae7420df@redhat.com>
 <akUii2CyEi7SRid7@localhost.localdomain>
 <871pdlphcc.ffs@fw13>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pdlphcc.ffs@fw13>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17455-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[paulmck@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,chinatelecom.cn];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:frederic@kernel.org,m:longman@redhat.com,m:realwujing@gmail.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,cgroups@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E0736FD586

On Thu, Jul 02, 2026 at 05:00:03PM +0200, Thomas Gleixner wrote:
> On Wed, Jul 01 2026 at 16:22, Frederic Weisbecker wrote:
> > Le Thu, Jun 25, 2026 at 01:27:54AM -0400, Waiman Long a écrit :
> >> That will require some adjustments to the nohz_full related hotplug
> >> functions. I have some ideas of what needs to be done. However, I haven't
> >> looked into RCU yet. I know RCU support changing the nocb mask for fully
> >> offline CPUs, I will need to find out if it possible to do that for
> >> partially offline CPUs.
> >
> > No because callbacks can still be enqueued at this stage. But we could
> > manage to make it work with CPUHP_AP_IDLE_DEAD.
> 
> Well, if you go down to CPUHP_AP_IDLE_DEAD then that's not any different
> from going down all the way because the latency spike of stomp_machine()
> for bringing it down is the same.
> 
> You are right that with the current code this is not possible, but it
> should be possible to avoid that alltogether.
> 
> The only critical path is when a CPU switches to offload mode. Switching
> to 'yes queue callbacks here' mode is not really interesting.
> 
> Let's look how RCU hot-unplug works:
> 
>   1) CPU is marked !active
> 
>   2) rcutree_offline_cpu() removes the CPU from the fully functional CPU
>      mask
>   
>   3) stomp_machine()
> 
>   4) rcutree_cpu_dying() just traces that the CPU is about to vanish
> 
>   5) Wait for the CPU to report DEAD
> 
>   6) rcutree_migrate_callbacks() mops up the leftover callbacks on the
>      dead CPU
> 
> So if the whole machinery changes to:
> 
>   1) CPU is marked !active
> 
>   2) rcutree_offline_cpu() removes the CPU from the fully functional CPU
>      mask _AND_ marks the CPU as "lightweight offloaded", which means:
> 
>         - no new callbacks can be queued on it anymore neither from the
>           CPU itself nor from truly offloaded CPUs
> 
>         - the CPU is still processing already queued callbacks and
>           participates in the GP magic
> 
>   3) Before CPUHP_AP_SCHED_WAIT_EMPTY add a new CPUHP_AP_RCU_SYNC state,
>      which does:
> 
>        - a full RCU synchronization to end all outstanding read side
>          critical sections
> 
>        - drain the now ready callbacks on this CPU
> 
>   4) Proceed to CPUHP_TEARDOWN_CPU, where the operation stops
> 
>   5) Do the magic cpuset changes for the CPU
> 
>   6) Bring CPU back up
> 
> At #4 the half unplugged CPU is not in NOHZ full mode and the tick keeps
> running so all GP processing work as before except that the CPU itself
> is not handling any callbacks because all queued ones are drained and no
> new ones can be queued. When it comes back up it turns into a fully
> offloaded one.
> 
> There are obviously a gazillion of details and cornercases to handle,
> but I don't see why this can't be made work in principle.

For this case, where it is necessary to adjust the set of nohz_full CPUs
while the real-time workload continues running, and thus presumably also
necessary to adjust the real-time workload's set of CPUs mid-stream,
wouldn't it work better to just leave all CPUs in RCU-callbacks-offloaded
state?  Then you can adjust the nohz_full state of arbitrary CPUs without
messing with RCU.

RCU might still have some TOCTOU issues with tick_nohz_full_cpu(),
along with interesting interactions between nohz_full adjustments for
online CPUs and non-RCU portions of the kernel, but this approach would
certainly reduce the number of oddball RCU-centric race conditions that
must be addressed.

Full disclosure:  Frederic was attacking the full-up problem of switching
the RCU callback-offloading state of *online* CPUs initially, but a
continuous stream of race-condition bugs inspired the current state,
which is to allow this state to change only for offline CPUs.  But maybe
Frederic knows a new trick or two?

							Thanx, Paul

