Return-Path: <cgroups+bounces-13965-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN38Ch35kmlx0gEAu9opvQ
	(envelope-from <cgroups+bounces-13965-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 12:01:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E41429B7
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 12:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B171A3020A60
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D12652B7;
	Mon, 16 Feb 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JV77inzM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D181A3029
	for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239660; cv=none; b=NjO6zMo6TuTLNWYRrFt6p64hG8xOgu0xpnYdOFrkdTu4AFdc5VILDgD1CcQQPWiHNEN2GUSlTLB4QPVjFh06S4mSrpqofi98fPAOoSAgKu3JMuXmybdqs77+GuF6zMX8pVSuh2kjpgiWYRJbHKBrQBFpgJgBEGG3UEpsZQsHI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239660; c=relaxed/simple;
	bh=5Bs2zOGo2Vwhwu/Eo9m6Z5+r8bQ43/BQ6C/GLcaCW1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyJ0/aRpIegKhTyGDFzqx02t6zt2PNC1M6dsuuJqGdsGHa+sL305mtdHfYD4Qalx9332jgL7yIy2XS3OpNc0R2LfT5uSV0WfoN7eOoe14cMeQ8Gu2azDVnl8xa81D/+vP2H8UTSSOydC3ILncEjpCgwodL0GPn2HmB7RwRGO/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JV77inzM; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4377174e1ebso2227044f8f.3
        for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 03:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771239658; x=1771844458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzgolleu2SIxliK/vEtotu12nLOXFd4HqJviqi0SJ1s=;
        b=JV77inzMfmp8iSeJBoZIGRfsVA5QBobwKz+ofecyLBKdz2nuE1RlRs3WDFfcV/fMMA
         05w2kRaV/Ii+EDWiFDZeURwU2KZTY24emo8ggMte2eIvjD4H7BTOhWkHZSIYQ0TlV2ql
         MZh3ydZzdFfYMffyPHnfSa0CTh6Xhepze+0ZWhHV2kHN3LKtYcEugZpoGhDxOV2ECMxR
         5BKbzq2MtsOM8snELGOCDaGGIExCz53vXf5or5NynIQVj/zCJmlUbnV1xkKkv39ALNK0
         6MBLrEYNI84Sq8StUT9XfD1vf6mxweZdjKgAEb2B4N5aWgq18ADXuyUf5bJCRVsmYRKn
         KM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771239658; x=1771844458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzgolleu2SIxliK/vEtotu12nLOXFd4HqJviqi0SJ1s=;
        b=ME2+OpyAKvV5vG5h3DFDYasuU/vFOaHhYphk6PPi9KdI54goqA7SeH1O82exBFiZWi
         CAXzwq53Z+36OVCDQQoTOxOdkKxyzn2UHyZhrhLHfJ/nVxhSjlNB6Yr/3GI1e176XASj
         s3hjgmzJu/5qJM4yRsEAzqBmjF9tNuDUX3NPlLOcejCoDruKYam+b5eb1oEscMgiv/RB
         qdviGA3bIgyMGNCy95jkp4fksvzNpO6aD/LTuHkC3YxIusvx40ath1G0FShDQeqsjsEt
         nCX2JtBjCU+fZLo2gq3zznjCGXYixlewG+/nMh4kTpu+BRwueQrKUffn9vaEuH7biVFp
         s0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVeFys9su15LT4f26uleLlgZnLj2L14hLZ0Wl22BfcRgu70+ML+N/ZGuTMiIKRDixW3blYAa3sg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sDZmAEIngIq4+K1ZP4FhLJAEqnPPTYXRg/vyku217+rkQldj
	E/kaArliDOHBbXNSxH/n78asrZqlWIimhS2ZQB8/KlNAOWPqaqyqL2lEqGR9pStzOMQ=
X-Gm-Gg: AZuq6aKGOLxxZg79+MLhR/9/M691nBLRak8HtFqoC/wRbj+bAz8+MkVoRRk0e3EEY23
	Ugpr3bGvSdP2UfPva7fq2r1gjHZxyAnSu0kTZLOwzStnqJArr8BTQ/XQNOpZ8wSxp0b09/WZ05l
	wYmcJG3FdTAa8BwJ2Ja3aWHgm1bIc7i7W3tZ8tYV5QIs5ZruKjAykXc2wxM41PzUezFkcFvfl6S
	xHfylwU2+Xedsb4wHe89VGPBkD613xxoUvGKRiUOsBECXCpk+KAfHnfwRuobyICRbd1/mR7cK0m
	y11NLDVyDkgAj9wdmwlVLigxcMxpvWyG2iqCHTxGY8/CgvWfbgnO4d/T29zX90kBEInhazYD3/g
	EbWE/Wg1b8rq27DFoWel66lhlILgdmkOkbq9EbAU/4m7MiAB4Hf4X3xSnlLJDuB+pl/4Yajip4R
	MEtdtae3R3CX9ehix0QSLXOu81NxIMz6++BA55
X-Received: by 2002:a05:6000:3102:b0:430:fdc8:8be3 with SMTP id ffacd0b85a97d-4379790ef6cmr18730047f8f.29.1771239657494;
        Mon, 16 Feb 2026 03:00:57 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5f0sm25813158f8f.11.2026.02.16.03.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 03:00:57 -0800 (PST)
Date: Mon, 16 Feb 2026 12:00:55 +0100
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
Message-ID: <aZL45yORfkNvS9Rs@tiehlicka>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZDw6xI2izFDfuuu@WindFlash>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13965-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,gmail.com,linutronix.de,suse.de];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: B61E41429B7
X-Rspamd-Action: no action

