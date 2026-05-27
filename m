Return-Path: <cgroups+bounces-16347-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGUbEZrVFmrrtAcAu9opvQ
	(envelope-from <cgroups+bounces-16347-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 13:29:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA75E362F
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 13:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C3E301FFB7
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06253F44E7;
	Wed, 27 May 2026 11:29:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777E3F6612;
	Wed, 27 May 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881357; cv=none; b=KZhCEL5cbUPQU9XX6nsDCXzDLzX7dvZvxX7ZV56ggB2ofI0v0fcD2WDAu2OoLPhYGG+dwtX3EoOfDaNNBkgba2KmWKeVWCdmCZHaVmb2TlURyR/p4c4rPJlRleQep5wAclY0YBVzFD10Of3ZG21+Ly5OBN6hXsk6X2cvVl12GYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881357; c=relaxed/simple;
	bh=CW32DMHVWpKDUREY1Ypc7jpVVUakxZHxNyI1UG8h/qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6a9HNhzgdYmqDB3pJ9ITCip2U/ATQlE6SjYrXBwZwL7tGZ95Xv+kbg/H6kzuhfkRA33t4FGKQQDjx+YIwRgdJ8XtZU3/Aa+3wJGm3yHgTB85W7QVSrAhe0Jf9vrzWPupQa5hpFgHyOPID4ZkQC2Rlt/nLCeJHzOP3Sde+JfxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 44a0520859bf11f1aa26b74ffac11d73-20260527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a88806d2-6fd2-4be2-b8c2-ff227b6ea4d7,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.12,REQID:a88806d2-6fd2-4be2-b8c2-ff227b6ea4d7,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:5249803a452c7fcf2f412865bf14f2a6,BulkI
	D:260525214329UXPT78B0,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 44a0520859bf11f1aa26b74ffac11d73-20260527
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1566285210; Wed, 27 May 2026 19:29:05 +0800
Message-ID: <b8269d9b-bd14-4ba1-be60-a210a9a1d093@kylinos.cn>
Date: Wed, 27 May 2026 19:28:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH rdma-next 0/5] cgroup/rdma: add per-type resource
 accounting for QP, MR and MR memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, leon@kernel.org,
 linux-rdma@vger.kernel.org, cgroups@vger.kernel.org
References: <20260525055506.2002985-1-cuitao@kylinos.cn>
 <20260525134314.GI7702@ziepe.ca>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260525134314.GI7702@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16347-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 9ACA75E362F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,Jason

Thanks for the review.

在 2026/5/25 21:43, Jason Gunthorpe 写道:
> 
> I would agree to mr_mem as a reasonable extension, but not splitting
> out objects to finer grains. There are endless objects we don't want a
> 100 different cgroup knobs, it is not usable.
> 

Understood.  Our initial motivation was
multi-tenant isolation: a tenant could consume disproportionate
resources by creating many objects of a single type.  In hindsight,
though, the real bottleneck is pinned memory, not object counts —
modern hardware has large object pools, and the scarce resource is
how much physical memory gets registered through MRs.  mr_mem
addresses that directly, while hca_object remains sufficient for
coarse object accounting.

I'll send a v2 shortly that removes the qp and mr counters entirely
and retains only mr_mem.

---
Tao


