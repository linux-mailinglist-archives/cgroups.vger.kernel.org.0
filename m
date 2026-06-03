Return-Path: <cgroups+bounces-16617-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y4rWJPtrIGrc3AAAu9opvQ
	(envelope-from <cgroups+bounces-16617-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:01:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601C63A59C
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:01:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P2TiUt6z;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16617-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16617-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA8C5306DFA1
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC503A4F5E;
	Wed,  3 Jun 2026 17:58:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052A397E6A;
	Wed,  3 Jun 2026 17:58:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509496; cv=none; b=mV+x9ec/NNEFT7qz5uHjnElXZqs7P43Bp5nh9a9jeuLVj3FVT1rgsvT8cZkVvo5H5ROrZcY2INDX02dh220etgUypsLMcS7uv8DvdxH5tVqJAmU8GxUIlChCYqDGDEXShhy7N4/M2fcWTc7aI9GtZjXCpm3sqepNi3JpjfxhfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509496; c=relaxed/simple;
	bh=vvLPP6WEde/WUFYdnAcqQBHtS6dTD4LXo5956YoNyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsB7UIswKrKDl7O3n4z1Entx3lbk0yvmm25H778BUhySY/BDtNB3cGOj/8/Vealzqj+BrV44TFnFdejJcqZBaTh97qpA27neClTn9/DI3scQxcXLPyZOvi4Bu1zU8CIjwU+uLjGnM4tZUy2M2ECU/sZtJyY7VI79gbjBXgVTaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2TiUt6z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32A41F00893;
	Wed,  3 Jun 2026 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509494;
	bh=Ykcodhu/XhN28Udohna/yV1olxzbiwJfyoyWGAC5NnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P2TiUt6zfW4qf6SwrC02SlsHFTbmLmtiLZLbf4P7PA8z2eEVp5ti6jzeRyOfR25dg
	 hj2iuGgjeuxq4rCJWfRPSCSUdOvsQIubNsgfikQ3l02ZMPm02WIrJdm3owUWEb+vpy
	 Clv2OlNXoKMHRUBD7heBvO+JAjOTG9q1tcuKc9jhmvPuAho2CCdFQ8EBuiVK2Y5v8M
	 WA8YJkM2ipgB26/ZHDGwwjOFxivIrZhWqTtDTwLSLewYnOtKDVv8b/qvfDpeNwHhU2
	 wEgnDH67/woY31cN6ZMp4Oi8hrN1mCjBh/J2EZ1GDwRtm15bjeLWF5AoLPhJs4Gh73
	 9lywnI06QpqZg==
Date: Wed, 3 Jun 2026 17:58:12 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, tj@kernel.org, shakeel.butt@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, chengming.zhou@linux.dev, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
Message-ID: <aiBqzOtEv5iAC_qC@google.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com>
 <CAKEwX=MQe_KFZe2vBXQYh0aa-x+E8AzNwmyjJGJk4tDoS9ML3A@mail.gmail.com>
 <aho_VtLCmIRsNyvO@google.com>
 <6deeaea7-3cd1-4403-29fc-d2dc55c297f8@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6deeaea7-3cd1-4403-29fc-d2dc55c297f8@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:nphamcs@gmail.com,m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16617-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,cmpxchg.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lixiang.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0601C63A59C

On Wed, Jun 03, 2026 at 07:22:36PM +0800, Hao Jia wrote:
> 
> 
> On 2026/5/30 09:40, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 12:58:09PM -0700, Nhat Pham wrote:
> > > On Tue, May 26, 2026 at 4:46 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
> > > > 
> > > > From: Hao Jia <jiahao1@lixiang.com>
> > > > 
> > > > Zswap currently writes back pages to backing swap reactively, triggered
> > > > either by the shrinker or when the pool reaches its size limit. There is
> > > > no mechanism to control the amount of writeback for a specific memory
> > > > cgroup. However, users may want to proactively write back zswap pages,
> > > > e.g., to free up memory for other applications or to prepare for
> > > > memory-intensive workloads.
> > > > 
> > > > Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
> > > > interface. When specified, this key bypasses standard memory reclaim
> > > > and exclusively performs proactive zswap writeback up to the requested
> > > > budget. If omitted, the default reclaim behavior remains unchanged.
> > > > 
> > > > Example usage:
> > > >    # Write back 100MB of pages from zswap to the backing swap
> > > >    echo "100M zswap_writeback_only" > memory.reclaim
> > > 
> > > Hmmm, so this 100MB is the pre-compression size? i.e if this 100 MB
> > > compresses to 25 MB, then you're only freeing 25 MB?
> > > 
> > > I'm ok-ish with this, but can you document it?
> > 
> > That's a good point. I think pre-compressed size doesn't make sense to
> > be honest. We should care about how much memory we are actually trying
> > to save by doing writeback here.
> > 
> > The pre-compressed size is only useful in determining the blast radius,
> > how many actual pages are going to have slower page faults now. But
> > then, I don't think there's a reasonable way for userspace to decide
> > that.
> > 
> > I understand passing in the compressed size is tricky because we need to
> > keep track of the size of the compressed pages we end up writing back,
> > but it should be doable.
> 
> Agreed. Using pre-compressed size is probably easier to implement. IIRC,
> interfaces like ZRAM writeback_limit are also calculated using the
> pre-compressed size.
> 
> I'll clarify this in the documentation in the next version.
> 
> > 
> > If we really want pre-compressed size here, then yes we need to make it
> > very clear, and I vote that we use a separate interface in this case
> > because memory.reclaim having different meanings for the amount of
> > memory written to it is extremely counter-intuitive.
> > 
> Agree. This would indeed break the semantics of memory.reclaim. I will use a
> separate interface for proactive writeback in the next version.

But doesn't it make more sense to specify the compressed size, which is
ultimately the amount of memory you actually want to reclaim.

Johannes, Nhat, WDYT?

