Return-Path: <cgroups+bounces-7622-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C2BA927A4
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC3D1769F2
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B625D8E0;
	Thu, 17 Apr 2025 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvzHPNUh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAC259C98;
	Thu, 17 Apr 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914155; cv=none; b=e3tGzzU5juOlfNiqgd9B/oeFSJ/860DfM0huSnsguvzx8J5fhjK9tTQyI70xfUt38aGWtKKabARhDd0HCkwqcaO4j8ecynlqv3BU1TqMM+HSQbgZwJUGbB6u5an4y+V+n3KL5Pg/riXefmi3+9Fj7t0ovFO+65BIL6mSAMjA/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914155; c=relaxed/simple;
	bh=afPt6arzpsA8Zd1rGIJQDoxdK+YZZO5qfXTo0EOb+Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eV/lm7PsbL1GzsTawWp5IG57LY1HXxJgw3zx9ms5wwbA5wjFPwS1PySYJZc5rCaDCOYUOwqOjCno5QC1pJQXVyyb+whWj/OPRFmfPNSVdqDeg71hh8H3OHfvnPs9az9Vt4RDSJf4KvRRO+vL9QJANTmKwm5IGcWdSZ72M3+NKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvzHPNUh; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso11917021fa.1;
        Thu, 17 Apr 2025 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744914151; x=1745518951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOAeBJO/WS4vfKtVVVEGHYmVPUUqppq9u6R1ATTPTqw=;
        b=OvzHPNUhgrrDJd1gW/QOk1RTbxv0HmPOSsAWdVGxIFjcqLpM5WMMQ11T+HkGE35pDQ
         9Pr9yELElElRMeDkdaoXiOHRj8NCAjIlML2+KeS1DIDZMWgveYD7qE6nbH8mjB/G9vOz
         7zdUic1bHvnM6kHQoPHDzwrkt5oGZdzzvaVUUfqJqPxvKjjVP1HHwN9VwhVAJqWQcjLj
         +wl4oajQT7DS33Abqt3AVR7z1Wk6RHlCGj8rIF3/u0L/XFuNgOArm8MtdPjigOENJbsR
         Bpz5x1fwYDaClLXX0i8mB7RDG9qxsakmc94eS6JpaVmTC0uVB+KR45IsW1d0STBGTYXX
         w6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744914151; x=1745518951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOAeBJO/WS4vfKtVVVEGHYmVPUUqppq9u6R1ATTPTqw=;
        b=nMNdbP1QwFdqjIlpM/pK5w6EnvBSzwA0/H1OJ7E1jOxezTbOH/ziAz98Ts2HBBeAe0
         HLdnFo6CAUSxrkB+o9RtG1vejjtMk8q+9xgzshnztNe/o6wySbYtL7rUdMoBonfZm7yF
         /gQI6LN5pJVNYKe1jdfCar/i9b4qCspA67SAdO8Kjo76uWD+/thT3UqmwdHR53MwpL+y
         gdu9dnYc2KrEIw+Oi1DHexN81+XkZSu54C04JMq87Y2TAriQbXL9YTfptiapHjlK/iTK
         7brhhyE81HhAuXsHXrLRh83WPLyA/Mpl2vF47l4RJjeIa5Bcq1xmTTBk57o9v9zwCyL8
         MyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh4mAiuMB93b77/9KHfJ3w6DvZt+CcVs29xzpMrwspoz/MiIh7359grw9gdr181+f1cH7zW/YqsqwgFRHD@vger.kernel.org, AJvYcCViLFrdTJ8cv/R4HUtUIi9Cxww/7xoqNF0PQCDWqM5GwsTmOaxUMQ/DP8DNnBnCCCW48YDolSVA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0haJ1UTqb6e1K4awONHYd5vf0pao2jyzqnsstsjwSs2I2IzE9
	PWppdgprTOz4OEBjJsKqkRpoQ30hbChxXrGlUTFZnsKFuj0EbZQsCev14eMXp0PRpTiT/RW38Fv
	dzfDeP7oLIudw1NuN6g3Ld3hj/Ps=
X-Gm-Gg: ASbGncv7AREx0RSLU1RuWE8kdciLlEpgl7rwQ2Rab5/xtoOW0i/y7nKqvq1KddqmhLn
	WZ1krrir0bbcIkO4qutf3kEuasB4mB9NbFXCLmssjeAF8Zp6H5UXJP8mJ6Fbv7rlE9BnPZiRUTq
	DLM7UL+ZT2yf+d9vF1fgnHuQ==
