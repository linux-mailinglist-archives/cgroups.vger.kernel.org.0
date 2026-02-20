Return-Path: <cgroups+bounces-14067-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLnkK9WvmGm3KwMAu9opvQ
	(envelope-from <cgroups+bounces-14067-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 20:02:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278116A3B1
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 20:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54F3C3040314
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ABE366558;
	Fri, 20 Feb 2026 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8TgpaKX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E32C21C3
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614155; cv=none; b=i0LI88WkILZurcc6N2xkK9+1GSFBwnCv5KjZDC4u65Z34Ogbw/gOth+vBf9FrmjCgQtdhFJNDG8lrAp+tRNZEaP5Tasj4UdO0qIFNmlEWtX3b7+boQqhnZ24l81zaTCrk31MVr7s0nj/rDtnUa+h2Fx/P91cyxWDc6+z0E9sIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614155; c=relaxed/simple;
	bh=N5qhaqWcXh/d96ddmtTrpBw3a0zINgR2nrqZREAJm+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MicHKxdSZov2iqVWw4vcGvh6dsj5GQJDfKtMHWxT/+cqNxS1wF1Bc1Dqq+NMaKdojw1OkEdeYoCatRFTtRBy3AfMuTw00XV0NYV+gHbYOmu0jvaZQd6mqVZLBGvHvCKCcJyUXECtKLWuuSMOHkWb41FAtWA0bgQTOVaMID4BhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8TgpaKX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771614151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9iHzvmcbPtFzdUbEREveeE+6fxU/Z+piAYr2pO9/Skk=;
	b=I8TgpaKX9UZroJADYLIZwNdyVcqgl7SRgvmdw/KeolTb/ACHNElu/ijIoarD6vYvq2oDxt
	MxFU9Owlyu1vntWtPk+IdaEpyTln39K6TGwKz1OlbB8P+Tl87D2k0NQjWU/U+Jyfyr8LNy
	Nr7lUkGDS5GLi2wMrSaTNB/KgyAB3Z8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-I5SMJDneMTSjyoCXVPcCRg-1; Fri,
 20 Feb 2026 14:02:27 -0500
X-MC-Unique: I5SMJDneMTSjyoCXVPcCRg-1
X-Mimecast-MFC-AGG-ID: I5SMJDneMTSjyoCXVPcCRg_1771614145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38767180057E;
	Fri, 20 Feb 2026 19:02:24 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63DF619560A7;
	Fri, 20 Feb 2026 19:02:22 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id E17AA402E7782; Fri, 20 Feb 2026 16:01:59 -0300 (-03)
Date: Fri, 20 Feb 2026 16:01:59 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Vlastimil Babka <vbabka@suse.com>
Cc: Michal Hocko <mhocko@suse.com>, Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
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
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aZivpwJnIGKdAMYE@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
 <aZibbYH7yrDZlnJh@tpad>
 <a1c11a09-da88-4edd-9571-0f792b59e9c3@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c11a09-da88-4edd-9571-0f792b59e9c3@suse.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14067-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quantvps.com:url,system_load.py:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6278116A3B1
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 06:58:10PM +0100, Vlastimil Babka wrote:
> On 2/20/26 18:35, Marcelo Tosatti wrote:
> > 
> > Only call rcu_free_sheaf_nobarn if pcs->rcu_free is not NULL.
> > 
> > So it seems safe?
> 
> I guess it is.
> 
> >> How would this work with houskeeping on return to userspace approach?
> >> 
> >> - Would we just walk the list of all caches to flush them? could be
> >> expensive. Would we somehow note only those that need it? That would make
> >> the fast paths do something extra?
> >> 
> >> - If some other CPU executed kmem_cache_destroy(), it would have to wait for
> >> the isolated cpu returning to userspace. Do we have the means for
> >> synchronizing on that? Would that risk a deadlock? We used to have a
> >> deferred finishing of the destroy for other reasons but were glad to get rid
> >> of it when it was possible, now it might be necessary to revive it?
> > 
> > I don't think you can expect system calls to return to userspace in 
> > a given amount of time. Could be in kernel mode for long periods of
> > time.
> > 
> >> How would this work with QPW?
> >> 
> >> - probably fast paths more expensive due to spin lock vs local_trylock_t
> >> 
> >> - flush_rcu_sheaves_on_cache() needs to be solved safely (see above)
> >> 
> >> What if we avoid percpu sheaves completely on isolated cpus and instead
> >> allocate/free using the slowpaths?
> >> 
> >> - It could probably be achieved without affecting fastpaths, as we already
> >> handle bootstrap without sheaves, so it's implemented in a way to not affect
> >> fastpaths.
> >> 
> >> - Would it slow the isolcpu workloads down too much when they do a syscall?
> >>   - compared to "houskeeping on return to userspace" flushing, maybe not?
> >> Because in that case the syscall starts with sheaves flushed from previous
> >> return, it has to do something expensive to get the initial sheaf, then
> >> maybe will use only on or few objects, then on return has to flush
> >> everything. Likely the slowpath might be faster, unless it allocates/frees
> >> many objects from the same cache.
> >>   - compared to QPW - it would be slower as QPW would mostly retain sheaves
> >> populated, the need for flushes should be very rare
> >> 
> >> So if we can assume that workloads on isolated cpus make syscalls only
> >> rarely, and when they do they can tolerate them being slower, I think the
> >> "avoid sheaves on isolated cpus" would be the best way here.
> > 
> > I am not sure its safe to assume that. Ask Gemini about isolcpus use
> > cases and:
> 
> I don't think it's answering the question about syscalls. But didn't read
> too closely given the nature of it.

People use isolcpus with all kinds of programs. 

> > For example, AF_XDP bypass uses system calls (and wants isolcpus):
> > 
> > https://www.quantvps.com/blog/kernel-bypass-in-hft?srsltid=AfmBOoryeSxuuZjzTJIC9O-Ag8x4gSwjs-V4Xukm2wQpGmwDJ6t4szuE
> 
> Didn't spot system calls mentioned TBH.

I don't see why you want to reduce performance of applications that 
execute on isolcpus=, if you can avoid that.

Also, won't bypassing the per-CPU caches increase contention on the 
global locks, say kmem_cache_node->list_lock.

But if you prefer disabling the per-CPU caches for isolcpus
(or a separate option other than isolcpus), then see if 
people complain about that... works for me.

Two examples:

1)

