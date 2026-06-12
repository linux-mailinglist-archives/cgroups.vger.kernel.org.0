Return-Path: <cgroups+bounces-16903-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxxBJcM2LGo3NwQAu9opvQ
	(envelope-from <cgroups+bounces-16903-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 18:41:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B711267B03A
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 18:41:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=mpGbqHpq;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16903-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16903-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1BD30C8671
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3651E5207;
	Fri, 12 Jun 2026 16:40:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2C5C613
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 16:40:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282455; cv=none; b=pdURoQs7P+jNDzIdU+9apQxZCHME11g42mav6yIqAWAm53IHc170Boj3yAtlqobuc3M/Mdw6/rkb8vVDPs7H+zcZOBnU+YPomU4dvGY2F2ObPknyII9SMeZIeh8VsfUcqRLcDVU7LIBRqOefQLzuHL4HChaSJ2uf5pPKUHGHdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282455; c=relaxed/simple;
	bh=o0KCIObepWeLB7YjoDLBQa24DbSiN/ma/7Xcktrlx+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhmgRAfPErKqv4cM6gq0JM7ilxXRCSQ7kSHMvZE7+shaX074PAinuH6C48boaekwsfO2GUCXj5jRp8Syd06auOhN1SNWrRfuOsgAd4d7PEnJzYQBIUuqO42UrhVfT4sml/bSnUBOmStxzH9Qvm+8dda4JcwM4p9AbDnsXjwM/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mpGbqHpq; arc=none smtp.client-ip=91.218.175.183
Date: Fri, 12 Jun 2026 09:40:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781282450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+edMgHsajKp6EUG8qdjLHZUa6igBGAxNqzsWn/cqwg=;
	b=mpGbqHpqnOqlz1Vq7gOTntaJ7OPxs83o6X27H+Dm7/LR1BULPsd9sVPzfGSBfSiwhepnuZ
	m6s7sl433AprtRWEMaDYbKUSK+hIVvwgbXsLiZ2DnhDtA/TJZ2K4Jhy9OQgK0ZJzL3rWfg
	3rT2pya67ARTrienUPLyJaINMkXBCbo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
Message-ID: <aiw2JB1lZV9xuNSp@linux.dev>
References: <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
 <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
 <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com>
 <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
 <CAO9r8zN6VVZz7dpjNrh8n7wbLkqcrsROPm70MQQxO49HJSmMFw@mail.gmail.com>
 <CAKEwX=MCFbsh9ndBtR0-bGRr_=v-6bBwTo=muzd9ZSD-LAK1nQ@mail.gmail.com>
 <1c25650e-bf98-2863-d505-9b94c385668b@gmail.com>
 <airypNnKrJJ54k_0@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <airypNnKrJJ54k_0@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16903-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:jiahao.kernel@gmail.com,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,suse.com,linux.dev,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B711267B03A

On Thu, Jun 11, 2026 at 05:39:16PM +0000, Yosry Ahmed wrote:
> On Tue, Jun 09, 2026 at 11:18:26AM +0800, Hao Jia wrote:
> > 
> > 
> > On 2026/6/9 02:01, Nhat Pham wrote:
> > > On Mon, Jun 8, 2026 at 9:48 AM Yosry Ahmed <yosry@kernel.org> wrote:
> > > > 
> > > > > But OTOH, this does seem like a recipe for inefficient reclaim. We
> > > > > might exhaust hotter memory of a cgroup while sparing colder memory of
> > > > > another cgroup... But maybe if they're all cold anyway, then who
> > > > > cares, and eventually you'll get to the cold stuff of other child?
> > > > 
> > > > Forgot to respond to this part, the unfairness is limited to the batch
> > > > size per-invocation, so it should be fine as long as you don't divide
> > > > the amount over 100 iterations for some reason. Also yes, all memory
> > > > in zswap is cold, the relative coldness is not that important (e.g.
> > > > compared to relative coldness during reclaim).
> > > 
> > > Ok then yeah, I think we should shelve per-memcg cursor for the next
> > > version. Down the line, if we have more data that unfairness is an
> > > issue, we can always fix it. One step at a time :)
> > 
> > Thanks a lot to Yosry, Nhat, and Shakeel for the great suggestions!
> > 
> > Let me summarize what I plan to do in the next version to make sure we are
> > on the same page:
> > 
> >  - Drop the per-memcg cursor and keep the root cgroup cursor
> > (zswap_next_shrink) logic intact.
> >  - Stick to using the zswap_writeback_only key, and change the proactive
> > writeback size to use the compressed size.
> >  - Consolidate and reuse the logic between shrink_worker() and
> > shrink_memcg(). Enable batch writeback in the shrink_worker() path, while
> > keeping the writeback behavior in the zswap_store() path unchanged.
> > 
> > Please let me know if I missed or misunderstood anything. Thanks again for
> > clearing things up!
> 
> Sorry for the late response, yes I think this makes sense. However, I
> have some comment about how this interacts with swap tiering, let me
> reply to the other thread.
> 

I think the swap tiers interaction will be figured out over next cycle. However
Hao can/should continue to push and we may decide to let it in orthogonal to
swap tiers.

