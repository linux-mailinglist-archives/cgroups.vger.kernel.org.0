Return-Path: <cgroups+bounces-7943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F7AA434B
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B867A1B642E4
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72F1E9B09;
	Wed, 30 Apr 2025 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q/PoeP17"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51B1C8632
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745995708; cv=none; b=aCV98xB8AwYKqKSTy7rmtB15/xAjxeXo9XylBhwIGWVTMwrF1Oss3fy4c21uRSCPbcc1jhfmPM03iRtIgNpfQOmJTckA1QuK2tdDUVbR9Jzn5vdthp77hxx63PLnO83mtQ+ABfl+RV6DUfSCGsvqm98fLNqV9BVHkTZp9kqJr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745995708; c=relaxed/simple;
	bh=PLN6NCA6PHzK2vowJ9PJFQeTe/Z2MIvKVVvm73D7mzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5CHEnUavQRMXC5Xr49QuKeXQtgFAApSRktl43WRksM8u6WvI/nGJ/AQj4iXNZ/UP7qRpwxQxy8bFtshfUDY87kHz5viMLJK4JZMnDhy/lljRvaJKFZvWy+IuKR7UVEjD5oKQCdGfbKvlaaVPiLeTd5MkHcN2OqbY1b0hn+gydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q/PoeP17; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso3340779a12.3
        for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745995704; x=1746600504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gJ92PtyNc3uFgKzWrC3UQrDRf0Vc6MoU7lP4izaMto=;
        b=Q/PoeP17gJPCcGUa2sluScG2mEgr9c4qDILQLJGkWKciUawRd8EouJOeDiPA9AEi0+
         FFrp1nw2y2pASVuxgfRQq9WSKFhdY7eCJP1FJohfIJ0hl5Tqg1Y0LQTJMa5bHx7OWvCD
         ZOu2UHNrqVKb6gERBtjTPKUi99azxm28sDvhGyYaeC3KRkClzdxW60o+xxhNO+Mr/SsO
         0IN9XZWMzLeRp19DzR+Upe8XpJdpS9ptbWRAIacFMAZgUR/T3fnSxqIYSNBpokAwipiQ
         pU8d3bkGb7qCXnoKrNxYeLs/VOyXvja1SykcALvNYGZOWqVHAeXm5gy2BWgQZRjn79Zr
         1nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745995704; x=1746600504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gJ92PtyNc3uFgKzWrC3UQrDRf0Vc6MoU7lP4izaMto=;
        b=flNFaGkmFh3t67NdClCNlaYenstW7pTPoDm3KeG3ezC1iPFq6jV7//Mec2VrlGME1o
         +Z2yLPHqfXbUH93ZrwberKbVJlrnuwoHtvlQ6gWIxkbYNWktKqhH7BDbF5I6iCjiym2F
         qwa3ySTWgDQ3a4JBxdryrkRPbsedxxpWmBUkn1p2AUSR5lT6kkGYcULl4aHK+GKWxitV
         thxgFhUdFsvSSYrcPtPHtDzhtMr1VdmFhZfumYJlyLq9pVucQePMIxKG9fk6P+h73Ndj
         Mh7ce5rS1hhYf9LudYEJGY9qLI4jiyU4sqnkGFu7kjX8cBtNiQioUcwqrwqKq75RXWK3
         i3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrZoSNRZNirfy9J0QpQ+juA6BCMbXzyT6wlzKJgsfAVdso+TouG7e72GAOEKVWAL4Z7v73jN4W@vger.kernel.org
X-Gm-Message-State: AOJu0YwPkegSVxyqFmxkAby6I8WqDdJRKwlGoMvEvRE3dmiC6AMPSNbB
	WGNiv2OJYf3tEjdnnm8dQS/LhGm4RGoV+rCcTA0mkYYVC79ngtcQwcuzMCY31XU=
X-Gm-Gg: ASbGnctx3vOV3Yge8m6HwRlvmnAoJ+eHlA/+VP2jY04EvJ+3od5R/KivXAH9Ed/UEm1
	+VTKkAOCinC3aklgBVbh+Tiu0Lgn1r1JmBwwmv6v4abTnK2Ukee8o4g4o7JgYw5Tb7SAjsuo8D6
	ngCbk6QWW4Vva4O+QapXT8E7QHHTn0U76LNCcxTciHy1ekSBbcxz0xhtaGVelCy7YCzTM15kpvx
	piMekiO/eAZf3ABIo2aVxEuzhAkD/l9QENyEKG2hHFcQ4cICpkcytQDQJv0Ru0iH01EQn+NWqsy
	NYPeH9B84VN1531myhoqQp4+4KB7wwQ=
X-Google-Smtp-Source: AGHT+IG+39qW8j7pMcUfNcRNZlvzFRRTpTPxxGngSv3XVrBTzw6ESYdByYqN2IRu7Qx4KY3myhmFKg==
X-Received: by 2002:a17:907:968b:b0:ace:6c36:cd13 with SMTP id a640c23a62f3a-acee21642a4mr155109666b.3.1745995704239;
        Tue, 29 Apr 2025 23:48:24 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6e41ad27sm877283266b.5.2025.04.29.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 23:48:23 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:48:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <aBHHt9_ruks4q4Ll@tiehlicka>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
 <aBDCXB_Tb2Iaihua@tiehlicka>
 <qt5jtbsgjym655tbnoddlo5c7cemndcgsqwy4wp7m7ki3venxz@cfp637s7eqo6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qt5jtbsgjym655tbnoddlo5c7cemndcgsqwy4wp7m7ki3venxz@cfp637s7eqo6>

On Tue 29-04-25 11:43:29, Shakeel Butt wrote:
> On Tue, Apr 29, 2025 at 02:13:16PM +0200, Michal Hocko wrote:
> > 
> > > Some of the design choices are:
> > > 
> > > 1. Fit all caches memcgs in a single cacheline.
> > 
> > Could you be more specific about the reasoning? I suspect it is for the
> > network receive path you are mentioning above, right?
> > 
> 
> Here I meant why I chose NR_MEMCG_STOCK to be 7. Basically the first
> cacheline of per-cpu stock has all the cached memcg, so checking if a
> given memcg is cached or not should be comparable cheap as single cached
> memcg. You suggested comment already mentioned this.
> 
> However please note that we may find in future that 2 cachelines worth of
> cached memcgs are better for wider audience/workloads but for simplicity
> let's start with single cacheline worth of cached memcgs.

Right, and this is exactly why an extended reasoning is really due. We
have introduced magic constants in the past and then we were struggling
to decide whether this might regress something.

I can imagine that we could extend the caching to be adaptive in the
future and scale with the number of cgroups in some way.
> 
> [...]
> > 
> > Just a minor suggestion below. Other than that looks good to me (with
> > follow up fixes) in this thread.
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Thanks!
> > 
> 
> Thanks, I will send a diff for Andrew to squash it into original patch.

Thanks!
-- 
Michal Hocko
SUSE Labs

