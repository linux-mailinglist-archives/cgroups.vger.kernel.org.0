Return-Path: <cgroups+bounces-14136-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDDGFWganGkZ/wMAu9opvQ
	(envelope-from <cgroups+bounces-14136-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:14:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C865E173A4F
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F69130BB73C
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696A34EEF8;
	Mon, 23 Feb 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bSBkdh9m"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0034357A3E
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837600; cv=none; b=Z/Ep8OmZzx8p6i+lJifly6J3p/r9e4LhskvNcVLLwhwzG/RRe8AAqtcHtikkJsaijMiC2tWJNW96hB9aRgQFhlfQG3B5QCFU7O/oJ/2QNvxHHfj0k5yNsFG59LtRtH+AKH2rI0Sj0A2jIsNAVsALz5XTjYU+hnQprQituXZnJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837600; c=relaxed/simple;
	bh=jqB3gE1qn7rXR9HRuSIc3L+7Qq9RTUV9iPWCv3Jp82g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7l8arJeKiR83pJoYiccxm7Tz8zivviHt+b5lVITMI6oku37sRtC8QD2uz3pT6q95cm5p8zhvfRs9ADXySUrKbK8g+raynjKXmol8Atfzg8IjcTkDSk/Xac0AMes71Jkd9XAa5fGx6TkFDyGQsYnzgjeoURk4+IUSzkXoJsM6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bSBkdh9m; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-482f454be5bso45222555e9.0
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771837594; x=1772442394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRKHr4XfNyvs/GPqZkcXmlWLUOkA8rjTfDtgUabPVdo=;
        b=bSBkdh9mRESWOH3yY010VWNKwvJbOqtsracoBwKkCJtpL5JS8W0BFNYCHIstl3BGAF
         T/r5llRQibtyBymbN5vdEB4l4kejnp8Iu924y2iw20FHOOUQZof9I+PY2LNoc6tdZ9TP
         4zz4SuV0BW225vuAdshjDLfpDsbsnbdkTRvgQkDWRs2frBI2S+PaZE5lp4YyWz5InvmA
         ZDYvVM7ajQADa9rU71roaEVlHcTrbkisJ6UaZYYgDnfFJzLScQ2P3p6akXqrZf6bHZQ5
         iOnWjTq52KMI8rmIkFsqR2PFVkCLAB2VDGdRF3jocZkOQJfmIqC95W2XWbW0bk5edNEr
         kwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837594; x=1772442394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRKHr4XfNyvs/GPqZkcXmlWLUOkA8rjTfDtgUabPVdo=;
        b=Rzc8btPJCGkawwW7pGRxNt45+Iskexnuxeurr1g8uztwmYH3Rmeg2sNzGqbOFkduNw
         zMouInRxypIItkoURKV6niIFuoP/VFEf7IKEUxu7SmlDy7+LFu3HSsBlp3NXQspHCGgP
         nS0Xf9/Nt6x5GF0t7tNHPnD6X9/xHpMiuh74oWMdwwdklD5flcofqX3/NYWu2wpz7YyH
         sUce7wR73MQH4og4WK+uL6hbd+M8vop+ZW1XIFj4zazjsDUEw/q6j5JH/Q0wYzmiB7N/
         asiDH9KyPNyoirEOgR9C2caZs+zQvZWi5B/FqRoNBIa/j3HO6wGHmCwsVCF9EIW/zK9v
         xHyw==
X-Forwarded-Encrypted: i=1; AJvYcCUanlgo/l6PIK02XMTGNzNdpBMCZvzdiCd5Vt+SHmcXFRSVuOHfJwBP2+5QqZRYSbTg/fx4bxoB@vger.kernel.org
X-Gm-Message-State: AOJu0YzleOdl3t3m79tvA/Q72OwXLwPKRDU5By/eWYwAc3eCUR9mWdKQ
	EaHOpg0dQTkPRvJEMv1nkA5xxg7TwUUjcBjxyOSkxJSQypMLrjPYrVe0erYnN0YLQzs=
X-Gm-Gg: AZuq6aIs1zfx2PyXQ8Mhmfb9/3UH1ZO0x2oZctaSlgLiBZdNkzK/wmSFOKIq/ID9H/m
	VuEXyzXTPW2u6q/0dl4Ba5uVFLFWjcq4W/yVmRfc3rjd2/v+PraotW6HjIIxNAu79VNeVX3d+Ly
	SUrEffp9NpDuxP4WU/GF6kcgDIQPev0LHqb0QtvORxRHkDNsml77GmRwj4O0qcMlSeF9NgUG3Ag
	QKdnnFr6zPyHqanKoShYkNaBqrXavOCISENXzCjSAa6pX1DVUNiPSo0jEcSL0jpjOwqDO+ytZbC
	Hq0hBFIwTekWslqVDLXgzTsYi6UdnHgBbX256yNJA7uaST07cqpInWm78VYmy5Dh3MmdNbBmrTP
	xBz3mcgrd6CJrsOxqGxma0Q9YfuGxG/Hm6kCTP5CrqGPygow7qltUQTOCDwy3Q3GSgxpXhRE3GD
	iD1Kwqlzr0t+hG2hbuB46Pn5GD5FZRscA=
X-Received: by 2002:a05:600c:1c29:b0:483:6d9e:e4f5 with SMTP id 5b1f17b1804b1-483a949e5edmr131156385e9.5.1771837593880;
        Mon, 23 Feb 2026 01:06:33 -0800 (PST)
Received: from localhost (109-81-84-7.rct.o2.cz. [109.81.84.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b75b4dsm281117665e9.4.2026.02.23.01.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:33 -0800 (PST)
Date: Mon, 23 Feb 2026 10:06:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <aZwYmNuucBspCYhk@tiehlicka>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZjY9h3XXMNY-Ytd@WindFlash>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZjY9h3XXMNY-Ytd@WindFlash>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14136-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,gmail.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,lpc.events:url]
X-Rspamd-Queue-Id: C865E173A4F
X-Rspamd-Action: no action

On Fri 20-02-26 18:58:14, Leonardo Bras wrote:
> On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> > On Sat 14-02-26 19:02:19, Leonardo Bras wrote:
> > > On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > > > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > > > [...]
> > > > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > > > have requirements as strong as RT workloads but the underlying
> > > > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > > > moving those pcp book keeping activities to be executed to the return to
> > > > > > the userspace which should be taking care of both RT and non-RT
> > > > > > configurations AFAICS.
> > > > > 
> > > > > Michal,
> > > > > 
> > > > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > > > boot option qpw=y/n, which controls whether the behaviour will be
> > > > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > > > 
> > > > My bad. I've misread the config space of this.
> > > > 
> > > > > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > > > > (and remote work via work_queue) is used.
> > > > > 
> > > > > What "pcp book keeping activities" you refer to ? I don't see how
> > > > > moving certain activities that happen under SLUB or LRU spinlocks
> > > > > to happen before return to userspace changes things related 
> > > > > to avoidance of CPU interruption ?
> > > > 
> > > > Essentially delayed operations like pcp state flushing happens on return
> > > > to the userspace on isolated CPUs. No locking changes are required as
> > > > the work is still per-cpu.
> > > > 
> > > > In other words the approach Frederic is working on is to not change the
> > > > locking of pcp delayed work but instead move that work into well defined
> > > > place - i.e. return to the userspace.
> > > > 
> > > > Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> > > > paths like SLUB sheeves?
> > > 
> > > Hi Michal,
> > > 
> > > I have done some study on this (which I presented on Plumbers 2023):
> > > https://lpc.events/event/17/contributions/1484/ 
> > > 
> > > Since they are per-cpu spinlocks, and the remote operations are not that 
> > > frequent, as per design of the current approach, we are not supposed to see 
> > > contention (I was not able to detect contention even after stress testing 
> > > for weeks), nor relevant cacheline bouncing.
> > > 
> > > That being said, for RT local_locks already get per-cpu spinlocks, so there 
> > > is only difference for !RT, which as you mention, does preemtp_disable():
> > > 
> > > The performance impact noticed was mostly about jumping around in 
> > > executable code, as inlining spinlocks (test #2 on presentation) took care 
> > > of most of the added extra cycles, adding about 4-14 extra cycles per 
> > > lock/unlock cycle. (tested on memcg with kmalloc test)
> > > 
> > > Yeah, as expected there is some extra cycles, as we are doing extra atomic 
> > > operations (even if in a local cacheline) in !RT case, but this could be 
> > > enabled only if the user thinks this is an ok cost for reducing 
> > > interruptions.
> > > 
> > > What do you think?
> > 
> > The fact that the behavior is opt-in for !RT is certainly a plus. I also
> > do not expect the overhead to be really be really big. 
> 
> Awesome! Thanks for reviewing!
> 
> > To me, a much
> > more important question is which of the two approaches is easier to
> > maintain long term. The pcp work needs to be done one way or the other.
> > Whether we want to tweak locking or do it at a very well defined time is
> > the bigger question.
> 
> That crossed my mind as well, and I went with the idea of changing locking 
> because I was working on workloads in which deferring work to a kernel 
> re-entry would cause deadline misses as well. Or more critically, the 
> drains could take forever, as some of those tasks would avoid returning to 
> kernel as much as possible. 

Could you be more specific please?
-- 
Michal Hocko
SUSE Labs

