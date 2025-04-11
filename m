Return-Path: <cgroups+bounces-7479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8180A86540
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1758C0B90
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46709258CE7;
	Fri, 11 Apr 2025 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN2YtGnc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B5205513;
	Fri, 11 Apr 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395180; cv=none; b=qjjArXsgFdrfp3u3XAw9UUi7ZAnBy/Ro1Q1fbmVZjvNM2c9PfrZGx7z8zKG66peT4JDoToAlcw+3c0Mwx5PGxfcQnzpGcP7I3gppA0EocOYZEc9IwDLpSR3EHZFihFyx+NPC9YaeBSeF6eApPka+4y53jdAKbOPeoERjYm46Qpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395180; c=relaxed/simple;
	bh=RohNaCbynXMsTU9AdMmyEMzpA/tTHrz5QG5mLFjKvQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTOG0kF6MWDJ5t8fh+GQsIhArIBQBNVqoDBUsq+JpXpbwqkO8w4NFdWfPlmJi5qPhnYIARAM5koLnLrrnn6zf0tYMddyjJGW6BO+LLUgALFd1sO58ipyztOvQTRSJYSeGaBDfSEnBUOP66Eq6p101qoR0TjqZYvMq5L5jgAaBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN2YtGnc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c546334bdeso188200985a.2;
        Fri, 11 Apr 2025 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744395177; x=1744999977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RohNaCbynXMsTU9AdMmyEMzpA/tTHrz5QG5mLFjKvQE=;
        b=XN2YtGnc5HHhcpc+q8UlpKczGjvYwu9l75iedpZRpK0xzgqFCtXKVrV+wEtpWkb3wo
         qI6BODP4nzaQd68Sm/lzUsPRDICi7Lswy2YlOg1JHa22alQFnrFlNg4bbc7Sgv8G6kcQ
         2EV+nsC3X31p2FrXyniqB/2ASACk8wQ4ScXaMGwlebxk59OYyvdooM676bxaKnoYP/gK
         Ntrva1RAZWoRj472Qvjt28YIy90HFxKJhXF/FSq+FmsrvI4W9OFxfqV4k79PqXAirFe5
         6PT8HMkY26KBwRBUXCGWxuQ9i20XUyToVo0LYJAuGfUImut61st6fGxMbr2dE+SkwwqP
         Xn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395177; x=1744999977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RohNaCbynXMsTU9AdMmyEMzpA/tTHrz5QG5mLFjKvQE=;
        b=n4mwuSAgrJgbL3Sy5wJsfbpPNQ74uazpu9XsWcb9pmtTaS/4nmwqfxKvqgtXZMEqH7
         tftZ+4Hy4UgHPSzlnSjMdaa4VsvcMSuOxZKpIhHUmmarF+n7sFuSaezYaZiYFIgKHCrJ
         jD7McNxK4+cWFhY9xWu+NirXFi1SCJw5O2jnoiuX2lWqOCDQTNlkMXH9lRVoUUr0lP4J
         hmTccWtPv4EyxEdpBsLaxAb7VoHZ8R9QJwqcZTAhDTVur6PPqFTrAN7ihih9spVmoftW
         ANTjaifZO7Ql+s/jUK0q0UdiVtMTnzS7ISYQz5aV3cdv84sjWSjIDU9OTTT8NhRFaXGB
         PEyw==
X-Forwarded-Encrypted: i=1; AJvYcCVKk06IKFtDJLjWE8YDUIMDljOs9ErKllWigmk/wry9APwpcpbKJ0+VJ52UwfI5e5sjdIGwkL16@vger.kernel.org, AJvYcCXKpFWSEl6sbVTzP+tbLHqnCoBaOZbYj+bcta50dnT8sSIazxgjatIbxy6/8Y8QPVgfmFizajo5cUBTBSGZ@vger.kernel.org
X-Gm-Message-State: AOJu0YykLsjrPh+5QPYQ7eXPrgY4cbBK7OZwtQjPLB/mkHwiSYMpS5jB
	t2U2o+TQujQFPxqAavC10luQfB6mYJalzKq/08YqbN4LG7C3otYSmj9nA7DRyPwRp/jFF+1gT7p
	QOwufY5474S4JouE5X76wX5JfOhI=
X-Gm-Gg: ASbGncsSrxlduAggN7inMxSZpigaEmni/EBoavwHTobLsZuLQmsRat4AuQZQd+8Bpc5
	u9wV92PzuFqmEnVqY3DGa2ioDKr5VoEQ+bv9rQKpHsrj50y3UBouK9Nb6+xuLMvOV2yaLT/EKNc
	xXmiH6SVgZ5pIq5fitL0cqw/XqDtGSu/R1Aly8ivEzqcOVWaYRCBw2NMSFrnMHf3j+dQI=
X-Google-Smtp-Source: AGHT+IG8jVgxtwWubehVN+Idyf1Ufevy60rGqvVQAG1oqRSMZHvG5QfgPIhp6kOOvLpu3Hu/Kwxt+gKP7lJmYuDJNw4=
X-Received: by 2002:a05:620a:4399:b0:7c5:6396:f161 with SMTP id
 af79cd13be357-7c7af20ba80mr660931985a.49.1744395177325; Fri, 11 Apr 2025
 11:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz> <CAGj-7pUxYUDdRGaiFon=V2EG+3Ex5s9i7VvWbDH5T0v-7SE-CQ@mail.gmail.com>
 <8cce9a28-3b02-4126-a150-532e92c0e7f8@suse.cz>
In-Reply-To: <8cce9a28-3b02-4126-a150-532e92c0e7f8@suse.cz>
From: Shakeel Butt <shakeel.butt@gmail.com>
Date: Fri, 11 Apr 2025 14:12:46 -0400
X-Gm-Features: ATxdqUEuqDVleemKEFKk_6Ulu3ecA-4XDITgG6BPtj9oe0wu99PMHvXpTs2Zmaw
Message-ID: <CAGj-7pXRmG2D+5=yj-5uuciiNccWws6erBg_hSm9S6coEhN+3Q@mail.gmail.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Waiman Long <llong@redhat.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 2:06=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 4/11/25 19:54, Shakeel Butt wrote:
> > (my migadu/linux.dev stopped working and I have to send through gmail,
> > sorry for any formatting issue)
> >
> > I don't see how local_irq_save() will break anything. We are working on
> > a stock of a dead remote cpu. We actually don't even need to disable ir=
q
> > or need local cpu's local_lock. It is actually the calls to
> > __mod_memcg_lruvec_state() and __mod_memcg_state() in
> > __drain_obj_stock() which need irq-disabled on non-RT kernels and for
> > RT-kernels they already have preempt_disable_nested().
> >
> > Disabling irq even on RT seems excessive but this is not a performance
> > critical code, so I don't see an issue unless there is
> > local_lock_irqsave() alternative which does not disables irqs on RT
> > kernels.
>
> local_lock_irqsave() does not disable irqs on RT kernels :)

Sorry, I wanted to say local_irq_save() here instead of local_lock_irqsave(=
).

> so keeping
> local_lock as is would do the irq disable on !RT and be more RT-friendly =
on
> RT. It's just wrong from the logical scope of the lock to perform it on a
> different cpu than the stock we modify. If one day we have some runtime
> checks for that, they would complain.

Basically I don't want to use stock_lock here. Maybe I should explore
adding a new local_lock for __mod_memcg_lruvec_state and
__mod_memcg_state.

