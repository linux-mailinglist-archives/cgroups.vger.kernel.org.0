Return-Path: <cgroups+bounces-14909-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPlZNf+yu2k8mgIAu9opvQ
	(envelope-from <cgroups+bounces-14909-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:25:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A512C7D90
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913B4302794F
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952933A8FE7;
	Thu, 19 Mar 2026 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dZ9ciG8g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED343A5438
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908659; cv=none; b=psjpY0WU4Ee1RWsU9r0eGdTlRlZjzZGz5a+EzLLaC1MsUZulFtf6jTHpD3i7NFWK8jSFjItJtQ8RA6FHH12ZMm37FzYDsMz4o7QCWdconRbdChyIX3ejAzhyH/fY/oIFhQW2xbnxz8KAa5wOJQqutVJ6AXFUcfd8naMXVzgBB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908659; c=relaxed/simple;
	bh=1Mkx5B7eSYzQwBQq0qsgYKqbQE9J4OvD7fKAaXh0skk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRz2fAK2K4vuanUT1OtvZtxMYw8vfqkcdr2sTrA3SKAw6HtBt8UouAIwJ2wtLyhRF9dSi927M3F6Fv5ighR4hJng0GHgCxE4K24uzG8UlZIK8UtBN62LqZGhyDJBnvur0HQY3HRXKVmVe+pveGmAzERiehtbIwD8b2C1KLs69os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dZ9ciG8g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-485392de558so3627045e9.1
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773908656; x=1774513456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5V6YAkrWNnqXNX+5hq6I3lGeubcpIYjE1TNWAVeFtuk=;
        b=dZ9ciG8g/6bgXxnR2oXbkPw0IXl1ZtWsyosrMVUOiCLMJNU5hD51orHehMcVBLnYIO
         92QVlqfqEaAoC8nrBzjhhaXY3YKjRHJwi8V0/qzrcBotersC5gNhGBrhyg0WTRuIlSzl
         SCfimMq/F08XumfaeZgnDtwZxluqIBbeDgU15/vB7laxY4TpeRQAiFS5Bp7wU5xHEjjD
         ujdw4TBT2RHZOjV5QviowXNjPjGTMR+KjXjH88wVm3HMwPITSE6j+AHlExS20oYMJ/O9
         dt7blUSnXKScZxOukxyxLk0LHxlBH5R16sf6PfPaiIj7ACeALzw8+cPlC1Cq09pB/yqC
         axOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908656; x=1774513456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V6YAkrWNnqXNX+5hq6I3lGeubcpIYjE1TNWAVeFtuk=;
        b=aA7vlR00YcFkZWaY4YeZvJX+HlS49Jxr5PaZRp7o62EEZBQQLAa86BCWbJjAjIInSg
         tD7ZrQ+Fwm8BjFoNDLGAwreqivu2cWpObFVeBwcaB+oxS4MDpMqjEhzKO1byQ/fPOcqu
         B7bg2gGU7y/BaI2DzeIgeLpKAwSYbCqhDS1BXoyFgPVbUpKIvpuhQ00o8r8KHzeswdLh
         iap4eu6FHmZouDogvLNGSQ3OJLPxQ6hq/0fhy814MCGxbYkTTCU5wPkZbQ+C97G7NgUJ
         WpDsmPfBNxPZuxY0SiqRzGTaEqhoA4MeLEBIG5J3wO/6DTUHofnSPOBVzxnuUff5fDca
         Gp/w==
X-Forwarded-Encrypted: i=1; AJvYcCXM79oZdBuHAuDtRzzIJrq1SzHnLSTrpWO7GQYKjPr7+aZWXB9psgc5lQNhyoOv5q/hJLkuqKET@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBL69YK1wug/0jr855OMobydv+Tw7hMdDlspq4GRm0mZjSJ7F
	7Fls62IwD8pFiAmVzVd696VtyNXHWrq6pSoO9M+7KXfMjNvwY6u5DBMloXuqjkY3xI8=
X-Gm-Gg: ATEYQzy2CYjRiEdt6kPNXtMj+HPEXEywvcnNypkGl/WXiZ8eE6j0YOgKnA4qQUFfAcl
	eGDbQZjdw2sxiu1k9C17viTBz7ObGjbBEtWLYYOtuXagtuAvqwMESuiJgDOhj8BK0hGVjelN3/8
	2I8OIMIICdudVa6oJsUghBe6urBBVYbRp/LTLM+KM4dwIGAWME2pYoCUUby8dDuFwCiLbDiekty
	7b/12n8A1QZmM/emwm6fvbjmp7S4mHiHdwNgkdcCJK0jEWMAgObA37+g673jtlY8VLwx7f64yDm
	4HNAeKixTu5zXpQU4FCjWWKEAqjGEdJFEE4FrzeTJMhpZm2Q1reHmUbZNmtK/UC983BvbjxGsb9
	wjhxdMZOHaVXUuP30DEI6GSDy9H/5SsdFQOIh9ZF39R6ynk35gKUdcsYIBPQ+jDi3BNLTO+pQzk
	SV4RNGCJ3z4u+yPl0gCXNgsurw24D0AB7RKw==
X-Received: by 2002:a05:600c:3f14:b0:486:f8d6:5dea with SMTP id 5b1f17b1804b1-486f8d65df5mr32233575e9.19.1773908656221;
        Thu, 19 Mar 2026 01:24:16 -0700 (PDT)
Received: from localhost (109-81-88-11.rct.o2.cz. [109.81.88.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8bd5f7csm52663255e9.0.2026.03.19.01.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:24:15 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:24:14 +0100
From: Michal Hocko <mhocko@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, yc-core@yandex-team.ru
Subject: Re: [PATCH] mm: add memory.compact_unevictable_allowed cgroup
 attribute
Message-ID: <abuyrvVfWJKV7CKC@tiehlicka>
References: <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
 <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
 <abphjNOYaNslTA90@tiehlicka>
 <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
 <abpue_k_9mjQAP6X@tiehlicka>
 <73322279-c6f8-4319-827b-938c20c96b9b@yandex-team.ru>
 <abp3-iJbazCpygIm@tiehlicka>
 <b9ceff32-1f8f-454e-84ce-b8788b3a4952@yandex-team.ru>
 <abqQtcNqxzxiZyf1@tiehlicka>
 <fd7409a3-5f8c-492b-836d-559b001a61dd@yandex-team.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7409a3-5f8c-492b-836d-559b001a61dd@yandex-team.ru>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14909-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 67A512C7D90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 18-03-26 17:03:53, Daniil Tatianin wrote:
> 
> On 3/18/26 2:47 PM, Michal Hocko wrote:
> > On Wed 18-03-26 13:08:31, Daniil Tatianin wrote:
> > > On 3/18/26 1:01 PM, Michal Hocko wrote:
> > > > On Wed 18-03-26 12:25:17, Daniil Tatianin wrote:
> > > > > On 3/18/26 12:20 PM, Michal Hocko wrote:
> > > > [...]
> > > > > > Shouldn't those use mlock?
> > > > > Absolutely, mlock is required to mark a folio as unevictable. Note that
> > > > > unevictable folios are still
> > > > > perfectly eligible for compaction. This new property makes it so a cgroup
> > > > > can say whether its
> > > > > unevictable pages should be compacted (same as the global
> > > > > compact_unevictable_allowed sysctl).
> > > > If the mlock is already used then why do we need a per memcg control as
> > > > well? Do we have different classes of mlocked pages some with acceptable
> > > > compaction while others without?
> > OK, I have misread the intention and this is exactly focused at mlock
> > rather than general protection of all memcg charged memory. Now
> > 
> > > The way it works is mlock(2) only prevents pages from being evicted
> > > from the page cache by setting unevictable | mlocked flags on the
> > > page. Such pages, however, are still allowed for compaction by
> > > default, unless /proc/sys/vm/compact_unevictable_allowed is set to 0.
> > > That property essentially "promotes" ALL such (unevictable) pages to a
> > > new synthetic tier by making compaction skip them. The per-cgroup
> > > property works similarly, however, it allows the scope to be much
> > > smaller: from a global setting that promotes literally ALL unevictable
> > > (mlocked) pages to this tier, to only promoting pages belonging to the
> > > cgroup that has memory.compact_unevictable_allowed as 0.
> > This is clear but what is not really clear to me is whether this is
> > worth having as mlock workloads are already quite specific, the amount
> > of mlocked memory shouldn't really consume huge portion of the memory so
> > you still need to have a solid usecase where such a micro management
> > really is worth it. In other words why a global
> > compact_unevictable_allowed is not sufficient.
> 
> In my opinion both mlocked memory and non-compactible memory have the right
> to
> co-exist on the same host without a global switch that turns one into the
> other. I agree
> that it's not a super common thing, but I still think it can be beneficial.
> 
> Some examples include but not limited to: security: so that sensitive data
> is never swapped
> to disk yet we have no problem if it gets compacted and the actual physical
> page gets replaced,
> performance for some apps: so that we can e.g. memlock a large binary in
> memory to keep it in
> page cache and improve startup time, but again don't care much if the actual
> backing pages are
> replaced via compaction.
> 
> On the other hand, some critically important/real time applications do need
> protection from compaction
> as well on top of the regular mlock, so that they have predictable latency
> and response time, which can
> really fluctuate during heavy compaction. Both of these cases can coexist on
> the same physical machine.

This is a very weak justification for adding a user API.
NAK to this.

-- 
Michal Hocko
SUSE Labs

