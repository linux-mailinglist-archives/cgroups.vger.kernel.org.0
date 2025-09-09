Return-Path: <cgroups+bounces-9830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B5B4A825
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 11:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04575188C64F
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FEB28AAEB;
	Tue,  9 Sep 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP6pMM9/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D927B346;
	Tue,  9 Sep 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409880; cv=none; b=tS2w4UUB2Gb56BVluNe6hHNETL0AcDeKtXlIXT72eSJTVwt2OUYqOi+rkRqRMfSRF8vHUJzQbd4hB+I33/vGigI97+bvJCdwXYs9CvsQE0GK4hKDRx9IEbxw2DeuAgis5UiDDc0NCs10J72Y4Zt3Y+RybXE0a7xNxw58/KGDkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409880; c=relaxed/simple;
	bh=ZGce/gSXDfTR7/ob9XkpZ5uWpAbb63d+FA91bM3ARII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOGoTLUkwy/dOptdKlwstyQsXWfAg7TNTtlFOwcT/1leFYZ9hyXE/+CYFH+Ltxrb4PEFkrIEm9c9vnWmux6ecJVE6xtKzcYhIHLc4hkgzou6lS4xGlEvQpsZKJWZgEdntMIT4vEr94i3WcITQXbpdAEJeFO3PI5oawFVnLRDFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP6pMM9/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-805a55c09aeso511667785a.0;
        Tue, 09 Sep 2025 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409878; x=1758014678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW2Nzzo2BQ2Und6tq1pi4NPh0bbGS+k2agz2uQ6CIcU=;
        b=NP6pMM9/lMg7ESAXhzPBKFPNORsKs6yuBu35IGq2FfHVAublxiFJwdc46ebycl6kwc
         IoaY+fRpwjL+UASC+B7fJ6XV25YsrYNMd/q/lbgNWRtgNpCD+E9S2bkP05RKiy0XOrqh
         cBlGKsPWuODEOpTPf5r6eEFy1guRfXKISTKZv69PR+rcJO0UbfYZncdPrpaG6ZP/282J
         Utivq5pAK9KXq51ZB9xR9VNRM7xPBmSm+WoTSB4FQ6H7jBTnVbe8ulvVsIy0m6sHxa6N
         ra87/5CmLeJLnRzvEaYBTLY4/L50+mEyf3dTJsMKWMv38VV8KH2Aqg6Cqh8zUEt0Ssto
         xGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409878; x=1758014678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lW2Nzzo2BQ2Und6tq1pi4NPh0bbGS+k2agz2uQ6CIcU=;
        b=Y0va9ZbQyxDuTr/J6muIq53hmwtQ++3TqXqVvH/ejLxtqE5TCpGCDZErs/uGUVArYg
         YNu5GrhtGxR6+XE9s9uuEa6Tv1u4bFtc1KrPRTTwErGe1qCxlORIz1f42grc7IS0heW9
         L7aCVb6hPxkeVOPbTrB9EQ2EKFJ2XsOGMuRHnwQu8frr9AfOAL7Fcm5fGe1/JYrt3CZL
         sRKgTX/jIsHzmskaTAq+8CdbA8qLB4xOGMZZNXZbeD9tRuQg1pmWuKGLQ8/Wgwh0fr4J
         YPz8wU9dVzgcRGZQ8zmNfcd4jHq1lBwS71IGpYq3BpQuFHtasLuSBPL/zJpfuSodc2b9
         A8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUEP8C1QhDFILBb5qi0EjKNj5l+a6zDlPvqZmGZKYEIx3cs33dg68aoCQOnhG5etS7S3UgG6chn@vger.kernel.org, AJvYcCUSdvQLxgrmNVn7NmC0JHS/FpS3tlHiQ7aqt7gYP0/0eXKJE7O+1K8GoM3b5BCFZfNds9LcCqBMg9ThkvRY@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcJCFaoXpW9dQIMvyVVX0l1SKOSs+aguMGX5NE90Xg7aIYAQA
	mTcnTzGCp8jXwVJaFFjHxuQqkxpMiLeRe1/miGIHBFQHVgwTeayIUuY643Xsdbuaagy3ZYJ+J6m
	z3Rs6q2yMZFywuOMo+kV+lyETg8qzEs8=
