Return-Path: <cgroups+bounces-14539-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDnoIFAppmk+LQAAu9opvQ
	(envelope-from <cgroups+bounces-14539-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 01:20:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 987231E7125
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 01:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1CB33072A0B
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A21E9B3A;
	Tue,  3 Mar 2026 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjYi1HH1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CD16DC28
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497221; cv=none; b=tqSGS1xfjYZAsyFWbQgz8TncUnp6dELOSyCNnOsQNTw9iTTx9OascBlsntHFFa2/NyvszmUkbIigMVccip8CUzxCR33miTE6lCi6CxwXGh1mri3yOnXFjKcqYFLRzYv3IKd1oEexIAFW6neGgQH6R3/biPdUeIDoQY/XVCAIvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497221; c=relaxed/simple;
	bh=qusRBsBs2gBLCAXQDdHP7X/vGLqql3bRPAfzrJIV79g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSaJzBS0FEHOCxcfpP4fiMpXcX8lvUfsYYKHhNQp1ycWDeIFxmMfiV9XQmS9bCAkN8UfqRXoJFXtwNx+teY19q7zujyIzY3ksUv+mAcvQ3Zm+srb51M5qZlhWjmIXIcce0syR5G4wHXHE20cmWhPsKI6EpxSYcpV+xZCOJ3Fazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjYi1HH1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772497218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PxAs2WvNVOxCftZ/jr64yaJOBUiDO5P1MZH42ytmr4=;
	b=YjYi1HH1JVPTq/97ZLb2aX0aIH4Y9Yj4ZpFAMGHmCSbqTxIzsaJGxBtn+lI33pd7bvjYtA
	xrKXHJ+o6OIZ025oUPR2VY9J6OrS08bDe4Ta3T7w0Fk0sbP1d55XjIQB8Ra6p3AsLjaIK9
	6TboqnNvsxJ4QCcPWquWLG4ZUoSvqzc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-6OCu4L77MnWbFpTG33YaJw-1; Mon,
 02 Mar 2026 19:20:15 -0500
X-MC-Unique: 6OCu4L77MnWbFpTG33YaJw-1
X-Mimecast-MFC-AGG-ID: 6OCu4L77MnWbFpTG33YaJw_1772497213
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BBD21800366;
	Tue,  3 Mar 2026 00:20:12 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4521800348;
	Tue,  3 Mar 2026 00:20:09 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 17973401CFE28; Mon,  2 Mar 2026 21:19:44 -0300 (-03)
Date: Mon, 2 Mar 2026 21:19:44 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
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
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aaYpICV55B70U1I2@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZjY9h3XXMNY-Ytd@WindFlash>
 <aZwYmNuucBspCYhk@tiehlicka>
 <aaJDjmnfuo8AM6J9@WindFlash>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaJDjmnfuo8AM6J9@WindFlash>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 987231E7125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14539-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:23:27PM -0300, Leonardo Bras wrote:
> On Mon, Feb 23, 2026 at 10:06:32AM +0100, Michal Hocko wrote:
> > On Fri 20-02-26 18:58:14, Leonardo Bras wrote:
> > > On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> > > > On Sat 14-02-26 19:02:19, Leonardo Bras wrote:
> > > > > On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > > > > > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > > > > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > > > > > [...]
> > > > > > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > > > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > > > > > have requirements as strong as RT workloads but the underlying
> > > > > > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > > > > > moving those pcp book keeping activities to be executed to the return to
> > > > > > > > the userspace which should be taking care of both RT and non-RT
> > > > > > > > configurations AFAICS.
> > > > > > > 
> > > > > > > Michal,
> > > > > > > 
> > > > > > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > > > > > boot option qpw=y/n, which controls whether the behaviour will be
> > > > > > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > > > > > 
> > > > > > My bad. I've misread the config space of this.
> > > > > > 
> > > > > > > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > > > > > > (and remote work via work_queue) is used.
> > > > > > > 
> > > > > > > What "pcp book keeping activities" you refer to ? I don't see how
> > > > > > > moving certain activities that happen under SLUB or LRU spinlocks
> > > > > > > to happen before return to userspace changes things related 
> > > > > > > to avoidance of CPU interruption ?
> > > > > > 
> > > > > > Essentially delayed operations like pcp state flushing happens on return
> > > > > > to the userspace on isolated CPUs. No locking changes are required as
> > > > > > the work is still per-cpu.
> > > > > > 
> > > > > > In other words the approach Frederic is working on is to not change the
> > > > > > locking of pcp delayed work but instead move that work into well defined
> > > > > > place - i.e. return to the userspace.
> > > > > > 
> > > > > > Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> > > > > > paths like SLUB sheeves?
> > > > > 
> > > > > Hi Michal,
> > > > > 
> > > > > I have done some study on this (which I presented on Plumbers 2023):
> > > > > https://lpc.events/event/17/contributions/1484/ 
> > > > > 
> > > > > Since they are per-cpu spinlocks, and the remote operations are not that 
> > > > > frequent, as per design of the current approach, we are not supposed to see 
> > > > > contention (I was not able to detect contention even after stress testing 
> > > > > for weeks), nor relevant cacheline bouncing.
> > > > > 
> > > > > That being said, for RT local_locks already get per-cpu spinlocks, so there 
> > > > > is only difference for !RT, which as you mention, does preemtp_disable():
> > > > > 
> > > > > The performance impact noticed was mostly about jumping around in 
> > > > > executable code, as inlining spinlocks (test #2 on presentation) took care 
> > > > > of most of the added extra cycles, adding about 4-14 extra cycles per 
> > > > > lock/unlock cycle. (tested on memcg with kmalloc test)
> > > > > 
> > > > > Yeah, as expected there is some extra cycles, as we are doing extra atomic 
> > > > > operations (even if in a local cacheline) in !RT case, but this could be 
> > > > > enabled only if the user thinks this is an ok cost for reducing 
> > > > > interruptions.
> > > > > 
> > > > > What do you think?
> > > > 
> > > > The fact that the behavior is opt-in for !RT is certainly a plus. I also
> > > > do not expect the overhead to be really be really big. 
> > > 
> > > Awesome! Thanks for reviewing!
> > > 
> > > > To me, a much
> > > > more important question is which of the two approaches is easier to
> > > > maintain long term. The pcp work needs to be done one way or the other.
> > > > Whether we want to tweak locking or do it at a very well defined time is
> > > > the bigger question.
> > > 
> > > That crossed my mind as well, and I went with the idea of changing locking 
> > > because I was working on workloads in which deferring work to a kernel 
> > > re-entry would cause deadline misses as well. Or more critically, the 
> > > drains could take forever, as some of those tasks would avoid returning to 
> > > kernel as much as possible. 
> > 
> > Could you be more specific please?
> 
> Hi Michal,
> Sorry for the delay
> 
> I think Marcelo covered some of the main topics earlier in this 
> thread:
> 
> https://lore.kernel.org/all/aZ3ejedS7nE5mnva@tpad/
> 
> But in syntax:
> - There are workloads that are projected not avoid as much as possible 
> return to kernelspace, as they are either cpu intensive, or latency 
> sensitive (RT workloads) such as low-latency automation.
> 
> There are scenarios such as industrial automation in which 
> the applications are supposed to reply a request in less than 50us since it 
> was generated (IIRC), so sched-out, dealing with interruptions, or syscalls 
> are a no-go. In those cases, using cpu isolation is a must, and since it 
> can stay really long running in userspace, it may take a very long time to 
> do any syscall to actually perform the scheduled flush.
> 
> - Other workloads may need to use syscalls, or rely in interrupts, such as 
> HPC, but it's also not interesting to take long on them, as the time spent 
> there is time not used for processing the required data.
> 
> Let's say that for the sake of cpu isolation, a lot of different
> requests made to given isolated cpu are batched to be run on syscall 
> entry/exit. It means the next syscall may take much longer than 
> usual.
> - This may break other RT workloads such as  sensor/sound/image sampling, 
> which could be generally ok with some of the faster syscalls for their 
> application, and now may perceive an error because one of those syscalls 
> took too long. 
> 
> While the qpw approach may cost a few extra cycles, it operates remotelly 
> and makes the system a bit more predictable. 
> 
> Also, when I was planning the mechanism, I remember it was meant to add 
> zero overhead in case of CONFIG_QPW=n, very little overhead in case of 
> CONFIG_QPW=y + qpw=0 (a couple of static branches, possibly with the 
> cost removed by the cpu branch predictor),  and only add a few cycles in 
> case of qpw=1 + !RT. Which means we may be missing just a few adjustments 
> to get there.

Leo,

v2 of the patchset adds only 2 cycles to CONFIG_QPW=y + qpw=0. 
The larger overhead was due to migrate_disable, which is now (on v2)
hidden inside the static branch.
My bad.

> BTW, if the numbers are not that great for your workloads, we could take a 
> look at adding an extra QPW mode in which local_locks are taken in 
> the fastpath and it allows the flush wq to be posponed to that point in 
> syscall return that you mentioned. What I mean is that we don't need to be 
> limitted to choosing between solutions, but instead allow the user (or 
> distro) to choose the desired behavior.
> 
> Thanks!
> Leo 

I think 2 cycles is acceptable.


