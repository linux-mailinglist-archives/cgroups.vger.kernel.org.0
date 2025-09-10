Return-Path: <cgroups+bounces-9966-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B72B52278
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 22:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35DB583A97
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9512FF67B;
	Wed, 10 Sep 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWgTzqdF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83332FAC14
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536904; cv=none; b=ivgPPUOThTio74iikFqZTUbPiAV3jFVSuoy0l/LdSfGXaWHTQX8lRyt29vysONfNuw/hAvLbYn/klhTGZ9+V0N5PUC7ryERoYh3D2rAaZCebhQAMoNgZvK2U/+HMtmnokKmIjtgrRKycbF5hz02mdzdPuvnoufcr8xpuo3nJEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536904; c=relaxed/simple;
	bh=RpQu8B19MEio3rAI2hB/X5DPqqs/M0gi/GwdHg8XiK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNfrbo4FVIzpPEPQWCy5ydi8+NMb70NOeHUV22HkmKJy6dNX3p4LmNogFTy3c23mxSBig4U6wbVMP0AEMXA3Ur2fSVOzTKBFiKO0e70olzD82567rmZSq3vxaf1YvWVFMs82Za+/wCF/0iEAyEMvjgE6H4fCmkkQZvI839449k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWgTzqdF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b4bcb9638aso164331cf.0
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757536902; x=1758141702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpQu8B19MEio3rAI2hB/X5DPqqs/M0gi/GwdHg8XiK4=;
        b=SWgTzqdFfCKjsj8Bv+0UQ1Mp9dUWEiX7jf3JVYNfIvO5Tomwe67XJxRTpJ6GwGM3h/
         t8+R9Y/MmKi36/4BzNAtBdl9I2/FfO7W7q2fSpPBIlJJ769CttmSqbKmsAoycft+xz7R
         bwVQq3s3ckVjfUCOBABJn8FP+tYB7HVK9DmP8XUmVjR/hJlb7As3ynd2d2b2dLtXu4PJ
         Zvwa0t38qYxcGigtBbu1rcLo0fH+9tAzmkKfddca/UQ4sphHo27ul0syL26gD2+WfLOu
         UXeXUvf5oXFG3voIAbFqKD1njuP+aqMHyvsgbVPypkFgGTAQMvc0oNgCEa5pyA6NykQl
         Wx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536902; x=1758141702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpQu8B19MEio3rAI2hB/X5DPqqs/M0gi/GwdHg8XiK4=;
        b=KSO+CMKcG49mMzM4CDUYSINWvduXse801eW1YfBkqLLnNiXzZrub2XywlYIVn5DDw9
         RurJuicGt+ubPL46OskQ8zhFF13Gw6cLBxPRfgrIl5uYKIOgWPrd06htajJ1pVbr8B/K
         Ga2aHv0yw+Bz3yYwb1vlOzi5V78+XYI6bL0q5OynALXxmwNj+gEqJLGrfHCRrBhrFj+m
         VnJtKfFiqt/qK/MEXQPkK1T5TMowRRsi1Cr5xgVpXOI8+xtCs9g4eIlJIsLyEeLLuCNv
         K7f+Dy/Y9szlR4cqt0JrQuaso4FHK9PwAiRhG6gHIJF9LbeugfZLPCwW/dLtbwQ6x0QU
         Mq8A==
X-Forwarded-Encrypted: i=1; AJvYcCXHOGGnsUr2FzEJCg17rwco3TqJ8LJP90dLBmKKizBWaPigRKVORjQ853Z0rJDyU8uTAsZRFRhq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs1SJgTY3FantoXu6OAvJaGcBZCuJrsdYlb2OyROA6zhQXNifd
	fdRLK7KmSmaFINLKGFFuoyaIWitpDf0wiFXqS2K7BCB3AQBwyWXX12oZwTvg5FhRxETGLz20GK/
	aoZA1pMTT/Ep2VvaCqXbSyKaUKi1u3VS7d6Vp+cyx
