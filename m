Return-Path: <cgroups+bounces-11451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C3C23541
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 07:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E68A4E362C
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1E2EC562;
	Fri, 31 Oct 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKCJJoCN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9712E7F38
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891277; cv=none; b=jMBY6q5w+sdecSlf6B6i+RMLDYBXG3ftiBVvjHZaqztU1v1EcCoWTewPyIIvIDCBAPoYZ/eU0d5Vm3nf9vnbhy+CqWFAZ4y7fFPBadnY4+EfkpmxzdVZpCVSlJFAkuOmM/gvJ94FEc15F9Hz1wl/9bUyTyVVW+CXe9TFwCC2j+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891277; c=relaxed/simple;
	bh=ulqQ2Efc96Ndv0ALKnZyWiWyzX2vMFMpabUS/C/Sh3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCkkfiOzBXRyXmUljR8Xmd4E23O3c5SvrDg0ZJhdOFe+wbbxEvC7K0P7PiXnbyN769HPHiePO/tJQSG/c+Hc5RZyDcM0XtEKJTuI3F7D4QhuNfE8KxtVFYpZO0iPN9gvEl7hF0NNhY55UI9eYyZV0r6RocHo5Ss6YbXJd/EKbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKCJJoCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025D7C116C6
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891277;
	bh=ulqQ2Efc96Ndv0ALKnZyWiWyzX2vMFMpabUS/C/Sh3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rKCJJoCNVl0Q5qtaH1Z+C7B1Oz+Fl08Rl8H0qpFx06zWBR66UY0lqEwb3iTi0T7bZ
	 iUo9iMhXwDO1C9+a/RSFlW0WTKwANQWJQ8up+KtwVzuAsT0So20658/XXdq0NWtphE
	 gkxQDiUHsr7C4T3wMDNAw3HFdzQLreVT717xnA/vyNUP8KC0C+zCtguLL8LVOJVhTh
	 ZtKH+qq8rbVN87I0SYHf2gnCjl8TbdTuDIGUVJSwLcNn6hCe162OTbkUhb0vZ2YZyG
	 TiXtol0bImMwkIReazkIjp2LKKFWPVssG+caVhcpP5V3ZVba/UK3e9lx3N681S99ct
	 WyIMCunGgs8qA==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87499a3cd37so13740766d6.3
        for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 23:14:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPJrBSbp4Ia895fCGnGEmbhjE4Xwa32ZuvchUI3ybxxE1x8eD8UZ1FyiPGwkkXU8EDybG16P5t@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6hS7pUSGjPk1ahtUz+kwY/FIMvmmGufUL0GNpGiFoN0tXM7I
	6Z68PJdkRGUfMf6p9kNN0WSTqwRMrUa+nvV15e1IfUFbgMGTJmXEHtm+H1iLoOx1TbbVSZqwSGA
	dSyhAjyUSGMe1YIuXzHPmRrkSsCakzcQ=
X-Google-Smtp-Source: AGHT+IERuBxgQd6R3EQpmFyFGBh/OYNUCmHcFdqHl5UpwHFlKQJ7KunNCXQLp2T8SUK1j4VkBMM2BQqqeY80Jp9bKs0=
X-Received: by 2002:a05:6214:2a8b:b0:87c:a721:42f3 with SMTP id
 6a1803df08f44-8802f450e57mr23817426d6.41.1761891276053; Thu, 30 Oct 2025
 23:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
 <877bwcus3h.fsf@linux.dev> <CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com>
 <87bjloht28.fsf@linux.dev>
In-Reply-To: <87bjloht28.fsf@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 30 Oct 2025 23:14:24 -0700
X-Gmail-Original-Message-ID: <CAHzjS_vRrxTLR0kFJvm4R3kO0s8hyN5Onsr6XfbA3Peyasz+Cg@mail.gmail.com>
X-Gm-Features: AWmQ_bndcOuOp7qdV3wXaWKIXpuAyFBwWSClkxOKSazNGGK9yzrR9MBHnc604rU
Message-ID: <CAHzjS_vRrxTLR0kFJvm4R3kO0s8hyN5Onsr6XfbA3Peyasz+Cg@mail.gmail.com>
Subject: Re: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial
 support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Song Liu <song@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Thu, Oct 30, 2025 at 12:06=E2=80=AFPM Roman Gushchin
> > <roman.gushchin@linux.dev> wrote:
> >>
> >> Ok, let me summarize the options we discussed here:
> >>
> >> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
> >> itself. The attachment is happening at the reg() time.
> >>
> >>   +: It's convenient for complex stateful struct ops'es, because a
> >>       single entity represents a combination of code and data.
> >>   -: No way to attach a single struct ops to multiple entities.
> >>
> >> This approach is used by Tejun for per-cgroup sched_ext prototype.
> >
> > It's wrong. It should adopt bpf_struct_ops_link_create() approach
> > and use attr->link_create.cgroup.relative_fd to attach.
>
> This is basically what I have in v2, but Andrii and Song suggested that
> I should use attr->link_create.target_fd instead.
>
> I have a slight preference towards attr->link_create.cgroup.relative_fd
> because it makes it clear that fd is a cgroup fd and potentially opens
> a possibility to e.g. attach struct_ops to individual tasks and
> cgroups, but I'm fine with both options.

relative_fd and relative_id have specific meaning. When multiple
programs are attached to the same object (cgroup, socket, etc.),
relative_fd and relative_id (together with BPF_F_BEFORE and
BPF_F_AFTER) are used to specify the order of execution.

>
> Also, as Song pointed out, fd=3D=3D0 is in theory a valid target, so inst=
ead of
> using the "if (fd) {...}" check we might need a new flag. Idk if it
> really makes sense to complicate the code for it.
>
> Can we, please, decide on what's best here?

How about we add a new attach_type BPF_STRUCT_OPS_CGROUP?

Thanks,
Song

