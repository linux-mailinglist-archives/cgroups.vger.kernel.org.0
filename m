Return-Path: <cgroups+bounces-7877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079AA9FF47
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 03:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63087462498
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 01:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5D20DD49;
	Tue, 29 Apr 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN1zu4gy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2967082D;
	Tue, 29 Apr 2025 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745891855; cv=none; b=QrjEthlm0zZBhxKAWA1z0KsWs/Xd1YEh6tJSDi3NlZwt4Dz1japs+3VKm5VNLJI8mT/4oA+cfssn6zinTO8z4r+2HVfWfYOqfVpNe8IimVpCaf1mRM0l+ua7nxee9JYctMn1S1tJKlS6H66XSQVQ8Ln2gwHYMb0Nz7rN2rS+Ul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745891855; c=relaxed/simple;
	bh=0aVd5JM1SATlQkOEKpKHvyBCifj+Y1pNPtszkHc0MDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ddsrt8+J6gsrr8/v8v7f87SuwUHoalQhj/k1rQlcxYwoR6kJDxglIK8BB1T0rzcBsu8WUALAqhd2fvhB91NLYTvmJuRpcvdCwLkHujcCarxqd0tIuf3A7XiMUt1D9BLCBQCodLYSOnDYEzALgRmhUhN7CKnFjcc1MgR8Dz0cwdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN1zu4gy; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso1047402a12.3;
        Mon, 28 Apr 2025 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745891851; x=1746496651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TcbnWyvi1dis9SuCZ1/SKbV8UgckR1GJ3YAyTppIVtA=;
        b=BN1zu4gy69wbKMIWSNQdHqhc0ynSALiseJlBwd1Sl2pCK66t4N01jO022WPybXi6+E
         EpX6R+RdrlYGC3d13KP/PpLzVS2Y72BxwmVW7irMlq2swAV1cM2MmZgVl/LwwPVCemUd
         4qPZ2ORdbqIFNuEMBq2vd5NkT77BjTHVdbPvsd6iUXgadBea/xZA1o1IOav6qcl2coWM
         kW6rRM3GGyfReLEyEE5n/3dO5sxSOH7adFSySsJWWHFVGjBb6yKn8JouWBUZNwlb90Ej
         Fcf7lgeB8H6SoEIuAyVj7adL5db+J5fJT83WK1i4SasOrt5qRtxoqQJ3v8SFdPWYuiF9
         ftdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745891851; x=1746496651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcbnWyvi1dis9SuCZ1/SKbV8UgckR1GJ3YAyTppIVtA=;
        b=MMfxlmAgifHGDQj5j95wI7bY0txppLNKr9vGmdGoV8v8iHLgKRqObr/KsTlBh8gBdf
         x2S63K4253N4hwsoeIakrYYhrGVib2J25mlhzIZOLy1dxW9+c3aRYnhvUULgOTJH12N8
         mBsSSFOCctMDGJetfBM3Tc7lg63kxuA3LxKtWLybjvUffBHm67rMoFchPZt/q65tCZ14
         mj+zVISv1qhhX+gfKa5qeJSZc/Cra8Og6roQakRSFwtiJZ9psT78Ylss8+n1SFfTBQFe
         vIbuEfsG/W6c7wxNsYhseaz3yV6AnvjfyQxslE+LQnrpDlIX9CWGdH3LMjhrADhkSEgi
         MP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1IZc3U3WeXDBhYu4TYPZFhPZvCIMfR+Ld7zoFGqY0k5qcdYCNzAuw2GFMr8Jd1FaLCM2z3t4+uA==@vger.kernel.org, AJvYcCWphEDOiJh91rikDOwlBCGy/hLEedCpNb4Fe41bdS8YlcVlyxUdrd3Ud+0UoVkZM2ZXCoM=@vger.kernel.org, AJvYcCXppP0grYV2baXsdPqTTc7PlvFmSWhtCfE8ZMbHtcGZW6f+NbuQ2CQOc3fr5i57Ats2BZIQ8LN7Kbcp8Z2t@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71zmE8NGaXmfvpb8aqiyDhVYmQNPRKVBIx6TEyp1f/UoxQwV1
	49F/lGnC9URLpUV//Zp0TSNq91pcwRKKy6bT0E9Fd4aRUV5wbasIvtLFKdmSsTl1G3iGupZuf7K
	fwRczt3qplwYYRhaxYhEjrQS33qQ=
X-Gm-Gg: ASbGncsP90bwqwLmQGDSCyF7MtBXSnHwoZPG9rZ8qRYT+qcf+UlIBqCDH4378iOrr+Z
	YozU5Nn26H1kpwhmIynbxCqVhPhxrhUYAeYdx6eebN+VAdRMjfeA1Fhz+QzTAFboEHok59t9XkK
	/WNwshpIuwxt/vuqKwdVzhPtycwXbIVDBg/B7GMsEGl+4=
X-Google-Smtp-Source: AGHT+IGOWEHRraH/2R9p5mFTxnX5r73jmgvEf14qIKTjllHFXZonneNpk+KF0w0p4HhcLjQZwdv7Ae+C7fdY42nuL00=
X-Received: by 2002:a05:6402:1d51:b0:5e5:cb92:e760 with SMTP id
 4fb4d7f45d1cf-5f73960b9dfmr10033682a12.17.1745891851157; Mon, 28 Apr 2025
 18:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <aA9bu7UJOCTQGk6L@google.com> <aA-5xX10nXE2C2Dn@google.com>
