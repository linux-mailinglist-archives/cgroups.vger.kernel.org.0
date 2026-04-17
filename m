Return-Path: <cgroups+bounces-15341-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CExNHbrW4WkVywAAu9opvQ
	(envelope-from <cgroups+bounces-15341-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 08:44:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF9417832
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 08:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 962DC3019FDB
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E893334C1C;
	Fri, 17 Apr 2026 06:44:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0C3B2AA
	for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408240; cv=none; b=LZwlLW7mMiGdk1Gthvku7bib/Q+TeZri7WMgLYMUrNNaN477XMuRnXXVJfnOe6WG9yld9d7bMF82AO01QL5sdE7YV/QAs9djPzent7nN4NRtC7AZp8rbc2YZlZGEJsTChEt9DifoT0fM/Juku8WagDRh7IbAMyePyRq/3gi7aN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408240; c=relaxed/simple;
	bh=XxU1lG0H0VT3E0p3fvDzVfk0t57feDPzlbqkIKRBI4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl/6gyNmU2NHPuO1WjxVhs3jgdspNOP1tKbPVjNpaFfPUUYS0zJaNmtCf87LLU91bTljiYdqWV0xFrAoWYMIkqK2cqrYLhYhI2k1xEILNdjykNeFPcVWOAr2lI9LGsRbkIEYF9AvVzJLqLg9u9sGYZHt6HiFQaWnaFaiwhUeu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9f8e6923a2811f1aa26b74ffac11d73-20260417
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:992794ea-b7d3-4d09-90f1-d863dff4d384,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:992794ea-b7d3-4d09-90f1-d863dff4d384,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:6fc43137d33ea2745b81e61a536961ef,BulkI
	D:260415213740OXDD663C,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|124|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9f8e6923a2811f1aa26b74ffac11d73-20260417
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1500427146; Fri, 17 Apr 2026 14:43:48 +0800
Message-ID: <7f938823-6b9d-4d40-aedf-d5e9e20e522b@kylinos.cn>
Date: Fri, 17 Apr 2026 14:43:43 +0800
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
From: =?UTF-8?B?5bSU5rab?= <cuitao@kylinos.cn>
In-Reply-To: <hh55ocozzvg6uyfjmwu2hldksmrq33kdqo5hpxi2q4nszztj2s@nmacfk64ks65>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15341-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: 97FF9417832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/15 21:37, Michal Koutný 写道:
> Hello.
> 
> On Tue, Apr 14, 2026 at 10:09:36AM +0800, cuitao <cuitao@kylinos.cn> wrote:
>>  	}
>> -	if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
>> +	if (strcmp(value, RDMACG_MAX_STR) == 0) {
> 
> Have you tested this? (When 'max' isn't the last assignment.)
Yes, I have tested this. Thank you for raising a valid concern about the parsing context. However, after investigation and testing, I believe strcmp is still the correct approach. Let me explain with test results from three kernel versions:

Test 1: Original code（mainline) — strncmp(value, RDMACG_MAX_STR, strlen(value))

echo "... hca_handle=ma hca_object=20"	 → accepted (BUG: "ma" matches "max")
echo "... hca_handle=maxaa hca_object=20" → rejected
echo "... hca_handle=max     hca_object=20" → rejected

Test 2: strcmp(value, RDMACG_MAX_STR) — this commit

echo "... hca_handle=ma hca_object=20" 	→ rejected
echo "... hca_handle=maxaa hca_object=20" → rejected
echo "... hca_handle=max     hca_object=20" → rejected

Test 3: strncmp(value, RDMACG_MAX_STR, strlen(RDMACG_MAX_STR)) — your suggestion

echo "... hca_handle=ma hca_object=20" 	→ rejected
echo "... hca_handle=maxaa hca_object=20" → accepted (BUG: "maxaa" matches "max")
echo "... hca_handle=max     hca_object=20" → rejected

The suggested strncmp approach actually introduces a new bug: it would accept "maxaa" as "max" because it only compares the first strlen("max") = 3 characters.
> 
> That value/c string is taken out of the whole line (see
> rdmacg_parse_limits), so it wouldn't be necessarily equal to
> RDMACG_MAX_STR. So bounded compare is still somewhat needed:
> 
> 	if (strncmp(value, RDMACG_MAX_STR, strlen(RDMACG_MAX_STR)) == 0) {
> 
Regarding the concern that value might not be exactly "max" when it's not the last assignment — the "max + extra spaces" test above demonstrates that rdmacg_parse_limits() uses strsep(&options, " ") to split the input by spaces, so by the time parse_resource() receives the value, it is already a clean NUL-terminated token. The extra spaces create empty sub-tokens that fail earlier in validation, regardless of which comparison method is used. So the value passed to the max-check is always either exactly "max", a number, or an invalid string — never "max" with trailing content from a subsequent assignment.

Therefore, an exact string match with strcmp is both correct and sufficient.

[  383.716179] rdmacg: set_max: raw input='rocep1s0f0 hca_handle=max   hca_object=20'
[  383.716184] rdmacg: set_max: dev_name='rocep1s0f0', options='hca_handle=max   hca_object=20'
[  383.716185] rdmacg: parse_limits: token='hca_handle=max'
[  383.716188] rdmacg: parse_resource: 'hca_handle'=max (ok)
[  383.716189] rdmacg: parse_limits: token=''
[  383.716189] rdmacg: parse_resource: missing name or value (input='')
[  383.716198] rdmacg: parse_limits: failed on token '' (err=-22)
[  383.716199] rdmacg: parse_limits: failed (err=-22)
[  383.716200] rdmacg: set_max: parse_limits failed (err=-22)
[  499.213562] rdmacg: set_max: raw input='rocep1s0f0 hca_handle=max hca_object=20'
[  499.213566] rdmacg: set_max: dev_name='rocep1s0f0', options='hca_handle=max hca_object=20'
[  499.213568] rdmacg: parse_limits: token='hca_handle=max'
[  499.213570] rdmacg: parse_resource: 'hca_handle'=max (ok)
[  499.213571] rdmacg: parse_limits: token='hca_object=20'
[  499.213572] rdmacg: parse_resource: 'hca_object'=20 (ok)
[  499.213574] rdmacg: parse_limits: all tokens parsed (ok)
[  499.213575] rdmacg: set_max: device 'rocep1s0f0' limits updated (ok)

> Thanks,
> Michal
Thanks,
cuitao


