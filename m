Return-Path: <cgroups+bounces-11440-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45087C21DD0
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 20:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA66634FC87
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 19:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D906374AA6;
	Thu, 30 Oct 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D5LxtFEq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F83176E1
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851216; cv=none; b=KFIHIbqJmA/J4Dbi5HUu4NNBCRvZikutj1ZeMAhNr9IPn/+RLao4crSNrSRBBm30JSmZxwx3Na7raUvBkRpC8ozzKCxXPt9wEPBdmFBwUezpfZphV7Y7jEdj/TLZNJE7XgJ2r/+trwg4AKY19V93bQCw27NB6tE6R3HwgNMnY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851216; c=relaxed/simple;
	bh=gYHkvpfJ7NmC+pz9e7oilRRIc6gDbQrnkoKo55uq7x4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oxGyNRWPmoCAP0i/GcKpfMqw/3p68cW0CLaRqodi9RvYdBskr9m50QeO+3HyQNcdcWW4h5fsWtDn7iAGJkye5sTzTNJBSxL1yiKSN0Czm4l+vY7henYMyN8UFqKBs03FYl6So95kPoRx7WLy71BJ2hE/g2akWqWHvG1RvmE04l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D5LxtFEq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761851211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhWnjZelzOe9tyVT1vIXYOQef+bxuvWza/B/Vqmbb0E=;
	b=D5LxtFEqxG8uDpVpfZvPERxoVNSJiF5uGU4oYINjPif2JtMGmAip97OZ2emrzwdh9rmuPr
	zfbLXebyjkLvy30tZWWZvZRv53ViAXmBpNtraVpi+xfXfAFkgtbzag9VuBr6g2fsHssdFU
	gx6K61ctconfr5Y5vdelplfWzEfFt8U=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Amery Hung <ameryhung@gmail.com>
Cc: Song Liu <song@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
In-Reply-To: <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
	(Amery Hung's message of "Thu, 30 Oct 2025 11:19:52 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-3-roman.gushchin@linux.dev>
	<CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
	<87zf98xq20.fsf@linux.dev>
	<CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
	<CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
Date: Thu, 30 Oct 2025 12:06:42 -0700
Message-ID: <877bwcus3h.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Amery Hung <ameryhung@gmail.com> writes:

> On Thu, Oct 30, 2025 at 11:09=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>>
>> On Thu, Oct 30, 2025 at 10:22=E2=80=AFAM Roman Gushchin
>> <roman.gushchin@linux.dev> wrote:
>> >
>> > Song Liu <song@kernel.org> writes:
>> >
>> > > On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushch=
in@linux.dev> wrote:
>> > > [...]
>> > >>  struct bpf_struct_ops_value {
>> > >>         struct bpf_struct_ops_common_value common;
>> > >> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_att=
r *attr)
>> > >>         }
>> > >>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_s=
truct_ops_map_lops, NULL,
>> > >>                       attr->link_create.attach_type);
>> > >> +#ifdef CONFIG_CGROUPS
>> > >> +       if (attr->link_create.cgroup.relative_fd) {
>> > >> +               struct cgroup *cgrp;
>> > >> +
>> > >> +               cgrp =3D cgroup_get_from_fd(attr->link_create.cgrou=
p.relative_fd);
>> > >
>> > > We should use "target_fd" here, not relative_fd.
>> > >
>> > > Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach=
 to
>> > > global memcg.
>> >
>> > Yep, but then we need somehow signal there is a cgroup fd passed,
>> > so that struct ops'es which are not attached to cgroups keep working
>> > as previously. And we can't use link_create.attach_type.
>> >
>> > Should I use link_create.flags? E.g. something like add new flag
>> >
>> > @@ -1224,6 +1224,7 @@ enum bpf_perf_event_type {
>> >  #define BPF_F_AFTER            (1U << 4)
>> >  #define BPF_F_ID               (1U << 5)
>> >  #define BPF_F_PREORDER         (1U << 6)
>> > +#define BPF_F_CGROUP           (1U << 7)
>> >  #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>> >
>> >  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
>> >
>> > and then do something like this:
>> >
>> > int bpf_struct_ops_link_create(union bpf_attr *attr)
>> > {
>> >         <...>
>> >         if (attr->link_create.flags & BPF_F_CGROUP) {
>> >                 struct cgroup *cgrp;
>> >
>> >                 cgrp =3D cgroup_get_from_fd(attr->link_create.target_f=
d);
>> >                 if (IS_ERR(cgrp)) {
>> >                         err =3D PTR_ERR(cgrp);
>> >                         goto err_out;
>> >                 }
>> >
>> >                 link->cgroup_id =3D cgroup_id(cgrp);
>> >                 cgroup_put(cgrp);
>> >         }
>> >
>> > Does it sound right?
>>
>> I believe adding a flag (BPF_F_CGROUP or some other name), is the
>> right solution for this.
>>
>> OTOH, I am not sure whether we want to add cgroup fd/id to the
>> bpf link. I personally prefer the model used by TCP congestion
>> control: the link attaches the struct_ops to a global list, then each
>> user picks a struct_ops from the list. But I do agree this might be
>> an overkill for cgroup use cases.
>
> +1.
>
> In TCP congestion control and BPF qdisc's model:
>
> During link_create, both adds the struct_ops to a list, and the
> struct_ops can be indexed by name. The struct_ops are not "active" by
> this time.
> Then, each has their own interface to 'apply' the struct_ops to a
> socket or queue: setsockopt() or netlink.
>
> But maybe cgroup-related struct_ops are different.

Both tcp congestion and qdisk cases are somewhat different because
there already is a way to select between multiple implementations, bpf
just adds another one. In the oom case, it's not true. As of today,
there is only one (global) oom killer. Of course we can create
interfaces to allow a user make a choice. But the question is do we want
to create such interface for the oom case specifically (and later for
each new case separately), or there is a place for some generalization?


Ok, let me summarize the options we discussed here:

1) Make the attachment details (e.g. cgroup_id) the part of struct ops
itself. The attachment is happening at the reg() time.

  +: It's convenient for complex stateful struct ops'es, because a
      single entity represents a combination of code and data.
  -: No way to attach a single struct ops to multiple entities.

This approach is used by Tejun for per-cgroup sched_ext prototype.

2) Make the attachment details a part of bpf_link creation. The
attachment is still happening at the reg() time.

  +: A single struct ops can be attached to multiple entities.
  -: Implementing stateful struct ops'es is harder and requires passing
     an additional argument (some sort of "self") to all callbacks.

I'm using this approach in the bpf oom proposal.

3) Move the attachment out of .reg() scope entirely. reg() will register
the implementation system-wide and then some 3rd-party interface
(e.g. cgroupfs) should be used to select the implementation.

  +: ?
  -: New hard-coded interfaces might be required to enable bpf-driven
     kernel customization. The "attachment" code is not shared between
     various struct ops cases.
     Implementing stateful struct ops'es is harder and requires passing
     an additional argument (some sort of "self") to all callbacks.

This approach works well for cases when there is already a selection
of implementations (e.g. tcp congestion mechanisms), and bpf is adding
another one.

I personally lean towards 2), but I can easily implement bpf_oom with 1)
and most likely with 3) too, but it's a bit more complicated.

So I guess we all need to come to an agreement which way to go.

Thanks!

