Return-Path: <cgroups+bounces-14571-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLOID9EZp2m+dgAAu9opvQ
	(envelope-from <cgroups+bounces-14571-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 18:26:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE11F49B1
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 18:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA9D30276A1
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B72370D5F;
	Tue,  3 Mar 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4RMh2/z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77E3537F0
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558735; cv=pass; b=DoMoSAv/j0PPkSY7qcCy0bP7ZE02DE9UGyvtMMTfQDqiDI3Nj3+LqfrgWhtcyq0S/ENKzvqXflRltA14K+MNrCt+jfVVusUxfIZIhoLSHKFBHxsEMg8aVCmqD2dsJibKE8Bj456s6e5vc0FHGCG9T0quemmJXb94xaQc7sV7Duo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558735; c=relaxed/simple;
	bh=p1noxESLu0MA7brXm1knWmLWb8wfzHlE5EPnaIYYBgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hD6DBYmYcxrnoNnnk8XqEm0Xu+BFJdAadMLS+SxNVd48aQ1LgXdzDGPs0OhhKpH5u+KzIwDbyJVyVlKhMlkiJF9uyb9ZCt/ZCyVTHoXicEsquMapC3HSMzbAZqlYS+k6A6NEDhpbgdjjyFrrJ7VvhmuQcag5kqjYL11rSJvfKPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4RMh2/z; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so71765e9.0
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2026 09:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772558733; cv=none;
        d=google.com; s=arc-20240605;
        b=ZCA4RUIQ+AwZpqVArcB9KkMzgXK9EgrnJGHBdaseMDZzDeOUcZEkhA0GtQvFE8cx4s
         byIuTxoa8nKjZN753zZd5lEeIz0p+pbenoTH5M2rSyJGQuVWsO7EsGca/hrmKugjNgVH
         coGPY1ff+aJWxO0ZxvHaODlApGhBLZid3uLkKWNHnEypnx+nNfCdVXmzVKZ7JSsLNn6a
         4jBskmQGT9x0DDlhDwjs5N+YxTX9xcatn8zdYnzLaQQox8J/afb1Iv2i1zT78bqFuxpV
         Uku3ZmjHQ59IGtSFPqw4wFKgaeW76smA+vIRRA3B8f971Yz63qPTFDTSEWaccnwhnmg5
         PNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p1noxESLu0MA7brXm1knWmLWb8wfzHlE5EPnaIYYBgQ=;
        fh=0OshcaDcoghNwBZjYKNV4KN79CPzdgxufuNsnvcflDo=;
        b=TR+gU1UqgpLJBgFfGCFUHASZtYLXxN2gxKmNv3WcYG51THs4pSRurwPzWiXx0LSlz8
         FSVHAgezg9OrXQ6EhUaqypcPKFPutmo3SbMlKjS9yg8fvERQsyHWdXNGPOri2RxEozPs
         kY5YEZBzuylU0sut/XAO0zJH+5QS9sd/ze0w5Oj4TKuwJy97Mc9Yv8VWf3uX5OXH+POp
         NLybJnnEARLJP14WMy/D3wVGTZBAymTnQQ6Y4S7ecPEDinzEvvBwLaQ0B2pK1fAXAi3a
         ShMBW/4nsBbZpLaaSbkBia92wIAr/xSkseQal6W4+1l1+IzceGmiPjpF1kMbls6TqLrm
         k3nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772558733; x=1773163533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1noxESLu0MA7brXm1knWmLWb8wfzHlE5EPnaIYYBgQ=;
        b=K4RMh2/zk8ayrjBHNfLguK0YN+QkGLFYazdcIwQaH5epZRMqzjmLyQJQHNSe4l9WdG
         ks+yU2yVEpOH9klmGJQc6GeB+zKAhMu/U6dp7JQ8eIBqfbwnS9pdeG+TS7GVoK7Po9fh
         KtngtbyzpeXlcNKRAnsi14FujgUh4miiolUwB3vlH3ZLEr0jyx7T9fnm2uqIe32NxdBh
         aI7398NcDGSYA8sd00WJ80AsrfxIz7OKc93TRj3YWuDdUzXBvGh1tUbLP+fnFpCCh6nS
         XHuWgg2zG9zRk1GCt2/7VGaAAQKmbsFCielcdAiRDussPSq6Hpw/HYW2poKOs3U+46EQ
         kbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772558733; x=1773163533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1noxESLu0MA7brXm1knWmLWb8wfzHlE5EPnaIYYBgQ=;
        b=EUNZdI5A8uV46HgaMOQNrwt8ElBw8vy/WSMTuG9XufuiiQlfTySOZ/hiyd0SXhai7a
         YMiIgpfu5PsGg3ouFuXqKTJYNLGrxDbrWz7V89Mw2dRU1PhGPgbbJLV5VjgAG1kcTAp1
         alpMRaoC8RVMbeLtT8PQ6lBNEcGKPlqUhKvzj7pqYvZEcD47pk7DAZiA6Punv6sfuGpL
         4uqgZf2pSUtvYZSDXyOto/fVUktsUmnrhjNubZYiHSZxlHf7ZAmXY1N+mXniO0HYxvFU
         TqGnzOY4Bo3iHrZ1xtL6vXaJVXHJkrnyotIQa82LRIr6xf7L5ui6ho7udq4VC1fKcnLV
         EDYg==
X-Forwarded-Encrypted: i=1; AJvYcCU5gwJw4AOuW0LZ6TLbuCgu4Io3GJ8KU6H6vFex9nAhYFP1ZoYLh0+CRBgXEsjTPitZO+WOSL9i@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzQBA5obJjmV0RJWPgOnI211pAwBU6jRK/1q0zxEaBjXJGlCI
	O+UE8uyQAEa6bLAHJuYOhUya9CVZALERtwU7bzPz3cQab2SFdPi6u58DcHotbSGisrruSGaWabL
	y8D4CO0NarnyhnFgVpIavzf1xRXL9qiPuXcwU/yPK
X-Gm-Gg: ATEYQzwW0+M14SPTuNHv1nmv5OddAt4CgN1bx0vgQr5/B73nlGe0d9+C3B4C6FVlpGN
	ajxIt9OuXcJEPWStXd/xzAdHjeNx0qoOUvwqb0P3xnwrOlaBKo8APqJWzNUUn02Y4tJ3i6vkrlq
	SNvx6gJUAuWyKUJcOHdgL22IvW7KVakKwJIBzzWBeg0P88y2bInzZRFWVzCSgTEcLPM7eOMOXlp
	ocYwhwSFXYEEgJ917WI4tXa8nI5/RP2d3ZnnfoHkW9zYlrpgM6x3n4gr2/hPVeoWVT4zSJSJj4y
	0KY6Gix28jBADl2E1foiEnSxMG6xy2MsNHlECtLRlfTfBB1r4Jj/FO1gFXKFfWfiXCG17w==
X-Received: by 2002:a05:600c:8a09:10b0:480:683f:743d with SMTP id
 5b1f17b1804b1-483ce5f6f44mr2585095e9.14.1772558732287; Tue, 03 Mar 2026
 09:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224020854.791201-1-airlied@gmail.com> <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com> <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
 <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com> <aaWuoe_CQwbtcxEY@linux.dev>
 <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com> <CABdmKX0=xPiwXgOHskGkE9Umj5=NrC=7OtngJjrm=mtOZmyzvA@mail.gmail.com>
 <614c3c39-1e11-4da4-b5ac-b8a6432dac7e@amd.com>
In-Reply-To: <614c3c39-1e11-4da4-b5ac-b8a6432dac7e@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 3 Mar 2026 09:25:19 -0800
X-Gm-Features: AaiRm53VHwY8zV-TMy3I5_8lCkvRhnZh3B-ppjhkgf1ohUtm3OVoU6SM37bueEs
Message-ID: <CABdmKX3MRdzVTFQcB+Z-6LkGbUxf2a04MTyjPpBSP0bfzRLB5A@mail.gmail.com>
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Dave Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94AE11F49B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14571-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,lists.freedesktop.org,kernel.org,cmpxchg.org,vger.kernel.org,fromorbit.com,redhat.com,ffwll.ch,google.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,amd.com:email,android.com:url,wikipedia.org:url]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:29=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 3/2/26 20:35, T.J. Mercier wrote:
> > On Mon, Mar 2, 2026 at 7:51=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 3/2/26 16:40, Shakeel Butt wrote:
> >>> +TJ
> >>>
> >>> On Mon, Mar 02, 2026 at 03:37:37PM +0100, Christian K=C3=B6nig wrote:
> >>>> On 3/2/26 15:15, Shakeel Butt wrote:
> >>>>> On Wed, Feb 25, 2026 at 10:09:55AM +0100, Christian K=C3=B6nig wrot=
e:
> >>>>>> On 2/24/26 20:28, Dave Airlie wrote:
> >>>>> [...]
> >>>>>>
> >>>>>>> This has been a pain in the ass for desktop for years, and I'd li=
ke to
> >>>>>>> fix it, the HPC use case if purely a driver for me doing the work=
.
> >>>>>>
> >>>>>> Wait a second. How does accounting to cgroups help with that in an=
y way?
> >>>>>>
> >>>>>> The last time I looked into this problem the OOM killer worked bas=
ed on the per task_struct stats which couldn't be influenced this way.
> >>>>>>
> >>>>>
> >>>>> It depends on the context of the oom-killer. If the oom-killer is t=
riggered due
> >>>>> to memcg limits then only the processes in the scope of the memcg w=
ill be
> >>>>> targetted by the oom-killer. With the specific setting, the oom-kil=
ler can kill
> >>>>> all the processes in the target memcg.
> >>>>>
> >>>>> However nowadays the userspace oom-killer is preferred over the ker=
nel
> >>>>> oom-killer due to flexibility and configurability. Userspace oom-ki=
llers like
> >>>>> systmd-oomd, Android's LMKD or fb-oomd are being used in containeri=
zed
> >>>>> environments. Such oom-killers looks at memcg stats and hiding some=
thing
> >>>>> something from memcg i.e. not charging to memcg will hide such usag=
e from these
> >>>>> oom-killers.
> >>>>
> >>>> Well exactly that's the problem. Android's oom killer is *not* using=
 memcg exactly because of this inflexibility.
