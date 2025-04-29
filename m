Return-Path: <cgroups+bounces-7906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FA2AA3BD7
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A595E9878F5
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17BC2DAF8D;
	Tue, 29 Apr 2025 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="To5cAwJ6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B222DAF80
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967726; cv=none; b=ARiY6CvOapr0VxSpxtD0oX0J/nMAQlmddjiI4pZDrBQDp6219AE8FxChMUeuyOJHP1vlb/9/MkMbxTDNhqv00ms0jfMoZ+Hyt8A3Ghwx46W3+jWXGdXMpIAkBuhoEJJrTY0pzl6PWD6hqvcI0J5hQVP8dGnvy1dtKTXfweDwxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967726; c=relaxed/simple;
	bh=xGHK2nnUOwrFV1pwM0pJFjXnuJW4DB86YngBLtbQbM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOL/3vYwVEYDUkNmYPySRdyjWqCz8/gWanEGgJEi6t6KeI8v5Uwpva4d8VwxDPecqDvyyLUNAPCvg8WmNIWaniCtZ/PBJCJQi2Y8NNrVoNEnG475UUhDpoBfwmDb7AJWJe3aExPQ3NgHxrFAoKj8pgBYtF/FNRmMZU1jlKHc+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=To5cAwJ6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47e9fea29easo182351cf.1
        for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745967723; x=1746572523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3cBPfGnbz/yvJrhNx9adzzOV771Og4uaUmsjg7veAQ=;
        b=To5cAwJ6n6m8eNjibng1FrCtYEY8UaUA60x156K0i2X2fYMNZSvuv9GQkLw0X7xf4w
         PNCRQ84MWK98QzZOJSLHtzHN6h6h6j6L0cvVJj0swVcigDZZF62/Pooe++OegCTXkNtn
         BRgmbDmtxMXcaHoMyxtvbC9Fc7IE2vP0egMGoUqPHAioNbCEfprvjTKh8wO2HZHhzcpK
         FX3b5tQnX+r/rXbRsx5I/0XfLUAviWsjmWl7jnbRo4BYwIQmk7RE3DMTNuZkFPLPx3Lr
         SavxywLrHehcZHs0jbQ7E1FuT079lVRQyKSjMgohwSMFVC0twtXgkPoCfD3KJS5boXx9
         6zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745967723; x=1746572523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3cBPfGnbz/yvJrhNx9adzzOV771Og4uaUmsjg7veAQ=;
        b=Hc/Ab3dw7UntKjSMDVsrikP+XsxqUN9MPYgSYW6gAcCh3LN2/CCDZqcGMKSbUzdhaY
         pSHsoqOXF2b/vXJGjHjItBQajb6pFlCBM4AYeX0K+DXOwRV3J9DWj33MvlhwNqsGjfo8
         MtDCexTWT7n+wAp0XWh8tVXthQJknmU6Z1XBXA1ENqlmcsLbccCFuriajcEAtBGlsypz
         v9K4E/hGli4KREbc/dM7IlyHaaK66mGFO6bVZmGX9HDtO1C++L1YWzWD4mmUQckBBBhD
         E5WosCMDNc7DD219nRokJR0EgNAbPwtYLde1+V2rixADjW9tsdul0DgcG4LCIgeVFQJ2
         NIJw==
X-Forwarded-Encrypted: i=1; AJvYcCW7wK8tP3UWUS9vXOEnsR6JpwuZQ0UQ/je5UylQOD7+QZfEt7K9tdyEaaY1DetF7vBh5o96FyZS@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEkdVwZcAuxUDSGvAPtOQ4+NGU3EYTwo5v5wf9e12ouxb8qTf
	T3mdZB2BgIayKORwGRVr9CdPVXeNdkiFZJMbmsSEWQGeWAPY0Q7K0WllDVE7aK+btHU0GphqxWt
	9zzFzPVhQ78zO7jSJhJKf1hfBRiLKNd58DskN
X-Gm-Gg: ASbGncurlHPPdEk9VXYycfo4Jb1ziXOOsAMITsGKaXJ2wFTtueay/zt4n4ajRr5BAbh
	Vouap0Xi/dgtlu3GoHesjGRWvZyx8rnlm2vstz+TrebUAkSi7vrnV/+UjU0rT88RbxYTkLyrWN8
	Mtxyi8kTSguR2ZGu0d/JTmVjpKwubL9FSU/wt+BnpdNNnUscyljSm1
X-Google-Smtp-Source: AGHT+IF0gr5CtAes59SO6D9Xj0Aw+uB4nzgHygdR3Y4wolPVTp2LjDG4D3xn7ja/TpQ6TJvn+4y3ap8WAP2rwioNkhA=
X-Received: by 2002:a05:622a:148:b0:486:8d63:2dfc with SMTP id
 d75a77b69052e-489b9838ba4mr1552441cf.2.1745967723192; Tue, 29 Apr 2025
 16:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <aBC7E487qDSDTdBH@tiehlicka> <87selrrpqz.fsf@linux.dev>
