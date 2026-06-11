Return-Path: <cgroups+bounces-16875-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G8CQNMgIK2rE1gMAu9opvQ
	(envelope-from <cgroups+bounces-16875-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 21:13:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72492674B13
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 21:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Uc8i2xo0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16875-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16875-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B045E312EE35
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AF4A341C;
	Thu, 11 Jun 2026 19:12:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA54F411695
	for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 19:12:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205173; cv=none; b=Fun3XmKxSYf/sVBswYwd36ieLDhkK4CML2TIT7kLiGghxKMDVYsAGY6aGL2q2dldg1jycIHiQueONJECg2SPDU3jQoWZ4IhLeljK7aIjO2YVuXJR8LlSCP6xC/HV1Gj4xqe53a39cgvqwMVkf+xMFLt3onAOkd1qWZ+8kv5QYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205173; c=relaxed/simple;
	bh=o7YGKE34le2qBruHHqA747ZUQ/YLoHJbQHqDHlyH/t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyle5lIh2S9re0jlaKQKZrkYlX6iIDFWvTinygt/3iyRU1b1OxU8ge4CApn0HngxepTLZrpFQIW67TQDtBqtvsXlZNlK3qav0yA/xnonu+9ci/5a1iD3ixrtWkLRgK1pMX+f5bMTNcIAFDs1P1YRWTOeNDikNn+DodDOHk5Aagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uc8i2xo0; arc=none smtp.client-ip=95.215.58.171
Date: Thu, 11 Jun 2026 12:12:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781205169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/dpbNb5biEC/ytKDW9uZGewAoGZBA0EolTNHIvaZZk=;
	b=Uc8i2xo0DpuSALr6ftYCaW+0Z/S4F6T6le8Fv3+0J0wM8ZOvUTo604t7eekw5yBWEE74rT
	1XToLGi4nkYSHnJ80iLFsNqN3yK320JIhhs0M1Kby8elC+hHeVYnHdf+3YGO5abK9j1c0Z
	i7Yrj0r9Y69Sjt0cQrqNNPoUtcAyeyM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry@kernel.org>
Cc: YoungJun Park <youngjun.park@lge.com>, 
	Hao Jia <jiahao.kernel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, 
	tj@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev, 
	Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, 
	chrisl@kernel.org, kasong@tencent.com, baoquan.he@linux.dev
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
Message-ID: <aisEWnb3pzmVC4dl@linux.dev>
References: <CAKEwX=OhxUxRCEfvZMnWzXy=Fa4jgzL3DuP-RmaVzdK65m4bew@mail.gmail.com>
 <6db27a22-cc7a-9a94-db3f-c912fd39aa32@gmail.com>
 <CAO9r8zM4SDdTgz9L2s1VfXL8K2VBjMD9ej2BTDxaGge1t2+quA@mail.gmail.com>
 <aicJBVT4pBvmyooT@linux.dev>
 <aicZ-5GX9De3MAU7@linux.dev>
 <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
 <aictKA0XWMWbxFdN@linux.dev>
 <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330>
 <airzE7jD9UtyR17J@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airzE7jD9UtyR17J@google.com>
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
	TAGGED_FROM(0.00)[bounces-16875-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:youngjun.park@lge.com,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lge.com,gmail.com,cmpxchg.org,kernel.org,suse.com,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72492674B13

On Thu, Jun 11, 2026 at 05:45:04PM +0000, Yosry Ahmed wrote:
> On Tue, Jun 09, 2026 at 01:19:13PM +0900, YoungJun Park wrote:
> > On Mon, Jun 08, 2026 at 03:27:07PM -0700, Yosry Ahmed wrote:
> > 
> > +Chris +Kairui +Baoquan
> > 
> > Hello
> > 
> > Thanks for inviting me to the discussion, Shakeel.
> > 
> > > > > > Youngjun is working on swap tiers. At the moment he is more interested in
> > > > > > allowing a specific swap device to a memcg or not. I can imagine in future there
> > > > > > will be use-cases where there will be a need to demote data on higher tier swap
> > > > > > to lower tier swap. What would be the appropriate interface?
> > 
> > Speaking of my work on swap tiers, I recently submitted a patch and am
> > currently considering memcg integration:
> > https://lore.kernel.org/linux-mm/20260527062247.3440692-1-youngjun.park@lge.com/
> > 
> > The future use-cases imagined above seem to align with this
> > direction. (BTW, I am currently waiting for reviews/feedback from the memcg
> > folks on this patch. Any reviews would be highly appreciated!)
> > 
> > We could potentially assign a target tier
> > for writeback within the existing memory.zswap.writeback interface. 
> > 
> > For instance, '0' could mean disabled, while non-zero values could represent
> > specific tiers, which would maintain backward compatibility with the current
> > version. Alternatively, if zswap is treated as the default top tier, 
> > the `memory.swap.tiers` interface could potentially replace `memory.zswap.writeback`.
> > 
> > Furthermore, this could be expanded so that each swap tier can demote data
> > user-triggered demotion between swap tiers.
> > 
> > Based on the current patch's ideas combined with my swap tiers concept:
> > 
> > Assuming a hierarchy like:
> > zswap -> tier1 (SSD swap) -> tier2 (HDD swap) -> tier3 (Network swap)
> > 
> > We could configure the active tiers via a setting like `memory.swap.tiers`
> > (tier2 enabled, tier3 enabled).
> > 
> > For example, the concept of `echo "100M zswap_writeback_only > memory.reclaim"`
> > could be extended. A user could run `echo "100M tier2 > memory.reclaim"`
> > to explicitly trigger demotion from tier2 to tier3.
> > (BTW, if we combine these features, my personal preference for the keyword
> > format would be `<size> <demote_prefix><tier_name>`. I think it would be
> > better to explicitly indicate that it is a swap demotion by using a specific
> > prefix followed by the tier name. 
> > Or make demote prefix another key is also possible)
> 
> I am not sure if proactive demotion between swap tiers would be driven
> by memory.reclaim, I am guessing a new interface might be more suitable.
> But yes, you are right that it's very possible that
> 'zswap_writeback_only' with memory.reclaim will become obsolete once
> swap tiering matures and starts supporting things like proactive
> demotion.
> 
> Part of me wants to wait until the swap tiering interfaces are figured
> out so that we don't end up with redundant interfaces, but I also don't
> want to hold Hao's work since it doesn't directly depend on swap
> tiering.
> 
> Shakeel, how do you want to handle this? I think there's a few options:
> 
> 1. Add zswap_writeback_only now, and when we have swap tiering demotion
> it becomes a redundant interface, like memory.zswap.writeback -- or
> maybe we try to deprecate both of them at that point. It's difficult to
> remove interfaces tho, but maybe easier to stop supporting
> zswap_writeback_only.
> 
> 2. Add zswap_writeback_only behind an experimental config option, to
> unblock development but have a line of sight to dropping support once we
> have a swap tiering interface.
> 
> 3. Wait until we figure out the swap tiering interfaces and then add
> the proactive zswap writeback as part of it.
> 
> WDYT?

Is Hao's work needed for some followup work/development? The earliest Hao's
work can is 7.3, so if we aim to figure out swap tiering interfaces in next
couple of weeks then option 3 is the way to go. If swap tiers take more time
then we can discuss other options as well.

However I would need zswap folks (Yosry & Nhat) help in figuring out swap tiers
interfaces. Zswap is the current top tier swap usage in real world. I want
zswap users to eaily (and hopefully transparently) migrate to swap tiers.

