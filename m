Return-Path: <cgroups+bounces-9970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785CB52416
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 00:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940D87A8711
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2163112D6;
	Wed, 10 Sep 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYzGrvdi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286C24BD04
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757542245; cv=none; b=QTLJfyi1vy8coiaNEPc2PFWxZb/U2oafPvv+Jt8A+/5vrx8t2mMiY4IX2KdmKt9WTH45hLyp6OXgcGIBNRW1t88T9RT7ff50cO3xHE1DcVkLXJxciBaSTB8zWddFgdk8hrp/kCHg9QK//cghsQUfVeQrZNOzBeD+f7ScXt3syHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757542245; c=relaxed/simple;
	bh=Ud8/LjX5tWIW9/pb4uJHFmXYj1ABUwohGw3Ffq3cLmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJwNleWcQNpjWDZcauolopM2a4ZIDUZgJeGWSL7XaIkAB8mv/rkn+R0Wy+FdXdwTCKgtMqKYGEeUAINy9gr7fpyexOkhJmiQGy8wSYpp69cVXe5NlH770X68k/UrMzGo2fq22H71ca7c0od3JQYxG3YlpgE/HTTmn5usdae91ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYzGrvdi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so33295e9.0
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757542242; x=1758147042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud8/LjX5tWIW9/pb4uJHFmXYj1ABUwohGw3Ffq3cLmU=;
        b=UYzGrvdi2HOGyLVC/EWexoTWzIxrrO0OmAlaMx0C2W6jWJLK7d3kIHPH3/x9pFXA8o
         EoVUqx+WhV4O+OXqcCKWT7BnEDyGCcywYn+LDvpEgImbPdST+5yAXjNHLmk8cnpWg2+R
         uvW4sAl9Lo7Wttd+ncgTLwTwEIdhdfWRGzP4v+HoZ1Edp2kCTHpyxmLj/lT2rFl3OE3I
         W5Tn7jv1YNMoRlQAOuYUELfSkUe7LQKHHSfDvgrqN9MvfSWUscCjF8BwbqGq+FnjXxq1
         8Pt3lpPwMOjt8gtbFMeJIRv4j0LN0tOw00KPdpnnqnSs5Hy09h7A+nPnncV1znvvBdnI
         rcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757542242; x=1758147042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud8/LjX5tWIW9/pb4uJHFmXYj1ABUwohGw3Ffq3cLmU=;
        b=iDZ107xnUMaTlpB8cdDU/AvGs1JJRC3qrAYsnnyB0h+EFQ8JP/2qN9YCRLBpquJ6xE
         ZB1Pmd9euEv8HWLT6nh6KZGVNP+dDEKolPE5w+k4Zuje9BdWliD7tnVD7WJzm9hZQjCt
         c5t7fQM39wWZi7aIicMf8FXhLR8LOtKpU4VmuwuwmluURdi0Ew9DLNAeCKnH0EHJvyf0
         oWOnBnbyvha5YkT0L9riZ5ft40RiAxDcWqN/Sj+0gVqFx5nB8iq5/knd+2CObP7p8cL2
         fVTZ4DXF/ldbDsp5bseLWH6PmPFhvP6kQxCdRdDx+HvCDWUdZD1BIexSq2uBVWlQ9ob3
         Z42w==
X-Forwarded-Encrypted: i=1; AJvYcCWf0VCZlI8DABnq+Bx6A1+3ZIn3W8CiX8c4YPTLYVvAoRWW0d4vX3KcLON3KIx6ndQdFOxxKze0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SH0crd2plObvQRHJgSX/k8Z860l6GeeCoKcC0EJV48ls2AGZ
	ArB2LHAzoJUzlCUxcgcF6mMcQt0TUYyyCC/4BaHKsjMIpRm/tAuRn0UVWl/Ya7UZhyIB8R/l1g8
	Q53QcCOKoy9LpPdCeRkP+qHAsjSUcqBVw6QTvmOtd
X-Gm-Gg: ASbGncsw/nLiZgh70JNSD7YhXIg9P9612kmDzmMgF1/EEiHZZdoaK7EqieMoD+lNSFz
	symkSCJwAHQ/tJKxXt99E3IwARC/JPYCJQh2clGA4eelAKMPtOc+Guhhmbv/NRpJKoQzsoqY5nM
	uQwXC8gTafVa3AwlLQxjI4hJ5M4DNWryij9kQwgbkJ7yxOsLSPl7P/IXWyMSSUnS4FeMDgmNB/D
	dsagHncviE/GZAk7y6v7dOIG1f+Bn01pUggP7f0M8W6
