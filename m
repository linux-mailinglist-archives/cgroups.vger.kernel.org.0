Return-Path: <cgroups+bounces-15448-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBMOAmwv6GlHGgIAu9opvQ
	(envelope-from <cgroups+bounces-15448-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 04:16:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6A4414AF
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 04:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CAA30302A2
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D430B53F;
	Wed, 22 Apr 2026 02:14:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8F18DB2A;
	Wed, 22 Apr 2026 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824060; cv=none; b=tZPsfHns4Vwjnk66UwyNsK0BS5SwSxn3o8hvFMmBZkRv/GElbh+oZs6Sz8AWUISMys0u25s/4bcKkmaVK+iIHYiKqaUakq2o+2n6xnvsMP+U3vYJ6ft1HJxvQGYELad370KQ4eyW2VQ/0W4y5slZ1IH50kJ7bACp3h2uwMBniD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824060; c=relaxed/simple;
	bh=23egVKJYSw9ace8WgOUoSFSghoooZBrk1sWrkiCcs34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRua5hBwVEdoB42qM/fHOKwytsTwyi+uw/PVVTmAEtH/Q5m1wtylkebF2ektugiB9KAdqzkF66LVT9aiXoPJFlsODPrJEC1h+mGnUH1dmn2oy+GW086iyEWPCbWYznPsIji0jH1sfACQMZtpRmaFFl3g1PgP5AVnZPgGgPIUAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f43704ea3df011f1aa26b74ffac11d73-20260422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:13354373-c6a5-4ec0-b59c-24552106c631,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.3.12,REQID:13354373-c6a5-4ec0-b59c-24552106c631,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f7e07e7224e1ad61b7e4cd2c4d596444,BulkI
	D:26042210141563B83QR0,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|83
	|102|127|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f43704ea3df011f1aa26b74ffac11d73-20260422
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(183.242.174.21)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 270174658; Wed, 22 Apr 2026 10:14:12 +0800
Message-ID: <bca5f779-1550-45af-a0d0-74b427b25c8f@kylinos.cn>
Date: Wed, 22 Apr 2026 10:14:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: make DL attach bandwidth reservation
 root-domain aware
To: longman@redhat.com, tj@kernel.org, juri.lelli@redhat.com,
 chenridong@huaweicloud.com, mkoutny@suse.com
Cc: hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260421083449.95750-1-zhangguopeng@kylinos.cn>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <20260421083449.95750-1-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[kylinos.cn:mid];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15448-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: 06C6A4414AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

For another case Waiman raised while reviewing the "record DL BW
alloc CPU for attach rollback" patch, I did some validation and
summarized the test results here:

https://lore.kernel.org/all/d683b3c8-f746-47cd-a306-314a8f3eecea@kylinos.cn/

In short, the data there shows that the same-root-domain case can
indeed leave persistent extra DL bandwidth accounting before the fix,
while the follow-up patch removes that growth and still preserves the
expected cross-root-domain bandwidth transfer behavior.

Thanks,
Guopeng
在 2026/4/21 16:34, Guopeng Zhang 写道:
> [PATCH] cgroup/cpuset: make DL attach bandwidth reservation root-domain aware