> >>>
> >>> Are you sure Android's oom killer is not using memcg? From what I see=
 in the
> >>> documentation [1], it requires memcg.
> >
> > LMKD used to use memcg v1 for memory.pressure_level, but that has been
> > replaced by PSI which is now the default configuration. I deprecated
> > all configurations with memcg v1 dependencies in January. We plan to
> > remove the memcg v1 support from LMKD when the 5.10 and 5.15 kernels
> > reach EOL.
> >
> >> My bad, I should have been wording that better.
> >>
> >> The Android OOM killer is not using memcg for tracking GPU memory allo=
cations, because memcg doesn't have proper support for tracking shared buff=
ers.
> >>
> >> In other words GPU memory allocations are shared by design and it is t=
he norm that the process which is using it is not the process which has all=
ocated it.
> >>
> >> What we would need (as a start) to handle all of this with memcg would=
 be to accounted the resources to the process which referenced it and not t=
he one which allocated it.
> >>
> >> I can give a full list of requirements which would be needed by cgroup=
s to cover all the different use cases, but it basically means tons of extr=
a complexity.
> >
> > Yeah this is right. We usually prioritize fast kills rather than
> > picking the biggest offender though. Application state (foreground /
> > background) is the primary selector, however LMKD does have a mode
> > (kill_heaviest_task) where it will pick the largest task within a
> > group of apps sharing the same application state. For this it uses RSS
> > from /proc/<pid>/statm, and (prepare to avert your eyes) a new and out
> > of tree interface in procfs for accounting dmabufs used by a process.
> > It tracks FD references and map references as they come and go, and
> > only counts any buffer once for a process regardless of the number and
> > type of references a process has to the same buffer. I dislike it
> > greatly.
>
> *sigh* I was really hoping that we would have nailed it with the BPF supp=
ort for DMA-buf and not rely on out of tree stuff any more.

