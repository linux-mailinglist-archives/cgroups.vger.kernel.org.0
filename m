Return-Path: <cgroups+bounces-16987-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lRpgH5OnMGrIVwUAu9opvQ
	(envelope-from <cgroups+bounces-16987-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:32:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E95CD68B464
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:32:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16987-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16987-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95A323027948
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2337A4BA;
	Tue, 16 Jun 2026 01:29:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADB379C33
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 01:29:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573351; cv=none; b=csPEsYlf5MZyHWjbV5bMxCj4pkGjtagon8EeqqpjXPpBxeuFXqqEL+bZkLgYIacz6/8fL0FC9qXaN1WyRUWtqwCXyv0//TLOSZz5hNEhtU3HmXdbmAoLvB0LLqTg73hTJk1Yha0YA3bPLJn2IDbR+iu3l3YAl/LzKhNcywfPCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573351; c=relaxed/simple;
	bh=KiChCwZqxm54uhaQQsZr9QsxUIoKEkOIVvi6nCtazyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfo2sQFv5XmcDuaGaFLDSEXMg5DT6w6Cvl11RNzhyOAego9IF3a2DPIGxSoSMO5pzU6boXlC2bIeukGxJEbyVRU3lWFB8SyS7mRmL4tg4i7WQm9fDtoaWoMzR2+zF5c9iX+KsskeJlA4yqSek2M0MFU2wHrtzk+ziMen/xpqjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 16 Jun 2026 10:29:08 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 16 Jun 2026 10:29:07 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chrisl@kernel.org, kasong@tencent.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	david@kernel.org, muchun.song@linux.dev, shikemeng@huaweicloud.com,
	baoquan.he@linux.dev, baohua@kernel.org, chengming.zhou@linux.dev,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, qi.zheng@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	riel@surriel.com, gourry@gourry.net, haowenchao22@gmail.com,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] mm, swap: Virtual Swap Space (Swap Table
 Edition)
Message-ID: <ajCm44rYpLOKCQ43@yjaykim-PowerEdge-T330>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
 <ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T330>
 <CAKEwX=O23a4iWBZoewKVb8QqODte6r3Xijckw3_oCJNoiO9M5A@mail.gmail.com>
 <CAO9r8zPj5EH8Mbpc6N+d1u2eEgoV33f+4s=v-84gaobAodPtUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zPj5EH8Mbpc6N+d1u2eEgoV33f+4s=v-84gaobAodPtUw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16987-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,infradead.org,google.com,surriel.com,gourry.net,meta.com,kvack.org,vger.kernel.org];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,yjaykim-PowerEdge-T330:mid,lge.com:from_mime,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E95CD68B464

On Mon, Jun 15, 2026 at 12:56:26PM -0700, Yosry Ahmed wrote:
> On Sun, Jun 14, 2026 at 7:39 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Sun, Jun 14, 2026 at 4:20 AM YoungJun Park <youngjun.park@lge.com> wrote:
> > >
> > > ...
> > > > * Integration with swap.tier by Youngjun (see [12]). For now, I'm
> > > >   leaning towards opting out the vswap device from swap.tier entirely, and
> > > >   treat it as a special device. Integrating it with swap.tiers will
> > > >   benefit the cases where you want some cgroups to skip vswap for fast
> > > >   swap devices (pmem), whereas other should go through zswap first. But
> > > >   most other use cases, either the overhead of vswap will be acceptable
> > > >   (or not the bottleneck), or we can just disable CONFIG_VSWAP entirely :)
> > > >
> > > >   Youngjun, may I ask for your thoughts on this?
> > >
> > > Hi Nhat,
> > >
> > > Tier 1: VSWAP, Tier 2: ZSWAP ...
> > >
> > > I don't see any problem applying the desired functionality with the
> > > currently proposed mechanism and interface. With this, a user would be
> > > assigned the default Virtual -> RAM swap tier, and the overall picture
> > > becomes one where swap tiers are composed according to the priority
> > > setting.
> >
> > It's more - is there a strong argument to let vswap be a tier (which
> > is not supported by just turning of vswap altogether).
> >
> > Because right now I'm not exposing vswap device to userspace in any
> > manner, pretty much. It's abstract and transparent, and minimizes
> > complexity (no vswap and swap.tier interaction) and surfaces for
> > issues.
> 
> I definitely think vswap should *not* be a tier. First of all, a vswap
> entry can be backed by zswap or an actual swap device, which would be
> two different tiers. How does that work?
> 
> I also think vswap should not be exposed to userspace in any way, at
> least not now. I still think we should aim to just make the
> redirection layer always on and eliminate "vswap devices".

After following the answers and giving it some thought, I agree that
vswap should be kept user-transparent. If there is a strict need to
disable it, relying on CONFIG_VSWAP to remove it entirely seems like
the right approach.

If a strong use case for user interaction emerges in the future, we can
revisit the design and figure out how to handle it at that time.

Thanks,
Youngjun Park

