Return-Path: <cgroups+bounces-9070-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98129B20B27
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 16:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182F018C52E3
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0B237194;
	Mon, 11 Aug 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Mqu5uMvs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744C227574
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920914; cv=none; b=lcGvo/SFu+ARY1CTFHDUvO+4An+F4GQesudSXzYngE5xUnR+PFTm3qJOWE8i8S+Y0btWxzoVysxFIVSEzP6uh+nMqCWM/opdz2HvO8w6p0PA1nQu8VFPFhLL1nc56Cg1kBER6ahUVX8R1ci8wJZuGhAo1lWnBfO3sHp5Qa97BJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920914; c=relaxed/simple;
	bh=y0zIX+KBoOVyLl1lGcBqZ+e5rFzymnFo9tPUEW6YMeQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OJtvwqK4kqXcJXrptvS40Xh7XotLY44N7pH9qos+rBKmghXzE427cdm77vk4C7GMz2dV7YE1TmrrUckvkfRjAsrwhwdXxZpM3Nx4IY1c63DkLQjszi/CmiDwzrHrB7juW4ZiN6jbtQHDsvAOPHKAZ5dDOmpVKZsPhtja2XMpej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Mqu5uMvs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so4995137a91.0
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920912; x=1755525712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Co7Mq6oJyrCqVWs37l+pII7jWFOL/0/u/Dfz+X4plSU=;
        b=Mqu5uMvs5KMYfmKZabhXK4vmRUYlSAs3jTtJI9XL6Bc2pxUqszTpWoYWSWpAGFEEPQ
         qLMmBdMsYn1urEUzwVC5YgSiDEJwSED/jAjpXEPaNn6fi5RZtE/YXfmZaicJWcvKOVcj
         IfRjikBzCkEvx+NKwKkchs8lDlt4M49KCjEqihEfNRhZhYxTU/XWF9WAXqU6Ga2jxw4j
         Pz4i6oYto/uBo4dJza3h4S8lssVRTRjYofC6bnk/9pppfp4YpXCmVGgiMqPbx+tZx6Ps
         HkrGzKgxpcTjXJevM9JY2Aib1MYJSfYyP2kDgbWrWP8OC1sooWHDGlIL1OBrwKCJsviV
         KIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920912; x=1755525712;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co7Mq6oJyrCqVWs37l+pII7jWFOL/0/u/Dfz+X4plSU=;
        b=ZAzfkc7ZAfoCxAc4yogppuiIqe2KHi4Nlf4BCVxSR8/PzhltIuuDdqPABZELT8JbQJ
         l8EwvKaUVFIxiZLU2g2bhdC70e7ek2GPGzb2z0zcyNNHQU1aVnkS4Nmoaji5WFkGUgQj
         MvTh0HfJ1EYbkBpdiy6IDpXr7YIOnxrGYpjoXvM3Bv9Rjiu2eedEv8vH233ttH/lRkZI
         2WZCD87IbWel+cjjVIdQAV+yezj5rz9x/f3lY/ssBikP/VI1D1D/ehJFy28fcnXWAgzS
         fxmfYxgiJePryF23Wx8RoQt46bIfC74WP4zCvN+AHjB09hWdRPyWHT5glBNUMOkZZcmw
         8Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCUa9w9G0Rhw+ioYG6wISA5H7jkzwH8GJdNHmitFQfYbYJxuVi8/kn88we3TkVs7CCxQB5UI7CzX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz//VrHIbMLjrJaNweUhHLQTLWm/dAmxAK+FG0/Ba/uYq+Oxc+
	NTcuzjlY9fAcjmB5GsORohjhnbcegcYaqh4rc5jH+Zs1J1rW6b0zg05ZNOMt5pI3sCQ=
X-Gm-Gg: ASbGnctmxY+nwQVyHO6uA8+nu/auZJwb4vQFSHb1Rry91znB1WNPCKdnC62M6yRepfL
	XnPcGXflIvMKA1JQxFmhcVpv8vPmdfIZH1IOwgUErf/YDA7/1loruHB3K8s1gU2Qj+UYPREAXSv
	8/Qd2SfHV5OGeeeVZxwnFSWn5sb2yKi4qLNn3d+mmYfP2SloLWUA/VF3bm7TuF/9XqENaytfUYh
	WDhLSSqDczybh/WvWoTx/V6KmazW6c6awCZ3ip0ZmfEq8/DTkM9WFG6BgPO3OyQ7rvt/Lis8Z0z
	ifYZEAzzQqAAJNcrh7ePsBlaWew87577P4kIrpj9tTOWmxsnnYLf0kQ7xORMAVSIULIX49TEXRo
	cMSosP35C/1ecLbvR09Sc3HzUQQ==
X-Google-Smtp-Source: AGHT+IHdapQQqIEBFEuAI4fgLuc7zanwo1g6eAIPxfo3wR6CEjTbZw+JPfriC+9e8kRAaZJLbRghjA==
X-Received: by 2002:a17:90b:48d1:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-321839fde25mr20913876a91.15.1754920910599;
        Mon, 11 Aug 2025 07:01:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250809141358.168781-1-rongqianfeng@vivo.com>
References: <20250809141358.168781-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] blk-cgroup: remove redundant __GFP_NOWARN
Message-Id: <175492090902.697940.7586040071360422708.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:49 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 09 Aug 2025 22:13:58 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: remove redundant __GFP_NOWARN
      commit: 196447c712dd486f4315356c572a1d13dd743f08

Best regards,
-- 
Jens Axboe




