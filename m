Return-Path: <cgroups+bounces-14555-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FPbISO7pmk7TAAAu9opvQ
	(envelope-from <cgroups+bounces-14555-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 11:42:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E10B41ECDD7
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF2A9300C824
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5539EF09;
	Tue,  3 Mar 2026 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc4pLu6o"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9739D6F6;
	Tue,  3 Mar 2026 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534556; cv=none; b=R5+0l5aUzkDN2Nb9pNax2DPLY8hDEZl0XE/ASEFp+M35eBTw4n0XAGydxbgj9x9bQbiikqDTJyV6O89+OxaIAEr2JSBHr+RvvxvsshGxh1X5f26IEcppcbfTA41SgrvqEnYXy6UzHO/avR38FQSIH00B6Uiq5/5Dd8B69Gzq78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534556; c=relaxed/simple;
	bh=LXTeLcko8TN4s1+AW7QCG0gHA8xgKDg8hODvm4T/7lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6ItDMCOe/7fUXyp8fKLSyltq3/Jof8CkmSg8QprqMPMkUe6ucYZRBKG2i6FdPTxgJ7yhtZZTYrHKsEA4FcWm44IykjLfLvNJo5CW21ji2vj9LY5rzxiZ6uUAbBz868m/OHtON2lOhJ0lgL9PzY0ZZ9VEi2RoZAxBuG1DHUW3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc4pLu6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347AEC2BCAF;
	Tue,  3 Mar 2026 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772534555;
	bh=LXTeLcko8TN4s1+AW7QCG0gHA8xgKDg8hODvm4T/7lc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pc4pLu6ohC9WXq6G0jj+NEJ5RkGQ37fiA5oNskpR6+zMukelRCHtriLRP4m7CqHAw
	 nPA2LlF3ddDrXi2EUp2GJ0padvrjbfd0UgIOdtSOReXm0uRZdgPT0InGWehijm2w/y
	 ndQDznoNs8TxIEw1DZhmy2CIPUuafpZ7uSQyLa9iPlJkL2+ESL6Q3lf6nlb+ZH4prL
	 VOKd1DKQ9RB0+R4IsTXYoiUOGwebLqLeSRAF3b5u+sTLjOPxrkQd4qWbV9zg4b6JKd
	 Bhfbxnc/CtloC/kupqmYWciYZEwAEqTyJGFzFWFS8uU+tn9+gYvJhSR8lJS0W1Dcjw
	 biTyQuTKeFhpg==
Message-ID: <541a6661-7bfe-4517-a32c-5839002c61e5@kernel.org>
Date: Tue, 3 Mar 2026 11:42:31 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm: memcg: separate slab stat accounting from objcg
 charge cache
Content-Language: en-US
To: Hao Li <hao.li@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-6-hannes@cmpxchg.org>
 <ji2jjt4vtmt2ox7wzytpivttc4z7j3u6cwmv23r6xit5322gns@te4t4djl5nlk>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ji2jjt4vtmt2ox7wzytpivttc4z7j3u6cwmv23r6xit5322gns@te4t4djl5nlk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E10B41ECDD7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14555-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cmpxchg.org:email]
X-Rspamd-Action: no action

On 3/3/26 09:54, Hao Li wrote:
> On Mon, Mar 02, 2026 at 02:50:18PM -0500, Johannes Weiner wrote:
>> Cgroup slab metrics are cached per-cpu the same way as the sub-page
>> charge cache. However, the intertwined code to manage those dependent
>> caches right now is quite difficult to follow.
>> 
>> Specifically, cached slab stat updates occur in consume() if there was
>> enough charge cache to satisfy the new object. If that fails, whole
>> pages are reserved, and slab stats are updated when the remainder of
>> those pages, after subtracting the size of the new slab object, are
>> put into the charge cache. This already juggles a delicate mix of the
>> object size, the page charge size, and the remainder to put into the
>> byte cache. Doing slab accounting in this path as well is fragile, and
>> has recently caused a bug where the input parameters between the two
>> caches were mixed up.
>> 
>> Refactor the consume() and refill() paths into unlocked and locked
>> variants that only do charge caching. Then let the slab path manage
>> its own lock section and open-code charging and accounting.
>> 
>> This makes the slab stat cache subordinate to the charge cache:
>> __refill_obj_stock() is called first to prepare it;
>> __account_obj_stock() follows to hitch a ride.
>> 
>> This results in a minor behavioral change: previously, a mismatching
>> percpu stock would always be drained for the purpose of setting up
>> slab account caching, even if there was no byte remainder to put into
>> the charge cache. Now, the stock is left alone, and slab accounting
>> takes the uncached path if there is a mismatch. This is exceedingly
>> rare, and it was probably never worth draining the whole stock just to
>> cache the slab stat update.
>> 
>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> ---
>>  mm/memcontrol.c | 100 +++++++++++++++++++++++++++++-------------------
>>  1 file changed, 61 insertions(+), 39 deletions(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 4f12b75743d4..9c6f9849b717 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3218,16 +3218,18 @@ static struct obj_stock_pcp *trylock_stock(void)
>>  
> 
> [...]
> 
>> @@ -3376,17 +3383,14 @@ static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
>>  	return flush;
>>  }
>>  
>> -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>> -		bool allow_uncharge, int nr_acct, struct pglist_data *pgdat,
>> -		enum node_stat_item idx)
>> +static void __refill_obj_stock(struct obj_cgroup *objcg,
>> +			       struct obj_stock_pcp *stock,
>> +			       unsigned int nr_bytes,
>> +			       bool allow_uncharge)
>>  {
>> -	struct obj_stock_pcp *stock;
>>  	unsigned int nr_pages = 0;
>>  
>> -	stock = trylock_stock();
>>  	if (!stock) {
>> -		if (pgdat)
>> -			__account_obj_stock(objcg, NULL, nr_acct, pgdat, idx);
>>  		nr_pages = nr_bytes >> PAGE_SHIFT;
>>  		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
>>  		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
>> @@ -3404,20 +3408,25 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>>  	}
>>  	stock->nr_bytes += nr_bytes;
>>  
>> -	if (pgdat)
>> -		__account_obj_stock(objcg, stock, nr_acct, pgdat, idx);
>> -
>>  	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
>>  		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>>  		stock->nr_bytes &= (PAGE_SIZE - 1);
>>  	}
>>  
>> -	unlock_stock(stock);
>>  out:
>>  	if (nr_pages)
>>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
>>  }
>>  
>> +static void refill_obj_stock(struct obj_cgroup *objcg,
>> +			     unsigned int nr_bytes,
>> +			     bool allow_uncharge)
>> +{
>> +	struct obj_stock_pcp *stock = trylock_stock();
>> +	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge);
>> +	unlock_stock(stock);
> 
> Hi Johannes,
> 
> I noticed that after this patch, obj_cgroup_uncharge_pages() is now inside
> the obj_stock.lock critical section. Since obj_cgroup_uncharge_pages() calls
> refill_stock(), which seems non-trivial, this might increase the lock hold time.
> In particular, could that lead to more failed trylocks for IRQ handlers on
> non-RT kernel (or for tasks that preempt others on RT kernel)?

Yes, it also seems a bit self-defeating? (at least in theory)

refill_obj_stock()
  trylock_stock()
  __refill_obj_stock()
    obj_cgroup_uncharge_pages()
      refill_stock()
        local_trylock() -> nested, will fail

