Return-Path: <cgroups+bounces-17774-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +/BQKtMeVmrJzQAAu9opvQ
	(envelope-from <cgroups+bounces-17774-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 13:34:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E2753F08
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 13:34:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mAvoqXa1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17774-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17774-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD9C930EC4BE
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E837188B;
	Tue, 14 Jul 2026 11:32:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BDF35BDDB
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 11:32:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028769; cv=none; b=l3GyvmLeShnwf/ZKBOQJH2NjMR9GfkdtCG8oXTteZEVpmSMSQ9ogRlvsikKqHXblWht9RzEDwPyw3m9K5X8eHvG2lo2o3jVotHGs5/pzuoZhamWqWQB/vQrmsO7OLlzXCEhLxzmK28h0wu3HFbNy0HQtbcTVbYwfvTPSzEVJ2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028769; c=relaxed/simple;
	bh=JW4SKwS9Sw6yTBXBo9sFe8ouOcRn4MEMwBkrwaQ4RB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2aQmjdEKtBHZsjWM3M2wPoDbqBwbeREHQ4MIoYWoc4grQ8L4j8KrPGlPMnZ8CUwaQvsuvVwFwctteFYcYI1c+Qk3dQzrxTq6cDuE/bYx3/ZQt7OVxNrQa1UCXoets06/5jfcumaINMutHBS1EAhnz9ndq6ne/WEifLYDP7ibBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAvoqXa1; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-472326ca506so3429653f8f.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028766; x=1784633566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXVTwIzWV4cMwvPDxnoNwAyB741h/M12a9/WAB/GHT4=;
        b=mAvoqXa12w5a9DWTYhc9WvB7EJLjOS6aPW6Yf+iYxxFFqEqVwadlEFH32yCmi/Ahnb
         Fb1z7agoPA0hgq1p4H8eOgYUyxmwg1k1gIp11wflJ4JIhQjYRQUHkhaBc910DauPel73
         1JsKuZogRlZjwndLp9eFjP+w5a1I/+5MM9dF9iI1EAfQ8HsUSJL/s/dHDfVbQ5ZUNfUY
         jD9AoC0Swd5xVfI3XvDvvbM3UZgrcqQNftylxDIAv+NgJfC4taUDQoPRZFo9j4FRoAQu
         2Rcu/ZhaucDJwU3/rsE9gt5dukYSFfjG/6rARMWoHiOLM0og54nl3jyttyTQUiWeDQto
         4/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028766; x=1784633566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXVTwIzWV4cMwvPDxnoNwAyB741h/M12a9/WAB/GHT4=;
        b=IyaBBOmIp5q4OvotoEtYrEOBJbrltiRKMqQg3cpWEEJ48x3Q7RC1/WMTRcI9v1RfeP
         idv434GdzIUF0ghkwkiR7huLs/6XXLrBfZn8Pho35ertuDN1TOq3KKJDWmPmyVROKIsQ
         PK1Jv69bwVt7jJxdZlkWXQGV+z7NfAb+vgBcParaBIbZ+S+5vrTz89OD9tbx4lSAarJH
         sHlp4f7U3ReqEOufg0uOhBo5bm/5rv3S/G2DVE/aArd1Yx+LgnxRvdO6FOo4KPaOaufU
         hXNLcsPvUdA9UYc7v/dDYnXsioweDFMOGv8bxMdNAHLlS4S0sfYF+xaXVKEsZmWEE6Q9
         ZQMw==
X-Forwarded-Encrypted: i=1; AHgh+Rpll7cfO/zodT5VknzCyFs+7dPm65FfMgfWy2X3kUecHE9ASJIh2nw9CjajfogefhrmptBjKlz5@vger.kernel.org
X-Gm-Message-State: AOJu0YwcG4NZ+o20qnhl0bljKf2/au24eCuWdqodUcru3J+knhf2SZs2
	kGXD98UCvkxPb3s8beEx4fCPYaVvruDc3GFg/hNpEDCMeX8chI3oP4kt
X-Gm-Gg: AfdE7cnMK+SMH6/QQZMFOK350Nlawi+BrK+aKHfGlcoMLLvdjXhnoyYhNqI9aG5L2xK
	N0igHI/ilLWLEr+2qZXmzFO8rjZL0CZ+4pRvZY8Mqhdo8jBhEK78c5zktBoq2WiShInwbrQdGkt
	g/Uux9KL2VOOQYpJfVZIA5MPFTiHIeXH9p77e5nLibyplNboD60EpcTknxwu9JYcGp+viAE4yh6
	fRdkWn1Rf6fFZOnmPrVnHJxi/HP0+F1WmJSo/W9JIWPKfrPg0HGPA4qD8TQNeBrsU0Fk0z/KXR2
	PXOhzy8lwyQnZG+fr1AriBxeQ5jKCQPrWCvH8YYDuiAxa19mos675V+G3T/212b63lnFi+9gMaY
	xKLgi3yyN/xVGm0Tv6cO7m7AVjXQMpNv1S3amdQDfajbkvb0paMO2QGsyM4Z87KfjxwdhtDxVkj
	mNa5YkajwQG5ED0hYUrF8c07L/e3V2IZSdzGm5HDMX5RZnoKEGoA==
X-Received: by 2002:a5d:5d89:0:b0:47d:edab:1b4e with SMTP id ffacd0b85a97d-47f4632fcb7mr4290530f8f.8.1784028766331;
        Tue, 14 Jul 2026 04:32:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c7c96sm7312549f8f.33.2026.07.14.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:32:46 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:32:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] blk-throttle: avoid ilog2(0) in
 calculate_bytes_allowed()
Message-ID: <20260714123244.69fbec98@pumpkin>
In-Reply-To: <20260714103028.1334831-2-cui.tao@linux.dev>
References: <20260714103028.1334831-1-cui.tao@linux.dev>
	<20260714103028.1334831-2-cui.tao@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17774-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pumpkin:mid,linux.dev:email,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE1E2753F08

On Tue, 14 Jul 2026 18:30:27 +0800
Tao Cui <cui.tao@linux.dev> wrote:

> From: Tao Cui <cuitao@kylinos.cn>
> 
> __tg_update_carryover() can call calculate_bytes_allowed() with a zero
> jiffy_elapsed right after a slice starts. The overflow guard
> 
>     if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
> 
> relies on ilog2(0) == -1 (fls64(0) - 1) to stay below the threshold so
> that the subsequent mul_u64_u64_div_u64(bps, 0, HZ) == 0 is reached.
> That works, but the ilog2(0) dependency is non-obvious.
> 
> Add an explicit early return for jiffy_elapsed == 0, which is equivalent
> (mul_u64_u64_div_u64(bps_limit, 0, HZ) == 0) and removes the reliance on
> ilog2(0).
> 
> No behavior change.

There is a pending patch to make the x86-64 mul_u64_u64_div_u64()
return ~0ULL on overflow to match the generic code.
That would completely remove the requirement for the overflow guard.

I can't remember why it got lost (again).
There have been arguments about what should happen for divide by zero.
Personally I'd return ~0ULL and let the caller decide what that means,
but the generic mul_u64_u64_div_u64() goes to lengths to generate any
trap that a normal divide by zero would generate.

	David

> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  block/blk-throttle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index ffc3b70065d4..f37911abefdd 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -603,6 +603,10 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
>  
>  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
>  {
> +	/* 0 elapsed => 0 bytes allowed; also avoids ilog2(0) below. */
> +	if (!jiffy_elapsed)
> +		return 0;
> +
>  	/*
>  	 * Can result be wider than 64 bits?
>  	 * We check against 62, not 64, due to ilog2 truncation.


