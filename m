Return-Path: <cgroups+bounces-17227-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F6ksGvqyO2onbggAu9opvQ
	(envelope-from <cgroups+bounces-17227-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 12:35:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2D6BD6B2
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 12:35:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RR85Reox;
	dkim=pass header.d=redhat.com header.s=google header.b=NRJwlZvv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17227-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17227-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3517300372C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6D285CA4;
	Wed, 24 Jun 2026 10:35:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454E28469B
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 10:35:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297325; cv=none; b=BzMKtv7VqQjX8xsyO/NP/mjIL+EppSTZ7ltqa/gFu6+HdOBlZj60PXnVy1iE1etf/dBdL9B5RVQl+dZ2ufrDOie/PPxc3jUOUSyCE5ghcOuJnukdHtwL+veIMbMECskrrH1AFQoVZBRyvGoNCZTXsvbMLrDAvyfAyoS1B9hRwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297325; c=relaxed/simple;
	bh=HIaYRlugnYrnIAEZ7/D3scwdn/jpoj1NmRTr10PelGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBKdKcYnVlmM7JNV5Brutz074ZScD5g7pHqDsrNQ+IWu6RPEStpfvFzz4iJqYfXfJOAkGd85mFNX6iFtMGl7Wp0vSACZct/3LuPB0iQ3ogECEh0xBO22zl2X7nVgRlw6PCYwHrsDO/iD34EFKYua8U/0kA569LlF8CMeTTfEL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RR85Reox; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRJwlZvv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782297323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TquLabB3IWUoIxIeapfjmriI8BBgvu3sn49zWkWYrOA=;
	b=RR85ReoxJJgj9kY/osOpYDIgVlhTlkBsc+C13qFfZYNYpMl2eQA5gJBNieVNBEUZSBycBb
	/hreRWE62KZgu6ZZ+v+Lfr2PDCKxiri3NX6IWVh1e1qo9xcxnZj3nVMf6aVVGQewF2PBGD
	5hEqXLANUSNHw4mSCkxsxCBRvPora+Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-ybd7a6_1MgOAPFCHH58QIg-1; Wed, 24 Jun 2026 06:35:22 -0400
X-MC-Unique: ybd7a6_1MgOAPFCHH58QIg-1
X-Mimecast-MFC-AGG-ID: ybd7a6_1MgOAPFCHH58QIg_1782297321
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4639f122c38so616178f8f.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782297321; x=1782902121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TquLabB3IWUoIxIeapfjmriI8BBgvu3sn49zWkWYrOA=;
        b=NRJwlZvvI0Nam4tW04F9KpWLy3foVaKnbEIdy9cF+F43jlx0KealUkBvaqNe7iHfhY
         t6LJ8UDG1uDrsovvl7WMs62K/ztfIxQh7PqLuE04BLXO89lzShaX1h//PmkDgjE9wUVQ
         xx1dkElhn0LOer0yxlMuHIfezJFJjpc4ThzZCjUF+jaWivqd59NHKk9NLPGJSCAIrZQ8
         jTlXkHzFDRAz8byTuQecPjGg87t1rpFT//dEAPbZsyKrYxTUha65Oe0VtJzoL9fQlbR8
         9CNZNQjACpKR+opIDzu62OoShYjJJPLygPrOwT/UCZPigJytf2w5C+KXJPbvfporCFuO
         WEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297321; x=1782902121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TquLabB3IWUoIxIeapfjmriI8BBgvu3sn49zWkWYrOA=;
        b=CQI2jpsTsULZXFb8hlSZ7VfWmIEWSJC9QCJGvVyzrZYJExY+/IRSLnba15lPuVJKok
         D4GV6G4LzRd1/Rg3x8J7nDcrNe3Zr5t0gtgsJatM0OUF24dvyf6WxWTLWSYZqB6KhuBG
         Bw3otzzMr9AuBZBfcrRr4MzUSl9/vIDAx1DqdUMjm34CtJ6LokuHKDoJy7/tzcgPcdgw
         iDNPMbPNFuF+OpazkNTK4zE4AdUGtoT6gcts0ZADkQoapGaeOKX6S7sfzB0OBq2qDT3o
         2aUMQSSdCOpqXHjiaUhgMVp9ydLlvfXd22Q1b6uGaLso7yvaFq1vHdTE5SN6x44ujnyg
         aNeg==
X-Forwarded-Encrypted: i=1; AFNElJ9LMWe124phM5FWIgFkfi29Ea3GsIPXz+enZSLe6PK/KXdzwjDE9p2j0vKQOHe0fyn6QMs2H1qk@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHUe0eETblK2UdCRaoINbnREScv/60BlP7OEC7MYkFM917LFg
	H56MfbxITj2pRlIDETrv5vXZ2OaD/z9+YkrxYblIpdNTaPTZUKRXhSRIBIwG8+z7RnQFn4Yh8ys
	rinGZEUSBb1+q9A1f8qtslh+cjOYIei5xWq/l5liwZ5XKyN9pjuHQRPifTDQ=
X-Gm-Gg: AfdE7clzrNtLa2ts4JVJFwvmdJuVzA9af1L/Qos4kngds8sVqkL22V4lhk8CsjMZQ17
	8zxvU0uRw29DV8+ksNkLyeaEUmpJiwSIYe7AXHWGrKXdhXamuxrL3CIvL1/eo/UTO/T2zPujIxe
	Rw85NMkw6hFhjrpa8wf1mEQAHt5I72aZO9Kn5cFDJepOIQsPrX7EpL8O8SzDTFwa3kgsgssQdoy
	mZNNYwcQ4LBXWabSRKXFyOgrzoSvY1DD/6wgnGLyiWkvr7LNwHFuIFXkdkBsl/wOe4Qc/mIrAl9
	LpSwrRvHPkFmqLNyNNq7pdnPM7U9Dqm4tDhEsQcu5ra7/YRzjdwwYjM66JAd/tkt+y2ZkDilj5Y
	qbgUULanOJwLiPBEHnYQDwyvOtDuWdk2BVDqpCbvn7Q==
X-Received: by 2002:a05:600c:c0c5:b0:492:4ff5:fb9e with SMTP id 5b1f17b1804b1-4924ff5fe1fmr187065815e9.37.1782297320960;
        Wed, 24 Jun 2026 03:35:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c5:b0:492:4ff5:fb9e with SMTP id 5b1f17b1804b1-4924ff5fe1fmr187065395e9.37.1782297320627;
        Wed, 24 Jun 2026 03:35:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.133.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm782135435e9.0.2026.06.24.03.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:35:19 -0700 (PDT)
Date: Wed, 24 Jun 2026 12:35:17 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
Message-ID: <ajuy5TDGckfXjpET@jlelli-thinkpadt14gen4.remote.csb>
References: <20260608121546.69910-1-yurand2000@gmail.com>
 <ajpcrDn2g2G9mGKp@jlelli-thinkpadt14gen4.remote.csb>
 <20260624091912.4fca8428@nowhere>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624091912.4fca8428@nowhere>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17227-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,cmpxchg.org,suse.com,vger.kernel.org,santannapisa.it];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:luca.abeni@santannapisa.it,m:yurand2000@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AF2D6BD6B2

