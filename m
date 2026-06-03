Return-Path: <cgroups+bounces-16612-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q2xsMqxOIGoH0wAAu9opvQ
	(envelope-from <cgroups+bounces-16612-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 17:56:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5C8639793
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 17:56:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=G5IJnpJ1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16612-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16612-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33FF730C0630
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA93AB273;
	Wed,  3 Jun 2026 15:09:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984EF397E91
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 15:09:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499343; cv=none; b=OkWUYbJhe2Sx28dkIf9uGwtIGRzQIMiirHf2kQ1hFMh+Y6Bg6cf7gXOGTx92E29t9I5KeGo0Wf0CM2NgvXlRTMIFkliv6Eor+GTZ6bUcjDfz9a+/6lEvdLE3OWcJCr/nJt1w/ozkKvLcAMXU1+yjBUiIY3AwPff+ClfjnfyrOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499343; c=relaxed/simple;
	bh=VGcwjx3DPZjE2hgdTexOWATae4GqcZm3OWlDTiWj77g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARCNAIjeZBs3pOW7dSZiDCcGTXr0sTXlp4Cn7OgT7xlrLrmv9K3ez51lJEGp/2+nZaWIX5M9hSekTIAauZxXEvrIOUgSsVp4OsdZthNB4ahtkxd4HBfMaxpsZripllXdJEL7IgLRxy0B/Ot4rGYo+y5z8R6GER0EC7hAWZ+nq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=G5IJnpJ1; arc=none smtp.client-ip=209.85.160.48
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-440f9c48b85so332089fac.1
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780499340; x=1781104140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Rgl+7P4bys3k8olUkjDrUmY90i/4VEAqR/MuDk3aF4=;
        b=G5IJnpJ1fpzebgCXZZYBBDP1JPUgcjL1XHLreTHoWERY0Zxub8g4n8/p1U5SSEARfG
         zCqQfBImBa1qHBfb+vfAPE+1eT71YVdJz2Wgi4IpumpvHoR5nFjqeQIIl0F3JiZ6hBMo
         91uT/Josj3QjW3NxgXODqwVsbZRC+DMByiRrJ2DUE6nTlE4xBbtdpY1gxJV763Tuqbny
         lM8fVqEgVXpNOGCpMFHYSdo4uEjgfjuNXzTLRYU45wuzN0h4ptWV7Pg6WPeUK5BLyRww
         KLKaaNNFPQRRNMJfTEJbehB5WTfU+6XiC+G3VH7w4G/JGEnEiPcZQY6Geqoc6Q4pAd/e
         8JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499340; x=1781104140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Rgl+7P4bys3k8olUkjDrUmY90i/4VEAqR/MuDk3aF4=;
        b=C8OfC90/i7O8H4JA6LTo9ySUyBINpOGRV5ghvop3qpyg7ZNmPGP0VoC2fCAzBBmlTb
         3VyemXvDqcAhOZacnXgNlV1TuEp/aIrKr+5GABS6B/P74B5oeW79v4e1wzKJ16/XZlLN
         s9mmGlXYvjD3HTN5l3nvcXFXsHX5rJTtG3MY5JKAWWx2xGr53T/xYPYUCQrNKg/v0HNf
         Xw8PKz9deGNgNQMETwkYQ3ADV9gkkvFsWVcZIwhV3Y1PSovKJnKObndazVDV0VdFY2GV
         NuIKF+pn537g8MT2swSrCp8WCL4qc7I8AQRErZCzb9SHmWU0eo7mWyqit6pNp2JOeoyD
         tKVg==
X-Forwarded-Encrypted: i=1; AFNElJ+HBJZYwUPyd5feS38TJhRlD7uqJBj1aN/KN4AGrsVyUgUJrcjVpxoCN+LzBkuoMcj5R2lg9VPC@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHg5z+d+Jf8JHkaHDHcMq+PGHJAW0wJVHoJDEpdqokejRmTf1
	in6GNoYSCYaBUA1gp4UWgyJrRNJNVoDGkgdTt/ZaQOYFTBUnbrA9RJZQBLbIlVuRets=
X-Gm-Gg: Acq92OG/37SbbHCaHvkSEQS+yN/bGR7+UsSQR0HY4dDTk8eQS3TDZJmja9M8GM+hnKc
	cupDNptJoQ4YCZuVXjv8aYw8/pJVCOG3SwauQ5xj3nIuKuoxzZXVRXG6WetBnOTrDZX/OJjn8wD
	++zKcv8AnjJ+xgcC6yIxkAP5Cj1n6uqwy2NjvgxJdHZhZTwQlHEjEQwvKbC4fZVp9ZA7rpTi9pR
	WAp6hy4gMfVWshpv6ZSyRAyhuSEpQdMpFwfk1WGcq4hpSgqyNKoOWBDElT69LEuQjwUBK/heQOM
	+MlqPcaW8g+VBjUS42+Hj52flPkDGfJiIhXo+av8lz/0bXCkFW1Wl1+k3QPd2sJAXDGVHg/ahys
	snTQQUVSQIBpwvBNzHBuspeysx5j40H+yWYjipOD2gTea+IHwFVDUzRFbb/smXQZt5mvkfUmJG6
	hUOhhW4VjQ265eVXPboSdtzbuPA7k3KoRTP0qFSmXMh2u8FmaNqAnw3kSk92pExhmIBMEnyuD/V
	hrZ7VHKLb2gGxZy6Ro=
X-Received: by 2002:a05:6870:9d98:b0:43c:33e6:275c with SMTP id 586e51a60fabf-440ddd8f4f0mr1723868fac.9.1780499340586;
        Wed, 03 Jun 2026 08:09:00 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7c42c33sm2468388fac.6.2026.06.03.08.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:09:00 -0700 (PDT)
Message-ID: <70200e71-bc14-4f1e-aab9-16b27efbb3ec@kernel.dk>
Date: Wed, 3 Jun 2026 09:08:58 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] blk-cgroup: fix blkg list and policy data races
To: yukuai <yukuai@fnnas.com>, Yu Kuai <yukuai@fygo.io>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1780492756.git.yukuai@fygo.io>
 <1686f891-599d-4cef-8f38-420033355f2d@kernel.dk>
 <189b8601-87a6-423a-b267-9d550c31c086@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <189b8601-87a6-423a-b267-9d550c31c086@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16612-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fnnas.com,m:yukuai@fygo.io,m:tj@kernel.org,m:josef@toxicpanda.com,m:tom.leiming@gmail.com,m:nilay@linux.ibm.com,m:bvanassche@acm.org,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,gmail.com,linux.ibm.com,acm.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kernel.dk:from_mime,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD5C8639793

On 6/3/26 9:06 AM, yukuai wrote:
> Hi,
> 
> ? 2026/6/3 22:35, Jens Axboe ??:
>> On 6/3/26 7:27 AM, Yu Kuai wrote:
>>> This small series fixes races between blkg destruction, q->blkg_list
>>> iteration, and blkcg policy activation.
>> In spam: Authentication-Results: mx.google.com <mx.google.com>; spf=pass (google.com: <google.com:> domain of srs0=eh6w=d7=fygo.io=yukuai@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom="SRS0=EH6w=D7=fygo.io=yukuai@kernel.org"; dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE) header.from=fygo.io <header.from=fygo.io> if you don't get this sorted out, your messages will be missed as they end up in spam for most people.
> 
> Thanks again for the notice. I think I finally figured out why dmarc failed. 

This email looks better!

-- 
Jens Axboe