X-Google-Smtp-Source: AGHT+IGNxJetQAdmZxPsKt7mIdqzM/Ejc5KV3uSEsScaLixz2qKOvSsv+1pKp5ZTrElO3eaLMLifvctqXSLyFrsJPz0=
X-Received: by 2002:a2e:300b:0:b0:30d:6a77:c498 with SMTP id
 38308e7fff4ca-3108eeee73bmr3853981fa.4.1744914150409; Thu, 17 Apr 2025
 11:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com> <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
In-Reply-To: <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 18 Apr 2025 02:22:12 +0800
X-Gm-Features: ATxdqUHcG8d_aiyS2th12G_MAUsmvhqwaj6344WYWF2XAVN1AGndbtg__x_BSUk
Message-ID: <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, akpm@linux-foundation.org, 
	david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:02=E2=80=AFPM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> > On Apr 15, 2025, at 14:19, Kairui Song <ryncsn@gmail.com> wrote:
> >
> > On Tue, Apr 15, 2025 at 10:46=E2=80=AFAM Muchun Song <songmuchun@byteda=
nce.com> wrote:
> >>
> >> This patchset is based on v6.15-rc2. It functions correctly only when
> >> CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were encoun=
tered
> >> during rebasing onto the latest code. For more details and assistance,=
 refer
