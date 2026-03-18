Return-Path: <cgroups+bounces-14860-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKfYFP5iummoVwIAu9opvQ
	(envelope-from <cgroups+bounces-14860-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 09:31:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DEC2B80D4
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 155083068B90
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15637F8C1;
	Wed, 18 Mar 2026 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/ZSKPjm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16E1F471F
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822354; cv=none; b=FZi9Iuw33B+PF/+Fg9s+8aCwK3BLi6CGy8uVXsSAOPfapJH+sZvlojWduFGmGm+4o+8uclsaTgP52WAk5uztEC2SjZowyu89g7IvHOKYgk8Xty2FzSf4FWo1IWkLl+kKqW2op4GUbviB2m8GAfqLFdddRnv1A7io7QFcIFrbL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822354; c=relaxed/simple;
	bh=QQVMaXaAflgjwrw9LePhqS1Qap8U+Lqqz6w2uj7bOGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOG4+alyijjFMnM5X7v420oPyLBr1P1UUqpqAdxkELrdsJBWFKM9A2/kXcLi0DS8l3q2ZsPb97R8lD7bfZcqQNkzwH7AVQgDgiVf3rLLPn1HYZJE8cE6eC+Xs424hGUFytWycRDPDe3UTeMfNCTj4AXrHSeV9FCiCtE83A8NGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/ZSKPjm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486507134e4so18502815e9.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773822350; x=1774427150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qct1M6uDgddyZIwhlydpZnvmv7ZwIfwluJBCESYJnoQ=;
        b=e/ZSKPjmpxeJJVM2zlJGotb6EPzQvTHfQk2lut2/ZxU9GkfM4TJnrE0IGy41Cw4rNs
         aklLIJSHI6wjz6rnn+RGXqBwSJx2rhdXvMT0CCT3KvxSuL0AbVrNF3U2pJ6hRUr3he2p
         uLWCs76QG1Ytc62wrKkjjvDtJaSm7t6t7EpKfqpo/tzF/w+wlGTBnSrfp6pjxPbwoEZU
         doC6XQmIfvV/XMyKaEn//kvxBR7O0Aakas6I4pesr+NKwcdBeMZDyt/CAzkqKLjAncVr
         RBnsoXaQ2ZRuzCQtSKLOjUwQZEqLwvC6khugKvTp1519bblqKxnx9mJZbq9WmavD74iV
         +EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773822350; x=1774427150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qct1M6uDgddyZIwhlydpZnvmv7ZwIfwluJBCESYJnoQ=;
        b=QGzUS4N3x6GZrXMRPoNhHeMoWYYZWDYcJnAPzqPFxLDQuVpEREhzmWG5FihppCUMac
         +uA7jlHFlWDFN1BP5HiQRUdrgyzajNu7QUzIt9Nq16xEHwqDnQirWQyeEnS4+C0p9dHr
         NwjpdVPZ1nqv6AykkF28ePsMfOBUfB9KDJ5xmyQQ3Axu35ELgzbjLc5CJWVhjAiL9ISa
         Ea98+MfYUncjzS+JysydZEF7oOBbcJ6nW/7urZcBGlxzsAcPfNheUodsG6T1hgux8aHM
         Pjf5+cBE6ls4x5qwsq4jRGboOKfqGE0NCI48aISxWXUn4i2tLxTDvu8XiKPDVP5BK8YE
         2ELQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3638jSkfEVUBXtSInSAn9FOHdZ4At5KT+f4ABwSWuJZ2VS+Turb09uSY6yvNlBnDZHL64lzba@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UsUcbPqZWzcXcAE8vm7esvtAHg/mgBZzM7ZNLdqEef0eky0G
	vc+D4HLUsy4uAUKDPaeE64kNkzwDvLV8O2/mB20SEycbP33aIqNvmQOutMENsiX49Cc=
X-Gm-Gg: ATEYQzzhwx158FlewRnmo8siCx2GEj8eZqxdxgCCqEk+Ql+bnDjqNZK6t7JSWHxqalZ
	m+K52ETGxwVezG5yedt8q0hkAxi1vVcALCHbtlFQ0vVpIsnuhcYbZu64zZtW5iaOJlgM2wdDQLy
	gDmjIVpqQY/dE6FWPTqEd5DSTbYAzCX3knbE+AEYbqX45m5EEDx9QCxVkbp7Mh8p66Tf1i1eRIs
	Atn7GnkaglUFNaZhZFaWD6IW+aRLTEYj1TEGUPl9G//BbJcBUlLfG/VlgJCzzP2hQGYsFIAZ1Q9
	x8V7jKJWK+Luq+WxzHJHqYT1XVG1t/1H9jE5Hk9rrqg1bFDOwzp2WCTtCw0qrEVmgQplReONdBi
	6jqWAS76RcHmJWoOuxCbGYigsTZw+0swsWvrF1Rvq1YuJO6+aI2kYkRWjnRiM6f8K2xwdwnht7n
	RqGHNm6x1Go6aZKdP+72AKzBgfEblzPQqACcbF
X-Received: by 2002:a05:600c:8486:b0:485:3a22:69b9 with SMTP id 5b1f17b1804b1-486f4457e6dmr35524025e9.29.1773822350370;
        Wed, 18 Mar 2026 01:25:50 -0700 (PDT)
Received: from localhost (109-81-21-195.rct.o2.cz. [109.81.21.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3322sm105879665e9.10.2026.03.18.01.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:25:50 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:25:48 +0100
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
Message-ID: <abphjNOYaNslTA90@tiehlicka>
References: <20260317100058.2316997-1-d-tatianin@yandex-team.ru>
 <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
 <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14860-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,yandex-team.ru:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02DEC2B80D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 17-03-26 23:17:28, Daniil Tatianin wrote:
> 
> On 3/17/26 10:17 PM, Andrew Morton wrote:
> > On Tue, 17 Mar 2026 13:00:58 +0300 Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> > 
> > > The current global sysctl compact_unevictable_allowed is too coarse.
> > > In environments with mixed workloads, we may want to protect specific
> > > important cgroups from compaction to ensure their stability and
> > > responsiveness, while allowing compaction for others.
> > > 
> > > This patch introduces a per-memcg compact_unevictable_allowed attribute.
> > > This allows granular control over whether unevictable pages in a specific
> > > cgroup can be compacted. The global sysctl still takes precedence if set
> > > to disallow compaction, but this new setting allows opting out specific
> > > cgroups.
> > > 
> > > This also adds a new ISOLATE_UNEVICTABLE_CHECK_MEMCG flag to
> > > isolate_migratepages_block to preserve the old behavior for the
> > > ISOLATE_UNEVICTABLE flag unconditionally used by
> > > isolage_migratepages_range.
> > AI review asked questions:
> > 	https://sashiko.dev/#/patchset/20260317100058.2316997-1-d-tatianin@yandex-team.ru
> 
> > Should this dynamically walk up the ancestor chain during evaluation to
> > ensure it returns false if any ancestor has disallowed compaction?
> 
> I think ultimately it's up to cgroup maintainers whether the code should do
> that, but as far as I understand the whole point of cgroups is that a child
> can override the settings of its parent. Moreover, this property doesn't
> have CFTYPE_NS_DELEGATABLE set, so a child cgroup cannot just toggle it at
> will.

In general any attributes should have proper hieararchical semantic. I
am not sure what that should be in this case. What is a desire in a
child cgroup can become fragmentation pressure to others.

I think it would be really important to explain more thoroughly about
those usecases of mixed workloads. Is the memcg even a suitable level of
abstraction for this tunable? Doesn't this belong to tasks if anything?
-- 
Michal Hocko
SUSE Labs