X-Gm-Gg: ASbGncvWHvgUuv6chI8docgIco88FJDYr4jlqf59WGquUACiDzSG8CMB6pyp43NYKrK
	RqL6Yp6cy53ry/fq0Mr1p68H4dlcAVUjc2n9TKEHxTkEUVETX6m1UJyfOdtTyQxZPb3gt+TE+ac
	X70SNE8u5+nibQgkdNkzH5Uu6cSqbThAy4MBcLMFz8e2cuK+79IVuY0OZ8dk9hUD0e6nhxzBsMa
	I3tdJYiHEQPKFTesw==
X-Google-Smtp-Source: AGHT+IHJOggxKeQl2En2vkS170HN9upj3XN1GrIbX/RBrm3+a8OJxKgKoilHkjOVfWI0HrL/ttqp+LzQfAyxcN8ccUo=
X-Received: by 2002:a05:620a:172a:b0:7f9:ec3f:b047 with SMTP id
 af79cd13be357-813be24adf8mr1052891485a.2.1757409878127; Tue, 09 Sep 2025
 02:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
In-Reply-To: <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Sep 2025 17:24:26 +0800
X-Gm-Features: Ac12FXzBjrEDwqilLgwY9xCBO5DS-3GJmCy35oFzG2rRHCjrrELhZ_Lm3diPEjA
Message-ID: <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Kairui Song <ryncsn@gmail.com>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 3:30=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Tue, Sep 9, 2025 at 3:04=E2=80=AFPM Lei Liu <liulei.rjpt@vivo.com> wro=
te:
> >
>
> Hi Lei,
>
> > 1. Problem Scenario
> > On systems with ZRAM and swap enabled, simultaneous process exits creat=
e
> > contention. The primary bottleneck occurs during swap entry release
> > operations, causing exiting processes to monopolize CPU resources. This
> > leads to scheduling delays for high-priority processes.
> >
> > 2. Android Use Case
> > During camera launch, LMKD terminates background processes to free memo=
ry.
> > Exiting processes compete for CPU cycles, delaying the camera preview
> > thread and causing visible stuttering - directly impacting user
> > experience.
> >
> > 3. Root Cause Analysis
> > When background applications heavily utilize swap space, process exit
> > profiling reveals 55% of time spent in free_swap_and_cache_nr():
> >
> > Function              Duration (ms)   Percentage
> > do_signal               791.813     **********100%
> > do_group_exit           791.813     **********100%
> > do_exit                 791.813     **********100%
> > exit_mm                 577.859        *******73%
> > exit_mmap               577.497        *******73%
> > zap_pte_range           558.645        *******71%
> > free_swap_and_cache_nr  433.381          *****55%
> > free_swap_slot          403.568          *****51%
>
> Thanks for sharing this case.
>
> One problem is that now the free_swap_slot function no longer exists
> after 0ff67f990bd4. Have you tested the latest kernel? Or what is the
> actual overhead here?
>
> Some batch freeing optimizations are introduced. And we have reworked
> the whole locking mechanism for swap, so even on a system with 96t the
> contention seems barely observable with common workloads.
>
> And another series is further reducing the contention and the overall
> overhead (24% faster freeing for phase 1):
> https://lore.kernel.org/linux-mm/20250905191357.78298-1-ryncsn@gmail.com/
>
> Will these be helpful for you? I think optimizing the root problem is
> better than just deferring the overhead with async workers, which may
> increase the overall overhead and complexity.
>

I feel the cover letter does not clearly describe where the bottleneck
occurs or where the performance gains originate. To be honest, even
the versions submitted last year did not present the bottleneck clearly.

For example, is this due to lock contention (in which case we would
need performance data to see how much CPU time is spent waiting for
locks), or simply because we can simultaneously zap present and
non-present PTEs?

Thanks
Barry

