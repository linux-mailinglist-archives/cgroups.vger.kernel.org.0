Return-Path: <cgroups+bounces-16601-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MAqVEGgSIGrZvQAAu9opvQ
	(envelope-from <cgroups+bounces-16601-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:39:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D127637239
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:39:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bJHgPWhs;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16601-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16601-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ADF03065919
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869245BD6B;
	Wed,  3 Jun 2026 11:27:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE1402427
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 11:27:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486054; cv=none; b=uJUvf6w5O+Yo0OHMPpxvd3l1Mpgi+C7sG89eqyRRmzG5j4y7Hy7dfuHv6bXCG43MN3OdlD8SlqYqgtFGGnJDQS6nWylYM2yBvjiYqrLTcEI5Z79rRzdFbGbJInY0bhCinpkgMeUdpe/JESpROdMXVqQUkjy4eCEM/i03hS4v42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486054; c=relaxed/simple;
	bh=Q5A+OD1aTiK+w+fKTenLE03+HWkfz3WlJe8SMvbsefQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5vHpXBSjvMf8L2PkMioPci2Jb0F/Q2b6OiurVjJMej6UWbdU8dmcDmPkpD2WNR9y9So5YMfY1Hw5BbXaLQ49eHhHfMNSgDbxzhxL+em2hnZ0Y6JShma+GhR9BqWw7jkPA3WAHyabl4zLs2DUX7WFX9JDZ3MMRlWI6c0O6m0mLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJHgPWhs; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf3781ca51so42916775ad.0
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780486052; x=1781090852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGeTlR7gBa/MmVgFAbV0MjIRnlhQQbkpnIke5FnciGo=;
        b=bJHgPWhsiOZDPsrhutFGNl3bNiBIxCo7Kh/JVmjKEsGPaGtxERT0jrYa0Vy7VqjfQL
         9i1BqtUYGk/t11zBsru1TFuEaA2TCCd7Aw9Fm0Oz3OyWMDKNpjECkxQgGtkde+LhiysM
         FtxXZloAdvhEPyocmid3Rj2CZLHtl/tof8dzq8yIPnm+nkH7768wrOZWQ6G2dHfA1Oto
         z/PTTQ2Nb9I8GscRGVpPWwkDXQ4GQa0kelRYQgbZZKuLjVWmrcMYCcMSzVMRt9Ey8B6X
         RMt8KbfpxvhTvAc0f/dyrn0yBt1oRNP/X4/1xB2gQdXZU2cFaH6hCNRrvsoAmssmDMfJ
         zrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780486052; x=1781090852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGeTlR7gBa/MmVgFAbV0MjIRnlhQQbkpnIke5FnciGo=;
        b=SiaTwefhjvADJjIq6EOlLEYEAq4nI0ukXL7wbQskWiiTAh2jgmz+R2s+cSI0OG6dzX
         ekVrWnGKB6keHRBJnsnJPOVfMtfbBw52DzpeULJnNNJm7JpFORJAZRQ/GcbgSSqp4bst
         HBDN1iTAP/NW4BmkzJUN+ZLXOKsighElyWhpIku/0Jw/EFqoTv8TadzUjGzR8NxYEZh9
         9yjESDzzKCW9VfReLE+Ty+CRxKUVeGJv6z8W2nMQevSY3wARfz2eud5m3xXthasYXwEa
         o7tgmqAeLqkzv+iMGzkhrHEV8nQjaIxd/Vm4zBupv+qjkSQDzeSPSt2RxSqap0t0cqMD
         NOEw==
X-Forwarded-Encrypted: i=1; AFNElJ9NUZDXvTyDj15uD5LwgO6n7CojHhl332rIJfegW5D1Lje/+kvn6lK3F0byZ5YW1QcdbK2M/Xz0@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPQNgOz/YmWVuJ2SZMuJsjlIOakIlPuraFzTYTp+fWSq1TAcg
	yOuKXhan90k8Mkyd/MpbJxCdHlSU1MEwMQBOl7yRF7ZNxcQfK7CfFHpA
X-Gm-Gg: Acq92OGnVP5RQpSDDjN4QWpSzt0OSKJoYIATPwhPGv8lxURNhO0NZcQsf/y30Bfc2mN
	j6iNBm3nY8e4rjt9H8Czhs5b/ef82Mcz7Rb/QoyYMFjX3z/v+S5kKjX09EKohKJwhoTnnolHMRc
	q44ndvd9Y+3gIxsC8EogqaCHyOxpoR0f8UuGjXs8fLksGgjQmhbJaS64LKopx9/AIuPY2/2yl31
	9SV5Z+gFniCVO5vmUFSpUWNX9UVGgKZOkLwmtb3byjiMEY4qwJvvAYeRp0mviH/VZzsKApjswL7
	w2eMNfVPmDVwu9RKMgAGhpAayrCcOBLxnkUWsfxFyKYe5qMQNWr8iIAUO8LEkB9y5+v8HUu4L01
	LEk2VvJ8nFWFvbCWkiJ5jcAf6YBJu9aQqNYz3ObOfxOSH/8GPPiUi7IfNoTYZg8JMz+TONbO8OR
	gL/CoGBaBYRxsqEaxGNvV3UJOx4nj7jRtsxCanFFz1X0X7obnoBeeXzQ==
X-Received: by 2002:a17:902:f60b:b0:2bf:160f:7043 with SMTP id d9443c01a7336-2c1644b2994mr34374485ad.34.1780486052378;
        Wed, 03 Jun 2026 04:27:32 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f88473sm25004435ad.25.2026.06.03.04.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 04:27:31 -0700 (PDT)
Message-ID: <ea2c1323-1440-e927-f14a-0eac54a245bf@gmail.com>
Date: Wed, 3 Jun 2026 19:27:22 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com>
 <aho-Z6wshceTAYd9@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <aho-Z6wshceTAYd9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16601-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lixiang.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D127637239



On 2026/5/30 09:37, Yosry Ahmed wrote:
> On Tue, May 26, 2026 at 07:45:59PM +0800, Hao Jia wrote:
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> Zswap currently writes back pages to backing swap reactively, triggered
>> either by the shrinker or when the pool reaches its size limit. There is
>> no mechanism to control the amount of writeback for a specific memory
>> cgroup. However, users may want to proactively write back zswap pages,
>> e.g., to free up memory for other applications or to prepare for
>> memory-intensive workloads.
>>
>> Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
>> interface. When specified, this key bypasses standard memory reclaim
>> and exclusively performs proactive zswap writeback up to the requested
>> budget. If omitted, the default reclaim behavior remains unchanged.
>>
>> Example usage:
>>    # Write back 100MB of pages from zswap to the backing swap
>>    echo "100M zswap_writeback_only" > memory.reclaim
>>
>> Note that the actual amount written back may be less than requested due
>> to the zswap second-chance algorithm: referenced entries are rotated on
>> the LRU on the first encounter and only written back on a second pass.
>> If fewer bytes are written back than requested, -EAGAIN is returned,
>> matching the existing memory.reclaim semantics.
>>
>> Internally, extend user_proactive_reclaim() to parse the new
>> "zswap_writeback_only" token and invoke the dedicated handler. Add
>> zswap_proactive_writeback() to walk the target memcg subtree via the
>> per-memcg writeback cursor, draining per-node zswap LRUs through
>> list_lru_walk_one() with the shrink_memcg_cb() callback.
>>
>> Suggested-by: Yosry Ahmed <yosry@kernel.org>
>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |  18 +++-
>>   Documentation/admin-guide/mm/zswap.rst  |  11 +-
>>   include/linux/zswap.h                   |   7 ++
>>   mm/vmscan.c                             |  14 +++
>>   mm/zswap.c                              | 138 ++++++++++++++++++++++++
>>   5 files changed, 185 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 6efd0095ed99..6564abf0dec5 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1425,9 +1425,10 @@ PAGE_SIZE multiple when read back.
>>   
>>   The following nested keys are defined.
>>   
>> -	  ==========            ================================
>> +	  ====================  ==================================================
>>   	  swappiness            Swappiness value to reclaim with
>> -	  ==========            ================================
>> +	  zswap_writeback_only  Only perform proactive zswap writeback
>> +	  ====================  ==================================================
>>   
>>   	Specifying a swappiness value instructs the kernel to perform
>>   	the reclaim with that swappiness value. Note that this has the
>> @@ -1437,6 +1438,19 @@ The following nested keys are defined.
>>   	The valid range for swappiness is [0-200, max], setting
>>   	swappiness=max exclusively reclaims anonymous memory.
>>   
>> +	The zswap_writeback_only key skips ordinary memory reclaim and
>> +	writes back pages from zswap to the backing swap device until
>> +	the requested amount has been written or no further candidates
>> +	are found. This is useful to proactively offload cold pages from
>> +	the zswap pool to the swap device. It is only available if
>> +	zswap writeback is enabled. zswap_writeback_only cannot be combined
>> +	with swappiness; specifying both returns -EINVAL.
>> +
>> +	Example::
>> +
>> +	  # Write back up to 100MB of pages from zswap to the backing swap
>> +	  echo "100M zswap_writeback_only" > memory.reclaim
> 
> 
> memcg folks need to chime in about the interface here. An alternative
> would be a separate interface (e.g. memory.zswap.do_writeback or
> memory.zswap.writeback.reclaim or sth).
> 
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 73e64a635690..7bcbf788f634 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1679,6 +1679,144 @@ int zswap_load(struct folio *folio)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Maximum LRU scan limit:
>> + * number of entries to scan per page of remaining budget.
>> + */
>> +#define ZSWAP_PROACTIVE_WB_SCAN_RATIO	16UL
>> +/*
>> + * Batch size for proactive writeback:
>> + * - As the per-memcg writeback target in the outer memcg loop.
>> + * - As the per-walk budget passed to list_lru_walk_one().
>> + */
>> +#define ZSWAP_PROACTIVE_WB_BATCH	128UL
>> +
>> +/*
>> + * Walk the per-node LRUs of @memcg to write back up to @nr_to_write pages.
>> + * Returns the number of pages written back, or -ENOENT if @memcg is a
>> + * zombie or has writeback disabled.
>> + */
>> +static long zswap_proactive_shrink_memcg(struct mem_cgroup *memcg,
>> +					 unsigned long nr_to_write)
>> +{
>> +	unsigned long nr_written = 0;
>> +	int nid;
>> +
>> +	if (!mem_cgroup_zswap_writeback_enabled(memcg))
>> +		return -ENOENT;
>> +
>> +	if (!mem_cgroup_online(memcg))
>> +		return -ENOENT;
>> +
>> +	for_each_node_state(nid, N_NORMAL_MEMORY) {
>> +		bool encountered_page_in_swapcache = false;
>> +		unsigned long nr_to_scan, nr_scanned = 0;
>> +
>> +		/*
>> +		 * Cap by LRU length: bounds rewalks when referenced
>> +		 * entries keep rotating to the tail.
>> +		 */
>> +		nr_to_scan = list_lru_count_one(&zswap_list_lru, nid, memcg);
>> +		if (!nr_to_scan)
>> +			continue;
>> +
>> +		/*
>> +		 * Cap by SCAN_RATIO * remaining budget: bounds scan cost
>> +		 * to the remaining writeback budget.
>> +		 */
>> +		nr_to_scan = min(nr_to_scan,
>> +				 (nr_to_write - nr_written) * ZSWAP_PROACTIVE_WB_SCAN_RATIO);
>> +
>> +		while (nr_scanned < nr_to_scan) {
>> +			unsigned long nr_to_walk = min(ZSWAP_PROACTIVE_WB_BATCH,
>> +						       nr_to_scan - nr_scanned);
>> +
>> +			if (signal_pending(current))
>> +				return nr_written;
>> +
>> +			/*
>> +			 * Account for the committed budget rather than the walker's
>> +			 * actual delta. If the list is emptied concurrently, the
>> +			 * walker visits nothing and nr_scanned would never advance.
>> +			 */
>> +			nr_scanned += nr_to_walk;
>> +
>> +			nr_written += list_lru_walk_one(&zswap_list_lru, nid, memcg,
>> +							&shrink_memcg_cb,
>> +							&encountered_page_in_swapcache,
>> +							&nr_to_walk);
>> +
>> +			if (nr_written >= nr_to_write)
>> +				return nr_written;
>> +			if (encountered_page_in_swapcache)
>> +				break;
>> +
>> +			cond_resched();
>> +		}
>> +	}
>> +
>> +	return nr_written;
>> +}
>> +
>> +int zswap_proactive_writeback(struct mem_cgroup *memcg,
>> +			      unsigned long nr_to_writeback)
>> +{
>> +	struct mem_cgroup *iter_memcg;
>> +	unsigned long nr_written = 0;
>> +	int failures = 0, attempts = 0;
>> +
>> +	if (!memcg)
>> +		return -EINVAL;
>> +	if (!nr_to_writeback)
>> +		return 0;
>> +
>> +	/*
>> +	 * Writeback will be aborted with -EAGAIN if we encounter
>> +	 * the following MAX_RECLAIM_RETRIES times:
>> +	 * - No writeback-candidate memcgs found in a subtree walk.
>> +	 * - A writeback-candidate memcg wrote back zero pages.
>> +	 */
>> +	while (nr_written < nr_to_writeback) {
>> +		unsigned long batch_size;
>> +		long shrunk;
>> +
>> +		if (signal_pending(current))
>> +			return -EINTR;
>> +
>> +		iter_memcg = zswap_mem_cgroup_iter(memcg);
>> +
>> +		if (!iter_memcg) {
>> +			/*
>> +			 * Continue without incrementing failures if we found
>> +			 * candidate memcgs in the last subtree walk.
>> +			 */
>> +			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
>> +				return -EAGAIN;
>> +			attempts = 0;
>> +			continue;
>> +		}
>> +
>> +		batch_size = min(nr_to_writeback - nr_written,
>> +				 ZSWAP_PROACTIVE_WB_BATCH);
>> +		shrunk = zswap_proactive_shrink_memcg(iter_memcg, batch_size);
>> +		mem_cgroup_put(iter_memcg);
>> +
>> +		/* Writeback-disabled or offline: skip without counting. */
>> +		if (shrunk == -ENOENT)
>> +			continue;
>> +
>> +		++attempts;
>> +		if (shrunk > 0)
>> +			nr_written += shrunk;
>> +		else if (++failures == MAX_RECLAIM_RETRIES)
>> +			return -EAGAIN;
>> +
>> +		cond_resched();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> There is a lot of copy+paste from shrink_worker() and shrink_memcg()
> here. We really should be able to reuse shrink_memcg().
> 

I will do some consolidation and code reuse in the next version.

> Is the main difference that we are scanning in batches here? I think we
> can have shrink_memcg() do that too. If anything, it might make the
> shrinker more efficient. Over-reclaim is ofc a concern, and especially
> in the zswap_store() path as the overhead can be noticeable. Maybe we
> can parameterize the batch size based on the code path.
> 
> Nhat, what do you think?

Nhat, since we now have the referenced-based second chance algorithm, 
should we consider doing batch writeback for shrink_memcg() as well?

Of course, we could pass a parameter to control whether batch writeback 
is needed, so as to preserve the original behavior of shrink_memcg().

Thanks,
Hao

