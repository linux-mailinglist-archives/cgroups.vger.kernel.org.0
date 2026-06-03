Return-Path: <cgroups+bounces-16611-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xGJDHKpAIGovzQAAu9opvQ
	(envelope-from <cgroups+bounces-16611-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 16:56:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC5638D95
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 16:56:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=h7GP2m1T;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16611-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16611-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9341D3159AA4
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864B339853;
	Wed,  3 Jun 2026 14:35:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAC2B9A4
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 14:35:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497332; cv=none; b=LoLX7pHtADdz186pbtsJSK5IfOBOf/Kmj+HRwKOiAHCbpGYWBfP8PljoWY0vTSXwpLeZCmjVSSUc1HcxSDI+tJ0s1AJNUvw0FL29eOAauc2IwrVrjq3qq6/7bj61O6W1iROk5Eom8GGEMHgOaPG/969nT7yiR1akpzf1I7PHNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497332; c=relaxed/simple;
	bh=PuDTKyv9tfB+xWxUoTe8q848BjQ5X8QmcPoOZoPitcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCNk7pwl9uafTQQykFk9htyvfNtuUlaSKKF4XGFP3R1sBoFVzrTddDM+cAAFds885SBoUcK8j/x7Gmf28AEK+Yxd/rd7PQlb5TXfciO98hcXA2N/oF5FkIIaFdC0B6Op9ZbnyYqE03lezhL7/LCZFJnUB4FVVcGr4nYkflnsRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=h7GP2m1T; arc=none smtp.client-ip=209.85.160.52
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43d2c7b5a6aso1850509fac.0
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780497330; x=1781102130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18nx2zWThaM2VYJdQpVl8cS/jzs9v1SzCLV0t+4aIpQ=;
        b=h7GP2m1TQ59bEN06v9nFX4w6ukml3QA0O3QxIyEdeaSpbXoR5IQlnHrsA6k3Nb+9vT
         uCZYWfTy43oDmQNYt5wqaYHouJ+gRUT+ZcTNrcyqQFhKyhCZqp3Y5dKKmZvu08p2SFpA
         umZ/2OzCLvw+v1YJtdrSC5AU5dzLxyLALg5vwZrtk3FCLtSSyKPw4N1aZ5z8rG4zrOOh
         EGsXA2foMr8g8y1rgRHp+bNvH7pnqVKvpo50/iJMTZsiluLf8vcl6ldGrW7kr+GfGlUn
         gAyu+sbN/eujvc0l9kDojCD8f8ZACYMhznAuBysFtyZMLrTISbDpv3y2zr4MlwEcqsIE
         e50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497330; x=1781102130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18nx2zWThaM2VYJdQpVl8cS/jzs9v1SzCLV0t+4aIpQ=;
        b=X+tFz4j0Nx6md4s6YNGHnKjgVZ2Q8IAVNEqr+bAGkvDX8nyoOrF08zyrimkXUnsQ2E
         LheH7id51mf9UEZi/dWmxM/b5mkQjoVaq9YvMWgjgSwUkwnvaQpGimfQTLyPMvBv8eYI
         z9BVzOnPc9Jnn5yPDk3m4kDCbfmqp4f5Azk537uqJOWsdEb8R/OVemZ2xxH7eRWmxQff
         zT9dXfpoy0PZW6ORNDemlHBkx9zacf3Qc+uOXprGgJtiiXvi0ZE2A6bxZFuffvigdh8t
         XtWGxhSTKINhT+5QReU+I3JuNuKWAm9i+u5o9EM9Ma3VtG03R3jTH/nPEgBl3+AXXhng
         uVEA==
X-Forwarded-Encrypted: i=1; AFNElJ/8kdIqB5Bf/FePA/boiSaLOOGuz5vTf9EB+mL/zsby9r9YtsdSDbbwhRctENiYv0MLitc9eJX2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2L4jYMCfyPlp99kppKs/abDtSEtoNH4DyialYB9i6p2CTj3SE
	imNNLfuNu0JGE3Ws51vuDHMrR/xeIfReneyFhtTbLjAHMknliZOS70SrT3j518OPa2Q=
X-Gm-Gg: Acq92OHka6a5dqAfoM7cFnn6MeC4+PTjvT3sf7lLhX1X69FnYt8VDccRXAVbZ2rChJo
	5l5UZAV4IWmPxzv4b6/XMVOJXeUKrUSX+sfe1cvXznEVFLxTZ82ncaaU5GH4ad4+mkOi1qAfE1I
	FnM0d3HuxgtAEeMaBwBKeXjSN76GaXpW8i4sfka17tIau0HiCkbz+UgN7GuW3VXZFQiCLi+AbeY
	3YyDT7uL220tvvBrOSgT/z3gr5C06ZZPIzWGxs3FyCOzdx6DsxMmFt1GgiZEmOZ/9VfwVcp2rvY
	wgv0fxlC7DlCxbO16+GDErn43IC3E7eioH9wqSo2UiF8ex/43ZW+TPxm8gMUaH+lbnbqQVuwT2T
	YuLQ4bG8FwuNELc1J7OEzB5FyUo+gdfmMFNUdWlKuaencZeL13c9KbGNR/Amkyl/wQ2i0F9DYC8
	s2of8cvyBSaKl7Nf+hNgjk8RCw2Ht3bONZtMZLXO/Ib/Z3tXdMw2RkY5IPtdYbzJXmZIIkwGEqz
	OhgLvluPKvfZ7jgiFk=
X-Received: by 2002:a05:6808:2e47:b0:484:e5e2:6b93 with SMTP id 5614622812f47-4865ab9d9d9mr2419978b6e.24.1780497329744;
        Wed, 03 Jun 2026 07:35:29 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a53bcsm1943090b6e.3.2026.06.03.07.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 07:35:28 -0700 (PDT)
Message-ID: <1686f891-599d-4cef-8f38-420033355f2d@kernel.dk>
Date: Wed, 3 Jun 2026 08:35:27 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] blk-cgroup: fix blkg list and policy data races
To: Yu Kuai <yukuai@fygo.io>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1780492756.git.yukuai@fygo.io>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1780492756.git.yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16611-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fygo.io,m:tj@kernel.org,m:josef@toxicpanda.com,m:tom.leiming@gmail.com,m:nilay@linux.ibm.com,m:bvanassche@acm.org,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,gmail.com,linux.ibm.com,acm.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10BC5638D95

On 6/3/26 7:27 AM, Yu Kuai wrote:
> This small series fixes races between blkg destruction, q->blkg_list
> iteration, and blkcg policy activation.

In spam:

Authentication-Results: mx.google.com; spf=pass (google.com: domain of srs0=eh6w=d7=fygo.io=yukuai@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom="SRS0=EH6w=D7=fygo.io=yukuai@kernel.org"; dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE) header.from=fygo.io

if you don't get this sorted out, your messages will be missed as they
end up in spam for most people.

-- 
Jens Axboe