On Sat 14-02-26 19:02:19, Leonardo Bras wrote:
> On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > [...]
> > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > have requirements as strong as RT workloads but the underlying
> > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > moving those pcp book keeping activities to be executed to the return to
> > > > the userspace which should be taking care of both RT and non-RT
> > > > configurations AFAICS.
> > > 
> > > Michal,
> > > 
> > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > boot option qpw=y/n, which controls whether the behaviour will be
> > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > 
> > My bad. I've misread the config space of this.
> > 
> > > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > > (and remote work via work_queue) is used.
> > > 
> > > What "pcp book keeping activities" you refer to ? I don't see how
> > > moving certain activities that happen under SLUB or LRU spinlocks
> > > to happen before return to userspace changes things related 
> > > to avoidance of CPU interruption ?
> > 
> > Essentially delayed operations like pcp state flushing happens on return
> > to the userspace on isolated CPUs. No locking changes are required as
> > the work is still per-cpu.
> > 
> > In other words the approach Frederic is working on is to not change the
> > locking of pcp delayed work but instead move that work into well defined
> > place - i.e. return to the userspace.
> > 
> > Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> > paths like SLUB sheeves?
> 
> Hi Michal,
> 
> I have done some study on this (which I presented on Plumbers 2023):
> https://lpc.events/event/17/contributions/1484/ 
> 
> Since they are per-cpu spinlocks, and the remote operations are not that 
> frequent, as per design of the current approach, we are not supposed to see 
> contention (I was not able to detect contention even after stress testing 
> for weeks), nor relevant cacheline bouncing.
> 
> That being said, for RT local_locks already get per-cpu spinlocks, so there 
> is only difference for !RT, which as you mention, does preemtp_disable():
> 
> The performance impact noticed was mostly about jumping around in 
> executable code, as inlining spinlocks (test #2 on presentation) took care 
> of most of the added extra cycles, adding about 4-14 extra cycles per 
> lock/unlock cycle. (tested on memcg with kmalloc test)
> 
> Yeah, as expected there is some extra cycles, as we are doing extra atomic 
> operations (even if in a local cacheline) in !RT case, but this could be 
> enabled only if the user thinks this is an ok cost for reducing 
> interruptions.
> 
> What do you think?

The fact that the behavior is opt-in for !RT is certainly a plus. I also
do not expect the overhead to be really be really big. To me, a much
more important question is which of the two approaches is easier to
maintain long term. The pcp work needs to be done one way or the other.
Whether we want to tweak locking or do it at a very well defined time is
the bigger question.
-- 
Michal Hocko
SUSE Labs