The BPF support is still a win and I'm very happy to have it, but I
don't think there was ever a route to implementing cgroup limits on
top of it.

> We should really stop re-inventing the wheel over and over again and fix =
the shortcomings cgroups has instead and then use that one.
>
> > My original intention was to use the dmabuf BPF iterator we added to
> > scan maps and FDs of a process for dmabufs on demand. Very simple and
> > pretty fast in BPF. This wouldn't support high watermark tracking, so
> > I was forced into doing something else for per-process accounting. To
> > be fair, the HWM tracking has detected a few application bugs where
> > 4GB of system memory was inadvertently consumed by dmabufs.
> >
> > The BPF iterator is currently used to support accounting of buffers
> > not visible in userspace (dmabuf_dump / libdmabufinfo) and it's a nice
> > improvement for that over the old sysfs interface. I hope to replace
> > the slow scanning of procfs for dmabufs in libdmabufinfo with BPF
> > programs that use the dmabuf iterator, but that's not a priority for
> > this year.
> >
> > Independent of all of that, memcg doesn't really work well for this
> > because it's shared memory that can only be attributed to a single
> > memcg, and the most common allocator (gralloc) is in a separate
> > process and memcg than the processes using the buffers (camera,
> > YouTube, etc.). I had a few patches that transferred the ownership of
> > buffers to a new memcg when they were sent via Binder, but this used
> > the memcg v1 charge moving functionality which is now gone because it
> > was so complicated. But that only works if there is one user that
> > should be charged for the buffer anyway. What if it is shared by
> > multiple applications and services?
>
> Well the "usual" (e.g. what you find in the literature and what other ope=
rating systems do) approach is to use a proportional set size instead of th=
e resident set size: https://en.wikipedia.org/wiki/Proportional_set_size
>
> The problem is that a proportional set size is usually harder to come by.=
 So it means additional overhead, more complex interfaces etc...

I added /proc/<pid>/dmabuf_pss as well, which actually isn't a
horrible implementation if you consider that the entire buffer is
pinned as long as there is any user.

https://cs.android.com/android/kernel/superproject/+/common-android14-6.1:c=
ommon/fs/proc/base.c;drc=3D1b269f8eb12649ec9370f4051ae049e54a31e3fe;l=3D339=
3

With page-based memcg accounting it would be much harder and more expensive=
.

> Regards,
> Christian.
>
> >
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> [1] https://source.android.com/docs/core/perf/lmkd
> >>>
> >>>>
> >>>> See the multiple iterations we already had on that topic. Even inclu=
ding reverting already upstream uAPI.
> >>>>
> >>>> The latest incarnation is that BPF is used for this task on Android.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>
>

