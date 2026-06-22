Return-Path: <cgroups+bounces-17154-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nrh6F46xOWrAwQcAu9opvQ
	(envelope-from <cgroups+bounces-17154-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:05:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8F6B290D
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:05:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=OsTU8y12;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17154-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17154-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845103078374
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6CA370D63;
	Mon, 22 Jun 2026 22:01:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3E37BE7B
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 22:01:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165686; cv=none; b=eg+xaEUyEUahMIG5uqhhlkpbtCSKmKh4aJaJ1bKbbjXN7L2tdX3MI7m+jSnbIOl3x3IQ32CunixJ4hEFil75MJ+qfx6m1Ysf83KZEpq2M0Ur/UX4g/2FDAcTP6KD3i1CwnTS1mRFcYCycM0xY3/+AisdwyGrcX8FE7Xw5yJfXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165686; c=relaxed/simple;
	bh=pw5rgiM42z9+JBpwIt2H1ljq/Yya2FexrtMFO0dWt34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LnC1TnEBF1dPUObNFc8qby2V1WHjysOdIkVZ+3aHElKrfrSpzFBVzazMMLiIovifkRMg2MEyenUOu31DrsONDfrvw9w5xngSHD0+Lxi8mwZIOlcaymGS52yaUQnMFB3aOkdek2hRIjftKISkAuTZ3wMLMN5/6lwab9ZKH9rGCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=OsTU8y12; arc=none smtp.client-ip=209.85.221.171
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bbca605be3so242729e0c.1
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165683; x=1782770483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlBCKHTgRWvnY8xmPasPUtWMx6sHe4epc0vhl27EoaM=;
        b=OsTU8y12MtR99HtRIrn6bqnYyNaVf9im0qmZ7+WTfIr7kKbPBrkV8atjAKDQGlrQ/2
         TYYKDLRnlIkwnxMqynMn2xOujZIpVbI9pkYJ65jEw3ZuPUeqoJGLfGhkt0lESbDZ1uci
         kB/LW+5aAJ43kDCJe++a7gc322ttfLY7bvlb3tdfCZAmaypMseakJ82KptJLeOQjkMYg
         Q3twJApRBVkRwS0zQS6bRABn1aW7waUa4G1HuDxV9ulscKRSg7MbrQklroAqfJeRz/UW
         NWMCUWxOqJ/61PQ9RJFqnBY0K5cAZkeT5wUYChpMc5+U0tx+IaexgbJpA5JZg+9lwA8s
         31oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165683; x=1782770483;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AlBCKHTgRWvnY8xmPasPUtWMx6sHe4epc0vhl27EoaM=;
        b=W6dygYuR2vOeNV3/ymtzmvnZHALan5CTYY5UAuy1EK0McNPHY7VsWsZ6ZXV/Yar9Mp
         S4mq7yfnV3HH3ozud0Q28NWNXwD6g8Anah9Ebwztu05W8wH7yLtTFmxspX5F+8RQfe5Y
         jojYmPtCjYEiFxQ+AA+OBgCuCBEPruPAcRARxGKLkqEJCljB2HAxaj+XfLeafiD9ybQ7
         zRcfZkXoeZUepYoPQ4YagrMCb7Jyg6jcSvvIeq5hu0aL0rZUuKg+XKBnPX0OoFoW+ciC
         E/sNrWEbOEgQScJx0VKl9ZUYU4a5B1WZZ3+4vgMnv49v4d99pEuarzP5Pjvf1WRlKPMe
         LpOA==
X-Gm-Message-State: AOJu0YxenNnbaD9w9I8QHCj3F5d++w9zd3ug/tl7ApgOxOE0qnnDkx8x
	zAokn+u9TNQJJPJztNIh5gD9HWQ5choLWDqaifWiWYxUNS075sz/nc+1GteCRwyYxk4=
X-Gm-Gg: AfdE7cnYo3SmE9tNS0CV9YVYjGlsqAXu7m3rxOQMhd7vwU0ylPUaqLazDkfTsFtyEY9
	/EqE7pKf1sQVWL08hQ2bkQMKUb0tBzZaWMIFO8Wrk9pV/PvlCPT55bGcfLizPAXftX8ezRu6sZv
	b0x1hRKzRY2BIe6mI+4mmsOxNhCT8VxLgbfrLXjLL9zBW8iS2sJMfDTxaI/xtnlmmIsSb+beBWx
	tKo1e6lgl/dsJOWS7DK0PDk1qNsVkeC/Cl5DKQbe0E36j0+HZEvORR5qjCKUKzZodTdHLdaqHrK
	zRidAl6SnfFjfK5zRktoodMsxcd/tqf7uTwQVS4Lf6yTktee43abU7wra2Lkmi9QrGvWxgZHeN1
	ntlzaNnooR2cKvZUW7bn6D5g2F/JGNKrrcsyU1hs5+AHmerco+GXQA9up/0SJ2aV1GsXs7vlp13
	AtWMB/e2d+wNyKS5biPxnr410YrzT2fYCtXOc=
X-Received: by 2002:a05:6122:4895:b0:5bb:fa79:56dd with SMTP id 71dfb90a1353d-5bc2ad5d404mr736786e0c.7.1782165681330;
        Mon, 22 Jun 2026 15:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:01:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, linux-block@vger.kernel.org, 
 Zizhi Wo <wozizhi@huaweicloud.com>
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com, 
 houtao1@huawei.com, yukuai@fygo.io
In-Reply-To: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
References: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH V3] blk-cgroup: defer blkcg css_put until blkg is
 unlinked from queue
Message-Id: <178216567226.110437.9780532607179300407.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:01:12 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:wozizhi@huaweicloud.com,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:houtao1@huawei.com,m:yukuai@fygo.io,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17154-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DB8F6B290D


On Tue, 16 Jun 2026 09:17:46 +0800, Zizhi Wo wrote:
> [BUG]
> Our fuzz testing triggered a blkcg use-after-free issue:
> 
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>   Call Trace:
>   ...
>   blkcg_deactivate_policy+0x244/0x4d0
>   ioc_rqos_exit+0x44/0xe0
>   rq_qos_exit+0xba/0x120
>   __del_gendisk+0x50b/0x800
>   del_gendisk+0xff/0x190
>   ...
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: defer blkcg css_put until blkg is unlinked from queue
      commit: 3ed9b4779a4aa3f44cd9f78627498d7adac40daa

Best regards,
-- 
Jens Axboe