X-Gm-Gg: ASbGncsFzeCP+Tf2rpsaouS1St1iU7v2h7oPrMuhlo/xcMew0x1l1XIsr/Js+buaNSp
	mJStv7Cmnu6g4vR1pLaHFBRDGVqExsnBcz1XXs+jlOfqpUf6buwRblMEIH8HHSnTeR9PdV2II9/
	0U1xAd1vJ56AVsztBRLBKov4tzDPCO7yuAL65gin0xOGmjn7UfJQ0DPJclvomOKHl9i4afcTKx0
	hTuL0DaJ0yxrgZUoY8n25VbVO96glEEvxSsY/KHyjEn5ogzWYDPow==
X-Google-Smtp-Source: AGHT+IHbQlhskzm2umaiSCVK7F4asqf8KLiAUVgJOpxaNfiXFJRF7QoxeR9wlR3GvPVF+MNtKa/jSV5VrLPSsQR7N2s=
X-Received: by 2002:a05:622a:311:b0:4b0:85b7:ea77 with SMTP id
 d75a77b69052e-4b626dac8a6mr7249681cf.3.1757536900773; Wed, 10 Sep 2025
 13:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com> <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez>
In-Reply-To: <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Sep 2025 13:41:29 -0700
X-Gm-Features: AS18NWANf9zf8-wwlTuHfifwdfaJCLJSeFkghtgQl5BDc45w4ZtnmTyIc9pxfNM
Message-ID: <CAJuCfpF1deAfZfWQZkAdws9FDNsmZp3KMQap-LqcX1NzOoknhA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Sep 09, 2025 at 12:48:02PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Sep 9, 2025 at 12:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > > > 1. Problem Scenario
> > > > On systems with ZRAM and swap enabled, simultaneous process exits c=
reate
> > > > contention. The primary bottleneck occurs during swap entry release
> > > > operations, causing exiting processes to monopolize CPU resources. =
This
> > > > leads to scheduling delays for high-priority processes.
> > > >
> > > > 2. Android Use Case
> > > > During camera launch, LMKD terminates background processes to free =
memory.
> > >
> > > How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> >
> > SIGKILL
> >
> > >
> > > > Exiting processes compete for CPU cycles, delaying the camera previ=
ew
> > > > thread and causing visible stuttering - directly impacting user
> > > > experience.
> > >
> > > Since the exit/kill is due to low memory situation, punting the memor=
y
> > > freeing to a low priority async mechanism will help in improving user
> > > experience. Most probably the application (camera preview here) will =
get
> > > into global reclaim and will compete for CPU with the async memory
> > > freeing.
> > >
> > > What we really need is faster memory freeing and we should explore al=
l
> > > possible ways. As others suggested fix/improve the bottleneck in the
> > > memory freeing path. In addition I think we should explore paralleliz=
ing
> > > this as well.
> > >
> > > On Android, I suppose most of the memory is associated with single or
> > > small set of processes and parallelizing memory freeing would be
> > > challenging. BTW is LMKD using process_mrelease() to release the kill=
ed
> > > process memory?
> >
> > Yes, LMKD has a reaper thread which wakes up and calls
> > process_mrelease() after the main LMKD thread issued SIGKILL.
> >
>
> Thanks Suren. I remember Android is planning to use Apps in cgroup. Is
> that still the plan? I am actually looking into cgroup.kill, beside
> sending SIGKILL, putting the processes of the target cgroup in the oom
> reaper list. In addition, making oom reaper able to reap processes in
> parallel. I am hoping that functionality to be useful to Android as
> well.

Yes, cgroups v2 with per-app hierarchy is already enabled on Android
as of about a year or so ago. The first usecase was the freezer. TJ
(CC'ing him here) also changed how ActivityManager Service (AMS) kills
process groups to use cgroup.kill (think when you force-stop an app
that's what will happen). LMKD has not been changed to use cgroup.kill
but that might be worth doing now. TJ, WDYT?


> > >

