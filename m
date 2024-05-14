Return-Path: <cgroups+bounces-2883-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D08C5991
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 18:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0C81C2083C
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A2180A71;
	Tue, 14 May 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWML6iTQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E1D17F36E;
	Tue, 14 May 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703380; cv=none; b=Z4EyJwdQsB2VGjvB+6GTKJfUb3yNtxMWpKTVcEt8q3d456Gh/7ibIynt/v98KHE3vb0Ff01Y/vDE18ROw12jmmAPy+ueRHJ9Od7xI2Fej89Ap75OcYmtQgtOk9GAL00JzVXyQVwQhfr7ae3pd+9qC+v6VuffshgkhkIVIPydyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703380; c=relaxed/simple;
	bh=tI5iqDOiTiYC4B7GifYHnbpZJY2dKaCl033UC642iOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVgOxerGCUNEEyGJccUwAqE7wz/M7rJ2sd1TQxB9rmX+HGYwT6w/nzZVyA3Yl/DaPNrQ7CxUtK8JhFEEzrnC+QBDQV5iFFzE1UKFxfOm+E4mcX9W1S9pZhw5f4RsyoMz0xXqrOIMsMiEqjjdhOX3ZmSUspvIuvdSgDS4vRcG94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWML6iTQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6792ea67dso62918121fa.3;
        Tue, 14 May 2024 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715703377; x=1716308177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNm7JNft7mpO8BN214kXK8UmHAE1xVMf/yTHb94B3/E=;
        b=UWML6iTQfCPG/NfXeEnRGmI6/xONjTTr8nM9Wl7cukf2fhmNFO8lmk0URRRt9S+IUg
         UnRtW7q9UrOUKEsub8Ag8vGtT02kitfTYBG/KXa2azqxwr7fltxeXxbFfFSqfIaeM7FY
         nrYW4YHMCT81vAs2xUQmWYF01jgPH1gxLUYH6WgMxlyu4K9ujPCFtJ3KQgsy4eDTMUMF
         wocOcraDNypnxNRB/9UutdrGSqZ6WcRE5QT0TwkIRYCmeB/AnensW/PXu4xGavTx/l4b
         vYjvQcK+3nhjFVxXN77EXfJqqPZhIVs8p8Lh1gne8ttEDqmSe+QKm9uPCdanExBKUcRl
         ScsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715703377; x=1716308177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNm7JNft7mpO8BN214kXK8UmHAE1xVMf/yTHb94B3/E=;
        b=XuzCVItdbrsi6mIpq2q7UIDMDu7mGfLPilM5TFYgS+HRb0xwvRQ/VbED0+SocLs9iV
         pMpdK55PQhiC0lUC1Su3yUpIh77UmH6nj8t9RVmpjxg2riFCdVtO0pNqfzfaMJu46jF1
         Qbc4YHuzRB17VozH1y2XfgmX9tATKJAVYxCpjkrEYmrdwI4XpEOCBL8GZS2eM4AL/C0R
         cwW24w1Hu6GiSqr91u9hqga07z9aQ1cWHIso9AEMYhJHqKLOOcpJ0rbSTVFJCfVsFcaW
         P9soG8AvwZBlC/44eXgtZ3guZANSwb7nsyErgl0Eu4bgZ9zGHFqbY763ou4nqzjgLbQf
         I9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfgxwKxWM+p60rSnspPeyyC/EnUn5p06VTHhj/mWvq5pkRACf1cHxiGsezB6uq4uAklBD5ffny4YOffE5k6ijXrxT41QNSPg==
X-Gm-Message-State: AOJu0YxU4uz7RHfuhNR3tXSNrm7lFXJ+Nkf0wU8ADvFmfp7QA0X8eQXD
	/DPEhfBErPDZ0HJjBz0Gt/4cjH7AaoVt36ncJA3cNbfqOgXg5VQaLgyGneyuMJz5yFBeBg5LP3b
	l7+hmY1x9a7dge9Q+Wmvcnyxxtyc=
X-Google-Smtp-Source: AGHT+IFM/NdCgN2gy/OGFmRRb913JkdNsM4ImWWzPaywGFRkUeSp/Q7M0Xm7pT0ExTdBvIBOEN3YRJ9LSqnQVOP5qfE=
X-Received: by 2002:a2e:9c8f:0:b0:2e3:991:52ad with SMTP id
 38308e7fff4ca-2e52039d6ecmr104912011fa.44.1715703376994; Tue, 14 May 2024
 09:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-5-yury.norov@gmail.com> <e0bc19d6-4a15-faa4-c8e1-163904276d5b@huawei.com>
In-Reply-To: <e0bc19d6-4a15-faa4-c8e1-163904276d5b@huawei.com>
From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 14 May 2024 09:16:04 -0700
Message-ID: <CAAH8bW99V5dRLxH9MYR1jnphVkp0ojPSjHx1zmKBxEcosgOcDw@mail.gmail.com>
Subject: Re: [PATCH 4/6] genirq: optimize irq_do_set_affinity()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Ben Segall <bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Imran Khan <imran.f.khan@oracle.com>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Leonardo Bras <leobras@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Waiman Long <longman@redhat.com>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 5:51=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
>
>
> On 2024/5/14 6:01, Yury Norov wrote:
> > If mask =3D=3D desc->irq_common_data.affinity, copying one to another i=
s
> > useless, and we can just skip it.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  kernel/irq/manage.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index bf9ae8a8686f..ad9ed9fdf919 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -285,7 +285,8 @@ int irq_do_set_affinity(struct irq_data *data, cons=
t struct cpumask *mask,
> >       switch (ret) {
> >       case IRQ_SET_MASK_OK:
> >       case IRQ_SET_MASK_OK_DONE:
> > -             cpumask_copy(desc->irq_common_data.affinity, mask);
> > +             if (desc->irq_common_data.affinity !=3D mask)
> > +                     cpumask_copy(desc->irq_common_data.affinity, mask=
);
>
> It seems that mask is a pointer, shouldn't use "cpumask_equal"=EF=BC=9F

cpumask_equal() is O(N), just as cpumask_copy(), so we'll have no
benefit if the masks are equal, and will double slow it if they aren't
in the worst case.

On the other hand, pointers comparison is O(1), a very quick tasks,
even more the pointers are already in registers.

> >               fallthrough;
> >       case IRQ_SET_MASK_OK_NOCOPY:
> >               irq_validate_effective_affinity(data);

