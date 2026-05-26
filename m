Return-Path: <cgroups+bounces-16289-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM4NEz4zFWqBTgcAu9opvQ
	(envelope-from <cgroups+bounces-16289-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 07:44:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F345D0EA1
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 07:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C82301D6BD
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224903BF667;
	Tue, 26 May 2026 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq04UDJh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92AE3AC0D7;
	Tue, 26 May 2026 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774266; cv=none; b=S5F9/EMBTeeMyGuIrrJsGBAiEcIA0+9cih68OCBic0GDhzr6PihAEqrEgIr3muoZcs0h7lhJPebYwhGqlz5m170uhC/8ofIG8Zx380auLl0O/8/eItcQone+T3LkxpcFpMOr1f+G1WRHxYqHdq5SfBTccZIQX9isLeHHSD7xi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774266; c=relaxed/simple;
	bh=6wqgINfsAdR/z7Yl9b3319gY8kjh/uhm+d3m9EjO+kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdyYBOQyGTnq+WxifRVDJPQKZ+hPsUbv0QQiPvoiPHqyWwmPS9U5bi4+DafLPcsyVzHoDnl/RS0G+Rrdw3uajY88C3V9lJmI00ZPmLA/r8EfFh/0TSoIuT7W3YnS4MLt+foEn15ioJtlieg5U8ZYqadMRDb2eb4jE9+tcBTihqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq04UDJh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A101F000E9;
	Tue, 26 May 2026 05:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779774265;
	bh=3LOeGxgwB1u3VB8Q18Mmd6WSv8GQDWdxyl8YN5KUzh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nq04UDJhGT7I6ZyKgOKhlOU2vI2Gz8n1X0V80IftTAF9gZBfmk28aGNvgAY1ORehc
	 ruai1IVtmqjSfo44/I6fbdYOVqpxvL+1929F5bp1/pH5HYB3dOqwRW7YWBlpTOVjyt
	 8TliOeKRU+O/WTWqVT4z5hc+y7AyMshF35rVTpH0x+ZpyE5a+suLLpewyvEifFzACp
	 rU8QFbyPKrBaaJcCPQlDWVc9MeKngzVq7hNWy8dgW850yXHMVCY52QGHPMnYmbY/ih
	 0Sl+VdkCyjtMfLnrQGD9BsQGy5/Oy22bFsOQAeIubfXGS4Okcc5wblSAzY9djw9tE9
	 J/epgrSL3JDSg==
Message-ID: <a3c9c8df-5836-4467-a3ce-a8142b754547@kernel.org>
Date: Tue, 26 May 2026 14:44:21 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] memcg: multi objcg charge support
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 David Laight <david.laight.linux@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260526033931.1760588-1-shakeel.butt@linux.dev>
 <20260526033931.1760588-5-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260526033931.1760588-5-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16289-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6F345D0EA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 12:39 PM, Shakeel Butt wrote:
> Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> per-node type") split a memcg's single obj_cgroup into one per NUMA
> node so that reparenting LRU folios can take per-node lru locks. As a
> side effect, the per-CPU obj_stock_pcp -- which caches exactly one
> cached_objcg -- thrashes on workloads where threads of the same memcg
> run on different NUMA nodes. The kernel test robot reported a 67.7%
> regression on stress-ng.switch.ops_per_sec from this pattern.
> 
> Mirror the multi-slot pattern already used by memcg_stock_pcp: turn
> nr_bytes and cached_objcg into NR_OBJ_STOCK-element arrays, scan all
> slots on consume/refill/account, prefer empty slots when inserting,
> and evict a random slot only when full. With multiple slots a CPU can
> hold the per-node objcg variants of one memcg plus a few siblings
> without ever forcing a drain.

nit: evict a random slot -> evict a slot round-robin
> A single int8_t index records which slot the cached slab stats belong
> to; the stats are flushed on slot or pgdat change. With NR_OBJ_STOCK
> = 5 the layout (verified with pahole) is:
> 
>    offset 0  : lock(1) + index(1) + node_id(2) + slab stats(4) = 8B
>    offset 8  : nr_bytes[5]                                     = 10B
>    offset 18 : padding                                         = 6B
>    offset 24 : cached[5]                                       = 40B
>    offset 64 : (line 2) work_struct + flags (cold)
> 
> so consume_obj_stock, refill_obj_stock and the slab account path each
> touch exactly one 64-byte cache line on non-debug 64-bit builds.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon


