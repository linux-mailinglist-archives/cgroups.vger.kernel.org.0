Return-Path: <cgroups+bounces-63-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF77D59B3
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8EBB20FA3
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7752B3A29A;
	Tue, 24 Oct 2023 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYydULxM"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1327EDD
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 17:25:50 +0000 (UTC)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED16133;
	Tue, 24 Oct 2023 10:25:48 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35164833a21so12835ab.0;
        Tue, 24 Oct 2023 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698168348; x=1698773148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyAmYbhNKRNC1zfPKtixIDHsRNfxwdhaIa0uB8FXo00=;
        b=KYydULxMlhttsvQV9616jUKOCxbsqaGDAQExlroKeJdJfT5Rcv8WurOD1mKIa4Jw3w
         g0Q/drWhsAxoJWMJEA7TzKNaHeuMUnycR5lOy0VfBuicLi5F5cPzRQKkpdPB3eIykJFW
         yFTQMDe2O9zgWU+pXApMUwl0LVGJqNBp89CqCJZHXyk4kT/GH6C5tHK/hRQk3rYkblv/
         G5WfpPTeoqpLZSXemYh1Bg+7BpD5uQYeSfVesjBg7ODSzXRNahZdfG75VZaGKce+15Zf
         SbXZXWl7IkQkFzbkGH2E5QI6zWmBW5UcwZOGRMkitmtURjx1h2BHMuDpsDCbLA+6wuOk
         fWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698168348; x=1698773148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyAmYbhNKRNC1zfPKtixIDHsRNfxwdhaIa0uB8FXo00=;
        b=jma2Nehlfcr62HJHOckI8hMT8P0Vc8ssdDbiImTb4GQSf7rVsVcxoy+DlglG3/5Yws
         XmzPoawVHlnpwh3khQ1iLUOqLph/L2qFx1DXb2fQeH8zqJ3flIAi4AoG9zH9z8vmimgt
         mbsGAY8917bFNMDu5PV/pw0hDE1Y2Lzs1eTIw6TPLXkYTei8KZoWepe1r7McmcRDu2ZG
         t8G799HrS9RTtGx4L22fnExrJnl5tz8XyINKlGF3fD8duWIXEzfZVnVQvARrm3ChW2qd
         h9Jta+XLZ1rpuKp6xjhTtSbhHAVfW2JjSavKaNmn/xqv0SdO8AWPjBAE2bqn6zSXP9IZ
         n2qw==
X-Gm-Message-State: AOJu0YweVjrrDVeQP6CJv7vU1JBP4rGj46kOtHPaotTq5aw2oWdfJ7hi
	cFtAbGv/u2Sgx1w0x8tLpHjEeqaVENhxEsIVwJ0=
X-Google-Smtp-Source: AGHT+IF+vxgskghZCA0NCHWlB1Q/r7kYFUjVNizx9+ZIXXSVzrK87LmX/ZotrdYY5apYuQ4vhLBKRTVkLEEBq2bzI6E=
X-Received: by 2002:a05:6e02:20e2:b0:34f:20d9:74a9 with SMTP id
 q2-20020a056e0220e200b0034f20d974a9mr17350245ilv.11.1698168347662; Tue, 24
 Oct 2023 10:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024000702.1387130-1-nphamcs@gmail.com> <20231024160904.GA1971738@cmpxchg.org>
In-Reply-To: <20231024160904.GA1971738@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Oct 2023 10:25:36 -0700
Message-ID: <CAKEwX=PrLaJU2py+nqkSObBx8kafdbNYn0GZVLPkSixDAEb1GA@mail.gmail.com>
Subject: Re: [PATCH] zswap: export more zswap store failure stats
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:09=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Oct 23, 2023 at 05:07:02PM -0700, Nhat Pham wrote:
> > Since:
> >
> > "42c06a0e8ebe mm: kill frontswap"
> >
> > we no longer have a counter to tracks the number of zswap store
> > failures. This makes it hard to investigate and monitor for zswap
> > issues.
> >
> > This patch adds a global and a per-cgroup zswap store failure counter,
> > as well as a dedicated debugfs counter for compression algorithm failur=
e
> > (which can happen for e.g when random data are passed to zswap).
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> I agree this is an issue.
>
> > ---
> >  include/linux/vm_event_item.h |  1 +
> >  mm/memcontrol.c               |  1 +
> >  mm/vmstat.c                   |  1 +
> >  mm/zswap.c                    | 18 ++++++++++++++----
> >  4 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_ite=
m.h
> > index 8abfa1240040..7b2b117b193d 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -145,6 +145,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPO=
UT,
> >  #ifdef CONFIG_ZSWAP
> >               ZSWPIN,
> >               ZSWPOUT,
> > +             ZSWPOUT_FAIL,
>
> Would the writeback stat be sufficient to determine this?
>
> Hear me out. We already have pswpout that shows when we're hitting
> disk swap. Right now we can't tell if this is because of a rejection
> or because of writeback. With a writeback counter we could.

Oh I see! It's a bit of an extra step, but I supposed (pswpout - writeback)
could give us the number of zswap store failures.

>
> And I think we want the writeback counter anyway going forward in
> order to monitor and understand the dynamic shrinker's performance.

Domenico and I were talking about this, and we both agree the writeback
counter is absolutely necessary - if anything, to make sure that the
shrinker is not a) completely not working or b) going overboard.

So it is coming as part of the shrinker regardless of this.
I just didn't realize that it also solves this issue we're having too!

>
> Either way we go, one of the metrics needs to be derived from the
> other(s). But I think subtle and not so subtle shrinker issues are
> more concerning than outright configuration problems where zswap
> doesn't work at all. The latter is easier to catch before or during
> early deployment with simple functionality tests.
>
> Plus, rejections should be rare. They are now, and they should become
> even more rare or cease to exist going forward. Because every time
> they happen at scale, they represent problematic LRU inversions.  We
> have patched, have pending patches, or discussed changes to reduce
> every single one of them:
>
>         /* Store failed due to a reclaim failure after pool limit was rea=
ched */
>         static u64 zswap_reject_reclaim_fail;
>
> With the shrinker this becomes less relevant. There was also the
> proposal to disable the bypass to swap and just keep the page.

The shrinker and that proposal sound like good ideas ;)

>
>         /* Compressed page was too big for the allocator to (optimally) s=
tore */
>         static u64 zswap_reject_compress_poor;
>
> You were working on eradicating this (with zsmalloc at least).
>
>         /* Store failed because underlying allocator could not get memory=
 */
>         static u64 zswap_reject_alloc_fail;
>         /* Store failed because the entry metadata could not be allocated=
 (rare) */
>         static u64 zswap_reject_kmemcache_fail;
>
> These shouldn't happen at all due to PF_MEMALLOC.
>
> IOW, the fail counter is expected to stay zero in healthy,
> well-configured systems. Rather than an MM event that needs counting,
> this strikes me as something that could be a WARN down the line...
>

Yup, I agree that it should (mostly) be at 0. It being non-zero (especially
at a higher ratio w.r.t total number of zswap store counts) is an indicatio=
n
of something wrong - either a bug, misconfiguration, or a very
ill-compressible workload (or again a bug with the compression algorithm).

A WARN might be good too, but if it's just an ill-compressible workload
that might be too many WARNS :)

But we can always just monitor pswpout - writeback (both globally,
and on a cgroup-basis, I assume?).

> I agree with adding the debugfs counter though.

Then I'll send a new patch that focuses on the debugfs counter
(for the compression failure).

Thanks for the feedback, Johannes.

