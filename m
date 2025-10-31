Return-Path: <cgroups+bounces-11467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A24C266F8
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 957604F9684
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057E24886A;
	Fri, 31 Oct 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEjxjv9o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CF1F4617
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932255; cv=none; b=DCxhgGyOexPulPmtO35pn65XNUmNxNHIZXeweACF6AuND+tYEEbypJXR4PZpEv4iY5xX9c+OhPLmNfegfWglzGly8ryeL+Nms1Jo7tb7vl6oxP0hgrcXtgiS5Zu6CryT6PgfOWDx8Kj882K3BbC7PID29IJ57n8MpOjkkqxgB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932255; c=relaxed/simple;
	bh=zsbaoA/F5NOlNgn/Q7m0Emzmj/vRyRI3wur6J/zRy/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noLBqFhv651uAlXPBLsZeC6gprjjaMrvz8oyJHH9TCX46Z5ii6y2zv2BNFXepV/eaU3ho5mNa+WhcZmhExEdPJxOJTMXLfAjig/utsOOblXMgWnwYdWxUQC4zobotgeukkG6zWz2OOgI+uJFAcRRMpPEoBIpED4RDWQyXhyfs9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEjxjv9o; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47721743fd0so13891225e9.2
        for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932252; x=1762537052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5mV2w6my4c1PMfXawO9gB6t8vYeJrvxem9h0oKA3+w=;
        b=lEjxjv9oFZlzMn5hsNQUVb6a+oQWFxj/lq53sbuJRiKJxH4DJmrPjp8IF8nY/8qNI4
         F4hrk3oAy8n5a2lNRUGK0fGFkRuAnULtm7BRdt0FWrI80Rc/malY1dyQjq/6+/uT0dS3
         WXYfqx4yB3mO2nyqfV/oS/N3bh5c9KFnkEYOmsJ3mZGBDAh0uNo4lnJab4qJt6zSwgon
         jGZGigAGe7GwDnAo9T8FoItHodMdZ15RnUciHb9W8rIIOEZPEiamKbAbfrzdz7R6yeoU
         uM+A8IIJtQjlXnuqwoYPz3kHcLFx61mjD3idEGwdeXtdHdeAYtjGxL31i9YwXy0jcjPN
         Qg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932252; x=1762537052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5mV2w6my4c1PMfXawO9gB6t8vYeJrvxem9h0oKA3+w=;
        b=PGKER98iJ2KRT4pV/IgZPyCq+91JJWHWpMib6ZXwuvFKAf7vV1J2UNg8yzPDzoYjjJ
         t0yR4H0LfXMZCNZOmKYPXYH1ojV9h3kojMtYdbBt7L/7x4L9N0aaULFxKrYee+tENSXD
         cccAdIAyeJJ4HufmMQ9ix0eb6LpTf8qCXkQCsjdOhu2G+/QOVhYjjvvY1XEfouX4N/Vq
         CkK9nAlzqtoTrwRQiQ2dC6DySH5+631zwvysrnBRbddD7zE/BnwYi8vCS54cYYZ1WGA0
         HAuP3YatmgtyTfsHJYaKJJOnQz8K55GvoARtugpiTck8aIZKSeMFES2A3lnD9bOQJStq
         qKnA==
X-Forwarded-Encrypted: i=1; AJvYcCWIBHV2IT6xyMfY5YBri8Fwh54um40selImuWC9qwzts745uG7xrJgDhA2y/n6+501H0nzxTIVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeU4M0S5UDogg+fZsEz6N+aYo5DhA8e57lHGbClvhVCVcLtq2
	eHs9mgRpik0EdYjvpmHY4eA5MjLah5OPkm0nYz7/cGRa+iveTs1QZb9juXeufmtZrgxQJM3D4Ck
	+mhf4KeId/bojjHM0f8z/nRuQR+9uNmw=
X-Gm-Gg: ASbGnctIHYADaHhJvZbDKWlyb3T9kE4LNRHUYDPDq+DIfA9DCRzHdfuYKi0a2q0+n3X
	YbrGUnij5RNHhVss3lYWvI1u89uen60pMMu0Oa2m0WXQiLau4paoNBUp0mI88qAnkNE0N5fNevd
	i1bpaFVu2Teo9D4/K5RhU6e3RlbmG/FheL7+/SR6quEUkgzjxKSZgtRwYVNYIP6uk3b9b1RPymb
	0VrGqiWTLZ7ZTXjdKffLoc1suUmjpLG4hHaZp3z+Rtu66ZWULl0pr9lcKsrcpVhPUMcR3m/G6eg
	+2Y0OUJDYZvFQm0L8w==
X-Google-Smtp-Source: AGHT+IHPMUcDW3YwpEvtBrlqSkWgH3dOQo9Kw9291NP88P35J7TeeNcT/Tu9V9VlCr57x5pMjLGDLOmypXe3JvzCues=
X-Received: by 2002:a05:6000:2585:b0:428:3f7c:bcfe with SMTP id
 ffacd0b85a97d-429bd6c1ef3mr3470559f8f.57.1761932251229; Fri, 31 Oct 2025
 10:37:31 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 10:37:19 -0700
X-Gm-Features: AWmQ_bk3MBgTJKB4MZUJUE5RMJOP5ctpuIVST3txj8WpDOUYgUkSaXNEbEZ7Ahg
Message-ID: <CAADnVQLHT7DrqwNb_N_==vxCdtX3QvTyZKxZa4STw4cD-WKswQ@mail.gmail.com>
Subject: Re: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial
 support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
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

Yes. Of course.
link_create.cgroup.relative_fd actually points to a program.
We will need it if/when we add support for mprog style attach.

> I have a slight preference towards attr->link_create.cgroup.relative_fd
> because it makes it clear that fd is a cgroup fd and potentially opens
> a possibility to e.g. attach struct_ops to individual tasks and
> cgroups, but I'm fine with both options.

yeah. The name is confusing. It's not a cgroup fd.

> Also, as Song pointed out, fd=3D=3D0 is in theory a valid target, so inst=
ead of
> using the "if (fd) {...}" check we might need a new flag. Idk if it
> really makes sense to complicate the code for it.

One option is to cgroup_get_from_fd(attr->link_create.target_fd)
and if it's not a cgroup, just ignore it in bpf_struct_ops_link_create()
But a new flag like BPF_F_CGROUP_FD maybe cleaner ?
If we ever attach st_ops to tasks there will be another BPF_F_PID_FD flag ?
Or we may try different supported kinds like bpf_fd_probe_obj() does
and don't bother with flags.

New attach_type-s are not necessary. The type of st_ops itself
reflects the purpose and hook location.

