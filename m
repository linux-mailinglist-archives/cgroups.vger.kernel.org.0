Return-Path: <cgroups+bounces-11414-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C0C1DD53
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 00:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601BD3A7311
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 23:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B731B830;
	Wed, 29 Oct 2025 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdjEmTlF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3493203A7
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782003; cv=none; b=kxuBKw2V17vos5lxXu/L58InP7t7N7Ql7ItiQhhNWFMUxsIzu2gr/fOU8cQX1iqjUaDnjvxYgtBtVsVpPv6+OevU5JLcJ9gZu0Ng5BmvFUlGV8MME3vKNkhYhVW27fpu/BdULPoZdRPCK1676vT8yeM6hC8MiOOHoumH7h5hRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782003; c=relaxed/simple;
	bh=D2m0EPDbKpZ3JRo0DT82GnQ89LW7K7rjeczuEkHf41c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwKaZNkyxwAC0hNJuYw69/+8Q1CKKYqs0tq7Hz4isCKkLipEiR884fuoO8Ja6hiJJietXpclUqO4PnDaVrWDrZFkyLmh7Sr6/Y6nKko9kqGv5tO9uAAKqYb883NOUlL7ygnEJcrrTce4Mc338RMu/UxK+Zi6QnrRWz9tGJUggqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdjEmTlF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42421b1514fso250298f8f.2
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761781999; x=1762386799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPZgBPK4KYbf0wiRz1OKb0KetLC+LXdJvV1wxFVXEDg=;
        b=GdjEmTlFtXhTuQnUYJW+l0CfSZil3NOWdcMOyTAXh5I70y6DEjmmTxMNcoW7NaLTEa
         SAy6cQec1OySTTXC5MGmJWDdby8z3p9gdF7DzIDggB+3df2Kp3eJbb1Uprx+O1IEMbQP
         MJDc3yUEFAvpfPUuivxzBLmhICzm0/mxjw+xNP3rxBFli80mD6knr3G+DKcIgbZsFucp
         wi9WxIrZCghgbFLFswKp874Hx3Hi69+RVFmrGj8gWqvfLBQBxRB+x1Zf5/1zlLsMRMe3
         +aJuRwE5VSq5PvqyR+Wxb7/2fLXeu/8dWOhl5/yiBjTzeM2oyHQgOyOGO4KjUdoJBVPy
         aIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761781999; x=1762386799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPZgBPK4KYbf0wiRz1OKb0KetLC+LXdJvV1wxFVXEDg=;
        b=WhpdPJ+vPjMfeOd4F9gCKIj4r8ErfW5gbMJK4/JEvW/9MVOZGd3kq8sjaZcfyGVzEj
         yaAk7xDaVcUsXfbMkMdENJNxfzvfwDddtx855yxXsrIRjaSfp6CmKGigr13O2cpQ249S
         1Dw1IHBC12xwBB5o7gYgKgq0plDgcC0+FRBqZMEZzv7Pj62DlGld9egI/Wf1Kn/6IG3t
         nY6iimtSzEV3UY/wuIexwM9nFv3hwNtgCOXWzwJgbcv0BXwQGGoZLLn/3Yga43JL6+mf
         zVD5WXd4zJbW6onSyBhZvqdbZ+cSp4ornmxwtBOiDv1pICFEfRYI1nWJQo5Ejg4PKbFK
         iGZg==
X-Forwarded-Encrypted: i=1; AJvYcCXNyRBF6JpfOXyoixD4U+jbLzSky7ODE3TxyqDJjKUHEYQ8g5RuYdhTxkPFeqA04VsB3s8Ha6M7@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLZdcwht52ZFI80EeopqFb4EPOk/EAWR+Fy8Wju0Qw9ePGTqN
	3bhsGhc6gIsSnUgYbBSl2OzfEKcl/napIh2RSdKJe6mXmCtpfraNj/MTVwpmzUsTuD9+LL1dY9c
	B7+uZeU99rEtCQq3qOiWSLBrRFq5s9w0=
X-Gm-Gg: ASbGncsBecrUgucAld9QaeZa569DGzTI5JpHLPZHFYtFJGEh3kdvT/95fNnH+em8Akg
	WP2u1aatzmR1vaS+bSfgUjjKeZUmmH85CIr7TyySA/h2coDLvaztXol9KTW8i5LKmexyHH2JyfV
	uaAEsYkSB12o8+vqUb4dzo5dD5MbLoxuwCtr39ktwIRZph+spiw0TwHOFBEiXrxn8pjldO73yti
	kLHmzhc+9W6uhui+hAPHDuCA7AVmLyx67ltg0Ujz3iMX6zt0OoJmmUgfap0mjfEcnnhZGx/USux
	4CPIOmK5jtUX+SkkvnA1TCbCMPLkmSiMCHjfigk=
X-Google-Smtp-Source: AGHT+IGrKp5MfacnbzNbpqAIhTO7ERG2WHtS4t6jru8KJPhlxG//rUzfqdjALv0fSxc61RpV8oyRKHl4WsT9w4GfLtM=
X-Received: by 2002:a05:6000:2005:b0:425:7e38:419f with SMTP id
 ffacd0b85a97d-429aef82fd5mr3552778f8f.16.1761781999226; Wed, 29 Oct 2025
 16:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev> <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org>
In-Reply-To: <aQKa5L345s-vBJR1@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 16:53:07 -0700
X-Gm-Features: AWmQ_bmmWr20Sr7nISe9-dxnu7qiuhrtBr-MHR5CpH7Nay8Y8PduHzn8NSxStmM
Message-ID: <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:53=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 29, 2025 at 03:43:39PM -0700, Alexei Starovoitov wrote:
> ...
> > I think the general bpf philosophy that load and attach are two
> > separate steps. For struct-ops it's almost there, but not quite.
> > struct-ops shouldn't be an exception.
> > The bpf infra should be able to load a set of progs (aka struct-ops)
> > and attach it with a link to different entities. Like cgroups.
> > I think sched-ext should do that too. Even if there is no use case
> > today for the same sched-ext in two different cgroups.
>
> I'm not sure it's just that there's no use case.

I think there will be a use case for sched-ext as well,
just the current way the scheds are written is too specific.
There is cgroup local storage, so scheds can certainly
store whatever state there.
Potentially we can improve UX further by utilizing __thread on bpf.c
side in some way.

> - How would recursion work with private stacks? Aren't those attached to
>   each BPF program?

yes. private stack is per prog, but why does it matter?
I'm not suggesting that the same prog to be attached at different
levels of the cgroup hierarchy, because such configuration
will indeed trigger recursion prevention logic (with or without private
stack).
But having one logical sched-ext prog set to manage tasks
in container A and in container B makes sense as a use case to me
where A and B are different cgroups.
DSQs can be cgroup scoped too.

> - Wouldn't that also complicate attributing kfunc calls to the handle
>   instance?

you mean the whole prog_assoc stuff ?
That's orthogonal. tracing progs are global so there is
no perfect place to associate them with. struct-ops map
is the best we can do today, but ideally it's run_ctx
that should be per-attachment. Like cookie.

> If there is one struct_ops per cgroup, the oom kill kfunc can
>   look that up and then verify that the struct_ops has authority over the
>   target process. Multiple attachments can work too but that'd require
>   iterating all attachments, right?

Are you talking about bpf_oom_kill_process() kfunc from these patch set?
I don't think it needs any changes. oom context is passed into prog
and passed along to kfunc. Doesn't matter the cgroup origin.