> >> to the "Challenges" section. This is the reason for adding the RFC tag=
.
> >>
> >> ## Introduction
> >>
> >> This patchset is intended to transfer the LRU pages to the object cgro=
up
> >> without holding a reference to the original memory cgroup in order to
> >> address the issue of the dying memory cgroup. A consensus has already =
been
> >> reached regarding this approach recently [1].
> >>
> >> ## Background
> >>
> >> The issue of a dying memory cgroup refers to a situation where a memor=
y
> >> cgroup is no longer being used by users, but memory (the metadata
> >> associated with memory cgroups) remains allocated to it. This situatio=
n
> >> may potentially result in memory leaks or inefficiencies in memory
> >> reclamation and has persisted as an issue for several years. Any memor=
y
> >> allocation that endures longer than the lifespan (from the users'
> >> perspective) of a memory cgroup can lead to the issue of dying memory
> >> cgroup. We have exerted greater efforts to tackle this problem by
> >> introducing the infrastructure of object cgroup [2].
> >>
> >> Presently, numerous types of objects (slab objects, non-slab kernel
> >> allocations, per-CPU objects) are charged to the object cgroup without
> >> holding a reference to the original memory cgroup. The final allocatio=
ns
> >> for LRU pages (anonymous pages and file pages) are charged at allocati=
on
> >> time and continues to hold a reference to the original memory cgroup
> >> until reclaimed.
> >>
> >> File pages are more complex than anonymous pages as they can be shared
> >> among different memory cgroups and may persist beyond the lifespan of
> >> the memory cgroup. The long-term pinning of file pages to memory cgrou=
ps
> >> is a widespread issue that causes recurring problems in practical
> >> scenarios [3]. File pages remain unreclaimed for extended periods.
> >> Additionally, they are accessed by successive instances (second, third=
,
> >> fourth, etc.) of the same job, which is restarted into a new cgroup ea=
ch
> >> time. As a result, unreclaimable dying memory cgroups accumulate,
> >> leading to memory wastage and significantly reducing the efficiency
> >> of page reclamation.
> >>
> >> ## Fundamentals
> >>
> >> A folio will no longer pin its corresponding memory cgroup. It is nece=
ssary
> >> to ensure that the memory cgroup or the lruvec associated with the mem=
ory
> >> cgroup is not released when a user obtains a pointer to the memory cgr=
oup
> >> or lruvec returned by folio_memcg() or folio_lruvec(). Users are requi=
red
> >> to hold the RCU read lock or acquire a reference to the memory cgroup
> >> associated with the folio to prevent its release if they are not conce=
rned
> >> about the binding stability between the folio and its corresponding me=
mory
> >> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
> >> desire a stable binding between the folio and its corresponding memory
> >> cgroup. An approach is needed to ensure the stability of the binding w=
hile
> >> the lruvec lock is held, and to detect the situation of holding the
> >> incorrect lruvec lock when there is a race condition during memory cgr=
oup
> >> reparenting. The following four steps are taken to achieve these goals=
.
> >>
> >> 1. The first step  to be taken is to identify all users of both functi=
ons
> >>   (folio_memcg() and folio_lruvec()) who are not concerned about bindi=
ng
> >>   stability and implement appropriate measures (such as holding a RCU =
read
> >>   lock or temporarily obtaining a reference to the memory cgroup for a
> >>   brief period) to prevent the release of the memory cgroup.
> >>
> >> 2. Secondly, the following refactoring of folio_lruvec_lock() demonstr=
ates
> >>   how to ensure the binding stability from the user's perspective of
> >>   folio_lruvec().
> >>
> >>   struct lruvec *folio_lruvec_lock(struct folio *folio)
> >>   {
> >>           struct lruvec *lruvec;
> >>
> >>           rcu_read_lock();
> >>   retry:
> >>           lruvec =3D folio_lruvec(folio);
> >>           spin_lock(&lruvec->lru_lock);
> >>           if (unlikely(lruvec_memcg(lruvec) !=3D folio_memcg(folio))) =
{
> >>                   spin_unlock(&lruvec->lru_lock);
> >>                   goto retry;
> >>           }
> >>
> >>           return lruvec;
> >>   }
> >>
> >>   From the perspective of memory cgroup removal, the entire reparentin=
g
> >>   process (altering the binding relationship between folio and its mem=
ory
> >>   cgroup and moving the LRU lists to its parental memory cgroup) shoul=
d be
> >>   carried out under both the lruvec lock of the memory cgroup being re=
moved
> >>   and the lruvec lock of its parent.
> >>
> >> 3. Thirdly, another lock that requires the same approach is the split-=
queue
> >>   lock of THP.
> >>
> >> 4. Finally, transfer the LRU pages to the object cgroup without holdin=
g a
> >>   reference to the original memory cgroup.
> >>
> >
> > Hi, Muchun, thanks for the patch.
>
> Thanks for your reply and attention.
>
> >
> >> ## Challenges
> >>
> >> In a non-MGLRU scenario, each lruvec of every memory cgroup comprises =
four
> >> LRU lists (i.e., two active lists for anonymous and file folios, and t=
wo
> >> inactive lists for anonymous and file folios). Due to the symmetry of =
the
> >> LRU lists, it is feasible to transfer the LRU lists from a memory cgro=
up
> >> to its parent memory cgroup during the reparenting process.
> >
> > Symmetry of LRU lists doesn't mean symmetry 'hotness', it's totally
> > possible that a child's active LRU is colder and should be evicted
> > first before the parent's inactive LRU (might even be a common
> > scenario for certain workloads).
>
> Yes.
>
> > This only affects the performance not the correctness though, so not a
> > big problem.
> >
> > So will it be easier to just assume dying cgroup's folios are colder?
> > Simply move them to parent's LRU tail is OK. This will make the logic
> > appliable for both active/inactive LRU and MGLRU.
>
> I think you mean moving all child LRU list to the parent memcg's inactive
> list. It works well for your case. But sometimes, due to shared page cach=
e
> pages, some pages in the child list may be accessed more frequently than
> those in the parent's. Still, it's okay as they can be promoted quickly
> later. So I am fine with this change.
>
> >
> >>
> >> In a MGLRU scenario, each lruvec of every memory cgroup comprises at l=
east
> >> 2 (MIN_NR_GENS) generations and at most 4 (MAX_NR_GENS) generations.
> >>
> >> 1. The first question is how to move the LRU lists from a memory cgrou=
p to
> >>   its parent memory cgroup during the reparenting process. This is due=
 to
> >>   the fact that the quantity of LRU lists (aka generations) may differ
> >>   between a child memory cgroup and its parent memory cgroup.
> >>
> >> 2. The second question is how to make the process of reparenting more
> >>   efficient, since each folio charged to a memory cgroup stores its
> >>   generation counter into its ->flags. And the generation counter may
> >>   differ between a child memory cgroup and its parent memory cgroup be=
cause
> >>   the values of ->min_seq and ->max_seq are not identical. Should thos=
e
> >>   generation counters be updated correspondingly?
> >
> > I think you do have to iterate through the folios to set or clear
> > their generation flags if you want to put the folio in the right gen.
> >
> > MGLRU does similar thing in inc_min_seq. MGLRU uses the gen flags to
> > defer the actual LRU movement of folios, that's a very important
> > optimization per my test.
>
> I noticed that, which is why I asked the second question. It's
> inefficient when dealing with numerous pages related to a memory
> cgroup.
>
> >
> >>
> >> I am uncertain about how to handle them appropriately as I am not an
> >> expert at MGLRU. I would appreciate it if you could offer some suggest=
ions.
> >> Moreover, if you are willing to directly provide your patches, I would=
 be