Hi Luca,

On 24/06/26 09:19, luca abeni wrote:
> Hi Juri,
> 
> very interesting demo, thanks!
> 
> On Tue, 23 Jun 2026 12:15:08 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> [...]
> >  - At 1ms task periods, the dl-server period is the critical tuning
> >    parameter, less the bandwidth. A 10ms dl-server with 60% bandwidth
> >    caused ~10% miss rates because the worst-case throttle gap (4ms)
> >    spanned multiple 1ms deadlines. Switching to a 2ms dl-server period
> >    at just 30% bandwidth eliminated all misses.
> > 
> >  - A simple Rule of thumb might be to set the dl-server period to at
> >    most 2x the shortest task period in the cgroup (e.g., 2ms dl-server
> >    for 1ms tasks, 10ms for 10ms tasks). Would you (and Luca?) agree or
> >    would you suggest something different?
> 
> With one single RT task in the cgroup (or with multiple synchronized RT
> tasks having the same period), I agree... Technically, the cgroup period
> P should be such that P - Q = T - WCET (where "Q" is the cgroup's
> runtime and "T" is the period of the task), but to see missed deadlines
> you need a relevant competing deadline (or HCBS) workload.
> 
> So, yes, I agree with your findings above.

Great, thanks a lot for taking a look!

> If we consider multi-core analysis, or multiple RT threads with
> different, non synchronized, periods, then analysis tool by Yuri
> (leveraging CSF analysis from real-time literature) is needed... But
> that is pretty pessimistic. The rule you suggest above is a better
> starting point in practical situations.

Indeed. I actually wonder if it would make sense to "extract" that tool
from the test suite and package it somehow so that it's easier for end
users to design their interfaces.

Best,
Juri


