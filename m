Return-Path: <cgroups+bounces-14227-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J9rH+PtnWncSgQAu9opvQ
	(envelope-from <cgroups+bounces-14227-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:28:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CB18B610
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 121483089B8A
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7D33AA1B0;
	Tue, 24 Feb 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5+4dnoh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EE3A9DB9
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957594; cv=none; b=DwmA3PP0CUxEOMmxMxqL1Cd6rNmc9+fzLTZIy/3WRED0p1ijtQtcikVzWEMZ431yBOaLXOIXwutTqUbcabHeGpNOxd6haOq0wvYFM9FCimvFFCT4ltm94uoTOtngHC1rDLqcqhzheEWIarPWrpWH7VEqyv19e+qJzZpiLthzAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957594; c=relaxed/simple;
	bh=tZ6lBQWuYTfqUbN2qwwVjecInGeYkTto8OO+tVC6hLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDb6QH0lMqTWLeiVZ+rdlQuz/0NNRAIaVajUBfJdfHlRi9PK6tNIUoRhqQKzSoQrmn+B6qV1SJnFcXreSR6GN1vN9edV0hc6H1eVJIMy75pGyQxcZNYM4jB5qgenDQFkJHL9cUTwtekq8cx9xl+I/V+LJBGh5v2qB8uAOMKT990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5+4dnoh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771957590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj/fGA5yp0dGoSw6F29+YuThvBFpON14H3YrN8gK7+w=;
	b=E5+4dnohZPnezFlTJF/iX90se25eI1lTsOc2NLaIkrMUWO0xsZGr+TdKzUunW2/EIKXcLq
	mO79cV8XUwZBtdheHXn8na/FNx+QuN/9qDX+TlPsaN1VuxTbg+Qug5rbzgW+e+FTdB1an3
	zoyv/+WeDhnzi7NfJot9Qklvi8p+D6g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-7KYmAGGrNIq1EsaTJSiqCQ-1; Tue,
 24 Feb 2026 13:26:26 -0500
X-MC-Unique: 7KYmAGGrNIq1EsaTJSiqCQ-1
X-Mimecast-MFC-AGG-ID: 7KYmAGGrNIq1EsaTJSiqCQ_1771957582
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 161F918002C2;
	Tue, 24 Feb 2026 18:26:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 149F61955F43;
	Tue, 24 Feb 2026 18:26:19 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id E09A4402DED09; Tue, 24 Feb 2026 15:12:32 -0300 (-03)
Date: Tue, 24 Feb 2026 15:12:32 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.com>, Michal Hocko <mhocko@suse.com>,
	Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>,
	Waiman Long <llong@redhat.com>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aZ3qEHzgI8Zuv7IU@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
 <aZibbYH7yrDZlnJh@tpad>
 <aZ24eAiQpo64-0Kz@pavilion.home>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ24eAiQpo64-0Kz@pavilion.home>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14227-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 247CB18B610
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 03:40:56PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 20, 2026 at 02:35:41PM -0300, Marcelo Tosatti a écrit :
> > 
> > I am not sure its safe to assume that. Ask Gemini about isolcpus use
> 
> Erm... ok fine let's see that :-)
> 
> > cases and:
> > 
> > 1. High-Frequency Trading (HFT)
> > In the world of HFT, microseconds are the difference between profit and loss. 
> > Traders use isolcpus to pin their execution engines to specific cores.
> > 
> > The Goal: Eliminate "jitter" caused by the OS moving other processes onto the same core.
> > 
> > The Benefit: Guaranteed execution time and ultra-low latency.
> 
> That would be full isolation (aka nohz_full) because the goal here is to beat
> the competitors. As such the software latency must tend toward hardware latency.
> 
> I wouldn't expect any syscall here but a full userspace stack with DPDK for
> example.
> 
> I put that in the 5g uRLLC (or similar low latency networking) usecase family.
> 
> > 
> > 2. Real-Time Audio & Video Processing
> > If you are running a Digital Audio Workstation (DAW) or a live video encoding rig, a tiny "hiccup" in CPU availability results in an audible pop or a dropped frame.
> > 
> > The Goal: Reserve cores specifically for the Digital Signal Processor (DSP) or the encoder.
> > 
> > The Benefit: Smooth, glitch-free media streams even when the rest of the
> > system is busy.
> 
> Here I expect weaker isolation requirements with syscalls involved. Scheduler
> domain isolation alone (aka isolcpus=[domain]) would fit.
> 
> > 
> > 3. Network Function Virtualization (NFV) & DPDK
> > For high-speed networking (like 10Gbps+ traffic), the Data Plane Development Kit (DPDK) uses "poll mode" drivers. These drivers constantly loop to check for new packets rather than waiting for interrupts.
> > 
> > The Goal: Isolate cores so they can run at 100% utilization just checking for network packets.
> > 
> > The Benefit: Maximum throughput and zero packet loss in high-traffic
> > environments.
> 
> I put that in the 5g uRLLC usecase family as well (again or similar low latency networking).
> 
> > 4. Gaming & Simulation
> > Competitive gamers or flight simulator enthusiasts sometimes isolate a few cores to handle the game's main thread, while leaving the rest of the OS (Discord, Chrome, etc.) to the remaining cores.
> > 
> > The Goal: Prevent background Windows/Linux tasks from stealing cycles from the game engine.
> > 
> > The Benefit: More consistent 1% low FPS and reduced input lag.
> 
> That's domain isolation because frequent syscalls are unavoidable.
> 
> > 
> > 5. Deterministic Scientific Computing
> > If you're running a simulation that needs to take exactly the same amount of time every time it runs (for benchmarking or safety-critical testing), you can't have the OS interference messing with your metrics.
> > 
> > The Goal: Remove the variability of the Linux scheduler.
> > 
> > The Benefit: Highly repeatable, deterministic results.
> 
> I guess here there are plenty of flavours. The only one I know of is this
> power simulator that relies of nohz_full. Not sure about the implementation
> relying on syscalls or not:
> 
> https://dpsim.fein-aachen.org/docs/getting-started/real-time/
> 
> > For example, AF_XDP bypass uses system calls (and wants isolcpus):
> > 
> > https://www.quantvps.com/blog/kernel-bypass-in-hft?srsltid=AfmBOoryeSxuuZjzTJIC9O-Ag8x4gSwjs-V4Xukm2wQpGmwDJ6t4szuE
> 
> That's HFT again and they state that they rely on polling userspace drivers so
> I don't expect syscalls.
> 
> But anyway here is a summary I would propose:
> 
> * Domain isolation alone is a good fit when some glitches must be avoided but
>   kernel work is still necessary: non critical high volume networking or data
>   capture, video games, etc...
> 
> * Full isolation is a better fit for ultra low latency requirement, in this case
>   the kernel is only good for preparatory work and interface layout between
>   userspace and the hardware (VFIO).
> 
>   I've observed 3 patterns so far:
> 
>     - Low latency networking with DPDK, eg: 5g uRLLC (should be syscalls free)
>     - Scientific simulation (not sure about syscalls)
>     - HPC computation such as LLM (not sure about syscalls).
> 
> Is flushing work only relevant for full isolation? If so I can't say which is
> the best solution between flushing pending work on syscall exit and doing that
> remotely. But if it's relevant also for domain isolation, then the remote
> work is better because it doesn't add unecessary work on syscalls which still
> happen in this mode.

Yes, see my last email about HPC.

> At least doing things remotely should be free of any surprising side-effects.
> But we must determine how to properly activate the isolated mode (switch to
> spinlocks) depending on the isolation mode which can be not only defined
> on boot but also on runtime (at least for domain isolation through cpusets
> but it will be the case as well with nohz_full in the future).
> 
> Thanks.

If you boot with remote spinlocks (qpw=1) today, then you can't change
that.

You could, because its a static key:

#define qpw_lock(lock, cpu)                                                             \
        do {                                                                            \
                if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))                   \
                        spin_lock(per_cpu_ptr(lock.sl, cpu));                           \
                else                                                                    \
                        local_lock(lock.ll);                                            \
        } while (0)

But haven't thought about switching on runtime (and don't see why it
would be necessary to switch on runtime). It is independent of 
switching CPUs to/from being isolated (or nohz_full).

OK will address the remaining comments and repost.


