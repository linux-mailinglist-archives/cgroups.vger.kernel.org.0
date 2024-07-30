Return-Path: <cgroups+bounces-3987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42694093C
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F66D1C2234C
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 07:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514118FDD2;
	Tue, 30 Jul 2024 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZH8TQMm3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22118FC6C
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323625; cv=none; b=bOVpPat3lNlHs+oHOXUiajQ0jpPuVDzWyQyCGJIsbzY+ZjnFCayFiVr7OGzwKn/nL5afSXw0U+ZynzSiZbozHEEXFgO+ugP9ogL54ck944+jF8uRcIp2FKLXtOaasDtN2KwfV03A0riWr4XOrxnVDJillcGo8Tl/6roUWV5quVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323625; c=relaxed/simple;
	bh=nFqkhvxsyk15u9JjoPfwv2HTZugFVr1gaBeyuH/Kfs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACj3fjEssodUvIkTkqVHUnQOBKaCD6Uok/I22QnzzCg/8Z3mmcpGjHqzp5tNyO2hpeOqHrotFOqG/BukTVL5tiNGS4mDGu/oIyZ/ZCUBuOr3M+BgDUogH9vtlFHPl4UXcAkUP98cF4ZmdRJWKMxEAbQrmpkwY98byKsMbZf1kQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZH8TQMm3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f025b94e07so56026121fa.0
        for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722323620; x=1722928420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8Jw306LnYMjl3oG/ZSN8RL6E+ZaAN6J5Cs3uDVTaZw=;
        b=ZH8TQMm38JJTpLTBfgInCs/1OLKmhGk1zy1fOZIWywnS8KLWMkF3dM9/RnLOyEh114
         ueNHWC8jBPYW+spOhuvtqLHtRvIvlSNr2jCzgoZJHmdji83sFISZRqqwBt2QQqadbuvN
         JUWJpnllMdJTZs4nBy7rB2ZObnqaRo727T5RnOMiYBt1lpd+NQ3UUnZRGLlGO6n1lBxh
         dXry203vDfch2zRxqQjSB6g74MZQ9OvnXvv2ly84x53X3/s9C/e0YA9geMfY2YTWjuaF
         2TOof9jAbsx+Hhrp2CfiHlJK3LbMabE86f7UceOwNeHAzmvjZBuFdrrM6DoGweEh7xBg
         bITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323620; x=1722928420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8Jw306LnYMjl3oG/ZSN8RL6E+ZaAN6J5Cs3uDVTaZw=;
        b=GrtnwlhyOpXNl/y0edKAPoGrl1H/IJlaXZOViBMC78kReqbtbX1H7H9VZ8YIodn0Jn
         CwgE5KzCosrDAIRwocfV8gzAy69JzenevazdSmViXKw9CzzrO9RVyhj6+MZ50JTkC5sT
         Y/j18/VHKcfYzl9xlBMGZ2bPTEnGUQR8IpSa1jIUoasAHVi/KDVf6vdvL+DQU9lkznoH
         i556D02UiZTeGytW67ZoLkngA5v/F57KFlkD59axjOM2HQBPBkfGUIbgJs3Y7wUE7Gs5
         wfgU8BQ74bAmAK3rrB8uPuoIHuhjj1zFr6gzlLuGQRTkSw/tJR9Vs/caH+ZzqHWkCwc6
         w8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTe22ssMcnzyEgwiUngeFgplfuyOJ4IFE8KlGHoD5F4EmWNXUULlr/9ULGjxShlc2X4Os/HxMBBjE8V0w8NyJdBFKclAkzPg==
X-Gm-Message-State: AOJu0YxMpwi66qvGsaybQGrEQduW+IwIg65lzJdRCIXd0U1SdESnwGdx
	e2TYBHq7UCR0S9zhyBMGTSc+558X4jBV21rOJoaUXVtr+Tlg7UtHVYY6rjBjnqw=
X-Google-Smtp-Source: AGHT+IHRg0ZBYYhcWjSKQ0NvUTuyVVrQfU7hqOyM8bqKvdWQ4J0rNsKyVW4w700F67i0tZ+o+BFmxw==
X-Received: by 2002:a2e:3009:0:b0:2ef:2c2e:598a with SMTP id 38308e7fff4ca-2f12ecd28b1mr76896251fa.11.1722323619832;
        Tue, 30 Jul 2024 00:13:39 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b8f51eaf5sm584855f8f.29.2024.07.30.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:13:39 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:13:38 +0200
From: Michal Hocko <mhocko@suse.com>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org,
	brauner@kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 01/39] memcg_write_event_control(): fix a
 user-triggerable oops
Message-ID: <ZqiSohxwLunBPnjT@tiehlicka>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>

On Tue 30-07-24 01:15:47, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> we are *not* guaranteed that anything past the terminating NUL
> is mapped (let alone initialized with anything sane).
> 
> [the sucker got moved in mainline]
> 

You could have preserved
Fixes: 0dea116876ee ("cgroup: implement eventfd-based generic API for notifications")
Cc: stable

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

and
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol-v1.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 2aeea4d8bf8e..417c96f2da28 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1842,9 +1842,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	buf = endp + 1;
>  
>  	cfd = simple_strtoul(buf, &endp, 10);
> -	if ((*endp != ' ') && (*endp != '\0'))
> +	if (*endp == '\0')
> +		buf = endp;
> +	else if (*endp == ' ')
> +		buf = endp + 1;
> +	else
>  		return -EINVAL;
> -	buf = endp + 1;
>  
>  	event = kzalloc(sizeof(*event), GFP_KERNEL);
>  	if (!event)
> -- 
> 2.39.2
> 

-- 
Michal Hocko
SUSE Labs

