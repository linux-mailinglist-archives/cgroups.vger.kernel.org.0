Return-Path: <cgroups+bounces-14388-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIYnNotun2mZbwQAu9opvQ
	(envelope-from <cgroups+bounces-14388-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:50:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8719E07B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C14C303A4A3
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF72D5923;
	Wed, 25 Feb 2026 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfjWYAmD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6A312816;
	Wed, 25 Feb 2026 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056198; cv=none; b=QjUDtCYS4My7xmviwJnlgj9tUvE9sG50Q3rrCOOIylpzmTYjqql/iQH/TunVUiEj96Ow77cSq67HPTUT5ER3IZg/dpTdBBd30U3elNM6fP6wgqjphQhOFYaQHaTKI/qiPArvrzf6Cird6XUTAR2ofrOZMwzN2ZTIWoNy5rvoBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056198; c=relaxed/simple;
	bh=eFfIbBi1BSaZ60S9OfdQ91pAdXxYSBhBHROYNQOv5Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZXzOtpkfWyzt950wKpRqP5HCdB8+U9h9RUPCatIpwc1vw5vwZGgX3qRf+lOW8Nm8A9wBLKKWZcJkHvZgNNXXuxfWwKLNb0cCQe9x0G3YhhFZe591lzFbMPYFo9epTJjKu65o3TYMUTkg1nKBtnCz56BAHx+4O9UNPYrRmIbZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfjWYAmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D25C116D0;
	Wed, 25 Feb 2026 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772056197;
	bh=eFfIbBi1BSaZ60S9OfdQ91pAdXxYSBhBHROYNQOv5Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfjWYAmDklXC1TbGymTmWkOLCr3v35NDsg+jk09TAAVxaBG5TOHo/+842G4WDx6HJ
	 mgF4tAsOA3Ompfz4yIqzUgyrFZwekdUlp1nARAEGk03tVlyAE0Dc8USwm9p7F2jNcc
	 D/fR89YRAAFNL/85ZnAiaaLzzTW2icXX+um8qBRr4F9lwoCampcszr5ZqSXw/dT1de
	 ns1cFBxHuVIDlvKr5w0VPmO8UzXptg8oOw0/RczrT3RNNqgGLzNCvgdJ+/04eChF93
	 V++K04HJmkvjmMgrVm32XMzO3y8AqdWZ/M7FGZj8gIw4sPMKGC8Pr8cOmcOJSDmil1
	 RcLf1SJMDpSvQ==
Date: Wed, 25 Feb 2026 22:49:54 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
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
Message-ID: <aZ9ugjKvb4U7_R93@pavilion.home>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <aZdk19MqYhWK90Do@tiehlicka>
 <aZzM_44L1vKzcOCy@pavilion.home>
 <aZ3ejedS7nE5mnva@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ3ejedS7nE5mnva@tpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14388-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 44D8719E07B
X-Rspamd-Action: no action

Le Tue, Feb 24, 2026 at 02:23:25PM -0300, Marcelo Tosatti a écrit :
> On Mon, Feb 23, 2026 at 10:56:15PM +0100, Frederic Weisbecker wrote:
> > Le Thu, Feb 19, 2026 at 08:30:31PM +0100, Michal Hocko a écrit :
> > > On Thu 19-02-26 12:27:23, Marcelo Tosatti wrote:
> > > > Michal,
> > > > 
> > > > Again, i don't see how moving operations to happen at return to 
> > > > kernel would help (assuming you are talking about 
> > > > "context_tracking,x86: Defer some IPIs until a user->kernel transition").
> > > 
> > > Nope, I am not talking about IPIs, although those are an example of pcp
> > > state as well. I am sorry I do not have a link handy, I am pretty sure
> > > Frederic will have that. Another example, though, was vmstat flushes
> > > that need to be pcp. There are many other examples.
> > 
> > Here it is:
> > 
> > https://lore.kernel.org/all/20250410152327.24504-1-frederic@kernel.org/
> > 
> > Thanks.
> 
> Frederic,
> 
> I think this is a valid solution, however on systems with many CPUs, in
> nohz_full, performing system calls, can't there be significant increase
> of lru_lock contention ? Consider 100+ CPUs performing many system calls
> which add 1 or 2 folios to per-CPU LRU lists.

That's more a question for Michal or Vlastimil.

> 
> Note: if you are confident about the above not being a problem, 
> this approach looks good to me.
> 
> commit eb709b0d062efd653a61183af8e27b2711c3cf5c
> Author: Shaohua Li <shaohua.li@intel.com>
> Date:   Tue May 24 17:12:55 2011 -0700
> 
>     mm: batch activate_page() to reduce lock contention
>     
>     The zone->lru_lock is heavily contented in workload where activate_page()
>     is frequently used.  We could do batch activate_page() to reduce the lock
>     contention.  The batched pages will be added into zone list when the pool
>     is full or page reclaim is trying to drain them.
>     
>     For example, in a 4 socket 64 CPU system, create a sparse file and 64
>     processes, processes shared map to the file.  Each process read access the
>     whole file and then exit.  The process exit will do unmap_vmas() and cause
>     a lot of activate_page() call.  In such workload, we saw about 58% total
>     time reduction with below patch.  Other workloads with a lot of
>     activate_page also benefits a lot too.
> 
> ...
>     The most significent are:
>       case-lru-file-readtwice     -11.69%
>       case-mmap-pread-rand        -15.26%
>       case-mmap-pread-seq         -69.72%
> 
> Some Gemini answers (question was "list of nohz_full usecases"):
> 
> 2. Scientific Simulation & Research
> 
> Research institutions (like CERN, NASA, or national labs) use nohz_full
> for "tightly coupled" parallel workloads.
> 
> Workloads: Molecular dynamics, fluid dynamics (CFD), and weather forecasting (e.g., WRF models).
> 
> The "Barrier" Problem: In massive clusters using MPI (Message Passing
> Interface), all CPUs often have to reach a synchronization barrier
> before the next step of a simulation. If one CPU is delayed by a few
> milliseconds due to a timer tick, all other thousands of CPUs sit idle
> waiting for it. nohz_full prevents this "tail latency" from stalling the
> entire supercomputer.

Wow! I heard about that possible usecase but I didn't know it was
really used in practice. I privately dug into this with gemini and
there are actual usecase references.

> 
> ...
> 
> 4. Competitive Benchmarking & Kernel Development
> Performance engineers use this mode to get "clean" numbers when testing
> new hardware or compilers.
> 
> Workloads: Core-to-core latency tests, cache-bandwidth benchmarks, and
> standard suites like SPEC CPU.
> 
> Goal: Eliminating the "noise" of the operating system so that the
> results reflect pure hardware performance.

Ok didn't know about that one either.

> Summary Table: Who uses nohz_full?
> User Group       Primary Workload       Why they use it
> Quant Firms      High-Frequency Trading To prevent micro-stutter during trade execution.
> Research Labs    MPI-based Simulations  To avoid the "slowest node" stalling the whole cluster.
> Telcos/ISP       5G/Packet Processing   To ensure wire-speed processing without interrupts.
> Hardware Vendors Chip Validation        To benchmark CPU performance without OS interference.
> 
> 
> Here is how scientific simulations handle system calls:
> 
> 1. The "Compute-Loop" (Low Syscall)
> 
> The core of a simulation (like a GROMACS molecular dynamics step) is
> just raw math: fetching data from RAM, doing floating-point arithmetic
> (AVX/SSE), and writing it back.
> 
> During the loop: The CPU stays in "Userspace" for millions of cycles
> without ever asking the kernel for help.
> 
> Why it works: Since there are no system calls, nohz_full can
> successfully turn off the timer tick, allowing the CPU to focus 100% on
> the math.
> 
> 2. The "Communication-Phase" (High Syscall)
> 
> System calls usually happen only at the end of a computation block, when
> the simulation needs to talk to other nodes.
> 
> The Tools: MPI (Message Passing Interface) uses system calls like write,
> sendmsg, or specialized RDMA calls to move data across the network.
> 
> The Pattern: These simulations follow a "Burst" pattern—long periods
> of zero system calls (computation) followed by a quick burst of system
> calls (synchronization).
> 
> 3. When are they "Syscall Intensive"?
> 
> There are specific parts of a simulation that are intensive, but
> researchers try to minimize them:
> 
> I/O Operations: Writing "checkpoints" or large trajectory files to disk
> (using write()). This is why high-end HPC systems use Asynchronous I/O
> or dedicated I/O nodes—to keep the compute cores from getting bogged
> down in system calls.
> 
> Memory Allocation: Constantly calling malloc/free involves the brk or
> mmap system calls. Optimized simulation tools pre-allocate all the
> memory they need at startup to avoid this.

Ok. I asked a similar question and got this (you made me use an LLM for the
first time btw, I held out for 4 years... I'm sure I can wait 4 more years until
the next usage :o)

Does MPI synchronization only use userspace code or does it rely on syscalls?

The short answer is: **both**, but the goal of HPC (High Performance Computing) is to use as few **syscalls** (system calls) as possible.

Here is the technical breakdown:

### 1. The "Fast Path" (User-Space only)

To maximize speed, modern MPI implementations (like OpenMPI or MPICH) try to stay in **User-Space** as much as possible.

* **Shared Memory (Intra-node):** If two processes are running on the same server, they communicate via a shared memory zone. Synchronization is handled by **spinlocks** or **software barriers**. The CPU "polls" (loops) on a memory variable until it changes. **No syscall is involved here.**
* **RDMA / InfiniBand (Inter-node):** With high-performance network cards, MPI uses **RDMA** (Remote Direct Memory Access). The user code instructs the network card to write directly into the memory of the distant server. Once configured, data exchange happens without involving the Linux kernel.

### 2. The "Slow Path" (System Calls / Syscalls)

Passing through the kernel (a syscall) is necessary in certain situations, but it is "expensive" because it forces a **context switch**, which flushes CPU caches.

* **Initialization:** During startup (`MPI_Init`), many syscalls are used to create sockets, map shared memory (`mmap`), and configure network interfaces.
* **Standard TCP/IP:** If you are not using a high-performance network (RDMA) but simple Ethernet instead, MPI must call `send()` and `recv()`, which are syscalls. The Linux kernel then takes over to manage the TCP/IP stack.
* **Sleep Mode (Blocking):** If an MPI process waits for a message for too long, it may decide to "go to sleep" to yield the CPU to another task via syscalls like `futex()` or `poll()`.

**In summary:** MPI synchronization aims to be **100% User-Space** (via memory polling) to avoid syscall latency. It is precisely because MPI tries to bypass the kernel that we use `nohz_full`: we are asking the kernel not to even "knock on the CPU's door" with its clock interruptions.

