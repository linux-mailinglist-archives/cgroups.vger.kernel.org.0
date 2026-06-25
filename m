Return-Path: <cgroups+bounces-17285-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vu+xFkQBPWqsvggAu9opvQ
	(envelope-from <cgroups+bounces-17285-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 12:21:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E546C6C49DB
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 12:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17285-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17285-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA43302F5AC
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1773CFF4A;
	Thu, 25 Jun 2026 10:21:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177693812CD;
	Thu, 25 Jun 2026 10:21:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382885; cv=none; b=hBBhQPDJsWAeTchUZQajTQmc4lb1w9HFv2O9O/nRYTzrKCzXS3Ilt9fcBr7b/WkpuvR7aZ/JU/lU/kyYnZ4zsohEsIWJ2MpWrMrbzwSorD/P8k/u58AvobPMlyXqPrTTRnQ4/U9ju4nk7TMwoOdJYX7323z5Fn2gr6/93vi5Y2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382885; c=relaxed/simple;
	bh=HclDAl9w7nD13+rfBStpPxKU94inq+mAd27AU3ktHDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7FxuQ1xIKC7Tk5hHRGr5OQjRRanCih64MwHC7PgANDiU39Wzif9aGMpWR79C//9yqJck7+337esFLAnV/8e7zjVtJWKw5zxJbGi23v4lMpEzI0r85/p8P5h/T3CBqZ20uUh03iodL6kXq1OvioyyClIfSX9cym1F/FES0yfXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 99c25ac0707f11f1aa26b74ffac11d73-20260625
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0080bd47-685c-4fc7-9089-0ad4c452358a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:0080bd47-685c-4fc7-9089-0ad4c452358a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:429edb8e878399609e86c16f6629f87f,BulkI
	D:260624112706YSGBNPCQ,BulkQuantity:7,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:
	nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:
	0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 99c25ac0707f11f1aa26b74ffac11d73-20260625
X-User: lihongfu@kylinos.cn
Received: from [192.168.109.123] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1977568665; Thu, 25 Jun 2026 18:21:16 +0800
Message-ID: <c645a8df-1d76-4e4d-bb97-47c539f7a205@kylinos.cn>
Date: Thu, 25 Jun 2026 18:21:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
To: Natalie Vock <natalie.vock@gmx.de>, tj@kernel.org
Cc: cgroups@vger.kernel.org, corbet@lwn.net, dev@lankhorst.se,
 dri-devel@lists.freedesktop.org, hannes@cmpxchg.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
 mripard@kernel.org, skhan@linuxfoundation.org, hongfu.li@linux.dev
References: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
 <20260625021053.488107-1-lihongfu@kylinos.cn>
 <b549422c-7c35-434d-ad4a-49a4676970ac@gmx.de>
From: Hongfu Li <lihongfu@kylinos.cn>
In-Reply-To: <b549422c-7c35-434d-ad4a-49a4676970ac@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:natalie.vock@gmx.de,m:tj@kernel.org,m:cgroups@vger.kernel.org,m:corbet@lwn.net,m:dev@lankhorst.se,m:dri-devel@lists.freedesktop.org,m:hannes@cmpxchg.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mkoutny@suse.com,m:mripard@kernel.org,m:skhan@linuxfoundation.org,m:hongfu.li@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17285-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dmem.events:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E546C6C49DB

Hi,

On 6/25/26 4:57 PM, Natalie Vock wrote:
> Hi,
>
> On 6/25/26 04:10, Hongfu Li wrote:
>> Hi, Tejun
>> Thanks for the review comments.
>>
>>>> Add dmem.events to report hierarchical low/max event counts per DMEM
>>>> region.  Increment counters on dmem.max allocation failures and
>>>> dmem.low protection events.  The file is available for non-root 
>>>> cgroups
>>>> only.
>>>
>>> Please don't double space in descs or comments. Also, maybe it's 
>>> obvious but
>>> it'd help if you list why and how this is useful. Why do we want to add
>>> this?
>>
>> I'll fix the double spacing in the commit message and comments.
>>
>> As for the motivation: dmem already exposes per-region limits and 
>> current
>> usage, but not how often those limits actually matter at runtime. 
>> Without
>> event counters, it's hard to tell whether allocation failures come from
>> this cgroup, a parent limit, or pressure elsewhere in the hierarchy.
>> dmem.events provides that visibility for tuning dmem.low/dmem.max and
>> diagnosing recurring device memory pressure.
>
> Shouldn't you be able to deduce this rather trivially from just 
> looking at the current usage together with the low/max limits you 
> already set? I'm not sure I really see anything this events file 
> provides that analysis of current usage and set limits doesn't? If 
> your usage is highly variable, the separately-developed dmem.peak file 
> might also suit your needs, but still, not sure what you can do with 
> dmem.events that you can't already do with these tools. 
Thanks for the question.

Besides exposing counters, dmem.events notifies userspace on changes via
cgroup_file_notify(). This allows tools to monitor limit-related events
(for example, allocation failures or low-protection fallbacks) 
asynchronously,
without the need to periodically poll dmem.current against the limits. 
While
you could infer some conditions from current usage and limits, polling is
inefficient and cannot capture transient events in real time. dmem.peak only
records the highest usage, not these specific events.

So dmem.events provides both lower overhead and richer, actionable 
information.

Best regards,
Hongfu