https://github.com/xdp-project/bpf-examples/blob/main/AF_XDP-example/README.org

Busy-Poll mode
Busy-poll mode. In this mode both the application and the driver can be run efficiently on the same core. The kernel driver is explicitly invoked by the application by calling either recvmsg() or sendto(). Invoke this by setting the -B option. The -b option can be used to set the batch size that the driver will use. For example:

sudo taskset -c 2 ./xdpsock -i <interface> -q 2 -l -N -B -b 256

2)

https://vstinner.github.io/journey-to-stable-benchmark-system.html

Example of effect of CPU isolation on a microbenchmark
Example with Linux parameters:

isolcpus=2,3,6,7 nohz_full=2,3,6,7
Microbenchmark on an idle system (without CPU isolation):

$ python3 -m timeit 'sum(range(10**7))'
10 loops, best of 3: 229 msec per loop
Result on a busy system using system_load.py 10 and find / commands running in other terminals:

$ python3 -m timeit 'sum(range(10**7))'
10 loops, best of 3: 372 msec per loop
The microbenchmark is 56% slower because of the high system load!

Result on the same busy system but using isolated CPUs. The taskset command allows to pin an application to specific CPUs:

$ taskset -c 1,3 python3 -m timeit 'sum(range(10**7))'
10 loops, best of 3: 230 msec per loop
Just to check, new run without CPU isolation:

$ python3 -m timeit 'sum(range(10**7))'
10 loops, best of 3: 357 msec per loop
The result with CPU isolation on a busy system is the same than the result an idle system! CPU isolation removes most of the noise of the system.


