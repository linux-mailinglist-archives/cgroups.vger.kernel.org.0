Return-Path: <cgroups+bounces-15958-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OlTGttuBmqFjgIAu9opvQ
	(envelope-from <cgroups+bounces-15958-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 02:54:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01201548373
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 02:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B40E6307E499
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937F361DB5;
	Fri, 15 May 2026 00:49:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405E367F2E
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806161; cv=none; b=f/DNm10caXEyZYmiy+QeREcbR1ixfrmW278edXlyMsMw9lEox0ZCh1N2+r59oEB00qvJ4DoIDItIgC8yYiNcWzliR5BVAtGamXC0aUs9ITBMcUTGSExmL9yUFQtRCG0G7dkyyO0j3837eKexpgWv4kskIVZHg2yD+qyjR3X2X9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806161; c=relaxed/simple;
	bh=mbosFEBxCA4Xh/6AZGkwurdKo8PPMtDwxwIbWYlSx+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo3iZAOpa4kTlpkLwj37TKsHa+TLFCwaPNXN/MIk9CSFJHynH3PwcxRXRSRAlBZ5OAd7YOjLHK1ze6CzHsUPvb4ZvxtTlCaZixOJwkD5MZWdgy2oirNiSWwUQxSXqQJCodFWZ101L882SY1Sv8iUfzhf6kKXde0vZXZpvVvYi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e429ab7a4ff711f1aa26b74ffac11d73-20260515
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5ffe5130-a28a-493a-9962-8e7fe0022a7b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:5ffe5130-a28a-493a-9962-8e7fe0022a7b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d8ab2f6064ca9085b30c6d9bb3fb9e9f,BulkI
	D:260515052705WKFGLB18,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e429ab7a4ff711f1aa26b74ffac11d73-20260515
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 103907716; Fri, 15 May 2026 08:49:12 +0800
Message-ID: <e3c8d6d5-58d4-46b7-9455-f8fd70ed3c96@kylinos.cn>
Date: Fri, 15 May 2026 08:48:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] cgroup/rdma: add rdma.peak and rdma.events[.local]
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
References: <20260514065034.387197-1-cuitao@kylinos.cn>
 <1d47de9b305b1576a24c242aa9e72c28@kernel.org>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <1d47de9b305b1576a24c242aa9e72c28@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01201548373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:mid];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15958-lists,cgroups=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Action: no action

Hello，

在 2026/5/15 5:26, Tejun Heo 写道:
> 
> One follow-up: the new event counters use READ_ONCE() on reads but plain
> ++ on writes, and all accesses are under rdmacg_mutex. Please send a
> follow-up patch dropping the READ_ONCE()s.
> 

Thanks for your suggestions and help throughout this process. 
I will handle the follow-up on my side later.

Thanks.

--
Tao