X-Google-Smtp-Source: AGHT+IE3cor2ZFx47kcBwK+FPBD50LrvoMIv/c7Fwfd1Jpre33Ol/npl+FUbI0aeN+ZCL2YEHcjgddsm1h5zK39jj+4=
X-Received: by 2002:a05:600c:8584:b0:45d:f6a6:a13e with SMTP id
 5b1f17b1804b1-45df81fce12mr2007125e9.1.1757542241661; Wed, 10 Sep 2025
 15:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
 <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez> <CAJuCfpF1deAfZfWQZkAdws9FDNsmZp3KMQap-LqcX1NzOoknhA@mail.gmail.com>
In-Reply-To: <CAJuCfpF1deAfZfWQZkAdws9FDNsmZp3KMQap-LqcX1NzOoknhA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Sep 2025 15:10:29 -0700
X-Gm-Features: AS18NWDgkOOVxVEJ5m_y8MH1I0nxlUuRqO0CwbrMLM_l8GTe9AE5nrTwvPrjvCI
Message-ID: <CABdmKX2386gYbF5BXzbJ3awybF+edGAfGgFguhAbppejYMKGZA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Lei Liu <liulei.rjpt@vivo.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Zi Yan <ziy@nvidia.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Sep 10, 2025 at 1:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Tue, Sep 09, 2025 at 12:48:02PM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Sep 9, 2025 at 12:21=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > > > > 1. Problem Scenario
> > > > > On systems with ZRAM and swap enabled, simultaneous process exits=
 create
> > > > > contention. The primary bottleneck occurs during swap entry relea=
se
> > > > > operations, causing exiting processes to monopolize CPU resources=
. This
> > > > > leads to scheduling delays for high-priority processes.
> > > > >
> > > > > 2. Android Use Case
> > > > > During camera launch, LMKD terminates background processes to fre=
e memory.
> > > >
> > > > How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> > >
> > > SIGKILL
> > >
> > > >
> > > > > Exiting processes compete for CPU cycles, delaying the camera pre=
view
> > > > > thread and causing visible stuttering - directly impacting user
> > > > > experience.
> > > >
> > > > Since the exit/kill is due to low memory situation, punting the mem=
ory
> > > > freeing to a low priority async mechanism will help in improving us=
er
> > > > experience. Most probably the application (camera preview here) wil=
l get
> > > > into global reclaim and will compete for CPU with the async memory
> > > > freeing.
> > > >
> > > > What we really need is faster memory freeing and we should explore =
all
> > > > possible ways. As others suggested fix/improve the bottleneck in th=
e
> > > > memory freeing path. In addition I think we should explore parallel=
izing
> > > > this as well.
> > > >
> > > > On Android, I suppose most of the memory is associated with single =
or
> > > > small set of processes and parallelizing memory freeing would be
> > > > challenging. BTW is LMKD using process_mrelease() to release the ki=
lled
> > > > process memory?
> > >
> > > Yes, LMKD has a reaper thread which wakes up and calls
> > > process_mrelease() after the main LMKD thread issued SIGKILL.
> > >
> >
> > Thanks Suren. I remember Android is planning to use Apps in cgroup. Is
> > that still the plan? I am actually looking into cgroup.kill, beside
> > sending SIGKILL, putting the processes of the target cgroup in the oom
> > reaper list. In addition, making oom reaper able to reap processes in
> > parallel. I am hoping that functionality to be useful to Android as
> > well.
>
> Yes, cgroups v2 with per-app hierarchy is already enabled on Android
> as of about a year or so ago. The first usecase was the freezer. TJ
> (CC'ing him here) also changed how ActivityManager Service (AMS) kills
> process groups to use cgroup.kill (think when you force-stop an app
> that's what will happen). LMKD has not been changed to use cgroup.kill
> but that might be worth doing now. TJ, WDYT?

Sounds like it's worth trying here [1].

One potential downside of cgroup.kill is that it requires taking the
cgroup_mutex, which is one of our most heavily contended locks.

We already have logic that waits for exits in libprocessgroup's
KillProcessGroup [2], but I don't think LMKD needs or wants that from
its main thread. I think we'll still want process_mrelease [3] from
LMKD's reaper thread.

[1] https://cs.android.com/android/platform/superproject/main/+/main:system=
/memory/lmkd/reaper.cpp;drc=3D88ca1a4963004011669da415bc421b846936071f;l=3D=
233
[2] https://cs.android.com/android/platform/superproject/main/+/main:system=
/core/libprocessgroup/processgroup.cpp;drc=3D61197364367c9e404c7da6900658f1=
b16c42d0da;l=3D537
[3] https://cs.android.com/android/platform/superproject/main/+/main:system=
/memory/lmkd/reaper.cpp;drc=3D88ca1a4963004011669da415bc421b846936071f;l=3D=
123

Shakeel could we not also invoke the oom reaper's help for regular
kill(SIGKILL)s?

