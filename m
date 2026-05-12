Return-Path: <cgroups+bounces-15820-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNf6MgLRAmoNxgEAu9opvQ
	(envelope-from <cgroups+bounces-15820-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:04:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592651B705
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3771D30156C2
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 07:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C9379C34;
	Tue, 12 May 2026 07:04:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406B36F8F8;
	Tue, 12 May 2026 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569471; cv=none; b=kVzo9tquYJScLdoe76RlbUuhA+3o/r1T2a5vDRPxkdBiBIVL6zxQAopUzZ0to3RR887/1jOGFHwwVq7L0IcYQ4rQQD+/GEFLgH+v/9yXx6UIms/XIQq4AxU7X9s7fJvEJk7PNJS+CGNkd6tZJjPpdCqbL1B/20fDPQqeMVcRx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569471; c=relaxed/simple;
	bh=KTtb5thfH4uUE2GHg6F5ljRQ3jUQ53dLxuVV8cVqTzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs7/zYWIbAlMwwD++Rwe2lGaKxf8FyYGnDgCp2FH/A5SMn8tCfViBrklNG7lw+A00f1eTUGnr8G8b2mZSZS/xPbqaAX5UAESg0NefMMDQX0igCXORUTFXIM5JlRUmOtTCsJl7jVRJPMrMITTKGPKSZjAjcqYu6aK9kAwfzX7DoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc2a59b24dd011f1aa26b74ffac11d73-20260512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4093d6e2-f795-43de-ac0d-53413b855a41,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:4093d6e2-f795-43de-ac0d-53413b855a41,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:8ff57456ce2fda429fa9dd9b04934a9c,BulkI
	D:260511094702GAMOY1KX,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc2a59b24dd011f1aa26b74ffac11d73-20260512
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 577036597; Tue, 12 May 2026 15:04:19 +0800
Message-ID: <3939a0e6-cf82-432a-b983-2a49496a7acb@kylinos.cn>
Date: Tue, 12 May 2026 15:04:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: return -ENOMEM on failed pool preallocation
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
 <1778555389652035.138.seg@mailgw.kylinos.cn>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <1778555389652035.138.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4592651B705
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15820-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,here.my:url]
X-Rspamd-Action: no action



在 2026/5/11 21:03, Michal Koutný 写道:
> On Mon, May 11, 2026 at 09:31:50AM +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
>> get_cg_pool_unlocked() handles allocation failures under dmemcg_lock by
>> dropping the lock, preallocating a pool with GFP_KERNEL, and retrying the
>> locked lookup and creation path.
>>
>> If the fallback allocation fails too, pool remains NULL. Since the loop
>> condition is while (!pool), the function can keep retrying instead of
>> propagating the allocation failure to the caller.
> 
> This implies that it's OK when the function keeps retrying with
> allocpool != NULL (and repeated WARN_ON()s)?
Hi Michal,

Thanks for taking a look.

No, that was not what I meant to imply. The commit message was not precise
enough there.

The intended normal retry is only for the case where the GFP_NOWAIT
allocation under dmemcg_lock fails. In that case, get_cg_pool_unlocked()
drops the lock, preallocates one pool with GFP_KERNEL, and the next locked
retry consumes that preallocated pool and clears allocpool.

So allocpool != NULL together with another -ENOMEM return is not expected to
be a normal retry path. The WARN_ON(allocpool) branch looks defensive, and I
agree that repeatedly continuing from there would not be useful if it ever
fired.

>> Set pool to ERR_PTR(-ENOMEM) when the fallback allocation fails so the
>> loop exits through the existing common return path. The callers already
>> handle ERR_PTR() from get_cg_pool_unlocked(), so this restores the
>> expected error path.
> 
> If the callers can handle it, maybe there's no need to retry at all.
> Perhpas dmem fellows can step in here.My understanding is that the retry still has a purpose independent of the
callers' ability to handle ERR_PTR().

The first allocation attempt happens in alloc_pool_single() while
dmemcg_lock is held, so it uses GFP_NOWAIT. If that fails,
get_cg_pool_unlocked() drops the lock and preallocates one pool with the
default GFP_KERNEL context. The next locked retry then consumes that
preallocated pool instead of trying another GFP_NOWAIT allocation for that
pool.

So callers can handle the final ERR_PTR() result, but the fallback
preallocation gives the allocation a chance to succeed in a less
constrained context before reporting -ENOMEM. That said, whether this
retry policy is desirable is a dmem design question, so input from dmem
folks would be helpful.

>>
>> Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>>  kernel/cgroup/dmem.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>> index 1ab1fb47f271..4753a67d0f0f 100644
>> --- a/kernel/cgroup/dmem.c
>> +++ b/kernel/cgroup/dmem.c
>> @@ -602,6 +602,7 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
>>  				pool = NULL;
> 
> This 2nd pool zeroing seems pointless.
Agreed. 

Since Tejun has already applied the fix, I will wait for the discussion
before sending any follow-up. If we keep the current retry scheme, a small
cleanup can make this path clearer.

Thanks,
Guopeng


