Return-Path: <cgroups+bounces-11587-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B0C346FD
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 09:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EFFC4E683F
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ABB287518;
	Wed,  5 Nov 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WkbWvACo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D0F27FB28
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330801; cv=none; b=bEgrZFCaYLMXpJiWpNGLx4Vt2U9FBEvCFzgWNtHBpRSmYnL0UBqFRCwKVNYR6Gw1kGXLewTrfqoigzmBaVHsQjtyHbpYU01AB7kAJZDKp+s35n6U0+ZeG12unn7/H2inQrqIxrmbCL49mGkbOon+s+7FdpdZVBcDADKp32XIGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330801; c=relaxed/simple;
	bh=iGlHjbSVKGGym3U23i7SdjhPDqTMOthBoaOervoF05M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAEwPjtsuECRuzEWzE1OWN6y6Spxeqk69p5dZ/FvkIJw4+ki9FnX8TCz28ce3vVGbuz1XjkQilUqRz/rZzy1zQY3GkPPN2F2oMpYPG6rRcOpA4U0PVqi3Y7xZU/qBpb9i7SUucUpC9u2uDjlaN6XVNm8TwWUg113CtyN7l+LS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WkbWvACo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso845054066b.2
        for <cgroups@vger.kernel.org>; Wed, 05 Nov 2025 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762330798; x=1762935598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQrBXNgrEH7DGm+hsPHKmGk/jGaaI76D+GIvDvjNENU=;
        b=WkbWvACoB/fFiHXMSnTOSxXQwU5vNBRJSzl9rdtOgnNpLCYIp2QqZ5YN4ulMN1FRRP
         Smh59WACgEvGQFGHdr0vQU+HVXLl1gLEcYMTB3Vmr4pBwg+gOd12oi1e+/8M+po/NSZt
         74WBtDYuxEmmk07I8Gunwq+EYOEtWcUU0NyOd5e6+Py3ahqnPZHbwL0btGIIDG5vVNBl
         sTib4O30Mvm/O91Zm2eLpOIYlyMr9OyNrGibW2uq3vKJT3yZT5/vXCU6Un0RUkhofQSq
         33fh47f+E6A6ONIJKSRAf5u+gDmOY6mRh8cNEmQ+fAkjO+OUMXh71p/qWIvcfEK0ZFI8
         wMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762330798; x=1762935598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQrBXNgrEH7DGm+hsPHKmGk/jGaaI76D+GIvDvjNENU=;
        b=ux0NyYlIrJEFYAOnoLzwPEuB9vcjAfvFMy03h8QLerPbcDFdtOXyMCx0Ar6wkmPylz
         p5nOx+r2rq3XuNXqfO+EtTswS59zRwQBSh9/wc1cDRjk/ODA9T9mK8fvY4o3Xj75nzdt
         4z/EHHsSc+BPQAG6GOIYcOZbihx+tDyaPYTmWIJIp9CDQNqrwQVS5T7H3jrS7Xu2J3O6
         ewvLC/KRRgtBqHBaveIlPbFGE3f5xhdAplW9DwEz/f5pkg6xrbXkYUXaSVbkGIl5TSfM
         RKsLXJujhb9fW8ADgSRLyHR243lyfdtpp3xiWm2zzVLoeMOn3UMYdk7oXtXtle3baH+7
         2/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDG3wDahJgdZ24ZRrgM9En1yS2yqyVX8J+Qei/VvV20jjQIVZVqugzSyIYzDrCm5yfrxl7e9HK@vger.kernel.org
X-Gm-Message-State: AOJu0YyjobniFjXCuOsrNOF/xzgxfk58vQVtcWZsZCFbQNhTRi4QVohi
	01KSytr4BzAkqsFULQqSzWwRFYjtB4BSPoG8EnoQaXw+WnX1E+e/bqUMN1yw33Wxb6U=
X-Gm-Gg: ASbGncvxzQXlSU6Z9UD4Tq6eDzowtQhCjFhkhCj2D5D1xuVZRNmOmz0pavvMU7T3kts
	pDTaLzvRQsGPEfrn6FIUrP9JCdC3PMUyB+5Q1+HlVRavehaKtm/I9i2VaNQnTWDObdb7uB1daG+
	JSTl5Q9tIP2tl0grqjKMaL478y8KMj7gahYRcL4LwDwrbN1yym+dD1L76SfR7q1m/dVfTX3wCnb
	d3nFQycvLDsX9sapQaNZuU5maoMGHRahmfRqCBUYrKM0TuOcCSfpHxH77dMmraaOLfHf3mPrQGu
	touLXD+qHJtdrKXZxbO/SC9NAglY8Ua7Uos3JoDme6fdQJ+Vy9wMypaa8/pbfZNqBxHPyitjTKI
	gX4a8SQ20jp2vixFrU9xcVth3xzb1h0xoHK3bG6pCpjk0U9jCLKUCDjmn7eKJOffXnQa80T7Op3
	J5SuE0L1sS2/mulw==
X-Google-Smtp-Source: AGHT+IEXHVZLvJt37T+Or0zq36XdlBJ5vgi75Kr1QEZUdY14YccQtqD44O4+t6LmVKBw9ksebwzytg==
X-Received: by 2002:a17:907:6ea6:b0:b6d:8e29:8f67 with SMTP id a640c23a62f3a-b72653eac19mr201927966b.26.1762330797054;
        Wed, 05 Nov 2025 00:19:57 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b725d86b9b1sm269126066b.25.2025.11.05.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:19:56 -0800 (PST)
Date: Wed, 5 Nov 2025 09:19:55 +0100
From: Michal Hocko <mhocko@suse.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
	laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
	corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Message-ID: <aQsIq_zQXMfNNo6G@tiehlicka>
References: <20251105074917.94531-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105074917.94531-1-leon.huangfu@shopee.com>

On Wed 05-11-25 15:49:16, Leon Huang Fu wrote:
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 6eed14bff742..8cab6b52424b 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2040,6 +2040,7 @@ struct cftype mem_cgroup_legacy_files[] = {
>  	{
>  		.name = "stat",
>  		.seq_show = memory_stat_show,
> +		.write_u64 = memory_stat_write,
>  	},
>  	{
>  		.name = "force_empty",
> @@ -2078,6 +2079,7 @@ struct cftype mem_cgroup_legacy_files[] = {
>  	{
>  		.name = "numa_stat",
>  		.seq_show = memcg_numa_stat_show,
> +		.write_u64 = memory_stat_write,
>  	},

Any reason you are not using .write like others? Also is there any
reason why a specific value is required. /proc/sys/vm/stat_refresh which does
something similar ignores the value. Also memcg.peak write handler which
resets the peak value ignores it. It is true that a specific value
allows for future extensions but I guess it would be better to be
consistent with others here.

One last thing to consider is whether this should follow
/proc/sys/vm/stat_refresh path and have a single file to flush them all
or have a per file flushing. I do not have a strong preference but
considering both are doing the same thing it makes sense to go
stat_refresh path.

In any case, thanks for considering the explicit flushing path which is
IMHO much better than flushing tunning which would become really hard
for admins to wrap their heads around. Especially when dealing with
large fleets of machines to maintain.
-- 
Michal Hocko
SUSE Labs

