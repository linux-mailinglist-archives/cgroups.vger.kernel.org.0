Return-Path: <cgroups+bounces-14557-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M+RKm7BpmlDTQAAu9opvQ
	(envelope-from <cgroups+bounces-14557-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 12:09:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 551941ED6F6
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 12:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D3B30612B1
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374703F23A3;
	Tue,  3 Mar 2026 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi97jkDc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54C3E5EF8;
	Tue,  3 Mar 2026 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536093; cv=none; b=cD+3TILu7vkrim58LS2zLIjgu/mzbSrmF+5MngEfBJnPV3uTgPpdN+GoDW3vR9I/Hsu53ecwksmAoLrTqqrLWF7kCSvoJMWC7hoUPfng9TWJvw7Q/zVOsKLz6g9oqDoQ5KfcMIe7X4lstfwtcwQcedMwmSvJHhFgWThWpgMoxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536093; c=relaxed/simple;
	bh=Pg+bxff6RLm2vjCjXAjEClO/zTnaUHcveVBLVQYUn1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeBTraMQorFB+GRn7z+SaAt9sXhWedX831VBZ1JvQ+ZaqRjYIbeP8Dv1a6IIbMU2wXJe/1Tg7LRLd8W63Kb4j3IcS3H1Xz6fq9Yo2Gq+px7wwk+tXWV4ekuPtbyTaec+sIgfGuSXiu2HyAXTMLOX6tckkfO3IHs0+psiaMNs6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi97jkDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187F5C116C6;
	Tue,  3 Mar 2026 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772536092;
	bh=Pg+bxff6RLm2vjCjXAjEClO/zTnaUHcveVBLVQYUn1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi97jkDcT/ZjH3j1UUJ6X1W7VKCwQsInCbpeBFP2WSVyZpLzXJu8QPzcM+MpXLHaP
	 v5fS7YCVHzOkRmsCOTvuoXmGSPdwd3i7T6x9y8gY1ZZEe7GFJ0w4TFdDGSPW2IFV0O
	 Rl7Ox3oKMYqpsUiSjnHzKLW80EIJLqCnlDmaidVAx9ChJ9HN8OizgUIjCoqB6JFQjw
	 9wBJDinzGnXWndQrjDIPTncYKV9DPeK2E/9jBboaAV2+942cFv7Vb5JkoLtFKJUHFK
	 b9HlDor/+weZnR5MYZV+X3vw19vXWqNARlzTRdKwKemmjkEwoDKfcf9zbEO4CUb1c7
	 LlzlaYyt5bL8A==
Date: Tue, 3 Mar 2026 12:08:09 +0100
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
Message-ID: <aabBGcuhVaFVwtus@pavilion.home>
References: <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <aZdk19MqYhWK90Do@tiehlicka>
 <aZzM_44L1vKzcOCy@pavilion.home>
 <aZ3ejedS7nE5mnva@tpad>
 <aZ9ugjKvb4U7_R93@pavilion.home>
 <aaAxVbt/DQyTgIs3@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaAxVbt/DQyTgIs3@tpad>
X-Rspamd-Queue-Id: 551941ED6F6
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
	TAGGED_FROM(0.00)[bounces-14557-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pavilion.home:mid]
X-Rspamd-Action: no action

Le Thu, Feb 26, 2026 at 08:41:09AM -0300, Marcelo Tosatti a écrit :
> On Wed, Feb 25, 2026 at 10:49:54PM +0100, Frederic Weisbecker wrote:
> 
> <snip>
> 
> > > There are specific parts of a simulation that are intensive, but
> > > researchers try to minimize them:
> > > 
> > > I/O Operations: Writing "checkpoints" or large trajectory files to disk
> > > (using write()). This is why high-end HPC systems use Asynchronous I/O
> > > or dedicated I/O nodes—to keep the compute cores from getting bogged
> > > down in system calls.
> > > 
> > > Memory Allocation: Constantly calling malloc/free involves the brk or
> > > mmap system calls. Optimized simulation tools pre-allocate all the
> > > memory they need at startup to avoid this.
> > 
> > Ok. I asked a similar question and got this (you made me use an LLM for the
> > first time btw, I held out for 4 years... I'm sure I can wait 4 more years until
> > the next usage :o)
> 
> You should use it more often, it can save a significant amount of time
> :-)

I fear the earth doesn't have the resources to serve daily use of LLM to us
all. Meanwhile it was a pleasant surprise to see it in action and answer questions
I had to myself for a long while. And I might use it again on the rare occasions
where a simple search engine request doesn't do the job.

> > ### 2. The "Slow Path" (System Calls / Syscalls)
> > 
> > Passing through the kernel (a syscall) is necessary in certain situations, but it is "expensive" because it forces a **context switch**, which flushes CPU caches.
> > 
> > * **Initialization:** During startup (`MPI_Init`), many syscalls are used to create sockets, map shared memory (`mmap`), and configure network interfaces.
> > * **Standard TCP/IP:** If you are not using a high-performance network (RDMA) but simple Ethernet instead, MPI must call `send()` and `recv()`, which are syscalls. The Linux kernel then takes over to manage the TCP/IP stack.
> > * **Sleep Mode (Blocking):** If an MPI process waits for a message for too long, it may decide to "go to sleep" to yield the CPU to another task via syscalls like `futex()` or `poll()`.
> > 
> > **In summary:** MPI synchronization aims to be **100% User-Space** (via memory polling) to avoid syscall latency. It is precisely because MPI tries to bypass the kernel that we use `nohz_full`: we are asking the kernel not to even "knock on the CPU's door" with its clock interruptions.
> 
> Of course, there is a cost to system calls. However, considering
> "low latency applications must necessarily remain in userspace,
> therefore lets optimize only for that case" is limiting IMHO.
> 
> Should avoid interruptions whenever possible, for isolated CPUs
> (in userspace _and_ kernelspace).

Very low latency requirements really should bend toward full userspace.
But you're right that isolation (even full with nohz_full) should probably
not be limited to that. HPC shows such a usecase where the workload is not
perfectly isolated and yet nohz_full brings improvements.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

