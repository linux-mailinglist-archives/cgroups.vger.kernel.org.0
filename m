Return-Path: <cgroups+bounces-3907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B993CE86
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 09:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8F61F23652
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C649176AC9;
	Fri, 26 Jul 2024 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Suk7yVbi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63DE174EFC
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977623; cv=none; b=DYlC7P634QzkEus8AhB+mLzEtHOATfbQW9C1EKEAAP8k3oH3rErvLUvvzTDLMbQNEiYjSCbUyWfgePPIM4uz9UW8qtXs2zRKa0bulCC0+QL95eFJyrh29x5jD/JfCLz6Oyq5bC5tfac2ThoBnBP5oZlBkEa9N4ulX9IG42HCgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977623; c=relaxed/simple;
	bh=wSoi4zLMIXPCXwIQ1UKPrQlhNTFJzZZZMgRyq8qz/f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB6LEzzs/PUVuWRkH0y63WTtUsBL/E3Ap6unaD19b8chfvkuuAlj5FnZNa6Tg4GTqAbwQgxxvWIvGXdAK4NikDeZUZem4gwzv+clqFPO5y1OvnVsGRm8e57zZV5Imo0is7rbkkJipk526cNTCH2pfZoE/Y5n24O55yHVJvGvSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Suk7yVbi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so2419033a12.2
        for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721977619; x=1722582419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LN2nwbjbyXoRcJjZ570U1pjE8CZSOfXAC4h71zhOWHo=;
        b=Suk7yVbiyCyxjxyqtajvHDYi9fR2PZw2sA3fql9Du+7zjIgaJi48D0vOI5lDmUmUgZ
         iuVsG44iyNYE4BJRkCN7xMhdJj6NBz8MeQNYNatMVsmcJrtHOIks2F+BrKwiemQHoso4
         Qvm0lnISNixPDzYAxjKMbbRbxFIJfLEYlbX75rpn35zvtGDH7blHgZyO6CWmRMjSnWzi
         OBC7KpOCyE61lVBkop5UKdTEuzpMKbnEX9PgOulMHfkGQAI6KsqYZ55m9n3mzxvoxAwa
         AstRTWu7ExnmhzWLwrxwwDQoWH6ibxFsoT9DgZIe5Nb4bwAvWsZL00XLejAKfDIUade+
         JG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721977619; x=1722582419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN2nwbjbyXoRcJjZ570U1pjE8CZSOfXAC4h71zhOWHo=;
        b=wcX4ZFfZKfhJzC1zB6MPSUWEPvh4Mfq0BcKFKfqnnvft21ehLEYarUNFIq4rl8OYRL
         SMVWRuTeO7Bw7/2aMIhz+Ni4gHpbntLyMO6HLDEKLKFH2rjD+IwW88LkQFZvUrNzT3EC
         xXkJvcQaTHrE3+tXZmshDiGWRhZvy500Uz4p5VW4oDie1UG6otEYeCW29YatXMxJAp5m
         JL/3o8T9OSfdTnb1kErNHQlTX2DoafKop4gnthk7WjeiHPnQD7/hTwyWmjE9A3t7eRcx
         p3k5/XXf+z3IGx5CF4sOtmyc7Vdj9rhHvG8ThDGJVgxkG/QNg6A5Hc1GJ+krKAVVy3Eb
         4P4Q==
X-Gm-Message-State: AOJu0YxQtzoBaskJgM/26Zs9YbXTI4AYr+oz5fTkYwZsTIyzmaw/+UmN
	OyDZ7ZhZe4rn1WR4lMEiFp1o9qp3bfcQbsv6V4751IoQbZzw4WuVYDpBwBLy9Mw=
X-Google-Smtp-Source: AGHT+IGWgD0kDQnmq5bju6IZvv8WrDPwym6j5td1p9Lp+AbIhu60mgxTty3z9uNBsYM0WkzORGFhQw==
X-Received: by 2002:a05:6402:35ce:b0:5a2:2ecc:2f0 with SMTP id 4fb4d7f45d1cf-5ac6203a57fmr3498866a12.1.1721977619053;
        Fri, 26 Jul 2024 00:06:59 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3ab8sm1558891a12.71.2024.07.26.00.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:06:58 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:06:57 +0200
From: Michal Hocko <mhocko@suse.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg_write_event_control(): fix a user-triggerable oops
Message-ID: <ZqNLEc54NVP40Kpn@tiehlicka>
References: <20240726054357.GD99483@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726054357.GD99483@ZenIV>

On Fri 26-07-24 06:43:57, Al Viro wrote:
> We are *not* guaranteed that anything past the terminating NUL
> is mapped (let alone initialized with anything sane).
>     

Fixes: 0dea116876ee ("cgroup: implement eventfd-based generic API for notifications")

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
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

-- 
Michal Hocko
SUSE Labs

