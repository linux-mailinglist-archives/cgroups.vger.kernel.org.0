Return-Path: <cgroups+bounces-14554-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGJtMP6spmn9SgAAu9opvQ
	(envelope-from <cgroups+bounces-14554-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 10:42:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242E51EC05C
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D88C230D241D
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C538C2DE;
	Tue,  3 Mar 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnQ0gYGU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603031717E;
	Tue,  3 Mar 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530795; cv=none; b=dm4OtGSGVaLfqWiMOqBB2YnQJ7qcDhMdpb++4opj0lWPTvYMeUz6OXhMTdF6BTv4pAApGcZd5d/DS/hpOnNTsXg50RzedzSPzb4+LWd7u7sZpe/JYe7hcvlJ8jSsf8OTU0MkCpnLYvLS6oBkQYvBofvoBI6qkBqYC/HAo1kIVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530795; c=relaxed/simple;
	bh=TkaYJ0+ciE8akBpuN5ZN0VbNEJHpN3mETiZttIZKh28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g73fXhUBAWegVs5A3fQ9Mbb7ulowNBFkJPuKmvwLWWdoJE39l6dtnxKUs4m2aa1yEWg8GIpISu1ejIxxtbAGo5qg4Q0LVBecIrU3/qQkcGd2zPobkHI0OD+hID6eacrXl41COQRpSa3Nreiw9GeKg+iDuRho9DIDggUtS3KmiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnQ0gYGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63F4C116C6;
	Tue,  3 Mar 2026 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772530795;
	bh=TkaYJ0+ciE8akBpuN5ZN0VbNEJHpN3mETiZttIZKh28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FnQ0gYGU20tf4Gl7wGSZALeK7ao+poKYVXiw2ayguP5D2cyuwCvEho8DvKbmvGwS8
	 qsZLLpnwWipwRQAlAF+hLG36qo6Ost7vllwsQtTOfUYsx/XUh3zRN3AvHcmfWxdpx6
	 wbmRhQoDvbhdwJ1e8kV4xDdg7QjAJTAR1vnJMPvv1KUKCVxWfsJ2sHHKaa6MXDTGJ8
	 Nh4R+Cv3PCvVEAo8YfwTsT7vcES4ngmMNgOvSJUdDEkLhXxaihOeVww2TNd9yXNJ13
	 dO5lzpQSFuVOKSo7wxJbH+FmzvqAyDEd2DSr78wL23bCOi+mNXQRFcqmqj4j+vl6nL
	 w9vBHbn06aBvg==
Message-ID: <ed664410-e220-4107-b207-6bb8b4b0e710@kernel.org>
Date: Tue, 3 Mar 2026 10:39:50 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm: memcontrol: use __account_obj_stock() in the
 !locked path
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-5-hannes@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260302195305.620713-5-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 242E51EC05C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14554-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 20:50, Johannes Weiner wrote:
> Make __account_obj_stock() usable for the case where the local trylock
> failed. Then switch refill_obj_stock() over to it.
> 
> This consolidates the mod_objcg_mlstate() call into one place and will
> make the next patch easier to follow.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/memcontrol.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 32c09b4d520f..4f12b75743d4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3227,6 +3227,9 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
>  {
>  	int *bytes;
>  
> +	if (!stock)
> +		goto direct;
> +
>  	/*
>  	 * Save vmstat data in stock and skip vmstat array update unless
>  	 * accumulating over a page of vmstat data or when pgdat changes.
> @@ -3266,6 +3269,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
>  			nr = 0;
>  		}
>  	}
> +direct:
>  	if (nr)
>  		mod_objcg_mlstate(objcg, pgdat, idx, nr);
>  }
> @@ -3382,7 +3386,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	stock = trylock_stock();
>  	if (!stock) {
>  		if (pgdat)
> -			mod_objcg_mlstate(objcg, pgdat, idx, nr_acct);
> +			__account_obj_stock(objcg, NULL, nr_acct, pgdat, idx);
>  		nr_pages = nr_bytes >> PAGE_SHIFT;
>  		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
>  		atomic_add(nr_bytes, &objcg->nr_charged_bytes);


