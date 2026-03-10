Return-Path: <cgroups+bounces-14731-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JnEFfjtr2nkdAIAu9opvQ
	(envelope-from <cgroups+bounces-14731-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 11:10:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9119A249251
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 11:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2199A30928C1
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D844BCAE;
	Tue, 10 Mar 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mffQwmEU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4942B728;
	Tue, 10 Mar 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137208; cv=none; b=GqawTLQP+pGf6SCujERnqmBicJCAyDQ5oBrPXlsnuRzmdNRf1l/hc+sDRoYhm/NDou8TWqCk8TBo6G18GirVt4ucOFPGq7+cnR1NPFnWD/EiRcqmss0g1b4ey9XKUzEqW07pI1i29ME/o+e4chEJASSQRi4SM4eIOFsBArtdgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137208; c=relaxed/simple;
	bh=W4CTub0Sa88sKKNCsV7akuk2L56fgLFSCEVuVsLi5N4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZqN3115qAUb4LpN9TNKZvEc8L6KQCpnZ8zokn0uiCaB273e6IYhZLIW3KzUK+6a/gMF8oaFCLLT2c5f3kMuMMsc2ypVoVobCPwHHM27TQt5wjfAczVsw2RIJeWrtSSeGzcsYo8lEBSDr8aTbwd4Ut59wv99NYuFtueuR4nGSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mffQwmEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF4C19423;
	Tue, 10 Mar 2026 10:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137208;
	bh=W4CTub0Sa88sKKNCsV7akuk2L56fgLFSCEVuVsLi5N4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=mffQwmEUr06v4k/y5Wr5pQqSjZjrr3p5wQsKp12EJx7cBlr2cCr+KXTspy1x0Rdhk
	 6TOCiBL89tbh/AEp9qlvqto4iIivLN/Dg6/zA9QZx9tP6EzutiQUE6WWV1Wzl9WUqQ
	 cfoJ986b8ifQjBR+0WqZa3y18URtV4iST9OLW6arc8PTOwTc8jMLb804uaJlz9e/8r
	 gmmCxhRShwL9bEFoUqqlEurRfx8/uugM52V2h20qIkYK55n/RD+iuWGC4cp6jdgIUp
	 CF6QrzDR/92ko7b/TcgATw438hSMtsHagIVeDTuUDj3VtP0qxaFtGHesoiuyxgwwki
	 c0tSgtW0pF2GA==
Message-ID: <a61a876d-6377-4e7a-9651-e0fc05819a72@kernel.org>
Date: Tue, 10 Mar 2026 11:06:42 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: vbabka@kernel.org
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, shicenci@gmail.com,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 viro@zeniv.linux.org.uk, surenb@google.com, stable@vger.kernel.org
References: <aa5NmA25QsFDMhof@hyeyoo>
 <20260309072219.22653-1-harry.yoo@oracle.com>
 <0a25d83b-c6ea-4230-a89d-1f496b91764c@kernel.org> <aa-PQBn5d0-U-sKg@hyeyoo>
In-Reply-To: <aa-PQBn5d0-U-sKg@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9119A249251
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14731-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,linux-foundation.org,vger.kernel.org,cmpxchg.org,linux.dev,kvack.org,gmail.com,gentwo.org,google.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 04:25, Harry Yoo wrote:
> On Mon, Mar 09, 2026 at 03:00:17PM +0100, vbabka@kernel.org wrote:
>> On 3/9/26 08:22, Harry Yoo wrote:
>> > obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
>> > array from the same cache, to avoid creating slabs that are never freed.
>> > 
>> > There is one mistake that returns the original size when memory
>> > allocation profiling is disabled. The assumption was that
>> > memcg-triggered slabobj_ext allocation is always served from
>> > KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
>> > both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
>> > allocation is served from normal kmalloc. This is because kmalloc_type()
>> > prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
>> > KMALLOC_RECLAIM with KMALLOC_NORMAL.
>> 
>> Hm that's suboptimal (leads to sparsely used obj_exts in normal kmalloc
>> slabs) and maybe separately from this hotfix we could make sure that with
>> SLUB_TINY, __GFP_ACCOUNT is preferred going forward?
> 
> To be honest, I don't a have strong opinion on that.
> 
> Is grouping by mobility (for anti-fragmentation less) important on
> SLUB_TINY systems?

Yeah, that's why "KMALLOC_RECLAIM = KMALLOC_NORMAL" there. So prioritizing
__GFP_RECLAIMABLE does nothing there, it goes to the same kmalloc_normal
cache. It only results in ignoring KMALLOC_CGROUP.
(I think in practice SLUB_TINY systems wouldn't enabled CONFIG_MEMCG either,
so it's a low priority, but still logical imho).

>> > As a result, the recursion guard is bypassed and the problematic slabs
>> > can be created. Fix this by removing the mem_alloc_profiling_enabled()
>> > check entirely. The remaining is_kmalloc_normal() check is still
>> > sufficient to detect whether the cache is of KMALLOC_NORMAL type and
>> > avoid bumping the size if it's not.
>> > 
>> > Without SLUB_TINY, no functional change intended.
>> > With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
>> > now allocate a larger array if the sizes equal.
>> > 
>> > Reported-by: Zw Tang <shicenci@gmail.com>
>> > Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from its own slab")
>> > Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
>> 
>> Added to slab/for-next-fixes, thanks!
> 
> Thanks!
> 


