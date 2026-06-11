Return-Path: <cgroups+bounces-16873-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LbE0F9PyKmqMzwMAu9opvQ
	(envelope-from <cgroups+bounces-16873-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:39:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3D674105
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BHbkmLxC;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16873-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16873-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CEBB3031A08
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA1400E0C;
	Thu, 11 Jun 2026 17:39:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7939184C;
	Thu, 11 Jun 2026 17:39:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199562; cv=none; b=lUamB/kXRJBs9i5F+7iJi2/IcRXpHeTR79WDcOl//AhN2v6KL6z5KPlbt7PFIIZ4xaKrNeApp9pk52sOgoEix2EUNEGeNttnPIckzK6ev3PPvO52VAuq8EfBmiCxmvGpzCodRmuEFVilHhBBfu9uw+TNh2FiI6k23Q4Ew4VA2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199562; c=relaxed/simple;
	bh=HMEVyLKst1VNoThhjaehgQMvN54Zu6Mff0BB2tESXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg5iOcXJSgt4CPE1PUYhmc6P6HhWNgnyutbibr381GHGAZe4F7QwyMNe8O9DZu9NjN6qIySAYkHBJtnGJr3SyUMrroJB1HbMSoUVzihCjbzU9taxCNT5Aa+U0FLH3BoLNZSPs2Cor9sgruwaD/NrXMaUdflyw2Vh+TUPCxLvGPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHbkmLxC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484E51F00893;
	Thu, 11 Jun 2026 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199558;
	bh=EDVNXhL2Pfk2NWjHVmUzJTm6IqAYDANPcobDFgmKGWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BHbkmLxC9oZUeSXsvuN7EeETvKhppZNCiJLffMi5U8/+iNueDNzhoRtOta14y3//J
	 si5BbetblwiOz15awvoRP9Q0yltQG9G4PJ0ow1o29o1wuxWPQQh8Xn0cMwpVmEfkGQ
	 1ImvBKSBZ7yIN7KNE9CGBNku0v4iZEjDtovmr7034CX8KGq+wWpKT5LyXiOreR7CWD
	 DXhq+ZhzvjFsXdY8P08EpFWi3ZmjZSz15DX/bwmLQVlv1rbYnQQ05uCgwnSisfgWnv
	 ZCfVo9utox81XMowyQqzQUOKl+KTB9gHzbYRj0UmHvXBI1s6FNwNUwyCXw87KcBLn8
	 oxsgp/LWYbXFQ==
Date: Thu, 11 Jun 2026 17:39:16 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
Message-ID: <airypNnKrJJ54k_0@google.com>
References: <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
 <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
 <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com>
 <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
 <CAO9r8zN6VVZz7dpjNrh8n7wbLkqcrsROPm70MQQxO49HJSmMFw@mail.gmail.com>
 <CAKEwX=MCFbsh9ndBtR0-bGRr_=v-6bBwTo=muzd9ZSD-LAK1nQ@mail.gmail.com>
 <1c25650e-bf98-2863-d505-9b94c385668b@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c25650e-bf98-2863-d505-9b94c385668b@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:nphamcs@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16873-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,cmpxchg.org,suse.com,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BF3D674105

On Tue, Jun 09, 2026 at 11:18:26AM +0800, Hao Jia wrote:
> 
> 
> On 2026/6/9 02:01, Nhat Pham wrote:
> > On Mon, Jun 8, 2026 at 9:48 AM Yosry Ahmed <yosry@kernel.org> wrote:
> > > 
> > > > But OTOH, this does seem like a recipe for inefficient reclaim. We
> > > > might exhaust hotter memory of a cgroup while sparing colder memory of
> > > > another cgroup... But maybe if they're all cold anyway, then who
> > > > cares, and eventually you'll get to the cold stuff of other child?
> > > 
> > > Forgot to respond to this part, the unfairness is limited to the batch
> > > size per-invocation, so it should be fine as long as you don't divide
> > > the amount over 100 iterations for some reason. Also yes, all memory
> > > in zswap is cold, the relative coldness is not that important (e.g.
> > > compared to relative coldness during reclaim).
> > 
> > Ok then yeah, I think we should shelve per-memcg cursor for the next
> > version. Down the line, if we have more data that unfairness is an
> > issue, we can always fix it. One step at a time :)
> 
> Thanks a lot to Yosry, Nhat, and Shakeel for the great suggestions!
> 
> Let me summarize what I plan to do in the next version to make sure we are
> on the same page:
> 
>  - Drop the per-memcg cursor and keep the root cgroup cursor
> (zswap_next_shrink) logic intact.
>  - Stick to using the zswap_writeback_only key, and change the proactive
> writeback size to use the compressed size.
>  - Consolidate and reuse the logic between shrink_worker() and
> shrink_memcg(). Enable batch writeback in the shrink_worker() path, while
> keeping the writeback behavior in the zswap_store() path unchanged.
> 
> Please let me know if I missed or misunderstood anything. Thanks again for
> clearing things up!

Sorry for the late response, yes I think this makes sense. However, I
have some comment about how this interacts with swap tiering, let me
reply to the other thread.

> 
> Thanks，
> Hao

