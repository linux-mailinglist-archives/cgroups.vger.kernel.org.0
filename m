Return-Path: <cgroups+bounces-9833-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B528B50188
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D34C7BD77A
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200436C090;
	Tue,  9 Sep 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WnE546bA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBA3680BF
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431697; cv=none; b=QH+HU+05DVNdwsdh+ykCg3xOEkIb2Ri+FRhzjiDqLoYsVi14EDKSy4k20VtIM/wWWJT5Zyam8Wcx9bCn4jGfmtz4VWcDEDu5UtUyWgdAG3oQoQYwN7gxRx+1ga4GbjPr4dBJ0oSxPj3XEjIqmlxQ3MXv/qyoBdIJt8TFxIksdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431697; c=relaxed/simple;
	bh=zdmMTS66pDXSVVeEoILIIh+RFkwTTy3dD9US6WLNHvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iicBK8msw9yqIo6JzAk806sVyHbCjrsXl6A8tWx83XAnfTVArW8JpeuEIoYhZfBiSnVwfXoecKbLkIaBYGSLTFfH2j6y3MlgSJhVrwkMgqL7WGjM6/96A7xpBrwDa2GjP9cWNB11tcmbEG63EBvqimN5rx4o11PcedDfDDRL/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WnE546bA; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3feb74a1f4eso16399545ab.0
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757431695; x=1758036495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jN1Kj7K7CkcC2gypxZGow6Wd+LfV+1NytZv39KYFilg=;
        b=WnE546bAGlo5G+8fg8jwTZo4lmsOMgNuGpIiLHtxNJ8GJ7O3Po14xHWH77y80XNtmG
         TjyfjohcywWIVVHmy70qFv2w4685MgZSg4ec/xc39NOAtoAxWSPJW4CGL6F+V+G7Gvaf
         Uf0d+Lv2fg2cqeIdD+0ln3wa0nCHnoZiImMzinbEyh7DIzvILb7/oHvq7mTtEnBPSVxK
         xH7m4MlU06X1aUwaV1vcjgokNNf8wScfBjQzp50AwKwqMk/SSowjDIa9N+t4o/00JiJl
         W/kIGX4EKBUjQktsif9voUWtpzY5ruvCxLcJM/H7Sfs12ReWECAitqF9zdhiixW5xgGp
         xPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431695; x=1758036495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN1Kj7K7CkcC2gypxZGow6Wd+LfV+1NytZv39KYFilg=;
        b=BkoasGTK5VW2th4aDss3FquD3E+r1kX/qDoG8M+NxBNKkIbouCV8UeQOjOOm2DaZ1l
         SL0ByV1WHCquoqh0iYetOmwwcZ1vKHLROX974ms+I5AOz3K2pRBN4c34i26BYMqxs4/W
         zunWdv1cZNO/UJOhxaVvxd+8G3t7RFXjdNQpQ8mWH7lTSt6/GR6jkm/ftn2AAEgBbo6n
         GuJ3IqmfFnOQ5QL+6OrY2aseycw3fTt3u73j7B0ZfrZoaXlSZXktp11Q+l5zGWlJ3I5v
         Du8D3BWqon1obulmMKjYsKEXp9ZJmdpqxU0ymuLMRz/XYZHAYZuOfnahyarF6aJl6FGf
         n5yw==
X-Forwarded-Encrypted: i=1; AJvYcCU5qbuUKB37Jqjfz3bVtZ0wgmhgrTLFz6h6em/uwnbbvOPWFJdH1xYLBlfAsWvpfwku1e34/f9n@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUU1htBf2OmGvs2KFsTGlbTXR1xKxhnOCojFjn4HKDNtAhSvE
	b79lhHHCwPkk1V+vRrmpBgomYwE7wYZXkc/6+vRY7lQV+uFpDsuQKu5bHKrGSn0dSmU=
X-Gm-Gg: ASbGnctsIk83NuRYDXxZxVo9mX5zQyvZ3bNL8BkY8yLFuzoGmFp7E0Jf9LG5Qjx92tl
	n/ehZgYKkxY3H7hXMIpXNX2Tz5hvh0dUKfA+35a1ombGX640J1KRaffQlL7p/cE3bWkIL2GWDPZ
	0l938NBIM6qQUsrapEToMJ7q/r88e+aCvn0NQFOWnPTWOG47rlLNqjjBaHkOYYP8RzEEYI9SvCC
	/m/t9hZyR7xXNsc7lVw/qz+6Cr+INpRNjMSupo+D1E7toIV7QjRqG7x7T9NiauULndIRnZ9y1sz
	Z+USXTVjTIISKfmZE+l9unqG83iAYkbNC3hPn4osOrDNJjH0akHEZ6u0f2fC3b7DbLpQTN25orq
	ZEdo68gE+xFfMoFOt34ODvxToQjENWRc7RbN6SEvS
X-Google-Smtp-Source: AGHT+IHxQYn//P6OlMBv4Hjw7zsJ7Uk1Uew3KWJj5QRX2MyObcGnhrIGAx1/Aj6Ur5T/j8o5uW59sg==
X-Received: by 2002:a05:6e02:1d99:b0:3f6:5e25:a5cc with SMTP id e9e14a558f8ab-3fd87781510mr141362695ab.23.1757431694832;
        Tue, 09 Sep 2025 08:28:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5103baa86e9sm5847043173.9.2025.09.09.08.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:28:14 -0700 (PDT)
Message-ID: <165f4091-c6c9-40f7-9b41-e89bfdd948cf@kernel.dk>
Date: Tue, 9 Sep 2025 09:28:12 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 00/16] block: fix reordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, bvanassche@acm.org,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Can you spin a new version with the commit messages sorted out and with
the missing "if defined" for BLK_CGROUP fixed up too? Looks like this is
good to go.

-- 
Jens Axboe

