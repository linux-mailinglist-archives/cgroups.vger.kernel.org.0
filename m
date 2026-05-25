Return-Path: <cgroups+bounces-16263-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN0pAdLTFGqqQgcAu9opvQ
	(envelope-from <cgroups+bounces-16263-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 00:57:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D55CF139
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 00:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2EE63019528
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C0B34B1A3;
	Mon, 25 May 2026 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LbE68e+u"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E39274FD1
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779749837; cv=none; b=rVKiLZ5Fcc9DxHms91opcaAQPsIIV4L+84acpm7GSAKuCGvYJt+jrr4Kwo+9UczJt9ymUOShGdNKBWGqtZ++8QXch1Tq51d5ZorNYr4lLP9zn/y4oMkH13SixyhgJJDkMt//gY2P/cUQAu4R2hM/qbMpxaCU10dYV6Yr5f1K2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779749837; c=relaxed/simple;
	bh=xdWAdCG0W4uZtuCTHPX/YYXBeyUnpOl9c/3K3ZXRFb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI3nvXAL9Wbaql/+aOuViuRbvaePgo9KXNIc/pvJ8SOpdirxE30h9B8xXMQzNXtIwnepWOv66G6FyhVVJX78oplUEtgbDuF1MduRnOwFlLMhse3JrX9STMRoIYBaXodL9+tUZsknpVksyV8RsY/uT40NaBhdkktRxkIYVaVJ7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LbE68e+u; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 May 2026 06:57:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779749829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvAHNAxC6rDU5yUwP8byqCJ4phTBIMQ7rInOdnEr2YA=;
	b=LbE68e+uwRgBhWHdTgPTc2kfRUtHSQ7kfDDN5iimq8ExxqmwnnDaC8GhsR1Wo0iimoE1CO
	XcdpFk16wzEkwVI0RHqWjb/g7IxTrlXxapmw24TPeCxMiTZucuHMmxxlNbOU1EDPxTiiPV
	MfP3/sV5DVZwc3MW/yi7xaAeppM2Y3Q=
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
Subject: Re: [PATCH v6 1/4] mm: swap: introduce swap tier infrastructure
Message-ID: <ahTTv5OWpaUF6S1S@MiWiFi-R3L-srv>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421055323.940344-2-youngjun.park@lge.com>
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
	TAGGED_FROM(0.00)[bounces-16263-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A83D55CF139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21/26 at 02:53pm, Youngjun Park wrote:
...snip...
> +bool swap_tiers_validate(void)
> +{
> +	struct swap_tier *tier;
> +
> +	/*
> +	 * Initial setting might not cover DEF_SWAP_PRIO.
> +	 * Swap tier must cover the full range (DEF_SWAP_PRIO to SHRT_MAX).
> +	 */

If so, do we need check if the upmost boundary SHRT_MAX is covered?

> +	if (swap_tier_is_active()) {
> +		tier = list_last_entry(&swap_tier_active_list,
> +			struct swap_tier, list);
> +
> +		if (tier->prio != DEF_SWAP_PRIO)
> +			return false;
> +	}
> +
> +	return true;
> +}
...snip...

