Return-Path: <cgroups+bounces-15735-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNedKGupAWqFhgEAu9opvQ
	(envelope-from <cgroups+bounces-15735-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:03:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA4C50B814
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BF24300B9F9
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0523C3448;
	Mon, 11 May 2026 09:54:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07583C3437;
	Mon, 11 May 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493240; cv=none; b=qCg1+esBTGzYKPtabVDAApSuyfS9psrzY+lZ32nRQoSl7uRSRurg8TE2Qbov/oll42ElgtGSFMeEPgu/hOTeD8n9ajJd38nltbgpSUAokSE+Bkr/hpOUpn7oqZZJCfRAR9KuiB6OtZ3oaRVA5b3L57MfXKbOgtS3c8lHeQe9FGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493240; c=relaxed/simple;
	bh=cmWrDiLTHn6V2S/BesPKUxTl65oTJ2pEmjeNEWXvBhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeeItauWZbKFaoZRdsLP/BmogrrPnW3cYpkD0gp7pAPxYIzo9ik1nCNQJrJsP49O/E7F8jN8HLMojxObb83rdtJl9x0r552azTjsdlievVMC2fuBZDRsQobZE3ys5jrnYqPHIZHBCAJP9INdohPtk/bDfI9/WojwCGLS+QzEBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 507751004d1f11f1aa26b74ffac11d73-20260511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9b45b3e7-bec6-4870-a454-d56941a371b6,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:9b45b3e7-bec6-4870-a454-d56941a371b6,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:be9e06d65ebb4ecc562e8d14fc3c251f,BulkI
	D:260511165634CUKTNEF5,BulkQuantity:3,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 507751004d1f11f1aa26b74ffac11d73-20260511
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 514874990; Mon, 11 May 2026 17:53:51 +0800
Message-ID: <85eaa9ae-1558-41a8-bf12-999a9b44bfa9@kylinos.cn>
Date: Mon, 11 May 2026 17:53:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Keep favordynmods enabled once per-threadgroup
 rwsem is active
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Yi Tao <escape@linux.alibaba.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511081607.83490-1-zhangguopeng@kylinos.cn>
 <22d91fdc-db54-4bcf-bc5a-2a496cc43057@huaweicloud.com>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <22d91fdc-db54-4bcf-bc5a-2a496cc43057@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AAA4C50B814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15735-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action



在 2026/5/11 17:05, Chen Ridong 写道:
> 
> 
> On 2026/5/11 16:16, Guopeng Zhang wrote:
>> cgroup_enable_per_threadgroup_rwsem is a one-way switch. Once it is
>> enabled, cgroup.procs writes use the per-threadgroup rwsem and
>> cgroup_threadgroup_change_begin()/end() use the same global state to
>> decide whether to take and release the per-threadgroup rwsem.
>>
>> The disable path warned that the per-threadgroup rwsem mechanism could not
>> be disabled but still called rcu_sync_exit() and cleared
>> CGRP_ROOT_FAVOR_DYNMODS. That partially disabled favordynmods while the
>> global per-threadgroup rwsem mode remained enabled: cgroup.procs writes
>> would continue to use the per-threadgroup rwsem, while
>> cgroup_threadgroup_change_begin()/end() could observe the exited rcu_sync
>> state. The root would also no longer report favordynmods.
>>
>> Make the transition match the documented one-way semantics. Call
>> rcu_sync_enter() only for the first favordynmods enable, and make later
>> disable attempts a no-op after warning once the per-threadgroup rwsem mode
>> has been enabled.
>>
>> Fixes: 0568f89d4fb8 ("cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs")
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>> Manual AB test:
>>
>> Before this patch:
>>   enable favordynmods:
>>     cgroup2 opts: rw,relatime,favordynmods
>>   disable attempt:
>>     cgroup2 opts: rw,relatime
>>   dmesg:
>>     cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled
>>
>> After this patch:
>>   enable favordynmods:
>>     cgroup2 opts: rw,relatime,favordynmods
>>   disable attempt:
>>     cgroup2 opts: rw,relatime,favordynmods
>>   dmesg:
>>     cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled
>>
>>  kernel/cgroup/cgroup.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 6152add0c5eb..fd10fb5b3598 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -1297,14 +1297,13 @@ void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
>>  	 */
>>  	percpu_down_write(&cgroup_threadgroup_rwsem);
>>  	if (favor && !favoring) {
>> -		cgroup_enable_per_threadgroup_rwsem = true;
>> -		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
>> +		if (!cgroup_enable_per_threadgroup_rwsem) {
> 
> Is this branch redundant? I think if (favor && !favoring) alone should suffice —
> or can the outer condition be true twice (i.e., can this block be entered
> multiple times)?
> Hi Ridong,

Thanks for taking a look.

I don't think the inner check is redundant. `favoring` is per-root, while
`cgroup_enable_per_threadgroup_rwsem` is global.

For example, root A may have already enabled favordynmods:

cgroup_enable_per_threadgroup_rwsem = true
rcu_sync_enter(&cgroup_threadgroup_rwsem.rss) has already been called

Then root B may enable favordynmods for the first time:

favoring is false for root B
favor && !favoring is true
but cgroup_enable_per_threadgroup_rwsem is already true

In that case, we only need to set `CGRP_ROOT_FAVOR_DYNMODS` for root B and
should not call `rcu_sync_enter()` again.

That said, Tejun pointed out that the visible flag state is ambiguous either
way after a disable attempt, so please consider this patch withdrawn.
-- 
Best regards,
Guopeng


