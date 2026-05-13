Return-Path: <cgroups+bounces-15866-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMHEHlHZA2pb/QEAu9opvQ
	(envelope-from <cgroups+bounces-15866-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 03:52:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4452C151
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 03:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810AB300F5DD
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 01:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266837FF5D;
	Wed, 13 May 2026 01:52:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA437FF58
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637133; cv=none; b=XgUR2eX8CrRxfw4P/aXwGY3qUa9N551Hm4a/tgx2vqrtKaEvLhgoGEo08VJ4zgf4ZtudoGm4MnP+9/07LmwJjMpCgYrZkZeT9kuFji6UJNnqDSqLCN0gbvRuEMUfjmRLxUugj2iJtj2y9iD7h247Lw+fu72zuGYQxMqX4TZI2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637133; c=relaxed/simple;
	bh=WEnlrS+931W84oA/afazsQPtzU3A5q9ko+qL5Ltqhxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFV3Iq0FkN93KkeBxmxgGXnIe9e+e9jXQkouRYZyeGiA8TW9J6NLMBm+vrc3MAtkyVe7dAOaz4ex/whgQ12jCf9XYROKxZHw3MpH7Qj6YOARyFEhU2t2pWNVWzI2iX6wPaRzmpbvPLvcHCZnJGwRm6UmbK7RkcI3oCrWbkzqOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 55ae829c4e6e11f1aa26b74ffac11d73-20260513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0b825f2a-43a0-40d7-a651-263fef7ba5c7,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:0b825f2a-43a0-40d7-a651-263fef7ba5c7,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:1774781ec4b5c16b98f4126ded248014,BulkI
	D:260513014910XX1R3MJF,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 55ae829c4e6e11f1aa26b74ffac11d73-20260513
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1530762897; Wed, 13 May 2026 09:52:01 +0800
Message-ID: <eb658ab5-490c-47b1-8e94-427e2404848e@kylinos.cn>
Date: Wed, 13 May 2026 09:51:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cgroup/rdma: add rdma.peak and rdma.events[.local]
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
References: <20260512031719.273507-1-cuitao@kylinos.cn>
 <8545cad8e29f27e927e76c7bbe1334ea@kernel.org>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <8545cad8e29f27e927e76c7bbe1334ea@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CFB4452C151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.992];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15866-lists,cgroups=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Action: no action

Hello，tejun

Thank you very much for your review.

在 2026/5/13 1:49, Tejun Heo 写道:
> * Patches 2 and 3 don't extend the rpool-free condition in
>   uncharge_cg_locked() and rdmacg_resource_set_max() to the new event
>   counters, so a "set limit -> hit limit -> uncharge to 0 -> write
>   'max max'" sequence frees the rpool and zeros the counts.
> 
The rpool-free condition in both uncharge_cg_locked()
and rdmacg_resource_set_max() only checks peak but misses the event
counters (events_max, events_local_max, events_fail).  This means a
non-zero event counter can be silently discarded when the rpool is
freed.  I'll add a helper that checks all persistent data (peak +
event counters) and use it in both sites.

> * rdmacg_event_locked() creates rpools in ancestors of over_cg via
>   get_cg_rpool_locked() just to host event counters. Those rpools have
>   usage_sum==0, num_max_cnt==max, peak==0, so the next real uncharge
>   through any such ancestor frees them.
> 
Agreed.  Using get_cg_rpool_locked() in the propagation loop was wrong
-- it allocates rpools in ancestors that never had any resource
configuration for the device, just to hold an event counter.  These
empty rpools then get freed on the next uncharge, losing the event
data.  I'll switch to find_cg_rpool_locked() so events are only
recorded in rpools that already exist.

> * Patch 3 says failcnt covers "this cgroup (or its descendants)" but
>   the code only increments the directly-requesting cgroup. Either the
>   description or the propagation is wrong.
> 
The description is wrong.  The code only increments failcnt in the
directly-requesting cgroup, not in its ancestors, which is consistent
with how pids.events.local tracks local attribution.  I'll fix the
commit message to say "originating from this cgroup" instead of
"originating from this cgroup or its descendants".

> * rdma.events / rdma.events.local print "mlx4_0 hca_handle.max 5
>   hca_object.max 0 " (trailing space). That doesn't match any of the
>   formats in Documentation/admin-guide/cgroup-v2.rst. rdma.current and
>   rdma.max are nested-keyed; the new files should be too:
>   "mlx4_0 hca_handle.max=5 hca_object.max=0".
> 
Will fix.  I'll switch to the nested-keyed format with '=' and remove
the trailing space so the output matches rdma.max / rdma.current:

    mlx4_0 hca_handle.max=5 hca_object.max=0

> * Please document rdma.peak / rdma.events / rdma.events.local in
>   Documentation/admin-guide/cgroup-v2.rst.
> 
Will add in the next revision.

> * "failcnt" is cgroup-v1 vocabulary; pids.events.local uses
>   "fork_fail" for the same role.
> 
Agreed.  I'll rename "failcnt" to "fail" to follow the cgroup-v2
naming convention.

> * Event counters are atomic64_t but all updates are under
>   rdmacg_mutex. Plain u64 with READ_ONCE on the read side would do.
> 
I also noticed this.  I have a version using plain u64 with READ_ONCE
on the read side, and it is currently being tested locally.  Since the
change touches a hot path in the charge/uncharge code, I want to be
cautious and verify that there are no regressions before sending it
out.

> * Patch 1 reflows an unrelated comment ("No user of the rpool ...");
>   please drop the churn.
> 
Sorry for the noise.  I'll revert the comment reflow and keep the
original formatting.

I'll send v2 with all the fixes above.  Thank you for the thorough
review.

Thanks.

--
Tao

