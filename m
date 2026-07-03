Return-Path: <cgroups+bounces-17474-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bjccEpHBR2pCewAAu9opvQ
	(envelope-from <cgroups+bounces-17474-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 16:05:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBEC7033C4
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 16:05:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xq16OwWQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17474-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17474-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAD3E31BF38E
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E113DC4A9;
	Fri,  3 Jul 2026 13:45:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8373DB994;
	Fri,  3 Jul 2026 13:45:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086356; cv=none; b=O/RRLMxJ8wCEcZFD8ZMi5PgBEiTa9k0/ZObFQPCeoYxZp+IFuyM1whLoCb2dlgGDtvf2MJFfp4kmBUmIrP9zhNgwfcMepKpz8zKcPmjJWYPvNGkzLh8+qmOH60RQcCtukyGJ21jEMry6eQZgw8qiNgdBLaX1gU4UQJrIv55lP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086356; c=relaxed/simple;
	bh=jJeKeSOPAVRCB0VsI0J57fh0QKwys4mGrWVHu9lFiXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgNj5Hl7ScKz71YqVMB/FbLtvtPPVa7PIcsf+GMLHoAYo5A+PrGbwOtWrkVw+YjpEY/PLSk/4tgZ0kMiiQfW5IoyBzRU7rcDmCWr1wQWsxKVsHr/Ko+VqpF7gAqdSPXrplLK1ped/EbsluWI0w/spNYyJu6/b/qfnTvVDCYl3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq16OwWQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE64B1F000E9;
	Fri,  3 Jul 2026 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783086354;
	bh=gDp6TSjVXB2fH6wNuUIUIZM/jwINLpp0dPQUa1OQAtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xq16OwWQpXMNBI21HWpOebQgamwcdgRxjnj0a8SVIJ+IjU0Oha497kw3dXEGo0uZY
	 s7tYVWi7jGVXIWdzPJNKxKhNJ0OC5erJVCPZO2gevfO5B1zO5Qez9S8h77LbbG92D0
	 Hcmu/c8TFY+LxocMA5D/UBTW3v+6vqtW5TJU8IU7l/3DfyJ2ZXjMzfCYgiAY/l50i+
	 rXLIM5g+3YL7ikDtJZQNpW6c2ObuG2hwyiBmyU5XUJQfZrBDAfIUd3KyZAj3LXiFDW
	 OIHvsfwfLyNWz+IHIQPE1ppdQNMGp6n6sw4aOLAWJL6Ov3VQswMo4vPU6++d3/qEZx
	 zCOcta8mlMhPA==
Date: Fri, 3 Jul 2026 15:45:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Jing Wu <realwujing@gmail.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	cgroups@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of
 nohz_full and managed_irq CPUs
Message-ID: <ake9D20lxx2Sncqm@localhost.localdomain>
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17474-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:longman@redhat.com,m:realwujing@gmail.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,chinatelecom.cn];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EBEC7033C4

Le Thu, Jul 02, 2026 at 05:00:03PM +0200, Thomas Gleixner a écrit :
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

But interrupts can still fire and queue callbacks, right?

> 
> There are obviously a gazillion of details and cornercases to handle,
> but I don't see why this can't be made work in principle.

If we need to do something tricky anyway, how about this that would
solve the initial problem of hotplug:stop_machine VS latency sensitive workloads
in general?

https://lore.kernel.org/lkml/ake24SbeTjPo7zXT@localhost.localdomain/T/#m4bdf9c760f7451232e21eea6d07935002e5ceb04

-- 
Frederic Weisbecker
SUSE Labs

