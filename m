Return-Path: <cgroups+bounces-13960-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a4VdN/3wkGnGdwEAu9opvQ
	(envelope-from <cgroups+bounces-13960-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 23:02:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942513DAD9
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 23:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3742300DE3D
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A3429E110;
	Sat, 14 Feb 2026 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJZ2N0D1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73676142E83
	for <cgroups@vger.kernel.org>; Sat, 14 Feb 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771106554; cv=none; b=sNcqA5Trs0Ta0e3xQAMYN50/QblYgXNUFQsXhpqkG47XyJ25o+lCqPc9RRYh0OAkWXN1FFrVb8RzGU1xHNygQNQD/wzpk8MYDohk2XniiMNmEyV5mVK+ShRoTfgWxEfdbPq5QwySv4U0lW1rRn2fdbh8QZzUVpaaFk+Ty5S3ZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771106554; c=relaxed/simple;
	bh=Gj+I22Tr3tVH7ZqlO8rebfanQFip8QzVyhWkU7kKwM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=KsmOnIllI3m9/LvpO8/b4DeqazYQA3zywCvwBw5jlNcAzXEikfOJ4i8VfvoLe81GNRcNrX42AAUil9FH3eC0XID4cislhPsJOvbgDP3oM/71LC5dl9UWe+oRwr4iiCEyNO/brcBJtCzSL3sN8Pr5EUiCfICIDTd4wdo3pvfpzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJZ2N0D1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4833115090dso18334635e9.3
        for <cgroups@vger.kernel.org>; Sat, 14 Feb 2026 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771106552; x=1771711352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=paxX9wG390aNg5udrEFUWei2TAJHGt4ATBMIYJAPwO8=;
        b=NJZ2N0D12r9f2EkyyrIgz/kFT1K48PuvC/rYNaYHGP5gw0wp7/EZsMWdmFQlHlRkQA
         eE0tHaWY0Vv6iTToEfhUk+dAOHJKIVdYZ41k1zWZYEkVnAguHjwScEn6JbghirEyuvQJ
         D86L+qfrlev//Kz/10cQBMzcFBODOu6Va/NLVCmXxE57AUU3egN2SOxdZqf4yT1/b+tx
         +DP3dyGITEKuA7iY7vgp2NcBMRPdj6RI1deVqDA+tCzA7d9KIT5tORZUeVZU7gVcTbev
         TNeIrztfZiJashB62Mq1VdO+l87hSeTgHzKvnv+eSRaslw7WyghflnEzoTx5+6XkMXVd
         my1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771106552; x=1771711352;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paxX9wG390aNg5udrEFUWei2TAJHGt4ATBMIYJAPwO8=;
        b=pfSYp7vzMiAX800lruNrF2x9ZXRHd07qRQOgwKaAiZauNe3luk10YFDM2uvyylM3FV
         /sEpwMNWvwm8A27oerJU2UE/ostLJWxCp8uE91PbSgz3NJhXSx5cTOOeo42HGXY3x2zu
         THs9iY/j9376FMkDZZULKBOdZPk2FbnLAujFpyGZeR/p9PB7CQkFOTapuLM7Y7qEK4MW
         6yuZAnK1UNjQdfyWpKQoXLXM9780aBnKtJG2DUOVGqc7oVCqg6HclR+iEBDcvmFobsUx
         T59gEyFQ/frp+EVVCR/s/Svrds1owAi3gJsUAkoihNuE3DusuZ5vPu8N7vCvzWf1Ii9q
         Ek+g==
X-Forwarded-Encrypted: i=1; AJvYcCVT1NKvB2iz5Hoe8xhwcPfAzZmbAcEw7HwpjQ3Pkp/VJqpEMuySZ8wV9iixzBMoa3LuBxWRsxwp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7G0sx9MCZ2xxK8nFmhUHHwMfZaR+KHlQp962JKjSOTCYvIbdO
	fLcKny7aQN2Z6KwOuIPder1z6OmfAt6EktzFl9JlXq0afFHkEjW7Q0Si
X-Gm-Gg: AZuq6aJZG2Xvd+RZTmZxj7KzYKxSqyooSCPLuODFUmjZCiW9CXwAOT9y/hn1+s4CqK3
	TB4gQRurnA4ExasMgvBeAMR9zB4RKOUlSO2zTp1Ms9jbAG3oMgcckkHBVXZ8/BOudtlw1bcX1BU
	Vg92I1YRu9RkD9rGdV2WWP0+WZflqvpAmz2W8jqo0ohU3TtyR7KU2xQ7gmz8g0AEMzo/xyC3BTI
	YMkwa4D537Lkg7G+23YMGG5Gev9zurv/h1IhQB4ZNiu95311LACC15z6PmErAqLXOW6A11jC1In
	KwFFADGBWngv3uSVgBOM7T+NuQEH70MEZOhUUTSQRazrsBq5+waouiolmlrVFL5hApV4SwozL4U
	5+2O+3pJpilMRbNyKm6xiL5rekOo+WcnDxmN4ffWhr9PWgC2ZXUhdZ6WjwZKLshFBFy/CGjGusf
	NnvEG2H1IZz4YvLgzXRnqgzUd9oQb84kxQWvU=
X-Received: by 2002:a05:600c:1381:b0:483:54cc:cd89 with SMTP id 5b1f17b1804b1-48373a1bbc4mr101089835e9.9.1771106551731;
        Sat, 14 Feb 2026 14:02:31 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a34d66sm57123695e9.20.2026.02.14.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:02:31 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Date: Sat, 14 Feb 2026 19:02:19 -0300
Message-ID: <aZDw6xI2izFDfuuu@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aYywl1hdBQP2_slo@tiehlicka>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka> <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13960-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,suse.de];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2942513DAD9
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> [...]
> > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > have requirements as strong as RT workloads but the underlying
> > > fundamental problem is the same. Frederic (now CCed) is working on
> > > moving those pcp book keeping activities to be executed to the return to
> > > the userspace which should be taking care of both RT and non-RT
> > > configurations AFAICS.
> > 
> > Michal,
> > 
> > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > boot option qpw=y/n, which controls whether the behaviour will be
> > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> 
> My bad. I've misread the config space of this.
> 
> > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > (and remote work via work_queue) is used.
> > 
> > What "pcp book keeping activities" you refer to ? I don't see how
> > moving certain activities that happen under SLUB or LRU spinlocks
> > to happen before return to userspace changes things related 
> > to avoidance of CPU interruption ?
> 
> Essentially delayed operations like pcp state flushing happens on return
> to the userspace on isolated CPUs. No locking changes are required as
> the work is still per-cpu.
> 
> In other words the approach Frederic is working on is to not change the
> locking of pcp delayed work but instead move that work into well defined
> place - i.e. return to the userspace.
> 
> Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> paths like SLUB sheeves?

Hi Michal,

I have done some study on this (which I presented on Plumbers 2023):
https://lpc.events/event/17/contributions/1484/ 

Since they are per-cpu spinlocks, and the remote operations are not that 
frequent, as per design of the current approach, we are not supposed to see 
contention (I was not able to detect contention even after stress testing 
for weeks), nor relevant cacheline bouncing.

That being said, for RT local_locks already get per-cpu spinlocks, so there 
is only difference for !RT, which as you mention, does preemtp_disable():

The performance impact noticed was mostly about jumping around in 
executable code, as inlining spinlocks (test #2 on presentation) took care 
of most of the added extra cycles, adding about 4-14 extra cycles per 
lock/unlock cycle. (tested on memcg with kmalloc test)

Yeah, as expected there is some extra cycles, as we are doing extra atomic 
operations (even if in a local cacheline) in !RT case, but this could be 
enabled only if the user thinks this is an ok cost for reducing 
interruptions.

What do you think?

Thanks!
Leo 









