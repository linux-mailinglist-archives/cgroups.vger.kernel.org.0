Return-Path: <cgroups+bounces-14863-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFJGK15wumnRWQIAu9opvQ
	(envelope-from <cgroups+bounces-14863-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:29:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8EA2B9088
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14D39308F120
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF23ACF19;
	Wed, 18 Mar 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bHwfKsGg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426A3A9D92
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825665; cv=none; b=H7cyPCz3FroYK61epJ2AmlRKSuOeSnehSPKZsIqVeiaGf6nswbZSmHBoRhJ8lnSmjytiaxhkAr69XLZMX22/kivqU7siLt6enFOM8CBvTob2vH9gZBEDe0e2cvH15bKqP1pjOi8xljeEYP7W2D9QdXCYRGfdoWSDXQciQrwMNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825665; c=relaxed/simple;
	bh=NjTLOP1JL1fBH5A4NzzAnnNOxOwCVtltXbP5Edd8/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZUGx8n0UCMc/XycNmH6mgDtUUjGuNKs8/v/jv4nt4DF2ssCY5T/Ygq0pK1FIMdB/+Fa9p44vucN+UHKttaHgu7u68qrcbvLtmTVhym7y6ZH6f/s5rJl/EHh0T0f5bkq1RwOXXA3/naycLt5l4ekoE0G4mkkt9GFys+GyARvCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bHwfKsGg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso74749835e9.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773825661; x=1774430461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCsWM+qtYn9cziDx86CoZ1L1lXbooAdYKLink0SGuB4=;
        b=bHwfKsGgD6X1BikYWNp3VJPY0r9MNvvEsrutbUcczJNgo0l23hQS+iGOTqgslzbnF2
         QGZuQXep+ZK04wV7BZAYdhSbG1bL/1I9SloRF4sZIhu2b/RmgKLuVMUk70gQzBk4SGHX
         4wz9wRTFotGD4/Fp03mMK7xuh0iCeKTal69kqeaL3/6v1d6Hb+31bofA5wbl+XC2UaTa
         7J4BnBjZqfnT0j62cUd4pWe+lUW8Hpq7OxhNVFD0w0rB0nzsLJyP9z3m9+sYk5L816JS
         mXX5trnQ7eAX/vHYejoq0IsY2PxAFGRXH4FT4WfzBCHUlOwI/efJssNzDiPZC2W5X3nh
         3eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773825661; x=1774430461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCsWM+qtYn9cziDx86CoZ1L1lXbooAdYKLink0SGuB4=;
        b=RO28ABGC5TZI5dpfR++q3ZmuDoADHl1W1eqUQA+zHaE/mJNJKqGoydepAKrVp3pt5M
         8wnAAzn4GnWoEYBSXneeFXDQuqPHP3m6pIK4GAo4Cd6p3zZGAZcRhrF3UNz8/tJn4Khx
         bSIxN4fsxDIb25gpUEEbZEbXq8ieU7woE96WrN4u3kPdoqeVn3bgaEIZzDB6KsMRzaxY
         id1VvCZwMXzofhS605XlcRkp/BanGI6/sQo1jWzM898tHV3fQjE9hYmnCkoaZX6vej1I
         3+Hjt2oSol7R1QVowRPBU2vJR7BzUbTJLp2Exm0DeIN639SGWU0CJ4yPLhK+QW/LKJti
         FVow==
X-Forwarded-Encrypted: i=1; AJvYcCXbTtCRl11fhVYxH5sKI48mm9wzLS0cL22adj5L1/QbPqYzo+7Zfilv8ar6tj6FN7K1s8cAmytD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlf1H9t8nhfVNIhajcqFLXppTYIF4Qr11x7TWvEsd9P0olBCak
	Y+Fc1MHP3AYios8Cdc/B+MS05oZuLpClYya9onY+QwlS3nCsA3Hb9ZRdlwnELF6zBf4=
X-Gm-Gg: ATEYQzybMqhmRNt8GJ3Z7TumJLIx55phlmzuXzBn0mBcV/3mw7kAAL4HIYFX6fx9OKj
	SLw73dIOr4un4erIgC1SqW565xMbz6W5Hfjl5UVF0+21DmycAyf2Knm3KNmBKZClsiz7wHpvufP
	xJ22oFLRKjNyl0ijPDEpnNlIoLkKLaz3uc6CjdDFmWyMfDCCM354y2ZbQ7kgDVY5abzEd+UNp7I
	GgkAAb2pXqYQeE+51SA0olSrWxvs3mP4hf1mnWcD2hY8DvIyaA4z+El/odP9u4LSkEDPx6uWBcS
	F5yQRAb4xr5DtJtgAhB+byCuo3QCwxRvUuNyml+RuXwVhkoZi2hnUOPF2RNkK8jH79G7BNMIYbN
	wmipw659GcLmRxwjNLeFxU5faFcZCHe6mykdXI4tI6wLjPmucfA6ol8Ou3Cj/z2qojqiHgYoeDO
	jMiOpjcUdq3oacgNgewG6+AwrePizs/SX78oA+
X-Received: by 2002:a05:600c:a20e:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-486f443d48cmr26793045e9.15.1773825661196;
        Wed, 18 Mar 2026 02:21:01 -0700 (PDT)
Received: from localhost (109-81-21-195.rct.o2.cz. [109.81.21.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4623a26sm16508605e9.7.2026.03.18.02.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:21:00 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:20:59 +0100
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
Message-ID: <abpue_k_9mjQAP6X@tiehlicka>
References: <20260317100058.2316997-1-d-tatianin@yandex-team.ru>
 <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
 <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
 <abphjNOYaNslTA90@tiehlicka>
 <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14863-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,yandex-team.ru:email,sashiko.dev:url,suse.com:dkim]
X-Rspamd-Queue-Id: 3F8EA2B9088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 18-03-26 12:04:10, Daniil Tatianin wrote:
> 
> On 3/18/26 11:25 AM, Michal Hocko wrote:
> > On Tue 17-03-26 23:17:28, Daniil Tatianin wrote:
> > > On 3/17/26 10:17 PM, Andrew Morton wrote:
> > > > On Tue, 17 Mar 2026 13:00:58 +0300 Daniil Tatianin<d-tatianin@yandex-team.ru> wrote:
> > > > 
> > > > > The current global sysctl compact_unevictable_allowed is too coarse.
> > > > > In environments with mixed workloads, we may want to protect specific
> > > > > important cgroups from compaction to ensure their stability and
> > > > > responsiveness, while allowing compaction for others.
> > > > > 
> > > > > This patch introduces a per-memcg compact_unevictable_allowed attribute.
> > > > > This allows granular control over whether unevictable pages in a specific
> > > > > cgroup can be compacted. The global sysctl still takes precedence if set
> > > > > to disallow compaction, but this new setting allows opting out specific
> > > > > cgroups.
> > > > > 
> > > > > This also adds a new ISOLATE_UNEVICTABLE_CHECK_MEMCG flag to
> > > > > isolate_migratepages_block to preserve the old behavior for the
> > > > > ISOLATE_UNEVICTABLE flag unconditionally used by
> > > > > isolage_migratepages_range.
> > > > AI review asked questions:
> > > > 	https://sashiko.dev/#/patchset/20260317100058.2316997-1-d-tatianin@yandex-team.ru
> > > > Should this dynamically walk up the ancestor chain during evaluation to
> > > > ensure it returns false if any ancestor has disallowed compaction?
> > > I think ultimately it's up to cgroup maintainers whether the code should do
> > > that, but as far as I understand the whole point of cgroups is that a child
> > > can override the settings of its parent. Moreover, this property doesn't
> > > have CFTYPE_NS_DELEGATABLE set, so a child cgroup cannot just toggle it at
> > > will.
> > In general any attributes should have proper hieararchical semantic. I
> > am not sure what that should be in this case. What is a desire in a
> > child cgroup can become fragmentation pressure to others.
> > 
> > I think it would be really important to explain more thoroughly about
> > those usecases of mixed workloads.
> I think there are many examples of a system where one process is more
> important than
> others. For example, any sort of healthcheck or even the ssh daemon: these
> may become
> unresponsive during heavy compaction due to thousands of TLB invalidate IPIs
> or page faulting
> on pages that are being compacted. Another example is a VM that is
> responsible for routing
> traffic of all other VMs or even the entire cluster, you really want to
> prioritize its responsiveness, while
> still allowing compaction of memory for the rest of the system, for less
> important VMs or services etc.

Shouldn't those use mlock?

> > Is the memcg even a suitable level of
> > abstraction for this tunable?
> 
> In my opinion it is, since it is relatively common to put all related tasks
> into one cgroup with preset memory limits etc.
> 
> > Doesn't this belong to tasks if anything?
> 
> I think it would be very difficult to implement as a per-task attribute
> properly since compaction works at the folio
> level. While folios have a pointer to the memcg that owns them, they may be
> mapped by multiple process in case
> of shared memory. We would have to find all the address spaces mapping this
> folio, and then check the property on
> every one of them, which may be set to different values. This may be
> problematic performance-wise to do for
> every physical page, and it also introduces unclear semantics if different
> address spaces mapping the same page
> have different opinions.

Yes, it would need to be something like an implicit mlock. I haven't
really indicated that would be a _simpler_ solution. But as this has
obvious userspace API implications the much more important question is
what is a futureproof solution. Also we need to get an answer whether
this is really needed or too niche to cast an interface maintained for
ever for.
-- 
Michal Hocko
SUSE Labs

