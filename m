Return-Path: <cgroups+bounces-3443-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DEC91B8BF
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7522E1C20E45
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35114388B;
	Fri, 28 Jun 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cBik3OzG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FB5C89
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560726; cv=none; b=QsW0hmFKioX4vHrdpQGfNpIyd6caw5eBBeiUwP7jOVg5LOSdI5RXs65fVLPUtMRmD7x+5vmEu+IJn0p3ziIM8Xq4RiQtTrRx8rYG6iuc9wBHUPePxLUDW9jTm6DNOa5+zDjsG/GbtOFJEkg8nrIxhKpQaSZTbE2fDmCoJmZ7o7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560726; c=relaxed/simple;
	bh=JUSBkqtlFZlGM2xrcHSRfAoIIHT2J2BMiHSuf0F3BaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX0X2uSEUdmUsWfIn6o4wUK/Z1N8uG5/URtvlF01pThp/oNKeVt3vWXkvo/gfF1sKi8CiJ8Nwq6SG1iwFBJ8t7Y5GqEwMgr7e/HgD7DUax5S9hFmujous+xdP5VM/JpORjnhgo0Iu1Rwg4bfP3VU/dsaFED3kgPBY3iV5CveA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cBik3OzG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so333914a12.3
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719560721; x=1720165521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zK0IyvrzgL+xOXZeNs6NwkiIfLaj+g1X1XQRxC3Lni0=;
        b=cBik3OzGJhPIfXH8ZDw6Rsg6uKBh2TKOAnZJdhIkhmOREobaEpOkdYKA3wilgcsmry
         TV3PTsM094JRHfmM9GjObGYRWFQNf/WPsRBpESm5aWg879Nrx9qodMZWV6Kk6YjNgBlh
         Z1WeQhQYfjEDwwQ2xf58mkxBop9MdC/JtAeT+sMPsmtp6GvTD24tYljAlmKcnbcnwZln
         VQxebrsW+iPlz0N3qXWXdRpbZNUHC72939tIz97Ssg89coFNTbEWYoHrUr0xSXyaHHRg
         HWtl925Qv169EZcVIx1f6L4C9oJNx68jIdicHLNEcuByKEfk+wLn5x/nyGqXVDgMyWLa
         G6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719560721; x=1720165521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK0IyvrzgL+xOXZeNs6NwkiIfLaj+g1X1XQRxC3Lni0=;
        b=bHRF0do2LT13B71wWr277+uPVDq7gEhzB/bPk2JRZOn6784FDevVaKhTeenxkVuSMm
         OX0g4eSEeGY4vpAFbzP6DTKxl771NjS1flbbv07XISB2TbrfKnZj9N7emI5uxc26tPC9
         Jj+7T0BrPxkmC8Q92DQIvzIhX0fzcUzfqcirGNdcN0dG81ZqAeGuZ1WANDM4fUOEId/2
         erNTZQ5322nVkB5Dy+gW/GUlih795ogS0UrdXtl92xSmscMAo92qvWXa+e2Gjz/gbi+i
         toYDlkT3cdn0q6y6VRhSKTzN4dBgCTGRK6YsbjimnVmofB2aHmBnCv8hy0bj5e4ffMCI
         kYfg==
X-Forwarded-Encrypted: i=1; AJvYcCWMMPhkkOgu39JJ/sVk5cJ2QokXpSE5A93+KeabrCNZnAkIPdQYULPfr6rwm0vZZtM+yVAJMmIwc+ShoECwL4qKpWmXI/DA7w==
X-Gm-Message-State: AOJu0YxeeweSyBwNu5gmv3R1z1IddF0PyyFNnQCjVp6AmZfJVD/WvTnc
	Uu+ivlc7JRrzOhKykd6lSM60UMjGsHoBFhhLUEq5AyJvgL4BG2KaUFyr5sb0rAQ=
X-Google-Smtp-Source: AGHT+IFbVaxM0DAkYtocL0zgPx+w3Uad0KAy3J9JWLJJFEoXMfvodZvIMdiV5+OAEx1nZLaxrud7Kw==
X-Received: by 2002:a50:cd9e:0:b0:57d:785:7cc2 with SMTP id 4fb4d7f45d1cf-57d4bdcc05bmr9343309a12.28.1719560721489;
        Fri, 28 Jun 2024 00:45:21 -0700 (PDT)
Received: from localhost (109-81-86-16.rct.o2.cz. [109.81.86.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b52esm610372a12.89.2024.06.28.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:45:21 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:45:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: adjust the warning when seq_buf
 overflows
Message-ID: <Zn5qELsJZ0CrdlZA@tiehlicka>
References: <20240628072333.2496527-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628072333.2496527-1-xiujianfeng@huawei.com>

On Fri 28-06-24 07:23:33, Xiu Jianfeng wrote:
> Currently it uses WARN_ON_ONCE() if seq_buf overflows when user reads
> memory.stat, the only advantage of WARN_ON_ONCE is that the splat is
> so verbose that it gets noticed. And also it panics the system if
> panic_on_warn is enabled. It seems like the warning is just an over
> reaction and a simple pr_warn should just achieve the similar effect.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I would just squash this with other patch removing it from
memcg_stat_format. But this is up to you.

Thanks!

> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c251bbe35f4b..8e5590ac43d7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1484,7 +1484,8 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  		memcg_stat_format(memcg, s);
>  	else
>  		memcg1_stat_format(memcg, s);
> -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
> +	if (seq_buf_has_overflowed(s))
> +		pr_warn("%s: Warning, stat buffer overflow, please report\n", __func__);
>  }
>  
>  /**
> -- 
> 2.34.1
> 

-- 
Michal Hocko
SUSE Labs

