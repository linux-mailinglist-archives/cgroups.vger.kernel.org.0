Return-Path: <cgroups+bounces-7477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3167CA86517
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 19:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA94189CDBC
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB10258CC1;
	Fri, 11 Apr 2025 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ+JVaV6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD142367DD;
	Fri, 11 Apr 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394091; cv=none; b=BTvEKLgO4x8ubqtW0cS3Ex3W+M+XdDgh29yf5S65LRN3uwXGBcZS+RPrTMcVt5g5cdgeZUJzMwM5FiJeB6D3Brc26Gr+Ow7E+drNoJ1GDDl/D36MCeH/J54m167dyzIHHrizGNQvkiAeegLWXQ59kJ2PxynIUlC6/AUCIWEhA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394091; c=relaxed/simple;
	bh=tyyox49HnOeNZgl4IFoSXhg7byGbPATXb8I6NlV8w0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBKvCOwhJLtUXBzzpFfn3IhUS2w29phO6gqmbHMvjJLVzyUvdpTDN9/r80dvfb/yFrway9AtRzXPYeYOkuSGbulb/H2exMTKYFFoFlIsMJAZOsUpI4mRbNH1ceWaU7qj+9FmBe4BCOPK1d37Voz75M7nvS3tBhOut/egPWIWlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ+JVaV6; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86fbb48fc7fso938665241.2;
        Fri, 11 Apr 2025 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744394089; x=1744998889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywkQx3u/4aownxE7hPIvWIFCLtDqYUgJXHHsxcNJYug=;
        b=jZ+JVaV6+nyvASx5ShC3kya3kOcj85Bu3ORilgvMo6OPpAjUHBSrrajmQax8rTiPCp
         hQhApW7jO3a2t9FAJG8692Z4DnoGX4i3fwHd8OZ1Bo+2Hv6FyGq1/MzwFXysbPNQB84j
         VY38M9Hr6HId/oamtsj3OGDuYdNk4BhUjY6xQKCwDB6FSXEjTL9nieMQWRXnxrPqg1a7
         u//+mu922sTKwamVcRYvrEtnvMbaqYpcJB2USu86VoNAbTmqYdfXhbzyln2XAJr+i04j
         HmMQ+cvy0oQAKwaIWkHsvu3W+R8AYu79ojchx4QXN4wMkf74v9y6m/IW/lMpT/DuBl/8
         Jmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744394089; x=1744998889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywkQx3u/4aownxE7hPIvWIFCLtDqYUgJXHHsxcNJYug=;
        b=oSAsM02/8BTougnePArSfYBkkGXoUOl001mmC/W/D1wijIseNm+KNDcdWjKVQdQN/V
         nm1Fqkvg2urvrCXiY/YOtpy/h21sJpkFzNDaERPapK/421J7yVhqWZU8JIjFLhXLzmbE
         RNfARcYS0sb4EbonADThQxWA8YRicnHxDkEhnP+va2jxV139WX44xoP+hKr8PBL0vXO7
         b4WbfiQCXBZG0Ljs5XajMUEGxp+u0LTRwXrTV5xdj7X9L4MNs/k7nlVnvoStPAQuF5/v
         YfzrxrwcF+KOD3tAXhZZ1wMdOQKsv10wKMa1u4o7Rw0TjstSlgg11NvNfM/p66JmNnJA
         GTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVms3jcovtwSh5pWbhfcCbZR9/mbAqWVqA0xUHI7pHiZNJerXsUGxv34I2ICh8jrzZPzillmWbI@vger.kernel.org, AJvYcCXUvrePHsBTLsZw3dMT01clOUsI61MFrf8gVE5bgBgXRIadwUynq7DSz9abP53hFuulj/nq9jczCG56TskX@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+vr78h3ujO4MHG9qJFFDNTP1aZTnX9YmSVDdTOSjWzqPyJ8B
	3KAA+hSXgkdBEoYYfYA+NdnLPK+pfl8h4XujsO65vm7IuPwUBa7+ubeik/BrP3YjyOI035AXMbB
	nYNhAJJ0/6WbYndyPkNJeVVlZcECCmLT+Exk=
X-Gm-Gg: ASbGncsDvadP0Mxnlf6TJZN1JhteOaxLDUoy/xPDBB3P3rVEOpnBD3R/2KE/7EgETu0
	S3Ix9P+kaUPHEmf3anISUw1FDIR4Dw8v4d63zJGdmob5yq3D4yc9fAzM3K/J99OWMZqLR5/eKf3
	YLPg7lxHWKYbBEOIPLNVWVnyx9KjwX2wTeYimiTlF3QS8dyMo2Em727qZS
X-Google-Smtp-Source: AGHT+IG9Gf4TMoSlwS41SzXYgEa8isUDPLUdrvCwJybGx3dUBlNtvJmto2C3Kb/Qh4F23GKeMRelpkSWv9NiJBxzXQU=
X-Received: by 2002:a05:6102:4b85:b0:4c1:9159:859c with SMTP id
 ada2fe7eead31-4c9e4f2079emr3137947137.15.1744394088951; Fri, 11 Apr 2025
 10:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410210623.1016767-1-shakeel.butt@linux.dev> <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
In-Reply-To: <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
From: Shakeel Butt <shakeel.butt@gmail.com>
Date: Fri, 11 Apr 2025 13:54:37 -0400
X-Gm-Features: ATxdqUEvGAuIZsSkxMfr_5OHtKy9t_zYrWp3bAl0ILZaS2YVXuD2eUp_XUPwSNI
Message-ID: <CAGj-7pUxYUDdRGaiFon=V2EG+3Ex5s9i7VvWbDH5T0v-7SE-CQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
To: Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Waiman Long <llong@redhat.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"

(my migadu/linux.dev stopped working and I have to send through gmail,
sorry for any formatting issue)

On Fri, Apr 11, 2025 at 04:06:46PM +0200, Sebastian Andrzej Siewior wrote:
>
> On 2025-04-11 10:55:31 [+0200], Vlastimil Babka wrote:
>
>  > @@ -1964,10 +1964,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>
>  >
>
>  > stock = &per_cpu(memcg_stock, cpu);
>
>  >
>
>  > - /* drain_obj_stock requires stock_lock */
>
>  > - local_lock_irqsave(&memcg_stock.stock_lock, flags);
>
>  > - drain_obj_stock(stock);
>
>  > - local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>
>  > + local_irq_save(flag);
>
>  I think for RT this is not great?
>

This is not a performance critical function, so I would not worry about
that.

>
> At least in theory, probably it's not
>
>  actually used together with cpu hotplug? As it relies on memcg_stats_lock()
>
>  I think no irq save/enable is necessary there. local_lock_irqsave wasn't
>
>  actually a irq disable on RT. I don't know if there's a handy wrapper for this.
>
>  No seeing the whole context but memcg_hotplug_cpu_dead() should be
>
>  invoked the control CPU while "cpu" is already gone. So the local_lock
>
>  should be acquired and the target CPU needs no locks since it is
>
>  offline. local_irq_save() will break things.
>

I don't see how local_irq_save() will break anything. We are working on
a stock of a dead remote cpu. We actually don't even need to disable irq
or need local cpu's local_lock. It is actually the calls to
__mod_memcg_lruvec_state() and __mod_memcg_state() in
__drain_obj_stock() which need irq-disabled on non-RT kernels and for
RT-kernels they already have preempt_disable_nested().

Disabling irq even on RT seems excessive but this is not a performance
critical code, so I don't see an issue unless there is
local_lock_irqsave() alternative which does not disables irqs on RT
kernels.

