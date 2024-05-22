Return-Path: <cgroups+bounces-2982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA88CC588
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C12284B5A
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE51422B6;
	Wed, 22 May 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F/1Ut54e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DE537E9
	for <cgroups@vger.kernel.org>; Wed, 22 May 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399075; cv=none; b=Mro5V61WK3fd/yBUd6jaxBYKZwdaH9lTb1QTe9TGH7oPJqzhj4wj+RTCE3qkdoyDF50YuQQwhqW2D48TrodnkkJuxe9Yde98ZGCq8HkLXn0wXrh3bhUSF0R+MG4ffhZFH1sLUk2arQ1ujhgfVj5aPB78f5MRZZHI5lc9p7yiLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399075; c=relaxed/simple;
	bh=1B9dsnoCotJxFTrkGAZwC40Nz5IzOJrheW4eFVSuLL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5Q0+sZImSZvIR5Ue8xUkSP5tLdLwuVQOKrGTYy8qhJxN+RvXxU4Ys7ObAe+VFlnWZq8B9VoXMrr4HXfF/H3Ee4FD42OGwO4LT+metXTFmWWfOlkdXvszglF8DNe8Z4YWM4G2RA0E6Fd6mRWcSjeoe3MPJT3+6BNKuPXC+82G5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F/1Ut54e; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e24aa659abso21713239f.3
        for <cgroups@vger.kernel.org>; Wed, 22 May 2024 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716399072; x=1717003872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyoQ04pME4REpApsHBdNGyO5vz5nhCeO/3yT1CYUWSM=;
        b=F/1Ut54evQVA/sNcBskksLJr3mLash2EAqtjclZRL8j9WZ1VFe8QogB2r7wBFBkEba
         C18D9ewMvCpAWMsbHKN+B3ZHQe8OYpOCZyCM7nQ3uIJ+fGieQIqYeZ2Ca7Vee1HNqGrc
         lNIQU2WnZr5mi+lRsnpOZFbMxbNby8Xy+lKR9Ogl9flW9BB6wtvAE8O1z20oU2K5CQCl
         jSzUMwDTMvxOSjO3lA0eLDPbvQbva8i7yR3/rTzyu3J83B8p/HIRZXhGCjUWFGz4xNgk
         6LS07pTxJxkb+v5MNY+2NvHOx5FpNWvgmi2K5J7bkXeMCSPV2+TzYTtZrmTKWB1AgwBq
         3BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399072; x=1717003872;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyoQ04pME4REpApsHBdNGyO5vz5nhCeO/3yT1CYUWSM=;
        b=tFHnR+YJAxoJtUYK0Ku+r8XlWo3TvWbOUXlwftARqCQYqYMICHykpJgu+Pgbx/Wrzj
         CJoC4mWLJTZho0Eb+maKSzUZOeKYBPe5zQ8mNwzqPUC+OpashT6AXUtNwB/DT+WdOLob
         cccUKXJHRcv+fESQzJqZFj1NTuBTeWBMb7pFHOgLNMdN2BlUwldWNXnZqieQhfAMejN8
         oKsRs8UwIXFCopzQvaCeuc3PUHkiFfOruiz7TPoTdP7dix2sPMvfJcr33xe+BvWI8l30
         gshEgZn98L6dWzoFgbusNS2ZULGHhdHMTu6Cb8IuG1fSkusC466i4/zSIxSYt6rBPXAQ
         C9Ew==
X-Gm-Message-State: AOJu0Yw9z2fEFTQVOjr6320V+X666TM3lrv+KweOdVgU8uvTkaAJwgkH
	ivJuBK1UzJrd53PSmBEFRvFid7N5TmU9hNRkOOGSwZ/ojzaL/hxlAeg0wn1MAkk=
X-Google-Smtp-Source: AGHT+IF/WI1FtilI6WWcWW4/jJALodFw4CgIslzmlQd2qik5wcTeLLwZMVKIhIz6ctQZ1GF6SAn4GQ==
X-Received: by 2002:a05:6602:420a:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7e37db353b9mr277689039f.1.1716399072236;
        Wed, 22 May 2024 10:31:12 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c1a86sm7626823173.105.2024.05.22.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:31:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, yukuai3@huawei.com, linux@treblig.org
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240522172458.334173-1-linux@treblig.org>
References: <20240522172458.334173-1-linux@treblig.org>
Subject: Re: [PATCH] blk-throttle: remove unused struct
 'avg_latency_bucket'
Message-Id: <171639907112.82914.16265588567608443016.b4-ty@kernel.dk>
Date: Wed, 22 May 2024 11:31:11 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 22 May 2024 18:24:58 +0100, linux@treblig.org wrote:
> 'avg_latency_bucket' is unused since
> commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW")
> 
> Remove it.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: remove unused struct 'avg_latency_bucket'
      commit: 4a482e691c8b8a188b1ea3d6a80180e9fa925fd0

Best regards,
-- 
Jens Axboe