In-Reply-To: <aA-5xX10nXE2C2Dn@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 29 Apr 2025 03:56:54 +0200
X-Gm-Features: ATxdqUFdh-Baw2wdCT7Q9ZoFIPb0JFBuAYBmlyEh_Ms9YrPmoZBG5fJLOSMLFxg
Message-ID: <CAP01T76Wv+swbT9xuQ-YhQ=-qOFggw6u1RziJNGjJBiNO233OQ@mail.gmail.com>
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matt Bobrowski <mattbobrowski@google.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Apr 2025 at 19:24, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Mon, Apr 28, 2025 at 10:43:07AM +0000, Matt Bobrowski wrote:
> > On Mon, Apr 28, 2025 at 03:36:05AM +0000, Roman Gushchin wrote:
> > > This patchset adds an ability to customize the out of memory
> > > handling using bpf.
> > >
> > > It focuses on two parts:
> > > 1) OOM handling policy,
> > > 2) PSI-based OOM invocation.
> > >
> > > The idea to use bpf for customizing the OOM handling is not new, but
> > > unlike the previous proposal [1], which augmented the existing task
> > > ranking-based policy, this one tries to be as generic as possible and
> > > leverage the full power of the modern bpf.
> > >
> > > It provides a generic hook which is called before the existing OOM
> > > killer code and allows implementing any policy, e.g.  picking a victim
> > > task or memory cgroup or potentially even releasing memory in other
> > > ways, e.g. deleting tmpfs files (the last one might require some
> > > additional but relatively simple changes).
> > >
> > > The past attempt to implement memory-cgroup aware policy [2] showed
> > > that there are multiple opinions on what the best policy is.  As it's
> > > highly workload-dependent and specific to a concrete way of organizing
> > > workloads, the structure of the cgroup tree etc, a customizable
> > > bpf-based implementation is preferable over a in-kernel implementation
> > > with a dozen on sysctls.
> > >
> > > The second part is related to the fundamental question on when to
> > > declare the OOM event. It's a trade-off between the risk of
> > > unnecessary OOM kills and associated work losses and the risk of
> > > infinite trashing and effective soft lockups.  In the last few years
> > > several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> > > systemd-OOMd [4]). The common idea was to use userspace daemons to
> > > implement custom OOM logic as well as rely on PSI monitoring to avoid
> > > stalls. In this scenario the userspace daemon was supposed to handle
> > > the majority of OOMs, while the in-kernel OOM killer worked as the
> > > last resort measure to guarantee that the system would never deadlock
> > > on the memory. But this approach creates additional infrastructure
> > > churn: userspace OOM daemon is a separate entity which needs to be
> > > deployed, updated, monitored. A completely different pipeline needs to
> > > be built to monitor both types of OOM events and collect associated
> > > logs. A userspace daemon is more restricted in terms on what data is
> > > available to it. Implementing a daemon which can work reliably under a
> > > heavy memory pressure in the system is also tricky.
> > >
> > > [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
> > > [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> > > [3]: https://github.com/facebookincubator/oomd
> > > [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> > >
> > > ----
> > >
> > > This is an RFC version, which is not intended to be merged in the current form.
> > > Open questions/TODOs:
> > > 1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
> > >    It has to be able to return a value, to be sleepable (to use cgroup iterators)
> > >    and to have trusted arguments to pass oom_control down to bpf_oom_kill_process().
> > >    Current patchset has a workaround (patch "bpf: treat fmodret tracing program's
> > >    arguments as trusted"), which is not safe. One option is to fake acquire/release
> > >    semantics for the oom_control pointer. Other option is to introduce a completely
> > >    new attachment or program type, similar to lsm hooks.
> >
> > Thinking out loud now, but rather than introducing and having a single
> > BPF-specific function/interface, and BPF program for that matter,
> > which can effectively be used to short-circuit steps from within
> > out_of_memory(), why not introduce a
> > tcp_congestion_ops/sched_ext_ops-like interface which essentially
> > provides a multifaceted interface for controlling OOM killing
> > (->select_bad_process, ->oom_kill_process, etc), optionally also from
> > the context of a BPF program (BPF_PROG_TYPE_STRUCT_OPS)?
>
> It's certainly an option and I thought about it. I don't think we need a bunch
> of hooks though. This patchset adds 2 and they belong to completely different
> subsystems (mm and sched/psi), so Idk how well they can be gathered
> into a single struct ops. But maybe it's fine.
>
> The only potentially new hook I can envision now is one to customize
> the oom reporting.
>

If you're considering scoping it down to a particular cgroup (as you
allude to in the TODO), or building a hierarchical interface, using
struct_ops will be much better than fmod_ret etc., which is global in
nature. Even if you don't support it now. I don't think a struct_ops
is warranted only when you have more than a few callbacks. As an
illustration, sched_ext started out without supporting hierarchical
attachment, but will piggy-back on the struct_ops interface to do so
in the near future.

> Thanks for the suggestion!
>
>