> >> glad to incorporate them into this patchset.
> >
> > If we just follow the above idea (move them to parent's tail), we can
> > just keep the folio's tier info untouched here.
> >
> > For mapped file folios, they will still be promoted upon eviction if
> > their access bit are set (rmap walk), and MGLRU's table walker might
> > just promote them just fine.
> >
> > For unmapped file folios, if we just keep their tier info and add
> > child's MGLRU tier PID counter back to the parent. Workingset
> > protection of MGLRU should still work just fine.
> >
> >>
> >> ## Compositions
> >>
> >> Patches 1-8 involve code refactoring and cleanup with the aim of
> >> facilitating the transfer LRU folios to object cgroup infrastructures.
> >>
> >> Patches 9-10 aim to allocate the object cgroup for non-kmem scenarios,
> >> enabling the ability that LRU folios could be charged to it and aligni=
ng
> >> the behavior of object-cgroup-related APIs with that of the memory cgr=
oup.
> >>
> >> Patches 11-19 aim to prevent memory cgroup returned by folio_memcg() f=
rom
> >> being released.
> >>
> >> Patches 20-23 aim to prevent lruvec returned by folio_lruvec() from be=
ing
> >> released.
> >>
> >> Patches 24-25 implement the core mechanism to guarantee binding stabil=
ity
> >> between the folio and its corresponding memory cgroup while holding lr=
uvec
> >> lock or split-queue lock of THP.
> >>
> >> Patches 26-27 are intended to transfer the LRU pages to the object cgr=
oup
> >> without holding a reference to the original memory cgroup in order to
> >> address the issue of the dying memory cgroup.
> >>
> >> Patch 28 aims to add VM_WARN_ON_ONCE_FOLIO to LRU maintenance helpers =
to
> >> ensure correct folio operations in the future.
> >>
> >> ## Effect
> >>
> >> Finally, it can be observed that the quantity of dying memory cgroups =
will
> >> not experience a significant increase if the following test script is
> >> executed to reproduce the issue.
> >>
> >> ```bash
> >> #!/bin/bash
> >>
> >> # Create a temporary file 'temp' filled with zero bytes
> >> dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
> >>
> >> # Display memory-cgroup info from /proc/cgroups
> >> cat /proc/cgroups | grep memory
> >>
> >> for i in {0..2000}
> >> do
> >>    mkdir /sys/fs/cgroup/memory/test$i
> >>    echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> >>
> >>    # Append 'temp' file content to 'log'
> >>    cat temp >> log
> >>
> >>    echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> >>
> >>    # Potentially create a dying memory cgroup
> >>    rmdir /sys/fs/cgroup/memory/test$i
> >> done
> >>
> >> # Display memory-cgroup info after test
> >> cat /proc/cgroups | grep memory
> >>
> >> rm -f temp log
> >> ```
> >>
> >> ## References
> >>
> >> [1] https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/
> >> [2] https://lwn.net/Articles/895431/
> >> [3] https://github.com/systemd/systemd/pull/36827
> >
> > How much overhead will it be? Objcj has some extra overhead, and we
> > have some extra convention for retrieving memcg of a folio now, not
> > sure if this will have an observable slow down.
>
> I don't think there'll be an observable slowdown. I think objcg is
> more effective for slab objects as they're more sensitive than user
> pages. If it's acceptable for slab objects, it should be acceptable
> for user pages too.

We currently have some workloads running with `nokmem` due to objcg
performance issues. I know there are efforts to improve them, but so
far it's still not painless to have. So I'm a bit worried about
this...

> >
> > I'm still thinking if it be more feasible to just migrate (NOT that
> > Cgroup V1 migrate, just set the folio's memcg to parent for dying
> > cgroup and update the memcg charge) and iterate the folios on
> > reparenting in a worker or something like that. There is already
> > things like destruction workqueue and offline waitqueue. That way
> > folios will still just point to a memcg, and seems would avoid a lot
> > of complexity.
>
> I didn't adopt this approach for two reasons then:
>
>   1) It's inefficient to change `->memcg_data` to the parent when
>      iterating through all pages associated with a memory cgroup.

This is a problem indeed, but isn't reparenting a rather rare
operation? So a slow async worker might be just fine?

>   2) During iteration, we might come across pages isolated by other
>      users. These pages aren't in any LRU list and will thus miss
>      being reparented to the parent memory cgroup.

Hmm, such pages will have to be returned at some point, adding
convention for isolate / return seems cleaner than adding convention
for all folio memcg retrieving?

