Return-Path: <cgroups+bounces-14417-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAFsDXbxn2kyfAQAu9opvQ
	(envelope-from <cgroups+bounces-14417-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 08:08:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C358A1A1A57
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 08:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 758E030C98A4
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ABA38F23D;
	Thu, 26 Feb 2026 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MM9fkwvl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A138E5DF
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089580; cv=none; b=e1XFpkfYsSRKL+NEkoMZLeFooGeON8s3aCPhbXcANMUA4fJ27xgkiQN0oYnUW4no8/eKE06Nw1OkcVa/AGJmFl1D42PrrvIwoj76zArn+VtHr1PQFvKSc8lDA46pjZSvvh6Onm6Nt2tOs+DkR/1UzK7+yI+1DqwmI1ZstLCLmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089580; c=relaxed/simple;
	bh=FazkpHjrkb8zZWOMtCUGeCY8AxmBQAe8akNPIgRMSz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyqDxFkhBZkZvfbfmwuzb5JJ/wqM9PqeA6zIYnaeDcVkA1SENLBqMT/mv4WJfuvOHeXxPJxXc7oEZ+Wzs3nNC6WSIq2MfoeLn7Np2dOBTeNPZXuEakse/sopmbAHmqPjXrXjei521VTIMZ6BARBgGolB89eDwbWVfz2ksjwdunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MM9fkwvl; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43767807da6so305867f8f.2
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 23:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772089577; x=1772694377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wRNHYTQlLX9EerVe+YBMUcaaqn9OJCKpaOuanb3o058=;
        b=MM9fkwvl6HuRz3VnxAR21CupoCPRAmv/tV7IRSuZQpy3oqPU7nra1jkW/mw4R7MeTP
         tOeUfnePIo8vFQI4U7sq7t5w1ZZunpEd8DTgtBcygSHSTBCLXrAGm+dMiumRZmAoPz8s
         0BsKkWgutbfp/wvTNm3a5Ip8guGsQt22Te1lIWtDfz7Hqe/3r2tuADKgAhdmZKmrfx+G
         6aYKOV1gCYSNx9NwJVfECvDSQAZV6bVzskZXvaMoP+tN6KfZDRnNaDxEunVrdVm9AL4M
         J49XZwTVm4gQYX/41mp/n1QmK93mH+IjAs4p1M2dvTk36k2Q85fiWrFVQIHGupDqPVL8
         RnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089577; x=1772694377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRNHYTQlLX9EerVe+YBMUcaaqn9OJCKpaOuanb3o058=;
        b=YOMhzNmY1h4kQPaTLxOcMk1yPqp8xlMnHZSKRdTuGWff6sjBNQ6UhfGchlK+NBjZ6G
         p3DNLAY4OhybKp+JMvYGAsOO8AgpDTCwziQOrzF4i7CcmXDN9NxyKE2/P3rbJP8hUnzU
         skm8oJZwao8aHgVPzychSdE98LwGpN8c4yckh8a2azfk43KptQneSyqD0Uzd0VM7CPrV
         fVqVKwiq+njw5AwrxnGhZZxsk6bClQp16CzVIRZ0JuJF/vpFNTMU+RVyKkXdGofLxL5n
         cqZcTgJnZhOM9Cpvlzn9vC9aAbOXfemoC0wBm0SrLtYq5ZQ+tfutGzdpusQ3YuxgZ+Ku
         cAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu5BrEQVAs+fc/ktnML0fMS6VR2GB+rA4DIq+XvayplQMLiCa7PMzTEe2k5V0HS4eqDPdkFR+z@vger.kernel.org
X-Gm-Message-State: AOJu0YwqncHoLGZn8fSMJYXMNlUQkKQoUxnUNZtlNVorCUbcetstPNIW
	6Xg3Jsiz9YD7lFriihSXsdru98kRx8R99VbmYyGtIiHzHtt+grrG/C5KvqIn/16Q8vw=
X-Gm-Gg: ATEYQzyPmHl6AkkyxE3qcwu6mDomX/M6J7eu68XXO1m/TljK8j1d40LFhZEbntuwXRn
	0l5Xwfn7lruiXLYpagOi/9udMEsiXNQSPx4WWBJhdfYBWfREKTf1ECnie6DRtj7/X/K0d3WCE6W
	WASDPnss6cf/oSWlje2mW7hFq60j7FipsgXm/NiEdICJjQUc2xYVHyB2Hr4tdM9BJ9Y+DMi5G2z
	P9jrpr4WS+lKC5qDWMpiKIcRaWxEipfrX6quM8rxld93Mh4n0RfPWlRQZX1bQwhGACnYzaNu5N+
	EpICHueCK+Eicd5a7/+1oO43c4jSQdKTq/D4dgs7kpUWBiH0CsIHNxTFkliqiJQd9uIA8vih4B8
	6WvQ6sH3Yj+SZLuLLjA5HgqG1NeC8QII5OZjuge4tHXqWHtqCDMtYSEj/wcniykz5LV/SRFuxX8
	mdODni6W0J2QZCtm4gGUjA2KaWl/s9S+f0Wg==
X-Received: by 2002:a05:6000:250d:b0:436:30b0:759f with SMTP id ffacd0b85a97d-43997f341b1mr1907374f8f.27.1772089576879;
        Wed, 25 Feb 2026 23:06:16 -0800 (PST)
Received: from localhost (109-81-17-39.rct.o2.cz. [109.81.17.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm17021783f8f.7.2026.02.25.23.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:06:16 -0800 (PST)
Date: Thu, 26 Feb 2026 08:06:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <aZ_w51dnP27nFZxL@tiehlicka>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ9ugjKvb4U7_R93@pavilion.home>
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
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14417-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: C358A1A1A57
X-Rspamd-Action: no action

On Wed 25-02-26 22:49:54, Frederic Weisbecker wrote:
> Le Tue, Feb 24, 2026 at 02:23:25PM -0300, Marcelo Tosatti a écrit :
> > On Mon, Feb 23, 2026 at 10:56:15PM +0100, Frederic Weisbecker wrote:
> > > Le Thu, Feb 19, 2026 at 08:30:31PM +0100, Michal Hocko a écrit :
> > > > On Thu 19-02-26 12:27:23, Marcelo Tosatti wrote:
> > > > > Michal,
> > > > > 
> > > > > Again, i don't see how moving operations to happen at return to 
> > > > > kernel would help (assuming you are talking about 
> > > > > "context_tracking,x86: Defer some IPIs until a user->kernel transition").
> > > > 
> > > > Nope, I am not talking about IPIs, although those are an example of pcp
> > > > state as well. I am sorry I do not have a link handy, I am pretty sure
> > > > Frederic will have that. Another example, though, was vmstat flushes
> > > > that need to be pcp. There are many other examples.
> > > 
> > > Here it is:
> > > 
> > > https://lore.kernel.org/all/20250410152327.24504-1-frederic@kernel.org/
> > > 
> > > Thanks.
> > 
> > Frederic,
> > 
> > I think this is a valid solution, however on systems with many CPUs, in
> > nohz_full, performing system calls, can't there be significant increase
> > of lru_lock contention ? Consider 100+ CPUs performing many system calls
> > which add 1 or 2 folios to per-CPU LRU lists.
> 
> That's more a question for Michal or Vlastimil.

And practically speaking we would need to measure that on real workloads
to be sure. Keep in mind there is still batching going on. We just flush
the remaining of it on the way back to the userspace.

-- 
Michal Hocko
SUSE Labs

