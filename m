Return-Path: <cgroups+bounces-3386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C549E919A6A
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 00:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760D61F237A1
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181D194083;
	Wed, 26 Jun 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hE+RjNOg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB418FC9D
	for <cgroups@vger.kernel.org>; Wed, 26 Jun 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439717; cv=none; b=jmewh/5oWcP3+KmkqMcf8LYhGriQxOOdgYM1C9QhcBZ6m1gCYBvGzA1KTOSni9WMiKcEDStkAlf95L63WpyQY1eSTBwXWCirZqwjM0GbZO+ChqgoRY9WRPVvx6lLgweSaXUlEY1syCDZpyddqD3z2RawfgD0AtKGOjJkr2iErh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439717; c=relaxed/simple;
	bh=ow9uMzU4QlTZN49r1yOxWduojAK/284N5Vep8JME3m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD2ptjOkmFKGEtMm+PgTgjy/F3492rEzRmu/UPXWJYusl+/gN3xyIOcvTvIoAxtrMYHlhqwZj/gLBy0sJ5tgxWqymNVM9I7y1PWeM0LAVx5vpfzBxJ4P19eMcH/xe2vLjHrUpv4HS5UH9/jxyK9OIcIrEDYTNeI8PskhMS3NOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hE+RjNOg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso1027612a12.0
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2024 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719439714; x=1720044514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow9uMzU4QlTZN49r1yOxWduojAK/284N5Vep8JME3m0=;
        b=hE+RjNOgGaqdi33sArfoVdNOf849hixKyOCzYuRwWjsoXyDB7/6DaZi6e11ABu0XBY
         ouF9DJ58jIobgecrgYlHcZg6il0Nd7O2HXKIYRZ0qRBwhQYixhIJ0HgYzp9NYSbUv/b0
         QK8Q+PIJehQ3Pyh4e5sBbaa51wb4uiOrdGZq2A6I7Jq0RGF6jhcY0kAJortGrHVvtC6U
         MHIyMx+WEZTueSDEFp7PHleLyVjVbQA0pfH70ArP1JQ/vJcqjANp2TYyEl7d/Sei8rbr
         je04VjtBKgn3ljZfBNZTBM1UZeeu2VNw7/NlpD4XukYuTdiT42wFIXeDAFRSIkxS0gUL
         KlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719439714; x=1720044514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow9uMzU4QlTZN49r1yOxWduojAK/284N5Vep8JME3m0=;
        b=aRHhKjTY4DsqHwVwBpr5s9BtSowfJBaTygzHpWAAi9lqc3NCtGxTFVOTf4N6aOmxor
         yJ35E4mznOC+xl/g2z+QGD6X2fSGTXZ1hXhyKcRYcXNZsXlQNN/u0l3xD9HYR2oPoVJ4
         9jddY07t/OVf1bAqYOBkELSkjgpGLd4SqONikvY4KQJu2kNcyAyMaMCFCo6GhEgkdNJj
         MJLlJxzZiAlnCT/4rJToHa6jercT4sOlBPdKC2h++TBkBmETCV1XVwO+l2e26kF0QeiE
         4l9I7zFD2BjPinDUtDHsVUJvykjNv9gz5Mg8YaGY+vu+Wiza+5TpWBr8m/XkU/wgrQga
         MXtw==
X-Forwarded-Encrypted: i=1; AJvYcCV5yunylIBfqZHPsAUu0QaP4WpTWpwffOf+zTSEMh8UhMgNe6wvn4hAexs7wPaugriTAdKNlV0ivhveRBkkGB+wZZVCOXFx9w==
X-Gm-Message-State: AOJu0YysEMVOxEWhyGdlPJij4jubWuc4pOEdEkrUVvT2NtYA/zTxYkZS
	SFWhpzzTVntcMCQ6CsElImu7W1lqQSmN3zV/ff6vKe3c1cM6ryYJgb0JpFtu3uYocDv26eGrBkt
	n+0EKVkrD5aaGDtfGABfvV6dwujjP6zfBkrbZ
X-Google-Smtp-Source: AGHT+IHi2xggiOm+Up9NomVLlotYhdckrjT5dOyCxfIdhHOlfpCFA13hcM0WF/+YkIUaXf9/7Qt0uwwB0bQyrqsQAa8=
X-Received: by 2002:a17:906:7f05:b0:a6e:4693:1f6e with SMTP id
 a640c23a62f3a-a7242c39be2mr819395666b.29.1719439713799; Wed, 26 Jun 2024
 15:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org> <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
 <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
 <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
 <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com>
 <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com> <CAJD7tkbq-dyhmgBOC0+=FeJ19D-fRpE_pz44cH7fCvtHgr45uQ@mail.gmail.com>
 <43732a44-1f90-4119-9e52-000b5a6a2f99@kernel.org>
In-Reply-To: <43732a44-1f90-4119-9e52-000b5a6a2f99@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 26 Jun 2024 15:07:55 -0700
Message-ID: <CAJD7tkauPM5trAhgYSC5_S_wvOA9gozPeUot-yhAW0fbF+Msag@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>, Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:35=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 26/06/2024 00.59, Yosry Ahmed wrote:
> > On Tue, Jun 25, 2024 at 3:35=E2=80=AFPM Christoph Lameter (Ampere) <cl@=
linux.com> wrote:
> >>
> >> On Tue, 25 Jun 2024, Yosry Ahmed wrote:
> >>
> >>>> In my reply above, I am not arguing to go back to the older
> >>>> stats_flush_ongoing situation. Rather I am discussing what should be=
 the
> >>>> best eventual solution. From the vmstats infra, we can learn that
> >>>> frequent async flushes along with no sync flush, users are fine with=
 the
> >>>> 'non-determinism'. Of course cgroup stats are different from vmstats
> >>>> i.e. are hierarchical but I think we can try out this approach and s=
ee
> >>>> if this works or not.
> >>>
> >>> If we do not do sync flushing, then the same problem that happened
> >>> with stats_flush_ongoing could occur again, right? Userspace could
> >>> read the stats after an event, and get a snapshot of the system befor=
e
> >>> that event.
> >>>
> >>> Perhaps this is fine for vmstats if it has always been like that (I
> >>> have no idea), or if no users make assumptions about this. But for
> >>> cgroup stats, we have use cases that rely on this behavior.
> >>
> >> vmstat updates are triggered initially as needed by the shepherd task =
and
> >> there is no requirement that this is triggered simultaenously. We
> >> could actually randomize the intervals in vmstat_update() a bit if thi=
s
> >> will help.
> >
> > The problem is that for cgroup stats, the behavior has been that a
> > userspace read will trigger a flush (i.e. propagating updates). We
> > have use cases that depend on this. If we switch to the vmstat model
> > where updates are triggered independently from user reads, it
> > constitutes a behavioral change.
>
> I implemented a variant using completions as Yosry asked for:
>
> https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgi=
t@firesoul/

Thanks! I will take a look at this a little bit later. I am wondering
if you could verify if that solution fixes the problem with kswapd
flushing?

