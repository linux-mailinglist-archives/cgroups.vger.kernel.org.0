Return-Path: <cgroups+bounces-3853-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC39396CA
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 01:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14742822FD
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C99376E7;
	Mon, 22 Jul 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="FDB1fnot"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FEE3770D
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689584; cv=none; b=ptDwH82DOwH6y4kNJlYWYeVAHXQ0DJSiQYoyTXDt2oG3L5CbGFsCQOp6jwpxa4Ohq7p/WX5p2qR2ATnGTSK82Tz8ZHfkGBnUjzO5Mtle/3OH6BJ33WmyriYk8KmbgTIzgt9SIl+M3CTflWL+Yn+JUf3sODO71OkwGaJaG4PuOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689584; c=relaxed/simple;
	bh=h3B/ptabEkBFRtNuCOTg/VeZx20EG7AeMAcYUrooFjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ6IFiYjMNcXwakZbZxKPU3QMbaf3ZCBPbBiUrryxPqJrdxv+tU9PHCgAKd7lUHgnADQ+EwMIZJGzNvK8XWchNC8WG/O7BHccI6yTEahdu2X1JR3qq1hsTqOcZaKK+N/ph0AFJNO96goDDsCRl5Jx7dwgCk2XYn+iPruM/nA3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=FDB1fnot; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so1030681a12.3
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721689582; x=1722294382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJTmpjGOdE4PBe1bESQVvDpEGil/BWgnfDXbEPkh0oQ=;
        b=FDB1fnot6Jv/AQtvCabGlzCwoGKHGXsf0Xl5krhS1BpWP/1RX61xHZini/ejBIYKAo
         0w7NfBcGD4C0gjGFamrucMyCmOxP4GVA08EzvMaDGBikJd4JpXOuL/48TWFGorXy00c0
         iqdtTUjxSZV89FeJLeDayDsxtxFj0J17HsOkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721689582; x=1722294382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJTmpjGOdE4PBe1bESQVvDpEGil/BWgnfDXbEPkh0oQ=;
        b=m+NqLQjM/oJVPVjtIRZp8LmjjdvyH9EmsZCKYxgx5Tx79Ho216JF5u8DbWw1IGoL+5
         cJs51bkXP4FdyzO4UtOx17/ys/BSXwBQeSKyo3hE8RqLUSlp2dQSVpdZ3c+lQKxrNPPF
         R/+RfYSLBjHsflJSwqxLq8Go9IwkkfCXgxG8/RpaumqzygrxavXyEFWMnxmWueSgc9Ne
         4A0wfoeeDHX9Z2qFQMEOSf3Xvaxt+hcUTyCT5JjIFhGKqI8lVPxikCA4hcIfU402dsnH
         wUhhD73e6PlZuFDtBZOWMy6vIP2X2G6kbPMB4VELg5nh06yXJHK7LSe928DswSg34c6Z
         GBmw==
X-Forwarded-Encrypted: i=1; AJvYcCUX9LnVRZm6w9drJAYt0juKJvaUs4nnLCK5niDcb+XXh0ZM6rWUs986yJlAtfj+X17O8Q97Vy77PzDgif5vd+YebSS/ud4TdQ==
X-Gm-Message-State: AOJu0Yye+gA6GtQMAoawBaY0SCqKES83mQsfbib/66xsQUeLU0JDO7kP
	amTL2hAMWAeWK04EvD3uUksNm/pSob74QfjcDM/8qyxbqZWk9hRAy5VjgmGJVS6tB068ABgFf+8
	JdD17iymEFJ4+1WcS4wfQ+yMqZOYdfx8n8xDRVg==
X-Google-Smtp-Source: AGHT+IER6ikq3RTY3TyMM01zi2l2zzP3nCn5Yl0SNA2nd/2d6WglMNmwZD//tkR85CfK4zkR6essvr9J0t+vSd7lUOY=
X-Received: by 2002:a17:90a:a114:b0:2cd:4593:2a8e with SMTP id
 98e67ed59e1d1-2cd45932ad1mr5460589a91.15.1721689581952; Mon, 22 Jul 2024
 16:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722151713.2724855-1-davidf@vimeo.com> <20240722151713.2724855-2-davidf@vimeo.com>
 <Zp6jSoB14boeGhWH@google.com> <CAFUnj5MF4nKq0B7aWWyBpK3b5EZh7W4+xAmeg5SMwpd7gHptsA@mail.gmail.com>
 <9abf7f84-c103-4280-825c-b382edb9b8fe@redhat.com>
In-Reply-To: <9abf7f84-c103-4280-825c-b382edb9b8fe@redhat.com>
From: David Finkel <davidf@vimeo.com>
Date: Mon, 22 Jul 2024 19:06:10 -0400
Message-ID: <CAFUnj5NJnxHg3uWASoS9N=7S8LRxYc1T5zGmQrPiBbF2PXHr-w@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Waiman Long <longman@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 3:47=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 7/22/24 15:30, David Finkel wrote:
> >>> diff --git a/mm/page_counter.c b/mm/page_counter.c
> >>> index db20d6452b71..40d5f4990218 100644
> >>> --- a/mm/page_counter.c
> >>> +++ b/mm/page_counter.c
> >>> @@ -82,6 +82,8 @@ void page_counter_charge(struct page_counter *count=
er, unsigned long nr_pages)
> >>>                 */
> >>>                if (new > READ_ONCE(c->watermark))
> >>>                        WRITE_ONCE(c->watermark, new);
> >>> +             if (new > READ_ONCE(c->local_watermark))
> >>> +                     WRITE_ONCE(c->local_watermark, new);
> >> Hm, can't we have a single comparison on the hot path?
> >> Also, we read and write c->local_watermark speculatively here, Idk if =
it's still
> >> acceptable with an ability to reset watermarks "locally". Maybe it is,=
 but
> >> it definitely deserves at least a comment with an explanation.
> > Unfortunately, since the two watermarks may be reset at different
> > times I don't think we
> > can consolidate.
> > e.g. I think that if the usage peaked, dropped down a bit and then was
> > going back
> > up again when the "local_watermark" was reset, we'll continue only
> > bumping local_watermark,
> > but we don't want to touch "watermark" until we hit that watermark agai=
n.
> If we make page_counter_reset_watermark() reset the local_watermark as we=
ll,
> we can guarantee "local_watermark <=3D watermark" and wrap one check insi=
de
> the other.
>
>          if (new > READ_ONCE(c->local_watermark)) {
>                  WRITE_ONCE(c->local_watermark, new);
>                  if (new > READ_ONCE(c->watermark))
>                          WRITE_ONCE(c->watermark, new);
>          }
>
> Cheers,
> Longman
>

Hmm, yeah, given that we'll only be resetting one of the two, I think I'll
use this option.
The branch predictor should make that second check pretty
much a noop in the common-case when we enter the outer if, too.

Thanks!

--=20
David Finkel
Senior Principal Software Engineer, Core Services

