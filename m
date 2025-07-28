Return-Path: <cgroups+bounces-8916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB4B13F95
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 18:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6933716EC33
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50C2750EC;
	Mon, 28 Jul 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="P1gAkzQi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E5274B21
	for <cgroups@vger.kernel.org>; Mon, 28 Jul 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718865; cv=none; b=k/qrnMZSx3ckYNx57Lj6lI1zFZBnQ2qtpSu9hJLc8zo1T4D1tnf6fSQGSDMOPBLHF3rOfLFt8EZk2LILhe6AT8QJIDkoAD32O4ClXt44P/1s3Kqr1jW7Kb0IAIFaiyibDMeCU33OdiEOpAytaChZmJilC3GY6PN8dirOlIcrVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718865; c=relaxed/simple;
	bh=RHNgwp/NdNGH7gkst2l4JDCtJhh6aUvSRSKnYwmtNtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZFD0f+83EkSNnfarsbDl5mWAYdqCUqtnf/oVDtsWo+2p4ofpPBUPUjC9yTyWi1Q+IWUZukCid2LGj+IVqoNVsSbfXJshbm/B/n2fuSTd3K2duzhekvOqMcrDxtPaIYKnSAvXtktFUWJC15ygP9VsBgIwHxCFM5L6QLzyNIPpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=P1gAkzQi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7074bad053bso12603566d6.0
        for <cgroups@vger.kernel.org>; Mon, 28 Jul 2025 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1753718862; x=1754323662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAw+2X708It0VR8pZYVOK00HQXozxtPn6s8nfVW4nlE=;
        b=P1gAkzQilIAHEGwKAMQXnIgfhmxiUSjDGx6rW2jiIY3p+ib8UnMG6By7A1MHr4GFjd
         8YJ1xkjtKJydTnMEvM8SmyD/JJYtIcM8/WMkpfqjsp//BSGWOBPrQPKp2N3WdvM3KS3Q
         R4VTxCZdDXB6lPfKjaS3CR414jq2CIg8pr89G3aHePXDvRS64yKfBDRWYHrzdw+iu1JB
         bYq3ZoRRc3Z/2lK3ZNbLqvm9SWKaCM7+HYkrut6q+7e2xaAUUjDztv46ZYGAlqxim+1t
         Gd9urpx7M1WTi74eF9y1e05NaWcvFJ+VL6TY96x41ziVFyvyHEuKQ3c2PjuSTK9qAoVn
         j9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718862; x=1754323662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAw+2X708It0VR8pZYVOK00HQXozxtPn6s8nfVW4nlE=;
        b=BMZwSzd/hTXoq2PRgK35ZB3gaCKWrhgyOgGt6PEho5q8UKCBhODYbPXoabSmx4grcX
         YwMv4f8watJFfaJf03Z3MEbM0CsdK8evStdka8i/Id2KxIrFT8mp3828yajZq7CFjN5O
         /fnFPMRoOICf4Lqbr2TJ8d9migumgk5igcNW5x8i82fi9CursQS7Xne24bCLfBmcmsLj
         KzsatSWfLljVRht/BBtEfcLbyeHHDNiE8cs0eNWVcO0V5fCuQdvuIwt9Y0kOcbj9MKSo
         aBjpHNdkebsjivlYWGqTHibvP/pR6hobVlAshFVl1mI+oZjFb9dvY/aHpVgq0/LNSIf6
         o43g==
X-Forwarded-Encrypted: i=1; AJvYcCU9rjhOrK+IZVrOi8OQq/qcksNX/3VAy36hFbAZNrjEUR0CweHTbN9upXwtNk/buHUwdxU4H0oy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfr9jndPFf1f7REwDpDGf6d/8OyrXYvKPZZovG61rzaQLEDCjK
	R9DV0uaDkQUszGRovSUsev7V9cbu1nonLY8ehaaKf/wkx7gVV9BbuGt5ZOc5ryb1bQ8=
X-Gm-Gg: ASbGncvOzFwA9ZTMlv8H6aGCglCe2SQrrVOChdqxV+to83/HwWTtD4D7khH4WubJpUY
	fITz1KIATeFN+X7GykIGhQAgDRbGJgPs0oeuXA6BlUGhGUPMS/EgDykZYImDTIl0wwPq+NSLwTR
	FwV68Ey/QMBC1JtJVRbmRNa5T53Pabnt9aqqg7tR29Gp2ozFL2YGAIDaAWo9n/7G5hq+qHxcdtv
	TGJnNSvsbD4amNpXsrIXHM9kreCWEaOMGL8rwzAb81yYc6K7oJbAYwBPj5uLfFVIKXTykhGVl//
	UgJcAvgkpleKoHChxwWLkM89832WztxomP41y68MPvaYE/GiqxpsDa/AfVxRN9/PoCZjr4IuzOw
	Kn7qM2Nlo4F6M51g7PDcYSQ==
X-Google-Smtp-Source: AGHT+IEaDZooEETiaWkCw4px/kQlCCmeui047F+bWZwnIBB50xOtbajOnYToq+ch+2hvV2HYIRrO0A==
X-Received: by 2002:a05:6214:76d:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-70720534e2fmr187905276d6.19.1753718861920;
        Mon, 28 Jul 2025 09:07:41 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70729a9657csm33250636d6.31.2025.07.28.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:07:41 -0700 (PDT)
Date: Mon, 28 Jul 2025 12:07:37 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <20250728160737.GE54289@cmpxchg.org>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-14-kuniyu@google.com>

On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
> 
> When running under a non-root cgroup, this memory is also charged to the
> memcg as sock in memory.stat.
> 
> Even when memory usage is controlled by memcg, sockets using such protocols
> are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> 
> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
> 
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and a single workload
> that opts out of memcg can consume memory up to the global limit,
> becoming a noisy neighbour.

Yes, an uncontrolled cgroup can consume all of a shared resource and
thereby become a noisy neighbor. Why is network memory special?

I assume you have some other mechanisms for curbing things like
filesystem caches, anon memory, swap etc. of such otherwise
uncontrolled groups, and this just happens to be your missing piece.

But at this point, you're operating so far out of the cgroup resource
management model that I don't think it can be reasonably supported.

I hate to say this, but can't you carry this out of tree until the
transition is complete?

I just don't think it makes any sense to have this as a permanent
fixture in a general-purpose container management interface.

