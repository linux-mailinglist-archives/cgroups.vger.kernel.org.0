Return-Path: <cgroups+bounces-4233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627B950C21
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 20:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C515F1F224BC
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4E1A0723;
	Tue, 13 Aug 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="HEb1DCRK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB643155
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573291; cv=none; b=uAWc4YkxMngcawoqgk4Kl90KlvaRmMazLrM4XrudovW8ODgAher28I+LvQ2TRAtRsKuMj4RwsBLeDpIlkdQrm3tnpzHqkvhgYgKg/b032Ru0nLMuiuuOFE4QM/NPXL/dw+JO7RHLC+UPxQKZ+pa9DBBDlPsYIoO1nb8FqJtLF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573291; c=relaxed/simple;
	bh=RkoPZNXVHHad8Jd9754GoREbOaQjonahlrs0ZLGF4/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpjNhFyAo1WB942+6nsp3C06JRogSaI6WlaH4OZroZdkQkmRpOv2F6hXDruMQwDrWkHTo0W6yqxydTb5E6TmvO9GcAjOoDgiEmtWhTMLEBsrbf34Oe7eCDvwx7IHqP77aL7nK9vATN+5UbT0wdSQrMAy2Ta08YUVkr46Tx3he6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=HEb1DCRK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a4df9dc885so13746885a.0
        for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1723573286; x=1724178086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4srqY1VfFiOMLNs/NhVDn1626nsyX4ITdrlzQ6L/6mo=;
        b=HEb1DCRK+qd+OKjVB/nm9qn6HMK9nFIkyNCYjanhTNLZIbOM9wNJJ0rMl3+8LftHJc
         /MUtFcswpu3cHpuRzHbZw+ep8Qk9wnCDEgM1lEWRS6VCGywrYLUZZ0RUgKPOZnfks7Ac
         nPMc2dNXGEf0eRuZNyLm8PKNDNgUTmBTsKL0xl2wxzS5oMSaTpGbTtFfgWCuw8i9gjuW
         OmO0CavisTBauyJu5YT2tgOJ82JJ2Q+SZz9wTxZcCZvggqGiZKOzR1cfDT5dBphH7YTo
         482d/2PBQ7+v9gI5NrsiHoJKaU8/j6Qkh0hvKf+ZB50xSvdG86qpVx76SMVWRuEJVpGJ
         nXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573286; x=1724178086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4srqY1VfFiOMLNs/NhVDn1626nsyX4ITdrlzQ6L/6mo=;
        b=j04l5UdhWBBmoecWKs1EzE/upAynAZ7RPGi9/sukfhJ0J/gqDUpUan+KacuGHEJYM+
         8p0aahTlg2j61J9bblSImFcOFSghQm4McD2BmlZpPONtUNaoTiB2AL4GacnakV/bWLwL
         i2dFs/rFaMw3LxICNflKU6rTA0v6yioKlYFhaJN5frYkpoOJQAbMJv8BuMWSw528Lf4l
         5B/wCavMESzI9fygtOr893E4IVTwGXyff6IL2Sl4rkxkAXVkhJBTl8mdBVSm1RbPACqs
         QvQNi7UV+XU6fE+1lGS9QG7yZcpwhAo0DY/cmnhNfexxd239QvZ51OgWHFb6wniw9bQ5
         ydZA==
X-Forwarded-Encrypted: i=1; AJvYcCXMitsf0ofkSACfECN7BjiDEpMOY/doGsYL6T+GbZrZ9QmtGOSXcmNUz4PP9ON/Xcvg4VZIQMaOFHTdXeq//qjKQO3xX7MY7Q==
X-Gm-Message-State: AOJu0YzC27ZpZMK7XIv6DnDYj8P/aXFbJFuWCZk4I3TgOnwELawzt9Mb
	OarHdvj1cMC+W4Cm07h6jvHjVNqRG4rm8AAFysoRspu1AzzHwMkYS6yWEu8XilXZanZ2B2JGwPw
	cwQ==
X-Google-Smtp-Source: AGHT+IE1AvRjfihIaTOyLrEW8dJCgcyY2eVQa95vZY+zLbcE73c0pa9MNuuc5TzPQHUA0ITZ8qMdsA==
X-Received: by 2002:a05:620a:4504:b0:7a2:1bc:be05 with SMTP id af79cd13be357-7a4e38c4c51mr697580085a.31.1723573285919;
        Tue, 13 Aug 2024 11:21:25 -0700 (PDT)
Received: from localhost.localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d72091sm361400085a.42.2024.08.13.11.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:21:25 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:21:20 +0000
From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
To: David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, mhocko@kernel.org, nehagholkar@meta.com,
	abhishekd@meta.com, hannes@cmpxchg.org
Subject: Re: [PATCH] mm,memcg: provide per-cgroup counters for NUMA balancing
 operations
Message-ID: <ZrukILyQhMAKWwTe@localhost.localhost>
References: <20240809212115.59291-1-kaiyang2@cs.cmu.edu>
 <e34a841c-c4c6-30fd-ca20-312c84654c34@google.com>
 <ZrqRXtVAkbC-q9SP@localhost.localhost>
 <284406af-56b8-4b66-750f-10f9d38cfac7@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284406af-56b8-4b66-750f-10f9d38cfac7@google.com>

On Mon, Aug 12, 2024 at 10:09:55PM -0700, David Rientjes wrote:
> Does this include top-tier specific memory limits as well?

Yes, we plan to have top-tier specific memory protection (like memory.low)
and memory limit (like memory.high). Exactly what the interface will
look like will probably depends on the community feedback. Maybe it's
just adding a memory_top_tier.low/high knob, maybe something else.

> And is your primary motivation the promotion path through NUMA Balancing 
> or are you also looking at demotion to develop a comprehensive policy for 
> memory placement using these limits?

Both promotion and demotion/reclaim path. If we want top-tier memory
protection and limit, moderating both promotion and demotion is I think
a must for converging on a stable distribution of memory usage on top-tier
and slower tier.

Kaiyang

