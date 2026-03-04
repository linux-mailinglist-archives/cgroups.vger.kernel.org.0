Return-Path: <cgroups+bounces-14599-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKXKOYktqGlPpQAAu9opvQ
	(envelope-from <cgroups+bounces-14599-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:03:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B120001D
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB64D3011790
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2326159E;
	Wed,  4 Mar 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6NpVag2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67A1B0439;
	Wed,  4 Mar 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629382; cv=none; b=EbR/k0itJkYwn0vhASDwcdEnjx46JBmwxxdigwpBCygWWXL+YzjbBHVD/DHSXA3Li4DwYsjt9S3rFuIkg1OkCHiY6f/Ak0/fVIktUAKBnCxO0dX7rMoMALzAaUzXrAZltmCRr86WxEpZmwbYMHaxJPS1ITeTqz4k7t+B/rkzTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629382; c=relaxed/simple;
	bh=TqA3vtHqmK2J2FK5mNjZzCVGaW+JImAg60XzuHNKSk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAjoDzfEFyWRkNIg1I8HQVj3iw1ja1MhKd3rjMEtCmsWY8/EWZ7F/0YdCP9FlEIoDBmpTof1ya/LrCBUysguGY2q7ZccVKtS0eDgvsKtjG1jJDnhGOMItJPvWM/fqyUHPB2YE6fZkFmckGE8LUSSo3c5paWNv1TIdnG+ZfoeBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6NpVag2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C092AC2BC87;
	Wed,  4 Mar 2026 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772629382;
	bh=TqA3vtHqmK2J2FK5mNjZzCVGaW+JImAg60XzuHNKSk8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g6NpVag2wYWX+aprYWMsse+oPMxIK3jNcy+BS3pnNRtMb4TbjuqM/yaE3hjf9goJA
	 1Nh3eQEgVu2qX/p8k9fvx90ctsUb69BZaIVeGtEXAKx3PW8fvS70A00D5h3kTf9T9W
	 Lf5kEjD7Rm8QHPlYBR5kDauqX4AwYhBjuMrq8UDUmZ1idEY/Ts5/Xs0ivw8L97ll0s
	 io0FJ58pylg3xVQ80FDpxIIPo1LyLmE6dbk6dM1G7KKYgJVQaJCXjYlYr6LMNgwT27
	 mjiE/LFcubpLvXBgs6fOy+gbQxl5AcBqfqCwMwDTv+B4EjJl0Ql7mE0H8586C3BDy8
	 Jdo9gxfZRD7PA==
Message-ID: <a61c62ca-45f3-49f3-90d6-a708e468af12@kernel.org>
Date: Wed, 4 Mar 2026 14:02:58 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm: memcg: separate slab stat accounting from objcg
 charge cache
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-6-hannes@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <20260302195305.620713-6-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 149B120001D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14599-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 8:50 PM, Johannes Weiner wrote:
> Cgroup slab metrics are cached per-cpu the same way as the sub-page
> charge cache. However, the intertwined code to manage those dependent
> caches right now is quite difficult to follow.
> 
> Specifically, cached slab stat updates occur in consume() if there was
> enough charge cache to satisfy the new object. If that fails, whole
> pages are reserved, and slab stats are updated when the remainder of
> those pages, after subtracting the size of the new slab object, are
> put into the charge cache. This already juggles a delicate mix of the
> object size, the page charge size, and the remainder to put into the
> byte cache. Doing slab accounting in this path as well is fragile, and
> has recently caused a bug where the input parameters between the two
> caches were mixed up.
> 
> Refactor the consume() and refill() paths into unlocked and locked
> variants that only do charge caching. Then let the slab path manage
> its own lock section and open-code charging and accounting.
> 
> This makes the slab stat cache subordinate to the charge cache:
> __refill_obj_stock() is called first to prepare it;
> __account_obj_stock() follows to hitch a ride.
> 
> This results in a minor behavioral change: previously, a mismatching
> percpu stock would always be drained for the purpose of setting up
> slab account caching, even if there was no byte remainder to put into
> the charge cache. Now, the stock is left alone, and slab accounting
> takes the uncached path if there is a mismatch. This is exceedingly
> rare, and it was probably never worth draining the whole stock just to
> cache the slab stat update.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


