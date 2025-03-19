Return-Path: <cgroups+bounces-7175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFE7A69994
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 20:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191A67A8774
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8F2147EE;
	Wed, 19 Mar 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="IglDzcCe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F91F4164
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413126; cv=none; b=BbG7mVg89lQxbcsMpfWZAMyzY/PWdUTiHxYajDz1ndlHY1NnqMxjzTufNEdaZ+KZ5a9Jf11HLndY6Ep1LSdc1qX62tO5m9pQjtyX7Q/+vzBPV3fAw56key4pteVTR1YefwMNrAajXRIqtjpN2y9Tb0airOHtwEt9qt70USQjIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413126; c=relaxed/simple;
	bh=iTVzyjVND7+F0XXvBx/0F1D8RMJY6QzOoyEcjmniBXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnMYTGv6+6K+zLYcovZC0T6gfsfqU8oLJJWunXOZiszF0wiMWklxd5/K4/zbGmbGC96Xr6pnvFaTB1eZ92+eCvelf3NLxsncc0tscAHGZxZ80oRHYR2tGmd/+AwNTntkwOj9kN1SFchPvSJNKQc0BoIQifyMT41d+CvUAseJv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=IglDzcCe; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769bbc21b0so597581cf.2
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742413123; x=1743017923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOsixAo0ygM8pbnBoreCQ/wxYJRqmZpkjLr4PFhJr7E=;
        b=IglDzcCeE+YAudSJLwaui9djKhAZxmY4ZElk6SRJWKTu8/scg8ianfxGmjGsgVijR0
         RDkeX8rkyxN7cPzDnmXXdL2/RnH5MrLq/+jNRGB12L/j6mXkCyasrBvgXaTS2xrjDvVa
         8f9PxbdMnUvsXXy9xcIGqmxjTWAvLDHgiOzU8L6dyDjQoc+eJqGzBJZ1smQEgorhO6xB
         T7Gb9c87DoliY7MusUT4S+C8x3qW1nZJjomkNtUtqYFKQ9/jcDFB2tWbr0gaxYaDO1wr
         7jW8DIgFjhtIA6ZvY0cYg9YP+sV5YhCNA557DkR6t3J+CPlv0TfAGV19zj+3wnfqHerc
         4lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413123; x=1743017923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOsixAo0ygM8pbnBoreCQ/wxYJRqmZpkjLr4PFhJr7E=;
        b=ERsw3PcUo/h8MoGbI4afztZds1anrCCjIc3uZAWAR7z4B22lHOwBgIyKdKoC5qVHk3
         9CLv5jGl4BQVpSjJ6A170pGL+xz+CbPAooBXeQFrhK/jJ7kLAUPKlbYLQcwtSMXudfno
         BV6QeNSk9BiDsksYXqSR/enomDNfA49xqQFEpWfq8ndh00NLIBsA7tSuIdWKl6so8zp4
         6by3sFknrm8zox0gV/CsvynJSyJUWoCW0rvuoreXvjgG0gMLFArInC+F4/N8q59jFTFu
         Iwu1z5Ia3oa17fds3+MkbmSUom/GRoFkZqi0bWHjmpZpOJFWbWHe2wB4SQF0ODFGMGI0
         jnBA==
X-Forwarded-Encrypted: i=1; AJvYcCWs5k9gQ0vIRYkv/xLX5TJYe31S57G0nwKuEzMXkoSBXb2LglV6jFGdacDdciuhag/LTm+6GzsW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UJdrLeah8vJuO4nrvHQgMrxfow4ZJHyzl4Q2ZxOoTYJnxnVn
	sbwWqkvNs3HqKh5C74BGRzrJEuCV0P79tt8QXpsmr9MeQaDmb4cNQ9Du6qj1wao=
X-Gm-Gg: ASbGnctF+nUCjBdu2XCy0Nd00v+b08LwXIk60ERDA0BrbNmp0Yr0K4vsuDSA6tGz+BO
	Wr947grhNzJrCW/9ZJ7tKpJa6oZHeYyVmP7PZz5o0GzLOtG2ycZIw4G/+0x1t4sBkFlVjAil/QH
	lytctiG64rSPGCwyK+XdvbbVWYN+8m9lQzE/awxeNJ0MI+4FmmVuxc0CSiYS0J8jpH5zLNlGAcv
	BmXmaSg25V8Uug66YbJxVceB3j3wds9mTzMPxPrQ9Daiflt9S1YRtucByv8zwae47Ir1Nrfr1I3
	UDkz/8+bWOZlxlHOF+4lw7zrna3I+BXyI8OSTc9zO7w=
X-Google-Smtp-Source: AGHT+IEnyT/QaZRGxSVvO87lm/uVpwiSi1//kCoa1GAM0k0kXVv6aSSGuoigVDhf/LPLiuSPY6r6Kw==
X-Received: by 2002:a05:622a:1e1b:b0:476:91a5:c832 with SMTP id d75a77b69052e-47708378761mr64518621cf.32.1742413123208;
        Wed, 19 Mar 2025 12:38:43 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb824a8csm83290581cf.65.2025.03.19.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:38:42 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:38:38 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Message-ID: <20250319193838.GE1876369@cmpxchg.org>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>

On Wed, Mar 19, 2025 at 02:41:43PM +0800, Jingxiang Zeng wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> memsw account is a very useful knob for container memory
> overcommitting: It's a great abstraction of the "expected total
> memory usage" of a container, so containers can't allocate too
> much memory using SWAP, but still be able to SWAP out.
> 
> For a simple example, with memsw.limit == memory.limit, containers
> can't exceed their original memory limit, even with SWAP enabled, they
> get OOM killed as how they used to, but the host is now able to
> offload cold pages.
> 
> Similar ability seems absent with V2: With memory.swap.max == 0, the
> host can't use SWAP to reclaim container memory at all. But with a
> value larger than that, containers are able to overuse memory, causing
> delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> out of balance, especially with compress SWAP backends.
> 
> This patch set adds two interfaces to control the behavior of the
> memory.swap.max/current in cgroupv2:
> 
> CONFIG_MEMSW_ACCOUNT_ON_DFL
> cgroup.memsw_account_on_dfl={0, 1}
> 
> When one of the interfaces is enabled: memory.swap.current and
> memory.swap.max represents the usage/limit of swap.
> When neither is enabled (default behavior),memory.swap.current and
> memory.swap.max represents the usage/limit of memory+swap.

This should be new knobs, e.g. memory.memsw.current, memory.memsw.max.

Overloading the existing swap knobs is confusing.

And there doesn't seem to be a good reason to make the behavior
either-or anyway. If memory.swap.max=max (default), it won't interfere
with the memsw operation. And it's at least conceivable somebody might
want to set both, memsw.max > swap.max, to get some flexibility while
excluding the craziest edge cases.

