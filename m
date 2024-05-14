Return-Path: <cgroups+bounces-2884-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B78C59DF
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB024B21452
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12617BB3A;
	Tue, 14 May 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzXyJ0Sp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5AF501;
	Tue, 14 May 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705268; cv=none; b=gBI5/D/YFWM26O+zjI5cKQFOdqTmuAahaP+pBdrts9q54ciLRHVq2PQglamzYINZ81qCKNXhcjiz/UwKZwOERsl9ypt17YGlPblktJMuITponI+kFjmXl0WEYd+aBi4yq3MTEmgp+jQ1BAVg0JOCGVmuoYCGjIw+EyFd6D5kzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705268; c=relaxed/simple;
	bh=mwFsSf+AWXeVxQSo74iPcsI576htwkDDfmRc0faDOi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9z3I5tU+sYTSqOLUZDutbpRWU3bf8t07SW9HSr898A/hXZgGMguOZE6cRiESml6Rkl7Cv0SZbfqrrP3XP26e2m8h5i+lRmu9g3Y4x+Ce+1b9ZOQdWljpe23FW1dfCFYebnj5ZgaBhcFAUIZjdE7UFksj2uHTULUvvS/6okdNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzXyJ0Sp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51ffff16400so9671394e87.2;
        Tue, 14 May 2024 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715705265; x=1716310065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EeQjuV214QMKCW8+MdYcFTtVImchVTc5aos0uWhYxk=;
        b=lzXyJ0Sp90TcfO/OHpGTA0ZJCHyVYuXgrPIcL8YS2axoKNDOap2ioFFiMBjVr6IGIO
         jYeqS1wR4IgNSUm5JHu7MrgHg04+w5o2b8I/NiStJxYgywib77yMX2uko8JEaVSjepJD
         0zUKCTEmkWd/Uo69GskpTSUOGgT11gvQjSXSEM2O1JSInRj4JEX9hBT7I9AXfG7afweI
         xhYoEfEn7UsfP2yzToc3OxEjvg4nfRk8rNCtJnbFCCYMPcPg9Q/KQSdp77RQPaKlzl9z
         ED+lputB8/VSjYZtlgzfZYKGht3vTf3aR4vRXbdJKTjGN1eosMn8OMpn33DwKLgV0gZy
         RZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715705265; x=1716310065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EeQjuV214QMKCW8+MdYcFTtVImchVTc5aos0uWhYxk=;
        b=QnLyCwpd6REiTzUQo7UuqhUfC0mOIOx5MU6OvESNct7j8hK1ph1+NPqukkvadvGhvY
         1hFcUPo5uDLAZc8Ft1Az67VbHwHiJ7/Ez1reFp07CtrnTKcpa7E7xp/tvDZMktqeFfrM
         CklDBp91KOKVPGrVqpSswWWJI8bXvv3FAKXZAJTeNlUDBgAWCUJGcW7SqBsamKNaq59+
         3xGfwyY38ZOcocRAlfY3ZB9D5qGzukgicK9ILyo9irdH5y3p4zBsK3uV/sYhDJBe4ZI+
         pVCfqm+jzGIIMut7X28HhvzgKBauC9A1HdNwS/TCnbS0CEBa0bTWyzsxB+1SnJWvYvTz
         k86A==
X-Forwarded-Encrypted: i=1; AJvYcCWc1NEOfUnJ0V0M4KRrS3M/ONOzu8Mrz+Rhel/Xw3vUxqw7u57TvC2j2oqcZvIJULWhoUz9b3KkUZRDml0pSQTycg4sSyYXfg==
X-Gm-Message-State: AOJu0YziFUiX3uKb/iGp6buEPYOXHiwYFd8BtQ2d9hbEgqOuY/8skbqQ
	zaMqgVCqfdy0HwgXaStwKeA0bJdJ1d8eqjs+rNKb9peiaitTchjFaahBI3wW22pIP+w0kDJzYjn
	mUWlE+LkJri08EN+s066teSQcIGU=
X-Google-Smtp-Source: AGHT+IGgSINXuTYWtlb6RPS0H4uxWInGDhUgFzN0Cd/IbplikulDsAF1ZDGi3eVXIqzcXUuEnpPFF0tcLEARhHXEJ64=
X-Received: by 2002:a05:6512:281a:b0:523:8c69:4843 with SMTP id
 2adb3069b0e04-5238c694a9amr18263e87.49.1715705264430; Tue, 14 May 2024
 09:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-7-yury.norov@gmail.com> <878r0cn6a5.ffs@tglx> <874jb0n5rt.ffs@tglx>
In-Reply-To: <874jb0n5rt.ffs@tglx>
From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 14 May 2024 09:47:32 -0700
Message-ID: <CAAH8bW-o_zz_C_NFnjL3uP1BXyC4OF-BAR2Dk2Xd-DFDOZpodQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] tick/common: optimize cpumask_equal() usage
To: Thomas Gleixner <tglx@linutronix.de>
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
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:42=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, May 14 2024 at 10:31, Thomas Gleixner wrote:
> > On Mon, May 13 2024 at 15:01, Yury Norov wrote:
> >> Some functions in the file call cpumask_equal() with src1p =3D=3D src2=
p.
> >> We can obviously just skip comparison entirely in this case.
> >>
> >> This patch fixes cpumask_equal invocations when boot-test or LTP detec=
t
> >> such condition.
> >
> > Please write your changelogs in imperative mood.
> >
> > git grep 'This patch' Documentation/process/
> >
> > Also please see Documentation/process/maintainer-tip.rst
> >
> >> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >> ---
> >>  kernel/time/tick-common.c | 15 +++++++++++----
> >>  1 file changed, 11 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> >> index d88b13076b79..b31fef292833 100644
> >> --- a/kernel/time/tick-common.c
> >> +++ b/kernel/time/tick-common.c
> >> @@ -253,7 +253,8 @@ static void tick_setup_device(struct tick_device *=
td,
> >>       * When the device is not per cpu, pin the interrupt to the
> >>       * current cpu:
> >>       */
> >> -    if (!cpumask_equal(newdev->cpumask, cpumask))
> >> +    if (newdev->cpumask !=3D cpumask &&
> >> +                    !cpumask_equal(newdev->cpumask, cpumask))
> >>              irq_set_affinity(newdev->irq, cpumask);
> >
> > I'm not seeing the benefit. This is slow path setup code so the extra
> > comparison does not really buy anything aside of malformatted line
> > breaks.
>
> Instead of sprinkling these conditional all over the place, can't you
> just do the obvious and check for ptr1 =3D=3D ptr2 in bitmap_copy() and
> bitmap_equal()?

I proposed this a while (few years) ago, and it has been rejected. On
bitmaps level we decided not to do that for the reasons memcpy() and
memcmp() doesn't, and on cpumasks and nodemasks level it hasn't
been discussed at all.

Now that most of bitmap ops have inline and outline implementation,
we technically can move this checks in outline code, as inline bitmap
ops are very lightweight already.

So I see the following options:
 - Implement these sanity checks in outline bitmap API (lib/bitmap.c);
 - Implement them on cpumask and nodemask level; or
 - add a new family of helpers that do this check, like
  bitmap_copy_if_needed() (better name appreciated).

The argument against #1 and #2 these days was that memcpy() and
similarly bitmap_copy() with dst =3D=3D src may be a sign of error, and
we don't want to add a code that optimizes for it.

Now, I ran the kernel through the LTP test and in practice all the
cases that I spot look pretty normal. So I can continue sprinkling
the checks once a few years, or do something like described above.

Can you / everyone please share your opinion?

Thanks,
Yury

