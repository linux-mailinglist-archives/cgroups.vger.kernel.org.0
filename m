Return-Path: <cgroups+bounces-15321-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDlxG4zd4Gm9mwAAu9opvQ
	(envelope-from <cgroups+bounces-15321-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 15:01:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA740E6F3
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5096B30067A3
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C338F630;
	Thu, 16 Apr 2026 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="YWvqLByp"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BD1C695;
	Thu, 16 Apr 2026 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344452; cv=none; b=hInP53mxa3GyfOzErEAwUHxPT18T3WTBP4zlgonzUrQ4qaYi9UgtCxrQCk74AUzBEQ1TIIHfaREaGx244DLRjI/xyh7OQgDPK6HFGR0BFdWvq3ukCXyYevoNQWAp8+0DyPrYOUyQE/S7lCBUxLX6nhPl3MBEOnZz4gnP2+QUJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344452; c=relaxed/simple;
	bh=wyXlV1QjTrvOnV0yjeB7w668Ayoqi+Gfb6YUV6x3bks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4Wu4G5lTv85bCnu87d1AtCLOqutfrnUIrK/HNjFpOPTFDJPdcEg+/4dlGGDMpUd+DBShjJu3z0v5uqEt9qoOAxTjDCsRAhcYmnCkBp4XWaNPTheSdK1Y6QhgpPbua48Gyjxo2yBXr/nwUeixeAJG+qZ8c5B6WMKN18kRWYGmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=YWvqLByp; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1776344116;
	bh=wyXlV1QjTrvOnV0yjeB7w668Ayoqi+Gfb6YUV6x3bks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YWvqLBypVemQeFv2zuoplMs3aJkJC8/L9F6Pxgz9B+5FY7P42+CDHbkoE2G1BUXX4
	 IskW3lcUJI6zjC/GkphqXrFVQtSDngusEeWGy9obPT6of3tPcQCM9TtM9SXrns02Tj
	 +e12pfn9OBPsMfxUPpa7dCXghZ3ZkZaZGTg86/SWxqyf9g3MhI9e7aksTyllW3uF7p
	 74RonGvy8iCN9t058OTUvX8ywynGI+fhUPRQoEEmR9LTNmIAeJOROf6UgBNP97WjGk
	 2r6hwTfsdJPiyrnqJyJ6NMJpPeYbreSmcvGLVeqnyVdwwrXjGdHs54RQPMwNuzGhz3
	 JJVK24NcVXBtQ==
Message-ID: <ffeba98b-575d-4e64-a1b9-ea41dd325658@lankhorst.se>
Date: Thu, 16 Apr 2026 14:55:15 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/dmem: allow max to be set below current usage
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[igalia.com,kernel.org,gmx.de,cmpxchg.org,suse.com];
	RSPAMD_URIBL_FAIL(0.00)[igalia.com:query timed out];
	TAGGED_FROM(0.00)[bounces-15321-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2ADA740E6F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Getm

Den 2026-03-26 kl. 16:18, skrev Thadeu Lima de Souza Cascardo:
> page_counter_set_max may return -EBUSY in case the current usage is above
> the new max. When writing to dmem.max, this error is ignored and the new
> max is not set.
> 
> Instead of using page_counter_set_max when writing to dmem.max, atomically
> update its value irrespective of the current usage.
> 
> Since there is no current mechanism to evict a given dmemcg pool, this will
> at least prevent the current usage from growing any further.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> When writing to dmem.max, it was noticed that some writes did not take
> effect, even though the write was successful.
> 
> It turns out that page_counter_set_max checks if the new max value is above
> the current usage and returns -EBUSY in case it is, which was being ignored
> by dmemcg_limit_write.
> 
> It was also noticed that when setting limits for multiple regions in a
> single write, while setting one region's limit may fail, others might have
> succeeded before. Tejun Heo brought up that this breaks atomicity.
> 
> Maarten Lankhorst and Michal Koutný have brought up that instead of
> failing, setting max below the current usage should behave like memcg and
> start eviction until usage goes below the new max.
> 
> However, since there is no current mechanism to evict a given region, they
> suggest that setting the new max will at least prevent further allocations.
> 
> v1 kept the multiple region support when writing to limit files, while
> returning -EBUSY as soon as setting a region's max was above the usage.
> 
> v2 only allows setting a single region limit per write, while allowing any
> new max to be set.
> 
> This version (v3) still allows multiple regions to be set, and explains why
> page_counter_set_max is not used anymore.
> 
> I am sending this version dropping the multiple region restriction for now,
> as we continue to discuss whether it should be supported or not.
> ---
> Changes in v3:
> - Dropped first patch as it was already applied.
> - Added comment explaining why page_counter_set_max is not used.
> - Dropped patch restricting multiple regions to be set for now.
> - Link to v2: https://lore.kernel.org/r/20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com
> 
> Changes in v2:
> - Remove support for setting multiple regions' limits.
> - Allow any new max limit to be set.
> - Link to v1: https://lore.kernel.org/r/20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com
> ---
>  kernel/cgroup/dmem.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9..c00aa06759967a8f8977aaf036dd7966ddb55718 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -159,7 +159,15 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
>  static void
>  set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
>  {
> -	page_counter_set_max(&pool->cnt, val);
> +	/*
> +	 * page_counter_set_max will return -EBUSY in case the current
> +	 * usage is above the new max.
> +	 *
> +	 * Since, there is no current eviction mechanism yet, setting max
> +	 * irrespective of the current usage will prevent further
> +	 * allocations.
> +	 */
> +	xchg(&pool->cnt.max, val);
>  }
>  
>  static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)

I haven't seen a reply yet, so do you want me to commit this now to drm-misc-next?

Kind regards,
~Maarten Lankhorst

