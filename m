Return-Path: <cgroups+bounces-14516-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC0bBC20pWkBFQAAu9opvQ
	(envelope-from <cgroups+bounces-14516-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:00:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F11DC4A1
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14B330935DD
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C2423163;
	Mon,  2 Mar 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nl1ciV1n"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9F411607
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466813; cv=none; b=T0i+gBPsB9rZe2cflz4shoqVPXklorpX7+mZvb7e9ntr4W4RiJ3zkNXjvVkeVY8fdaUxjiVa/IsNX+jxUSikg6rw4CqGNBTy0DCB1hm6WUClMLDr6KMdBdLisGk9agphDEqhQ65K9oEqrW7SPLF60uToMTMDJoWHzxkSmxskjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466813; c=relaxed/simple;
	bh=WIbh+is4KvNzRkch3zcJp52bSKjLueSHIQxVDyUP5ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5wshMRzx2kTzfT6VGF9jjgBDItipcvXF4R+xuLkYMIr0ZVvq5k00MD7hKmKe8arcfhhphTydQoutVNSdXltvtG9uL4WKRzAO7RmC4u85s5bpFDTO4u1SGdW0/osYdvfwpAunO9mxUM40Y0VoHj81Tm2zAUyvneZVIouyhLBMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nl1ciV1n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772466808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5je42QRO4AOiyaMXgXsTKWPYijh9+PVOYu2ob4k4BI=;
	b=Nl1ciV1nk9HNdv1ZcB4W5QFNKojATCaQg6wET/Me1eqHEbTP7Z7pu0bDuTLAAHLjD7z7Jr
	Sa0LeMqUYntbel5Rc8VYPBwkXK6JtaZH4fwZzKqes7YF7HSTFlzyhCMjEKQV+8bGB0ZdrY
	gCZl/Ls9cbu4FlK6kSulfBBeuLwj3nU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-tvROHLPWMWegtmx-T6a-ig-1; Mon,
 02 Mar 2026 10:53:25 -0500
X-MC-Unique: tvROHLPWMWegtmx-T6a-ig-1
X-Mimecast-MFC-AGG-ID: tvROHLPWMWegtmx-T6a-ig_1772466802
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32AE21800365;
	Mon,  2 Mar 2026 15:53:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E899119560A7;
	Mon,  2 Mar 2026 15:53:20 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 82AC5401E0CDF; Thu, 26 Feb 2026 08:41:09 -0300 (-03)
Date: Thu, 26 Feb 2026 08:41:09 -0300
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
Message-ID: <aaAxVbt/DQyTgIs3@tpad>
References: <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <aZdk19MqYhWK90Do@tiehlicka>
 <aZzM_44L1vKzcOCy@pavilion.home>
 <aZ3ejedS7nE5mnva@tpad>
 <aZ9ugjKvb4U7_R93@pavilion.home>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ9ugjKvb4U7_R93@pavilion.home>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 940F11DC4A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[100];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14516-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:49:54PM +0100, Frederic Weisbecker wrote:

<snip>

> > There are specific parts of a simulation that are intensive, but
> > researchers try to minimize them:
> > 
> > I/O Operations: Writing "checkpoints" or large trajectory files to disk
> > (using write()). This is why high-end HPC systems use Asynchronous I/O
> > or dedicated I/O nodes—to keep the compute cores from getting bogged
> > down in system calls.
> > 
> > Memory Allocation: Constantly calling malloc/free involves the brk or
> > mmap system calls. Optimized simulation tools pre-allocate all the
> > memory they need at startup to avoid this.
> 
> Ok. I asked a similar question and got this (you made me use an LLM for the
> first time btw, I held out for 4 years... I'm sure I can wait 4 more years until
> the next usage :o)

You should use it more often, it can save a significant amount of time
:-)

> ### 2. The "Slow Path" (System Calls / Syscalls)
> 
> Passing through the kernel (a syscall) is necessary in certain situations, but it is "expensive" because it forces a **context switch**, which flushes CPU caches.
> 
> * **Initialization:** During startup (`MPI_Init`), many syscalls are used to create sockets, map shared memory (`mmap`), and configure network interfaces.
> * **Standard TCP/IP:** If you are not using a high-performance network (RDMA) but simple Ethernet instead, MPI must call `send()` and `recv()`, which are syscalls. The Linux kernel then takes over to manage the TCP/IP stack.
> * **Sleep Mode (Blocking):** If an MPI process waits for a message for too long, it may decide to "go to sleep" to yield the CPU to another task via syscalls like `futex()` or `poll()`.
> 
> **In summary:** MPI synchronization aims to be **100% User-Space** (via memory polling) to avoid syscall latency. It is precisely because MPI tries to bypass the kernel that we use `nohz_full`: we are asking the kernel not to even "knock on the CPU's door" with its clock interruptions.

Of course, there is a cost to system calls. However, considering
"low latency applications must necessarily remain in userspace,
therefore lets optimize only for that case" is limiting IMHO.

Should avoid interruptions whenever possible, for isolated CPUs
(in userspace _and_ kernelspace).


