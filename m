Return-Path: <cgroups+bounces-7034-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C07A5ED5A
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 08:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FF91799FB
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C2260381;
	Thu, 13 Mar 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gvnkWa1d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948F25FA2E
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852353; cv=none; b=N+mz+rzajc6cNZHWoEfyWB5dHkqLzhoYwPkxFbG/XPoi+jv5h1f4xsxAzPooYBW7m4nWPiAo0gnN3d/Qu13kXmaf2eUFQXKlQBPsvy/OvKfn8i8fpFYJU5rcpNdO9RsCNk7KhTLBodvYmHP5xg8N9ekVu8/3hY5rWg1Qnh3yaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852353; c=relaxed/simple;
	bh=g+coC1tcSoO2mePh9mteUAAAd7rmYV5+RU0XhaHQIq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpirbeH6pytilODi+AqOHPbIfXrM+7BX3nnVMn8VzEudRRuwUwZtUhEI0aO6grwGYwtxsM7xKqpdPfyz22bd06ojqUZCxZelafreB+GcloyZ4Uo4EQPfJpbuegVqHZ8jCAmDtxtlLmTW+EaWTnU02OivFX1+zMYTV2e7HopcamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gvnkWa1d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf257158fso3545915e9.2
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741852349; x=1742457149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwKhF6W+tY2SZzFtha8IxW1ChO3y61zw2i9r0o8B2QM=;
        b=gvnkWa1dTn8bnDsDsjzCGK+rpozRpKybJ2qqofvSGjcfUKLLYWdHnpuG17AEbE6acL
         XOp/E2G+kWaEZysM0ai/bppHNYH4h2MMreiozIiLzHek2c5I9Vv+Sy0l2kY3Caxa37m3
         iLg13YSoislMrABZvJtjPf7wCzOT6e/avUIuPWdmIbJFG6PhE5aW6iDodwBg9icFpy+Y
         mix3HBf3krai6JTYzrv5q+/tOX9MRIHgh30Kb1EhbChyyb4F0hRGxah1ovbz9K4wFiBe
         Ni8tiMmWs852FQWFqma8uZK0ikONpyU3mCo4upBTPfCvIUA2wcOsYcEEC70iBCbQgivu
         eFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741852349; x=1742457149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwKhF6W+tY2SZzFtha8IxW1ChO3y61zw2i9r0o8B2QM=;
        b=pjg+/i8pe0OmhSFGe6/Rn1zBukrZLfCHFrQxJPs9QC79lVmJ9JyMl/s3CM842mSHi0
         ucVIaYbbW4WZl38VCv08SS1FqbhwdzxZ8n4zQAptb3OvW+lgiaTx572XDTCeRPzNGA+N
         lgVphEGtRkYrGXjlmFuh9jyTymR2tRofmLvXPsGMpQHDCGJV5B+PI8dvXBp2/edo9bxv
         JB/b6BzmUw1x4IWsQP8DNz/3q/GgcHad7T99TEiMqG8pkVpcUAGvFsmmsTOLwloxLsHu
         MsAUKTxGXeSqs/r9UU+kjqUoSiP7aUSbOW4zoN63Hy2TKp26tzW6u9oeAf7HiTt1T0Jw
         EcQw==
X-Forwarded-Encrypted: i=1; AJvYcCUYNLM7kD61jnZID1jqKsva4Q6UoCEC5gPUBg43vyhL4HORZXZB/nFhThyAGfJaiWRB0sRYtFjI@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLbHxyhu59FA7Cb/yIC1ue4D0JXZD5VDgyAgr5AY1piqSDEjm
	jvZ+Z8gqyJGXgKjOLVD2T6W1J8WDKXEcN2u+9MOg9VKcCahn1Uck86kbTcuLl/o=
X-Gm-Gg: ASbGncuGGnKguymhWncSYm85sM+sELgPp+RtM1d3TWSvvvLcmBOkRqsAZGlh1F0+o9i
	NjYdLGVYTtuZ2Uo2bkhyybxGBNnRht7sZVKzaBXGWmmZLfUFgGyI5/02OkQORHnwMgF/FS29dG4
	jFoLm/46G2j1BdUCD8RG2c0EleM/2MP84JaV2UarFd2itKDykJbSu6ct26clA7idRb8bKwpO90p
	rEYCn8zA12smprwx4s0Ow/lOw1JRSO0Tn/CE/2CZWJlcHkP9qVUXYGXG7HKaPp8YE0w7qlIoqPI
	a1CgFYiFYgS5jMdyQyjKcuMBgJaggXNifT+Gi0idfvNTu2yftWptcZ+9yA==
X-Google-Smtp-Source: AGHT+IElPecKlbEZZxwASyZJ3LHCo6Gze44psTuhhZlIHYx5NP2MBXEcSOn5ghjbG0glf2GQOqurSA==
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b706 with SMTP id 5b1f17b1804b1-43ceeeeb95amr117545505e9.24.1741852348716;
        Thu, 13 Mar 2025 00:52:28 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df3537sm1197565f8f.8.2025.03.13.00.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:52:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:52:27 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: avoid refill_stock for root memcg
Message-ID: <Z9KOu9XTe5O7tqRd@tiehlicka>
References: <20250313054812.2185900-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313054812.2185900-1-shakeel.butt@linux.dev>

On Wed 12-03-25 22:48:12, Shakeel Butt wrote:
> We never charge the page counters of root memcg, so there is no need to
> put root memcg in the memcg stock. At the moment, refill_stock() can be
> called from try_charge_memcg(), obj_cgroup_uncharge_pages() and
> mem_cgroup_uncharge_skmem().
> 
> The try_charge_memcg() and mem_cgroup_uncharge_skmem() are never called
> with root memcg, so those are fine. However obj_cgroup_uncharge_pages()
> can potentially call refill_stock() with root memcg if the objcg object
> has been reparented over to the root memcg. Let's just avoid
> refill_stock() from obj_cgroup_uncharge_pages() for root memcg.

Makes sense. It is just pointless draining of a different memcg.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhockoc@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e08ce52caabd..393b73aec6dd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2643,7 +2643,8 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  
>  	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
>  	memcg1_account_kmem(memcg, -nr_pages);
> -	refill_stock(memcg, nr_pages);
> +	if (!mem_cgroup_is_root(memcg))
> +		refill_stock(memcg, nr_pages);
>  
>  	css_put(&memcg->css);
>  }
> -- 
> 2.47.1
> 

-- 
Michal Hocko
SUSE Labs

