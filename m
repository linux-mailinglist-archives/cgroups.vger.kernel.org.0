Return-Path: <cgroups+bounces-15359-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM2BM6d85WnlkQEAu9opvQ
	(envelope-from <cgroups+bounces-15359-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 03:08:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA5425F3A
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 03:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3E8F300A7FC
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C221A453;
	Mon, 20 Apr 2026 01:08:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12E2AF1D
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776647329; cv=none; b=S8rATWD9cU3KO/lTZm+c2TIB4f0smEO3glAKOwbl3HNIQxtJUDQf5Y4JOZaibFpGf9+wlalVNFW5Gm+4ZwN1h2JBOgCp9MJsYC9Iy8bkMKSmsfwycj4ThVpWoFN4wZqEYmVNz2SVRNRBKEwDZk/mYUds2wi4oohyvmiucvab7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776647329; c=relaxed/simple;
	bh=rWtjVYh55h1xvROnqM4+j+HFnnP00N8dnOq29U54mvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh4thLME87rhzCLj7jJxSbw5D4r0RvEnhaz9pphO6ZzGnc9h7LY6O7A+7QzMJpZTcTvLHgOE2vhmriqPuD17wcKVdX51f+fZpdcIgpewzzB48y1QjNzyviVEjX9HzlyRexIlMxveUmnQOg8XQlnJ2RaVUO89lqNopp7JlbmkU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7336900a3c5511f1aa26b74ffac11d73-20260420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7f8f6b3f-5e15-402c-adbc-0183d158ca06,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:7f8f6b3f-5e15-402c-adbc-0183d158ca06,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d5ca6400dc874326a8ab83aa35c93bbd,BulkI
	D:260415213740OXDD663C,BulkQuantity:3,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7336900a3c5511f1aa26b74ffac11d73-20260420
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 562884916; Mon, 20 Apr 2026 09:08:32 +0800
Message-ID: <bb944944-756d-473a-9214-b246c2e4125b@kylinos.cn>
Date: Mon, 20 Apr 2026 09:08:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/rdma: fix strncmp prefix match in parse_resource()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org
References: <20260414020936.306853-1-cuitao@kylinos.cn>
 <hh55ocozzvg6uyfjmwu2hldksmrq33kdqo5hpxi2q4nszztj2s@nmacfk64ks65>
 <7f938823-6b9d-4d40-aedf-d5e9e20e522b@kylinos.cn>
 <t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15359-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCCA5425F3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/17 17:53, Michal Koutný 写道:
> On Fri, Apr 17, 2026 at 02:43:43PM +0800, 崔涛 <cuitao@kylinos.cn> wrote:
>> Test 3: strncmp(value, RDMACG_MAX_STR, strlen(RDMACG_MAX_STR)) — your suggestion
>>
>> echo "... hca_handle=ma hca_object=20" 	→ rejected
>> echo "... hca_handle=maxaa hca_object=20" → accepted (BUG: "maxaa" matches "max")
>> echo "... hca_handle=max     hca_object=20" → rejected
>>
>> The suggested strncmp approach actually introduces a new bug: it would
>> accept "maxaa" as "max" because it only compares the first
>> strlen("max") = 3 characters.
> 
> True, I missed this.
> 
>> The extra spaces create empty sub-tokens that fail earlier in
>> validation, regardless of which comparison method is used.
> 
> Yes, this is suckage too (also in your Test 2 third result).
> 
> As I look around (tg_set_limit, user_proactive_reclaim,
> ioc_cost_model_write), this would be most cleanly tackled with a
> match_table_t and match_token().
> 
> WDYT?
> 
I’ve also gone through the relevant code of tg_set_limit, user_proactive_reclaim and ioc_cost_model_write. Let me have a go at implementing it this way.

Thanks,
cuitao
> Thanks,
> Michal


