Return-Path: <cgroups+bounces-13860-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBFTHJ6jjGlhrwAAu9opvQ
	(envelope-from <cgroups+bounces-13860-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 16:43:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53842125C9B
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 16:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2E4B3008C24
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D9130F7E0;
	Wed, 11 Feb 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDb9hAux"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED385310636
	for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824593; cv=none; b=F6ZjO3lWmOFDQECqZoMK0aH4qqqKJNxrt+an2zhkIqwpa6Jws+N/qUHCm0awW7HmtfPPQA27dRukHBf5nnc6k8dYTLd07N8Qt++hl5FYw4R7lkM4znCWRTMVYjtDyV2MQbfirvJh8hPcV8NKvhAYBLbtKeyNhXQXhqosvOcSSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824593; c=relaxed/simple;
	bh=KASUW0pyryAgersxWpn6QLBWZqNmrD3crrlaDFyAuR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4Ll/ge2wzMtcQW/oqZ9nKo2LYtR2s3pofhhs4x9SqRkuWBoYy2//9u/Z1HPu8Ide9e54afbHybpJMCrI9hubZRELvQb9/4FAUWPhY40wjNUW7NZPbgiSTd7JX/Xps7tlQuexWXGbSTQNUmeyZRRkSWYWGYUeVmD5LKV8lD5Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDb9hAux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770824591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE7la7K/IKWK0kSdZLLaAcmHE3mv3hvFTPaHbiBOxk8=;
	b=UDb9hAux+qJH2e75ZO/z/a2h9EOA84fAhccaZ1tiGzSSYLt9La2GZ/mI2gdyrN7Msr/2We
	KBM1XxMNVsylYQyFxMik0dIV3N2FFWfl4xem+EgbeSd4Om+e1PDfPMNP1r+imRVTYht2CM
	AojUOG4YviyG8UJA6zPGy62DQLl+ZpE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-CvMfWgf9MqKHQQmxAVGhcg-1; Wed,
 11 Feb 2026 10:43:06 -0500
X-MC-Unique: CvMfWgf9MqKHQQmxAVGhcg-1
X-Mimecast-MFC-AGG-ID: CvMfWgf9MqKHQQmxAVGhcg_1770824584
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E0861955F28;
	Wed, 11 Feb 2026 15:43:04 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F7911800668;
	Wed, 11 Feb 2026 15:43:03 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 7DAC1400DF589; Wed, 11 Feb 2026 09:11:21 -0300 (-03)
Date: Wed, 11 Feb 2026 09:11:21 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
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
Message-ID: <aYxx6cq6he6jTIZI@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYxviLoWsrLqDU7o@tpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13860-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 53842125C9B
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:01:12AM -0300, Marcelo Tosatti wrote:
> On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > On Fri 06-02-26 11:34:30, Marcelo Tosatti wrote:
> > > The problem:
> > > Some places in the kernel implement a parallel programming strategy
> > > consisting on local_locks() for most of the work, and some rare remote
> > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > kernels, even though the very few remote operations will be expensive due
> > > to scheduling overhead.
> > > 
> > > On the other hand, for RT workloads this can represent a problem: getting
> > > an important workload scheduled out to deal with remote requests is
> > > sure to introduce unexpected deadline misses.
> > > 
> > > The idea:
> > > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > > In this case, instead of scheduling work on a remote cpu, it should
> > > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > > work locally. That major cost, which is un/locking in every local function,
> > > already happens in PREEMPT_RT.
> > > 
> > > Also, there is no need to worry about extra cache bouncing:
> > > The cacheline invalidation already happens due to schedule_work_on().
> > > 
> > > This will avoid schedule_work_on(), and thus avoid scheduling-out an
> > > RT workload.
> > > 
> > > Proposed solution:
> > > A new interface called Queue PerCPU Work (QPW), which should replace
> > > Work Queue in the above mentioned use case.
> > > 
> > > If PREEMPT_RT=n this interfaces just wraps the current
> > > local_locks + WorkQueue behavior, so no expected change in runtime.
> > > 
> > > If PREEMPT_RT=y, or CONFIG_QPW=y, queue_percpu_work_on(cpu,...) will
> > > lock that cpu's per-cpu structure and perform work on it locally. 
> > > This is possible because on functions that can be used for performing
> > > remote work on remote per-cpu structures, the local_lock (which is already
> > > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > 
> > What about !PREEMPT_RT? We have people running isolated workloads and
> > these sorts of pcp disruptions are really unwelcome as well. They do not
> > have requirements as strong as RT workloads but the underlying
> > fundamental problem is the same. Frederic (now CCed) is working on
> > moving those pcp book keeping activities to be executed to the return to
> > the userspace which should be taking care of both RT and non-RT
> > configurations AFAICS.
> 
> Michal,
> 
> For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> boot option qpw=y/n, which controls whether the behaviour will be
> similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> 
> If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> (and remote work via work_queue) is used.

OK, this is not true. There is only CONFIG_QPW and the qpw=yes/no kernel 
boot option for control.

CONFIG_PREEMPT_RT should probably select CONFIG_QPW=y and
CONFIG_QPW_DEFAULT=y.

> What "pcp book keeping activities" you refer to ? I don't see how
> moving certain activities that happen under SLUB or LRU spinlocks
> to happen before return to userspace changes things related 
> to avoidance of CPU interruption ?
> 
> Thanks
> 


