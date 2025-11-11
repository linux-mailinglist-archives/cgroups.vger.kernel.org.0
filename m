Return-Path: <cgroups+bounces-11800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CFC4BAD3
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 07:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A81A74E8B10
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C442D595F;
	Tue, 11 Nov 2025 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="GdJyNN46"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C82D3EC7
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842462; cv=none; b=U0p+eLRcH22v4jUFkdpZKf76EEU7ZsAqstZ6aYaMpq70JEp2HbbyaEvhhwZwoz+Nt+h18gqGxSRYupZ7WAsfU08gEMoUXG9urlojcmJ252zm7iTMi0fj8Wok0TRJNWt34dUfTuW2LLlUuNh4zqBVet+pnbLqV/ZvNitLmp3zZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842462; c=relaxed/simple;
	bh=89750Oqu/BHAULCo/u4k/dwdc+TJgBdi3kwqH7WW9JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmuLiLuTTNZNdFv3e/k/spUEWL1cW6ldA+7xQ1iLDkT4wN8ygiLcXIEH3h0+JLpPHXHG5Zr4m06TArpb13ezSFr3XXkqysudK3roKNLw4/JouGmqjzjDGUUGULU+TV4mGWQPzlxYi2YVcLgRI2sOFsVLgCmzfA2RE3T/BxRIGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=GdJyNN46; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3439e1b6f72so1793072a91.2
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 22:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762842460; x=1763447260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89750Oqu/BHAULCo/u4k/dwdc+TJgBdi3kwqH7WW9JE=;
        b=GdJyNN46yLS3b1G+msP90X37DCoOmpaIXITKAdfe2Wc/tmb9yxRG1a3IFybkmtc1Fs
         NWvJT5mg7aCURM9KiMMFcgpvoaJDlYuHSM2FAAY2Ehh9M1Y9VK9577s0NKfeQsdeeypR
         mHEt9SsHqQPxA294PcPAjAduH5P9eCe3DLr0fi/W3yjcGkwYA9fGv+9Uv5Q8cGuFptRB
         GX/KuT/unYj/jp+ugjhaQ3ff82srJeJTVZArMTV/RawhUfBCp0E9j4e6T7gC9ppnLsgl
         mppvkVMWY+9xWYNwRI8VJoPhiyx+d6kwYCR8WEa7DfOO5QdC7cb3ANm85HVO/3V+NT+L
         ZaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762842460; x=1763447260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=89750Oqu/BHAULCo/u4k/dwdc+TJgBdi3kwqH7WW9JE=;
        b=XH0F59DQ7u5Dw1vlzAR2FkQDTf+kvgwLuccqDPUza1UaTUPQ2+dDIImPvzzKw1U4eJ
         nJOVuUL0MPbiUnxZ2YP0C/cAT7Kci68K+3+JJqh3849KsB/oSuQHJA2qW7ht7B6EJaV2
         FrZnDHfugCGv8X159kEuZbhNqndHRHFZW5qAF9AvxSPiBHWCv11nQG/RCzPPsB0AoOmC
         ikXyNEpql2x9mFC5akvMJa7NP8CvGG9Blln3rwoAbeIX7BlIlJzhKcrXin9X5gZfMXLl
         /cokI7e0R7RiLnJuSfnQcq/S/vNJQ0Hx7NO3LrxUgBF1QeXiSrzw4EOOQWe6nN9+4ceO
         4htA==
X-Forwarded-Encrypted: i=1; AJvYcCWKn2CJ8SIsLkeRHdV5AB9KGEtlxkDzlmmpI8BJlUQPcLLbxaxZtVRCzQgNnIFlhf1q40JTOFOO@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2C+O2x4FNnrhkobe1IcBTcKOyhJnwPRLNBBRMQ5632xCgmdJ
	8fBWF/JgO0AC/PhRg/LEF/Lpr1yczx9svYRLQnxz6vi3wIXxGhgjvsO1Kof7u0s6C1I=
X-Gm-Gg: ASbGnct1fkf5pmo2lZm1k6ijC+XU0+elsN6rBm80kh9ece4dtaU8eSYh64+DegxWZ09
	oHakgekt4vTibWPnRpOcedFesSdORR+rsoTQGzheXWvjLwjkfRN98UI6+pVnhE/sUWNvoBr4Saz
	9LXQNsIASi5AQcB7AXMa2psViRx7lzQaYIu2izv4+f9s68o/9MDAnyTMlRKlww7qqTmHhlh4D/6
	1hMcKSj/6wHThYpLZxUqUb7OcV6MotlnHi0cHHPcG/nVQsMqcEeCgjmG2NH4nt8sbbgWpzbzWjj
	W/4cgWC4SdCa1k5XIY//+xAynCyB+chD/xEbMHrKIN38ewKVCp2rygRa7GzFxQPceLKsa7PRmxv
	WEYkepyQeODaQLcKwoSX9e+Es6gpaY/KDLCvqv9jujb/EgMmEm/6zVRf09nmCMM5/87yaPClcwN
	Qat0apPqOfzaCw1ioWyj7diAAH
X-Google-Smtp-Source: AGHT+IHvv3nGqmj6KV33XK0cWeJgSfI0JoC5d0X073m/gYYS8JMWAEkjk7xwepmEOfVYPNtHkdK8iw==
X-Received: by 2002:a17:90b:3c09:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-3436cbf60c3mr13213813a91.22.1762842460272;
        Mon, 10 Nov 2025 22:27:40 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c6951633sm14267754b3a.0.2025.11.10.22.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:27:39 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: tj@kernel.org
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mhocko@kernel.org,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for on-demand stats flushing
Date: Tue, 11 Nov 2025 14:27:30 +0800
Message-ID: <20251111062732.72880-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aRINDrnnI1HVvU1p@slm.duckdns.org>
References: <aRINDrnnI1HVvU1p@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 11, 2025 at 12:04 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,

Hi Tejun,

>
> On Mon, Nov 10, 2025 at 02:50:11PM +0100, Michal Koutnı wrote:
> > All in all, I'd like to have more backing data on insufficiency of (all
> > the) rstat optimizations before opening explicit flushes like this
> > (especially when it's meant to be exposed by BPF already).
>
> +1. If the current behavior introduces errors too significant to ignore, I'd
> much rather see it fixed from the implementation side rather than exposing
> internal operation details like this.
>

I haven't observed any significant errors with the current behavior.

That said, I agree that we should focus on improving the flushing
implementation to enhance stats accuracy on high-core-count systems.
I'll review both the synchronous and asynchronous flushing paths to see
where we can tighten things up.

Thanks,
Leon

