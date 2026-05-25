Return-Path: <cgroups+bounces-16264-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JwvNu7VFGoPQwcAu9opvQ
	(envelope-from <cgroups+bounces-16264-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 01:06:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 369425CF209
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 01:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3A5303FAD7
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A832573F;
	Mon, 25 May 2026 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="esKgEHGv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD841305677
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779750265; cv=none; b=qtsfKUTN15Q0L4loP7/GO+1QMo7ncDQphw79EkcpALgb/UaRpUyV922xkfuovgGVX6b5yGQ+8lGDt03pCgmn1S4CJn0VA144VxgXQWJ6x0/wZzB5Ili0z0s9zigXBvA3XNunxmAmNqmSWA4kG4PsM7dGujlrY5ji9r8uDT0g1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779750265; c=relaxed/simple;
	bh=GE4ufXL1ql78UrNz8uHqwKreGNMFi2fyq25UQpGQUeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfTDSWv0cMOHO9ih99jL50TNgbbI16PNieySOtC1v0dfk3I4GpETSTXCmnkq11dgdcFCkpihVBoPSt6RsAIYluCelDcQemooc5sAMb6WmRQiEeuxep3b+OZ78k4Oqn0cqanP1RsdkDS9Iux5m2fDCJ8ZUt985lXAhZt5U7zc3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=esKgEHGv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 May 2026 07:04:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779750261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vfRCGs/J5hRiEUILEO3f4AuKoAZdtqxzS7pzC9urB+o=;
	b=esKgEHGvsXOPdD6FjDGRu5GQsjqd0gSih1rqrwpGZXi4ErFpCGaa41wTJXVHnZsFnQzmpI
	nO+ALdzzyjhabI9VMh6ALkdzrZuxVg9rycCFbEC46KLpZ3N0qopaM4MPM/IVG/+yGxJ0Pe
	A2FK0zrL9W8z2N2XQqfwKK7JylPXHEQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com,
	baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v6 2/4] mm: swap: associate swap devices with tiers
Message-ID: <ahTVaix8eauPfUtx@MiWiFi-R3L-srv>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-3-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421055323.940344-3-youngjun.park@lge.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16264-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoquan.he@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:dkim,lge.com:email]
X-Rspamd-Queue-Id: 369425CF209
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21/26 at 02:53pm, Youngjun Park wrote:
> This patch connects swap devices to the swap tier infrastructure,
> ensuring that devices are correctly assigned to tiers based on their
> priority.
> 
> A `tier_mask` is added to identify the tier membership of swap devices.
> Although tier-based allocation logic is not yet implemented, this
> mapping is necessary to track which tier a device belongs to. Upon
> activation, the device is assigned to a tier by matching its priority
> against the configured tier ranges.
> 
> The infrastructure allows dynamic modification of tiers, such as
> splitting or merging ranges. These operations are permitted provided
> that the tier assignment of already configured swap devices remains
> unchanged.
> 
> This patch also adds the documentation for the swap tier feature,
> covering the core concepts, sysfs interface usage, and configuration
> details.
> 
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  Documentation/mm/index.rst     |   1 +
>  Documentation/mm/swap-tier.rst | 159 +++++++++++++++++++++++++++++++++
>  MAINTAINERS                    |   1 +
>  include/linux/swap.h           |   1 +
>  mm/swap_state.c                |   2 +-
>  mm/swap_tier.c                 | 101 ++++++++++++++++++---
>  mm/swap_tier.h                 |  13 ++-
>  mm/swapfile.c                  |   2 +
>  8 files changed, 266 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/mm/swap-tier.rst

LGTM,

Reviewed-by: Baoquan He <baoquan.he@linux.dev>


