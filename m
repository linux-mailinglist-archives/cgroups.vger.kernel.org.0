Return-Path: <cgroups+bounces-14229-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB8LDvLtnWncSgQAu9opvQ
	(envelope-from <cgroups+bounces-14229-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:29:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 206BA18B627
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40139308E8FD
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617D63ACA50;
	Tue, 24 Feb 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF3F2z5K"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470283A7F7A
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957597; cv=none; b=ES0SDQ3y3FxRfUWUidGIHWLuiE419WIzWFjM/xPNr1NyZmPE0H/DomJVg7ztiUFIcoQh0xpEtDzFEEf2L2iKc1eZ7BrObP0/CaIMmrJ+FA1/8syK1b2Jcs4tdU1xxHW0fhJZMJjjakSZMS7HLE3GWSYNESkIzpO8oGGrGpUPJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957597; c=relaxed/simple;
	bh=FvnmLGPLHXyhrj1/5cDyraosP4vIqR+3YxSc01p6IV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhbuxqWT6YS9WCo6a8V6Hw2mY3cecjTUGuK7EE+n+TVZpaQ7wYaahRDs1k5JKiQXSBXcnDw+SyewT3AIcNPBnEYOPsh80lSbBo0dSShT9DCu/aKV7K4pVZcI/z35Cfj5tgVWUoRG1HS3g1xJo7TJdPCKf2upwkKjOI4MnxwmXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF3F2z5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771957593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GML4cQKyFDkRjMCJYN18Tp92PgzLzTZvQzyFw96BP3s=;
	b=bF3F2z5KPKvrW+rZuaf/dwt8q4GKDZOOoRHjnOacrHc/n7ly0Ixgx1w8RgMGebx8n982i1
	GQNepjq9iCQABVlEqf2n5vBogWNvOEt7D0Le8LL0ZHDnRotqCGBAAVRNaVJVLoqkyHdEd0
	VRYuZaXHci70go+ZWWGteJjjhXuh6vw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-4_cKb8SaPYe60uVj9YEhjw-1; Tue,
 24 Feb 2026 13:26:27 -0500
X-MC-Unique: 4_cKb8SaPYe60uVj9YEhjw-1
X-Mimecast-MFC-AGG-ID: 4_cKb8SaPYe60uVj9YEhjw_1771957582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09ED319560BA;
	Tue, 24 Feb 2026 18:26:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FCBC3003D88;
	Tue, 24 Feb 2026 18:26:19 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 976304028250B; Tue, 24 Feb 2026 14:23:25 -0300 (-03)
Date: Tue, 24 Feb 2026 14:23:25 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <aZ3ejedS7nE5mnva@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <aZdk19MqYhWK90Do@tiehlicka>
 <aZzM_44L1vKzcOCy@pavilion.home>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZzM_44L1vKzcOCy@pavilion.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14229-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 206BA18B627
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:56:15PM +0100, Frederic Weisbecker wrote:
> Le Thu, Feb 19, 2026 at 08:30:31PM +0100, Michal Hocko a écrit :
> > On Thu 19-02-26 12:27:23, Marcelo Tosatti wrote:
> > > Michal,
> > > 
> > > Again, i don't see how moving operations to happen at return to 
> > > kernel would help (assuming you are talking about 
> > > "context_tracking,x86: Defer some IPIs until a user->kernel transition").
> > 
> > Nope, I am not talking about IPIs, although those are an example of pcp
> > state as well. I am sorry I do not have a link handy, I am pretty sure
> > Frederic will have that. Another example, though, was vmstat flushes
> > that need to be pcp. There are many other examples.
> 
> Here it is:
> 
> https://lore.kernel.org/all/20250410152327.24504-1-frederic@kernel.org/
> 
> Thanks.

Frederic,

I think this is a valid solution, however on systems with many CPUs, in
nohz_full, performing system calls, can't there be significant increase
of lru_lock contention ? Consider 100+ CPUs performing many system calls
which add 1 or 2 folios to per-CPU LRU lists.


Note: if you are confident about the above not being a problem, 
this approach looks good to me.

commit eb709b0d062efd653a61183af8e27b2711c3cf5c
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Tue May 24 17:12:55 2011 -0700

    mm: batch activate_page() to reduce lock contention
    
    The zone->lru_lock is heavily contented in workload where activate_page()
    is frequently used.  We could do batch activate_page() to reduce the lock
    contention.  The batched pages will be added into zone list when the pool
    is full or page reclaim is trying to drain them.
    
    For example, in a 4 socket 64 CPU system, create a sparse file and 64
    processes, processes shared map to the file.  Each process read access the
    whole file and then exit.  The process exit will do unmap_vmas() and cause
    a lot of activate_page() call.  In such workload, we saw about 58% total
    time reduction with below patch.  Other workloads with a lot of
    activate_page also benefits a lot too.

...
    The most significent are:
      case-lru-file-readtwice     -11.69%
      case-mmap-pread-rand        -15.26%
      case-mmap-pread-seq         -69.72%

Some Gemini answers (question was "list of nohz_full usecases"):

2. Scientific Simulation & Research

Research institutions (like CERN, NASA, or national labs) use nohz_full
for "tightly coupled" parallel workloads.

Workloads: Molecular dynamics, fluid dynamics (CFD), and weather forecasting (e.g., WRF models).

The "Barrier" Problem: In massive clusters using MPI (Message Passing
Interface), all CPUs often have to reach a synchronization barrier
before the next step of a simulation. If one CPU is delayed by a few
milliseconds due to a timer tick, all other thousands of CPUs sit idle
waiting for it. nohz_full prevents this "tail latency" from stalling the
entire supercomputer.

...

4. Competitive Benchmarking & Kernel Development
Performance engineers use this mode to get "clean" numbers when testing
new hardware or compilers.

Workloads: Core-to-core latency tests, cache-bandwidth benchmarks, and
standard suites like SPEC CPU.

Goal: Eliminating the "noise" of the operating system so that the
results reflect pure hardware performance.

...

Summary Table: Who uses nohz_full?
User Group       Primary Workload       Why they use it
Quant Firms      High-Frequency Trading To prevent micro-stutter during trade execution.
Research Labs    MPI-based Simulations  To avoid the "slowest node" stalling the whole cluster.
Telcos/ISP       5G/Packet Processing   To ensure wire-speed processing without interrupts.
Hardware Vendors Chip Validation        To benchmark CPU performance without OS interference.


Here is how scientific simulations handle system calls:

1. The "Compute-Loop" (Low Syscall)

The core of a simulation (like a GROMACS molecular dynamics step) is
just raw math: fetching data from RAM, doing floating-point arithmetic
(AVX/SSE), and writing it back.

During the loop: The CPU stays in "Userspace" for millions of cycles
without ever asking the kernel for help.

Why it works: Since there are no system calls, nohz_full can
successfully turn off the timer tick, allowing the CPU to focus 100% on
the math.

2. The "Communication-Phase" (High Syscall)

System calls usually happen only at the end of a computation block, when
the simulation needs to talk to other nodes.

The Tools: MPI (Message Passing Interface) uses system calls like write,
sendmsg, or specialized RDMA calls to move data across the network.

The Pattern: These simulations follow a "Burst" pattern—long periods
of zero system calls (computation) followed by a quick burst of system
calls (synchronization).

3. When are they "Syscall Intensive"?

There are specific parts of a simulation that are intensive, but
researchers try to minimize them:

I/O Operations: Writing "checkpoints" or large trajectory files to disk
(using write()). This is why high-end HPC systems use Asynchronous I/O
or dedicated I/O nodes—to keep the compute cores from getting bogged
down in system calls.

Memory Allocation: Constantly calling malloc/free involves the brk or
mmap system calls. Optimized simulation tools pre-allocate all the
memory they need at startup to avoid this.


