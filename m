Return-Path: <cgroups+bounces-11450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69CC231DE
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 04:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263EF1A20967
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 03:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD5255248;
	Fri, 31 Oct 2025 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLzBiQf0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C821DB15F
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879850; cv=none; b=YRzqvzUPAq8YQQbHLkQ11B1fNuxDNmRv1pyJHOaJulO9DMbRGblY36zIf7U3/0cPVRsw/BAaMEo1C2jhhRuqZkvFTafkeRZgM2+ZZq81MD6LtwmUCEumcALXPjEtJ67Zoi0ugPNP0l55xnn5hoyjOartumc3Gb0KrrfvPlkF1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879850; c=relaxed/simple;
	bh=k4vEw8EY43K8XMI5/V9THCw3n8L7r2pGWAp1vr5FCMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fefmCw0oHne0IVr5NMKLWRqVExd4kQ8JLiCMWyS05tQZwNdvXfG5M1Q5djgAj57UVIM99aqFPRJL/eO6Q1aWyJ7dhgxbQo1hi081JvovG+6EoYEu7TuZb4Ztiynapb+oRoWU0L6W4qx8BPttit5sM8an1MMoJryamoIpMVGsW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLzBiQf0; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e1e1bf882so1805419d50.1
        for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 20:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761879848; x=1762484648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB1+LZPkwFY008oY4N4SwT8A6lc9mI9L3ZvDOPN4piw=;
        b=DLzBiQf0msab7dX9UbQrn/hGecPBWjrruen3bRaE78U8k/5MelnLUrsZMPc9DayuHD
         EChe1xZB/ZFEL7ypBuM8Z8+r2NivHg8Drxu/HkFWDy19HOlMLuNBThDcH7Fna8B4p4Z7
         1ny0FTUEfgtU9FJ8SiUUwAnAANcA38L8vOo9pjUoF1mZiRXyWjPtnFIpta2LJPr+mW+i
         B3RXeOJrDwONcTWCN0aNeFOpyTUG10o1Uc0QMESVwbfcELxQ2byWEgAqsBnMtCOI9TkC
         j/MorT05+gI6N2phFgMqWTjEhqDSE5+0WcWrpSj7QYVRNbPl/6ywRz9rxsqlIlUvRavY
         pceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879848; x=1762484648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB1+LZPkwFY008oY4N4SwT8A6lc9mI9L3ZvDOPN4piw=;
        b=miFLW7Pm0HIs1c4exUbsm+STmQHFl1iqpTLYHroLXTD61KuVfgjmvndBGWVC5KKbt1
         Q0mevg2cHrgATFvifPYnch2QgHZ2z/Ct/otejbLmJPDOPSYpL/1gAr06eClIed+J+2s0
         AmaIeK8CDt9hKbp29Ibz03MX6ni291N7g+uqZQ3yUaUAiW0vfZvbpH+pmuz2rHoP/3q6
         35QJMvgNANhTdN3BDWUZvAxZhEZjM9bHFQST48jknBD+h0DgxavsAUU36qvoCI913Tz6
         Td/GnSOVTOg8yIClT+6Md+AB7QS0K+hMqlopDp2IETacrakLcU4tiPOfCZycIo4NrXih
         fp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMsDi2ZTJC7O7H9npspiLQEh1IgIYW3b5niG8mAHO9EKcAvki6uGzlNUy1iTFr8jXfXobh7nSR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywed8R8tpnoH+JvInxMpzALzqMIaV1MivsI5eep5zRjofZfijZD
	4DewGhwCpjGEeAxDTa8DHUk/8XIB8pnurHX+f5T+ArcRs/nudBLzp1+b5C8Ow9fGAysvWwJSkHm
	gjpQKFbyOO4LXtUIZpd33yXehA4nkqI0=
X-Gm-Gg: ASbGnctDPUF/W1eB2lcIfD4ruYOJfMmCnzs41ELYizuWkRldhhKn5QUBPgyrSfgGVtZ
	u6UHrqm7ejkw+elkvUpTxswbwP7sdjh6MfwycJOkhvBxefol0SqvtT1cKPrulQbE9RupcGS8r4v
	fZH3Yumv6eAkV/0x8pe33K7u/8oZy9gH2VSm+uJ+DnS+cbWpAEmW42ypEIQsPehb220/dr/pLbZ
	R65+ndGECXfJ2nuf4ldQY7mHhgDu4q1W0e4uhydI5x/foob73rtkjjkxe5StAs/mbrOZ15H
X-Google-Smtp-Source: AGHT+IEsp6bhgRsy8ZEn85Qr6vOIkt2gdB3bVnGU3Gq1UCl2kGI49jRJiPmXq7RgqzS4b09IRWebGz2bLvXPLAd+uuk=
X-Received: by 2002:a05:690c:45c4:b0:717:ca51:d781 with SMTP id
 00721157ae682-7864841b780mr30065937b3.17.1761879847982; Thu, 30 Oct 2025
 20:04:07 -0700 (PDT)
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
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 31 Oct 2025 11:03:30 +0800
X-Gm-Features: AWmQ_bmM-gv798v1iqUntXkV_a5zia70abL0uoWQ696LNsBFCfXEwG0AGFz5jnE
Message-ID: <CALOAHbAnH=mRmWUX8v_8GcnvEYTN6cDR+w9AM1p+nYezA+LD4g@mail.gmail.com>
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

On Fri, Oct 31, 2025 at 7:30=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
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
>
> Also, as Song pointed out, fd=3D=3D0 is in theory a valid target, so inst=
ead of
> using the "if (fd) {...}" check we might need a new flag.

I recall that Linus has reminded the BPF subsystem not to use `if
(fd)` to check for a valid fd. We should avoid repeating this mistake.
The proper solution is to add a new flag to indicate whether a fd is
valid.

> Idk if it
> really makes sense to complicate the code for it.
>
> Can we, please, decide on what's best here?
>

It seems the only way for us to learn is through practice=E2=80=94even if t=
hat
means making mistakes first ;-)

I can imagine a key benefit of a single struct-ops-to-multiple-cgroups
model is the ability to pre-load all required policies. This allows
users the flexibility to attach them on demand, while completely
avoiding the complex lifecycle management of individual links=E2=80=94a maj=
or
practical pain point.

--=20
Regards
Yafang

