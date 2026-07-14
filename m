Return-Path: <cgroups+bounces-17809-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vg6oMZ63VmoMAgEAu9opvQ
	(envelope-from <cgroups+bounces-17809-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 00:26:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE5759379
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 00:26:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=i42a4VKV;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17809-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17809-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AA2A302BCA1
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF13F7A95;
	Tue, 14 Jul 2026 22:26:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C20418A4A
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 22:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067993; cv=none; b=NSWbYM04YOuR8yfzMCDsMoaKlm65D+takA20MdeNO7cnzmV4ZQ2U05UFOfp3wo64R02QyL8j+tBo3/wohd6OlFPMO08HrKkG8b/Z01bP+vqPKz65E43qvsaRF16lWXUd235gPJeTg7cdKXof4+UqhUE6wD/g2RRDCa3QZMJ4DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067993; c=relaxed/simple;
	bh=XamUYAhJizBUmM6Oc0lOH6OBOW/hHWrEeaLeNO09kMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NemTCis+fJcLy3ry+3HkoT/nmh6zn5E3RJC4O4TZLxqZzRFr6CLuBtR728+rnhRROL75C0d1e90smeSYrlzGrzeYKVQ8OYKQbGE4KZJ3fuxGZmLTzL1TV0AH9HTqAB+XqpSADlowZ9m9cdTQzqsRAs5eqRLfDHYOJk4mUUUQllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i42a4VKV; arc=none smtp.client-ip=95.215.58.178
Date: Tue, 14 Jul 2026 15:25:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784067979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8XW3L66ASo6nPb0QYUT2YcX697e32EmDld90wK/FIsA=;
	b=i42a4VKVo5N20vlVKTvopu/hg8gbxNnHB9LGHEJLwYkKQDRHA9C7BCJ7ncjziBV6nDqfoS
	1SQp/XZCif3gOzGjh9r9WAYq4iNoe9yd430Lpvxo8WTxPIgKv/dlPWL9ivdXVnFQYZPHrx
	2bSJu/0FMyYADnrDNvuOJLi9nUvVGw8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, joshua.hahnjy@gmail.com, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, baver.bae@lge.com, her0gyugyu@gmail.com
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
Message-ID: <alawYov0c7a0Q6_l@linux.dev>
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330>
 <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
 <alUQ0ksPP00PVwew@yjaykim-PowerEdge-T330>
 <alae-LIRwEFUjgs1@linux.dev>
 <CAO9r8zNfp-T19cYyZxKHBY-FnmQ_9=fbP4JYPPFgYtUCo5fZyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zNfp-T19cYyZxKHBY-FnmQ_9=fbP4JYPPFgYtUCo5fZyg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17809-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73AE5759379

On Tue, Jul 14, 2026 at 01:52:14PM -0700, Yosry Ahmed wrote:
[...]
> >
> > Yosry, what is needed to enable zswap as a swap tier? What will be the minimum
> > requirements for that?
> 
> From zswap's perspective, we just need to skip zswap is zswap as a
> tier is disallowed. Could just be a check in zswap_store() similar to
> the check if zswap is enabled. I am assuming that if a swap tier is
> disabled, nothing happens to the existing swapped out pages in this
> tier, but new pages do not get swapped out to it. This is the same
> behavior that happens if zswap is disabled at runtime.
> 
> From the tiering perspective, we need to accept "zswap" as a possible
> tier, or maybe creating it as a tier by default if zswap is configured
> would be better to avoid handling the case where the user doesn't
> create a tier for zswap. 

Default tier if zswap is configured makes sense. Should zswap be treated as
having 32767 (or maybe 32768) as priority as it sits infront of all swap
devices today? Also whichever swap tier has priority range containing 32767,
will have zswap in it.

> We also need to disallow zswap being the only
> tier as that combination cannot work without vswap.

Do we need to do anything explicitly for this? I am assuming in a kernel with
swap tier support, there always exist a swap tier if there is even a single swap
device configured i.e. a tier with the full priority range.

> 
> I think this should be enough to support "zswap" as a tier and allow
> disabling/enabling zswap per-memcg (or globally?) through tiering.
> 
> In the future, if/when swap demotion is added, we need to figure out
> how that would work with zswap. For example, if pages should go to
> swap device A then swap device B, then an entry in zswap using a swap
> slot in device B should not skip device A and be written back directly
> to B. vswap would naturally give us a solution for this problem.

This seems reasonable to me. Punting demotion/writeback to future.

Youngjun, what do you think? Is this reasonable amount of additional work or do
you envision some complexity here?

> 
> > If that is not too much, we can make that part of this series.
> 
> Yeah I think it's better if we agree on the design and zswap support
> before landing partial support.

