Return-Path: <cgroups+bounces-14556-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULLVGGq/pmlDTQAAu9opvQ
	(envelope-from <cgroups+bounces-14556-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 12:00:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2201ED3F8
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16710314FFCC
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A43BED1A;
	Tue,  3 Mar 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTywvoTU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF53BED0E;
	Tue,  3 Mar 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535333; cv=none; b=BEE3M8e0el93d0TGKzKcs+sA5i6Tu7Ds9d61JnUWeFF/BknFz75hAhsWOop/11ak+PPx6gXVbVqnw3921Bc5dr332vndZTgFAp26zFoM1RS/NOAuVccHZxN5dfsviCIu6ZC4gxvvb++VT72YGeX0Hfm+a2SWEfpgtHde+x7NJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535333; c=relaxed/simple;
	bh=U1ApVomksiqWCT2sGpijV9kFi6nnWZi4UHDKMufxrYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZLm5bIdReYcwrpN6kS8heqyvjCl+r/X4JS9346NxZIZASw5Ze1eoPuJeOLYJ3B5oJw9+dxmNiaeueJCGhKzkwBN8p23XoXGvavyix+THRmxsmF9CiTnvPpOZxIWuG36P/joJNZGerpSV1t9eAXvKYJV3xlJ80DPK7lbuCJZS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTywvoTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4113C116C6;
	Tue,  3 Mar 2026 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772535333;
	bh=U1ApVomksiqWCT2sGpijV9kFi6nnWZi4UHDKMufxrYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTywvoTU6cn+uM30VZVVIsd89qPxICra9DYBbl9Ildtr1jSFikkTARJliSVvZKVf6
	 zfAYc86OX6AyqBRnBO/XTTZjxQg853ye6++NvPL6ZFDirfLACYqxSGq8WTMdrk4sRM
	 t6l7JGjTdTdGfk/sHQqVnnnXq2rf3hf4/Fzr1USPi0kYn2uXb+ew9t1vdJ/LsTW9QN
	 yK+XPHM+HclEwMgLLIvVQfPmP66LqKYDONlupzJIrZbS1fbTWUcRE8KF7RnXFdK84U
	 arBwHJkqPOnTL21B+1onE17zYIxUNVdVmARnknVyxN2XXyzf2xYhngXWXFWWBWVcW2
	 WoMrAD6LtymPQ==
Date: Tue, 3 Mar 2026 11:55:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
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
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aaa-Ig5gKeU1PV4D@pavilion.home>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <aZdk19MqYhWK90Do@tiehlicka>
 <aZhv+Bw7nKKmbFdq@tpad>
 <aZwbcKeO-59l0UOC@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZwbcKeO-59l0UOC@tiehlicka>
X-Rspamd-Queue-Id: BE2201ED3F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14556-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,suse.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pavilion.home:mid]
X-Rspamd-Action: no action

Le Mon, Feb 23, 2026 at 10:18:40AM +0100, Michal Hocko a écrit :
> On Fri 20-02-26 11:30:16, Marcelo Tosatti wrote:
> > On Thu, Feb 19, 2026 at 08:30:31PM +0100, Michal Hocko wrote:
> > > On Thu 19-02-26 12:27:23, Marcelo Tosatti wrote:
> [...]
> > > and delayed pcp work that migh disturb such workload
> > > after it has returned to the userspace. Right?
> > > That is usually hauskeeping work that for, performance reasons, doesn't
> > > happen in hot paths while the workload was executing in the kernel
> > > space.
> > > 
> > > There are more ways to deal with that. You can either change the hot
> > > path to not require deferred operation (tricky withtout introducing
> > > regressions for most workloads) or you can define a more suitable place
> > > to perform the housekeeping while still running in the kernel. 
> > > 
> > > Your QWP work relies on local_lock -> spin_lock transition and
> > > performing the pcp work remotely so you do not need to disturb that
> > > remote cpu. Correct?
> > > 
> > > Alternative approach is to define a moment when the housekeeping
> > > operation is performed on that local cpu while still running in the
> > > kernel space - e.g. when returning to the userspace. Delayed work is
> > > then not necessary and userspace is not disrupted after returning to the
> > > userspace.
> > > 
> > > Do I make more sense or does the above sound like a complete gibberish?
> > 
> > OK, sure, but can't see how you can do that with per-CPU caches for
> > kmalloc, for example.
> 
> As we have discussed in other subthread. By flushing those pcp caches on
> the return to userspace. Those flushes are not needed immediately. They
> just need to happen to allow operations listed by Vlastimil to finish.
> Or to avoid the problem by not using them but that is a separate
> discussion.
> 
> I believe we can establish that any pcp delayed operation implemented
> through WQs can be flushed on the way to the userspace, right? The
> performance might be suboptimal but correctness will be preserved.
> So doing this on isolated CPUs could be an alternative to making changes
> to the pcp WQ handling.
> 
> I haven't checked the WQ code deeply but I believe it should be feasible
> to flush all pcp WQs with pending work on the isolated cpu when the
> isolated workload returns to the userspace. This way we wouldn't need to
> special case each and every one of them.

If you look at flush_scheduled_work(), there is a big compile time warning
to prevent from using it because it's too deadlock prone.

But even if we flushed only some specific relevant workqueues, I'm not sure
that would help. The problem is not so much about locally queued workqueue
handling. On a preempt kernel, that would most likely issue a context switch
right away to handle the work. The problem is more about remote queuing while
the CPU is in critical code in userspace.

Also such a flush or local queue would involve multitasking and tick restart.
We could handle that with forcing to be stopped on userspace entry but that
doesn't simplify the picture.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

