Return-Path: <cgroups+bounces-12784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3777CE52A7
	for <lists+cgroups@lfdr.de>; Sun, 28 Dec 2025 17:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D90300F32A
	for <lists+cgroups@lfdr.de>; Sun, 28 Dec 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1A219E8D;
	Sun, 28 Dec 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u61F1VoB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C920FAAB
	for <cgroups@vger.kernel.org>; Sun, 28 Dec 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766938076; cv=none; b=aJJsxxqkLD8RTQzT212ud0t6IUCU7B539H6iPo/qYDukCBEVc90Cunt1m/IC5JV5F5bTN7Sjk0hqGNfDvrI1PWnYYPSdo//4rqJ1/4HfaQNb9NfXrE2F3+w/+SIhpzdD3jV1xM17ZUrcpvw9yWJzwM1d4VqXocqMoUzGwd3hPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766938076; c=relaxed/simple;
	bh=F2tCKSP4YvGQrNXRGmXd+37cmYKNHnUr0Z8WjkgGb9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nwNrZfQPKGmTYX188iqBRPF7V6uKxOutbuxaOfy3dG9jddU6KGG8bl2YdzskHOwHx4jpvgCz1agIaJJc7p6QV8ETWS0YB554tf/qsaMaHU3XMZzAWTdEJWmaM0DOL1NKJebaWRofBpnEfoM3SESaUtFdYXDfzvriu8mPQ2fC6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u61F1VoB; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-3e80c483a13so5809816fac.2
        for <cgroups@vger.kernel.org>; Sun, 28 Dec 2025 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766938072; x=1767542872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szKx8AguahzJOPQzAYE7zxY9qDBahnfp9k8YWlf8ulA=;
        b=u61F1VoBUjM58ptmaZGV2/6X6BHiXdRvZZltRF/BMLMXwk7YO9f0A2xvFB44WApO8R
         RDNhslRDnmlt/Z2grgUNNVzrjOFMMhn8cO1UEA9+la1wtuxIu69qX0bsVYXk74kUYn1Q
         4rqsHUECeUXZS5ibcxe1iz8gaXNLuN9HE0CgmWV9oAmOZGURPkdNgdekH/a9+hI1Kdnr
         L2AvObcQKwmK+xsmN3oo0TxQdfpsYNxWByFpGf36lA8joCtBkAtGW0PCGY8sDXMEcaoE
         mfW4dvIDwm+I3jYbaUpR9yfu/48AV/wDjzJM1tY79ZBrgU9TFamkciSzNPwIG/brxwo/
         T/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766938072; x=1767542872;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szKx8AguahzJOPQzAYE7zxY9qDBahnfp9k8YWlf8ulA=;
        b=MSJ6SOzXLpMjIhRAJQMwXe24mGoHb5OcwpsoFaIuZcy2veejJZ1OYKO6FKtm2ByEzL
         n65kcf9mQtoxv0oBEYA6DkwNe9S3T1PQfrLXB0wVHYw5s6xnucMIhlkdsv9TNIAiwbRn
         /l8A8GYgyJWFGQ7RQD/o0//+Hyfac7kMzp9HYFedzkC5yk/c+Q5UD0PEXZBoOb5kJ1+S
         1aXf/FvQ/1C5/f6qOY6aI/3JKDw1rYWWvr4blRcVDEF/FxOBAup3QY53CtRjcrXXFutZ
         Y7t7z2UCyqVpygfL29f2V6QbReKniIXNwTEdMWVLwY1VIp+Si0fhsOsgAty/hIr85aGN
         xvGQ==
X-Gm-Message-State: AOJu0Yz7B3HAqJM2QLZbjc008MUNrPxsbici9Y2JmbJ2AlKyUmL9041H
	2+K+rykPcNOXcbGcLfuMeH9TSLq25yW2/ZrycZrIMrMBcx8Wlb2TSzkKIvIFxwCNy8Y=
X-Gm-Gg: AY/fxX5ZNq5wMrFywoKrG8V2SVBg5pNNJAaklhWmBXQFoJeDySeZLIrchVZi0eO8tTc
	OCBqwm1yQcrNd8PJayEZu7ylXwtTYJNjPn1mWupEJhBhAX6csu+5hByTlTZiGAIgxbbUCeSDtCD
	VxchRhTvp+wDljfxfKmfehAZSDc8A0M1mQjaIJV78k7oWlUXvw9DsxtjqLeyKMwDUwr9QTQMeNz
	qJaeEwGrRe0JpFNqESJG8Jm4NDCvUYzx0alyNtnPq8GlYOyvnNVUfeYhJTu7qzA0K8ui0BzbKK5
	QqN/H4DZw8FMl52vYNm1qoKO3l6DuNbYo7ptxskmma/S4Qdne/OJDXsXq+4P9m1Ffa8H69llr4I
	YIvdogaXZM1BOu7ntlprqvUu7HdPSnBxF2e/2YNhk/j4O9uIbJJAQXJUDWhIS5s1P1CLOstFxTk
	uoMKg=
X-Google-Smtp-Source: AGHT+IFnaTAxARAdtF+X96h9yfgX9gbDfyl9BBErpuilZEbI2PIGfbl1nU+8YgIsKD8rjejXZtcsnQ==
X-Received: by 2002:a05:6820:1691:b0:65c:fa23:2cf9 with SMTP id 006d021491bc7-65d0eb442e1mr11450341eaf.76.1766938072567;
        Sun, 28 Dec 2025 08:07:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f6eb26fsm17211956eaf.14.2025.12.28.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 08:07:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai@fnnas.com, shechenglong <shechenglong@xfusion.com>
Cc: cgroups@vger.kernel.org, chenjialong@xfusion.com, josef@toxicpanda.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stone.xulei@xfusion.com, tj@kernel.org
In-Reply-To: <20251228130426.1338-1-shechenglong@xfusion.com>
References: <71df89fb-1766-40d5-8dd5-5d0c6f49519e@fnnas.com>
 <20251228130426.1338-1-shechenglong@xfusion.com>
Subject: Re: [PATCH v2 0/1] block,bfq: fix aux stat accumulation
 destination
Message-Id: <176693807087.193010.13084739282285642085.b4-ty@kernel.dk>
Date: Sun, 28 Dec 2025 09:07:50 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 28 Dec 2025 21:04:25 +0800, shechenglong wrote:
> > Please change the title and follow existing prefix:
> > block, bfq: fix aux stat accumulation destination
> > Otherwise, feel free to add:
> > Reviewed-by: Yu Kuai <yukuai@fnnas.com>
> 
> Thanks to Yu Kuai for the review and helpful feedback.
> 
> [...]

Applied, thanks!

[1/1] block,bfq: fix aux stat accumulation destination
      commit: 04bdb1a04d8a2a89df504c1e34250cd3c6e31a1c

Best regards,
-- 
Jens Axboe




