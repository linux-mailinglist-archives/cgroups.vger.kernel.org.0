Return-Path: <cgroups+bounces-16917-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FtuNO0lkLmrbvAQAu9opvQ
	(envelope-from <cgroups+bounces-16917-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 10:20:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF47680A34
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 10:20:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16917-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16917-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D98D8300B578
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6702F25F4;
	Sun, 14 Jun 2026 08:20:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864F265621
	for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 08:20:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425220; cv=none; b=GTkhlzs3OhsZtGrKR2OVzygoQqAv1LSIfz9RwTQUxf4gZK3/mDF9XOteTIKV8JA5x/ZEi8IMWD1T6AvzZdwA/mktArf5gNRnb3X3LlzZyMfj0LAypcdrKVdIX5hWL6lb1wP7HwJ5dP5anX8CdJ/1Ep9HkN6RkMblL1xs/FU46ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425220; c=relaxed/simple;
	bh=gewyEdyEhtdyYxG+SRF/EqpHzJVs6wnsL55nkCPli0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVvqDqCv+SattjcL9QQCPSm/G48ByvAHUVXzWogio0nL/Bzh9ji2Z6HRyBhxpJqIg0/XkthjUP0W9BRJEGx36lDohTGsDDsCk1KH8k4FYeSRgDpZ1ORPcQGbuKkzFavaEmTGxJLIXBvDhHWQW60/eRBDb+DNVobJEOsdvIqpyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 14 Jun 2026 17:20:09 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 14 Jun 2026 17:20:08 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, yosry@kernel.org, david@kernel.org,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	baoquan.he@linux.dev, baohua@kernel.org, chengming.zhou@linux.dev,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, qi.zheng@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	riel@surriel.com, gourry@gourry.net, haowenchao22@gmail.com,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] mm, swap: Virtual Swap Space (Swap Table
 Edition)
Message-ID: <ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T330>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612193738.2183968-1-nphamcs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16917-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,yjaykim-PowerEdge-T330:mid,lge.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AF47680A34

...
> * Integration with swap.tier by Youngjun (see [12]). For now, I'm
>   leaning towards opting out the vswap device from swap.tier entirely, and
>   treat it as a special device. Integrating it with swap.tiers will
>   benefit the cases where you want some cgroups to skip vswap for fast
>   swap devices (pmem), whereas other should go through zswap first. But
>   most other use cases, either the overhead of vswap will be acceptable
>   (or not the bottleneck), or we can just disable CONFIG_VSWAP entirely :)
> 
>   Youngjun, may I ask for your thoughts on this?

Hi Nhat,

Tier 1: VSWAP, Tier 2: ZSWAP ...

I don't see any problem applying the desired functionality with the
currently proposed mechanism and interface. With this, a user would be
assigned the default Virtual -> RAM swap tier, and the overall picture
becomes one where swap tiers are composed according to the priority
setting.

A few more thoughts came to mind.

Shakeel also proposed a per-tier max for the swap tier interface.

https://lore.kernel.org/linux-mm/aiw2p5ANjsQUCIHA@linux.dev/

However, for vswap, rather than treating it as a case for limiting the
amount via such a per-tier max, I think the current interface is the
better fit. (But, as Shakeel mentioned, if we only allow the limit
to be set to 0 or max, the usage could end up being the same. I'm still
thinking this part through.)

I have a few other thoughts as well, but I plan to raise those points in
the swap tier discussion thread instead. Please take a look at the
related thread, and let me know if you have any opinions. :)

And I'll share more if other thoughts come to mind

Thanks,
Youngjun Park

