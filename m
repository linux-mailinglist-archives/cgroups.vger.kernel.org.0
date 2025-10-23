Return-Path: <cgroups+bounces-11062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A10C01536
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 15:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F54F24BB
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BECC314D38;
	Thu, 23 Oct 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="awbeEmJn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624B314B71
	for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225500; cv=none; b=lwwaEBNEVg/heMBdq7vEASQTyH6xNDcfCJK/kCufydD5jPo4eVD8c/ClvY2aF+fMFUoWsrbqTlLdxTcava7fby/HLOFJrmGpvHwPZRww4fRUo9jcPq5TL5/1lKatOYrB9ATR4O9MND7xo0WZ54pEJFxUH/rH4wIN6ZeOoX2fgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225500; c=relaxed/simple;
	bh=Lc1Mo56YYeHKGhtOHcFCM5aAwC89s+OOPJH/HCtbr+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9H6L37+yufLwoeFYkch5+UiahAFMvsnR4RbRP/ndc8X7xsfKAaQRleoCpe7h74W3URb8DKG951goU3V5ZGDYs69vWEouTt/9XPTAhdVEcSKuEE5m6MhOTWzC/2hkdMmw64kapahH9fT0P1izOMxvt22uszFqMUl0uV7vm+bjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=awbeEmJn; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so4461595e9.0
        for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761225496; x=1761830296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3He/u9vFruVYiw+KrZIv2T9bBvLzWNfQ1++/hzzXmzs=;
        b=awbeEmJnt394LyQM7QuLbDnvuoiIc5klnnJgDryMDLr+VGZo1qYUGw6HLuAC9pc4aH
         dn2TA4tgT+dgBBNPr+6MK2uiB20xYtM5NCr+Xx3wD7UzRXXp0OYpBErdaw/7TvmhOjbf
         WT22bUkCD16E9Fql7QmH4xGciMGTTE9VM0jBSA3qGYWu0XiUciq/15mwIn8hh7+1wKrB
         JpTrhXIMWrOFdzhCvzJefooK30sJS9ASZ+cCLpqciv/Ne222O+ciTVoMsAifqRSUO51a
         Wd8fcgpRmGWTEQspZQgXJPS7rqxg6gqczqGdFFQChXosFgRe0lEL15QnLhGL5QsLwE7d
         Jysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225496; x=1761830296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3He/u9vFruVYiw+KrZIv2T9bBvLzWNfQ1++/hzzXmzs=;
        b=ZjPhNX4zO8eugR/y30GpWrKs4VzMh3pCfy+3NzfgRAWOarRHC4yWqQ/xs7QPVO/G4x
         o0GR6f2JCxBFQyumEQH7CHc+LfR0ZfeQM/AaoVLjGdw+3yAMLbrT79zt2Kf/apXLx5nl
         IhwjdD9lUc1HnOxX53X28sWB06T1bMSIaJ5Et9CAeMqXhpKEZ4aAu+Fq6kmux5uS835R
         Bb66HjAN1zgwsdCqgw3xuDmM16Dcz/E++rRkUYYB/tY4E2Qa1pulCeTDZj81ke+cnOBH
         LXsFmXm6GJ7a7+HkbnqpvPxrZP/YnSeJL4lRK4xuJw1V9xFdb3J54Yf8uHBSwRqDtKaV
         23Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVZppHkarh1/15QP/iCtl1Pz9tGv3kahorBvxrZ4iBIQBPUqbPveHa6reM1vUzIvcUZc5TNPs8y@vger.kernel.org
X-Gm-Message-State: AOJu0YwicnUE/g14K8BKT2I8mxpnKPNE1gBJ3N8AMc5UjZ3YecUrgbXr
	6AcUhFdRIbf7VhZA2PZUBgJcnKB4xuBnbj1zsn2IShvYNMXhMiZmBeJavWvPpD96IHc=
X-Gm-Gg: ASbGnct/bryVbcgx+9IMllsxhnnfpZwHcEPK+sb6llMKz/DjJjf8uSOnd24pTf3WpBj
	DIs7j2YX69Tc0nFpcii85yA2PsWH+BHgXCFRvoejZQFhgwhtiBjmul/ISD0q+6/23XlPwk134Ki
	yrIMaFU3AMGACvtMmqJvMy5TQDBLFmLb1YvjxCDA1TSLAroAGiIGrnHJQL+CDKtf+Ccy1kSzHC6
	vsSa17cEhUEsZZwEiAxhQbZoeToTLksu54K0i9fOpw905c6LYXGfrqzA8WmpIPbrAbrEeWkzYdW
	NYrjO3xxrO31YhXNZs705/bAD+pgQb3GWJCri2gO9PCunS5nZtgvcmTspf+p6PUeUr63DxFJl2e
	2CoRsCfCl0tdVhUHcFCgCz5S9Sjfz1jm/QNSRXKnXRCLL/+JeIVcAKMeDgiPiLy8igrPvVK6IZM
	I150sIrY/91OB3+cmsXxFKGEw19SLio5wuZoyP
X-Google-Smtp-Source: AGHT+IFI7d4omhBXbweB66gvKZIb/3KhXaNp52twT+N2y9aaJX7j7EPXuCFbvF4eTwXcj+1QGz7jOQ==
X-Received: by 2002:a05:600c:3512:b0:471:12c2:201f with SMTP id 5b1f17b1804b1-471179134f0mr209161265e9.32.1761225496200;
        Thu, 23 Oct 2025 06:18:16 -0700 (PDT)
Received: from localhost (134.pool62-36-43.static.orange.es. [62.36.43.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm98414875e9.8.2025.10.23.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:18:15 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:18:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
Message-ID: <aPorFhxQc7K5iLZc@tiehlicka>
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021234425.1885471-1-shakeel.butt@linux.dev>

On Tue 21-10-25 16:44:25, Shakeel Butt wrote:
> The function __memcg_memory_event has been unnecessarily marked inline
> even when it is not really performance critical. It is usually called
> to track extreme conditions. Over the time, it has evolved to include
> more functionality and inlining it is causing more harm.
> 
> Before the patch:
> $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
>    text    data     bss     dec     hex filename
>   35645   10574    4192   50411    c4eb mm/memcontrol.o
>   54738    1658       0   56396    dc4c net/ipv4/tcp_input.o
>   34644    1065       0   35709    8b7d net/ipv4/tcp_output.o
> 
> After the patch:
> $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
>    text    data     bss     dec     hex filename
>   35137   10446    4192   49775    c26f mm/memcontrol.o
>   54322    1562       0   55884    da4c net/ipv4/tcp_input.o
>   34492    1017       0   35509    8ab5 net/ipv4/tcp_output.o
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

As the only user is in tree should we make that EXPORT_SYMBOL_GPL
instead?

-- 
Michal Hocko
SUSE Labs

