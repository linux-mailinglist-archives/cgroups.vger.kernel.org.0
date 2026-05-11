Return-Path: <cgroups+bounces-15734-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEU6GFmoAWrlhQEAu9opvQ
	(envelope-from <cgroups+bounces-15734-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:58:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E515D50B741
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10E17301725B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE243C3433;
	Mon, 11 May 2026 09:53:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB13C277B;
	Mon, 11 May 2026 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493204; cv=none; b=S5yoBB8JwOkak+ew5XFdg1CeCZIu25r6op+htoZYd03rKFyRYvH+m+TeyYlA8HNTd82o0INFv4uucgBc8K48863rnZzAJltm5gBx3etCKUZmIKLy6iQV4Va/Kvrw2HOzABmyQ7VHOjhbE61UuirZkXSgKiNqJ0Mzibr4ZlCvPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493204; c=relaxed/simple;
	bh=9VpFinIDTPRY5uqkktW2MiBKAZ4bKLgAqBz8O/fA1BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV0xAnrgr0gzaJbFzaPH1VMAtsbLI2DIYf0uYx8eBajfXPOcNWuGQMLz1F+HyZzwnBWsFSndPhLoAUEbHTzLEOX/PqdQCMH2epAs0ybW/TrdbN21wAcpz2hMYPJCf1MqN8TzqKDk0nQJWpTeP9BuByf3F0X4uwwYrcFvKnXsTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3bca93344d1f11f1aa26b74ffac11d73-20260511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6461122f-1c81-47e9-8de3-6bf4c6444164,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:6461122f-1c81-47e9-8de3-6bf4c6444164,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:08d0535b453160569fd22b38ed236bf5,BulkI
	D:260511165634CUKTNEF5,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3bca93344d1f11f1aa26b74ffac11d73-20260511
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1195461452; Mon, 11 May 2026 17:53:16 +0800
Message-ID: <d1af3300-fbb5-47f7-8c71-1e91e807006c@kylinos.cn>
Date: Mon, 11 May 2026 17:52:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Keep favordynmods enabled once per-threadgroup
 rwsem is active
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Yi Tao <escape@linux.alibaba.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511081607.83490-1-zhangguopeng@kylinos.cn>
 <8440961feb374c1a7eb6a751d2d9ae0c@kernel.org>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <8440961feb374c1a7eb6a751d2d9ae0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E515D50B741
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15734-lists,cgroups=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action



在 2026/5/11 16:56, Tejun Heo 写道:
> Hello, Guopeng.
> 
> Thanks for the patch.
> 
> I don't think this is worth changing. The mechanism is one-way, so on a
> disable attempt show_options has to lie one way or the other: clear the flag
> and it reports nofavordynmods while per-threadgroup rwsem is still in effect,
> keep the flag and it reports favordynmods after the user asked to turn it
> off. The pr_warn_once is what actually tells the user what happened. Neither
> flag choice is meaningfully better, and the underlying ambiguity is out of
> scope to address here. Without a stronger justification I'd rather leave the
> existing behavior alone.
> 
Hi, Tejun.

Thanks for the explanation.

I see your point. After a disable attempt, either value of the visible
mount option can be misleading, and the warning is what tells the user the
actual state.

Please consider this patch withdrawn.

Thanks,
Guopeng

> Thanks.
> 
> --
> tejun