In-Reply-To: <87selrrpqz.fsf@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 16:01:52 -0700
X-Gm-Features: ATxdqUEHJ0lKafIQLl6tuQKVn2J6UGA75Kfzy8FGMf24UMiPODsN3bv6xf3NM-k
Message-ID: <CAJuCfpFUBkNQS_851=L3PKH231VPKpAL7CRNEKj0_3Nhpxsysg@mail.gmail.com>
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:45=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Michal Hocko <mhocko@suse.com> writes:
>
> > On Mon 28-04-25 03:36:05, Roman Gushchin wrote:
> >> This patchset adds an ability to customize the out of memory
> >> handling using bpf.
> >>
> >> It focuses on two parts:
> >> 1) OOM handling policy,
> >> 2) PSI-based OOM invocation.
> >>
> >> The idea to use bpf for customizing the OOM handling is not new, but
> >> unlike the previous proposal [1], which augmented the existing task
> >> ranking-based policy, this one tries to be as generic as possible and
> >> leverage the full power of the modern bpf.
> >>
> >> It provides a generic hook which is called before the existing OOM
> >> killer code and allows implementing any policy, e.g.  picking a victim
> >> task or memory cgroup or potentially even releasing memory in other
> >> ways, e.g. deleting tmpfs files (the last one might require some
> >> additional but relatively simple changes).
> >
> > Makes sense to me. I still have a slight concern though. We have 3
> > different oom handlers smashed into a single one with special casing
> > involved. This is manageable (although not great) for the in kernel
> > code but I am wondering whether we should do better for BPF based OOM
> > implementations. Would it make sense to have different callbacks for
> > cpuset, memcg and global oom killer handlers?
>
> Yes, it's certainly possible. If we go struct_ops path, we can even
> have both the common hook which handles all types of OOM's and separate
> hooks for each type. The user then can choose what's more convenient.
> Good point.
>
> >
> > I can see you have already added some helper functions to deal with
> > memcgs but I do not see anything to iterate processes or find a process=
 to
> > kill etc. Is that functionality generally available (sorry I am not
> > really familiar with BPF all that much so please bear with me)?
>
> Yes, task iterator is available since v6.7:
> https://docs.ebpf.io/linux/kfuncs/bpf_iter_task_new/
>
> >
> > I like the way how you naturalely hooked into existing OOM primitives
> > like oom_kill_process but I do not see tsk_is_oom_victim exposed. Are
> > you waiting for a first user that needs to implement oom victim
> > synchronization or do you plan to integrate that into tasks iterators?
>
> It can be implemented in bpf directly, but I agree that it probably
> deserves at least an example in the test or a separate in-kernel helper.
> In-kernel helper is probably a better idea.
>
> > I am mostly asking because it is exactly these kind of details that
> > make the current in kernel oom handler quite complex and it would be
> > great if custom ones do not have to reproduce that complexity and only
> > focus on the high level policy.
>
> Totally agree.
>
> >
> >> The second part is related to the fundamental question on when to
> >> declare the OOM event. It's a trade-off between the risk of
> >> unnecessary OOM kills and associated work losses and the risk of
> >> infinite trashing and effective soft lockups.  In the last few years
> >> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> >> systemd-OOMd [4]). The common idea was to use userspace daemons to
> >> implement custom OOM logic as well as rely on PSI monitoring to avoid
> >> stalls.
> >
> > This makes sense to me as well. I have to admit I am not fully familiar
> > with PSI integration into sched code but from what I can see the
> > evaluation is done on regular bases from the worker context kicked off
> > from the scheduler code. There shouldn't be any locking constrains whic=
h
> > is good. Is there any risk if the oom handler took too long though?
>
> It's a good question. In theory yes, it can affect the timing of other
> PSI events. An option here is to move it into a separate work, however
> I'm not sure if it worth the added complexity. I actually tried this
> approach in an earlier version of this patchset, but the problem was
> that the code for scheduling this work should be dynamically turned
> on/off when a bpf program is attached/detached, otherwise it's an
> obvious cpu overhead.
> It's doable, but Idk if it's justified.

I think this is a legitimate concern. bpf_handle_psi_event() can block
update_triggers() and delay other PSI triggers.

>
> >
> > Also an important question. I can see selftests which are using the
> > infrastructure. But have you tried to implement a real OOM handler with
> > this proposed infrastructure?
>
> Not yet. Given the size and complexity of the infrastructure of my
> current employer, it's not a short process. But we're working on it.
>
> >
> >> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@=
bytedance.com/
> >> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> >> [3]: https://github.com/facebookincubator/oomd
> >> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-o=
omd.service.html
> >>
> >> ----
> >>
> >> This is an RFC version, which is not intended to be merged in the curr=
ent form.
> >> Open questions/TODOs:
> >> 1) Program type/attachment type for the bpf_handle_out_of_memory() hoo=
k.
> >>    It has to be able to return a value, to be sleepable (to use cgroup=
 iterators)
> >>    and to have trusted arguments to pass oom_control down to bpf_oom_k=
ill_process().
> >>    Current patchset has a workaround (patch "bpf: treat fmodret tracin=
g program's
> >>    arguments as trusted"), which is not safe. One option is to fake ac=
quire/release
> >>    semantics for the oom_control pointer. Other option is to introduce=
 a completely
> >>    new attachment or program type, similar to lsm hooks.
> >> 2) Currently lockdep complaints about a potential circular dependency =
because
> >>    sleepable bpf_handle_out_of_memory() hook calls might_fault() under=
 oom_lock.
> >>    One way to fix it is to make it non-sleepable, but then it will req=
uire some
> >>    additional work to allow it using cgroup iterators. It's intervened=
 with 1).
> >
> > I cannot see this in the code. Could you be more specific please? Where
> > is this might_fault coming from? Is this BPF constrain?
>
> It's in __bpf_prog_enter_sleepable(). But I hope I can make this hook
> non-sleepable (by going struct_ops path) and the problem will go away.
>
> >
> >> 3) What kind of hierarchical features are required? Do we want to nest=
 oom policies?
> >>    Do we want to attach oom policies to cgroups? I think it's too comp=
licated,
> >>    but if we want a full hierarchical support, it might be required.
> >>    Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes t=
he true root
> >>    memcg, which is potentially outside of the ns of the loading proces=
s. Does
> >>    it require some additional capabilities checks? Should it be remove=
d?
> >
> > Yes, let's start simple and see where we get from there.
>
> Agree.
>
> Thank you for taking a look and your comments/ideas!
>

