Return-Path: <cgroups+bounces-13952-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eERONlNXj2lqQQEAu9opvQ
	(envelope-from <cgroups+bounces-13952-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 17:54:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357113868A
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A82A2300808E
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD03624D5;
	Fri, 13 Feb 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="KXQwlwDV"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03516CD33
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001677; cv=none; b=GwEIw+vCnTmeovSuoF8xrbz3bmHVQl00g7CNghCZJWiFubX2T/nn7pY7McmWT+ZhuzqMQmoiLQBbDMTsnSm0mubf7HZt1zgmQnDIH8ElRtOVM4QRqJRCSN7M5dUawBQU0CexkeNxjEOFnqi4mSpGYBG5VNEVjk678eUluY32vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001677; c=relaxed/simple;
	bh=G2BnGX26PUJwPNtKkgDw/Z/6YxRQh+f8bAqoAuDkZEc=;
	h=Content-Type:Subject:Date:To:References:Cc:Mime-Version:
	 In-Reply-To:From:Message-Id; b=YYP6pCkTJsH+21KhjzoRIsxBcVIN7q0PF7vg4yjhdY0rTBPXsgRCdlsHLAwN8xX7KWKwE0HqMK2FI/aA7ZniqHpH34v0Suvnm8A6IZjLWPZCMtFMr5daRhr+Z5xHJ5LF2mKfoyjRlYS3zKHNBxrrvrB45Ets4bB6JtV4bPaQvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=KXQwlwDV; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1771001668;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=G2BnGX26PUJwPNtKkgDw/Z/6YxRQh+f8bAqoAuDkZEc=;
 b=KXQwlwDVoeV68Rlu0oEVJu4Lg47uzpXzUtH96viL2v3Xs68gacIGKwNCoVOZFcoyyLaEer
 ymGWnnngyfo4xnbaHcYKZMF1Fv6BI5KnF7xgLrYwoacbnPZklLjpxDYvNBEkdu8RAg+r5z
 15ZlDskw2mYj4Vyz9Z1pXpOw5T3Sp5brjn3WpRqsrC27JahEe6zAvBfY0Qxyci+3l56LXV
 oK8ibWD51JQu4BLfsLxqw/56CKfqq1neAfXyDosFOReQ5Z5e9qQa8MYjTSkiczPQmhbM9M
 GS4XvgXZVpEA2+ql53FXQ4APk5fmFePZNHxY5DvGHD1b8Ll0K1wKm6EKfeArBQ==
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+2698f5742+765c66+vger.kernel.org+yukuai@fnnas.com>
Subject: Re: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for cloud disk
Date: Sat, 14 Feb 2026 00:54:22 +0800
Received: from [192.168.1.104] ([39.182.0.132]) by smtp.feishu.cn with ESMTPS; Sat, 14 Feb 2026 00:54:25 +0800
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Reply-To: yukuai@fnnas.com
To: "Jialin Wang" <wjl.linux@gmail.com>
References: <20260213073829.182168-1-wjl.linux@gmail.com> <890f2571-fb46-4ff2-b7ea-7cfa10bc8797@fnnas.com> <CAG18Jnyvs9Ob2WKQV0LQYGrq3F+czrRukhxW5JCza0iZQvbh-g@mail.gmail.com>
Cc: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>, 
	<lianux.mm@gmail.com>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CAG18Jnyvs9Ob2WKQV0LQYGrq3F+czrRukhxW5JCza0iZQvbh-g@mail.gmail.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <a18d26f4-a494-48b2-8024-4de1047afb25@fnnas.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13952-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[fnnas.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,kernel.dk,gmail.com,vger.kernel.org,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fnnas-com.20200927.dkim.feishu.cn:dkim]
X-Rspamd-Queue-Id: 0357113868A
X-Rspamd-Action: no action

Hi,

=E5=9C=A8 2026/2/13 20:24, Jialin Wang =E5=86=99=E9=81=93:
> Do you have any specific thoughts or suggestions on the best way to combi=
ne
> these two mechanisms? I would really value your advice on the implementat=
ion
> direction.

Implement a new model in iocost, you'll configure bps/iops_limit the same a=
s
blk-throttle, you'll also need something like tg_dispatch_bps/iops_time() a=
nd
throtl_charge_bps/iops_bio() to calculate cost by max(bps_cost, iops_cost).


--=20
Thansk,
Kuai

