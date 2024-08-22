Return-Path: <cgroups+bounces-4412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093795BDB0
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2319C285D91
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137B1CF283;
	Thu, 22 Aug 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHUaQn2O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495B1CC8A7
	for <cgroups@vger.kernel.org>; Thu, 22 Aug 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348867; cv=none; b=ARHp5bNcsMldZ+RCvHoodSY+csSUC7Kn5TY9+BTl1JdGgZeuyVPuyRkDHSBLaov/6MoaJppf0Rr3zPrC76MqHzq8bl9j+KIMZpk09/tT2NedvL4AaIt63YOVBJC4fBO91ojk/eC3OdWKF9tfl2YbXpNOLCuukGOdz0so6zboA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348867; c=relaxed/simple;
	bh=q6Acx4w/gpPfq64/oulJYn/HYe7pYYoDgXScvJE6EYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrXon1CCNktvMzGjdHZZ58mbCc4I5f4nzqL+1ULXk+rnL2aKA/WVV2wAMIkUdbF1Qx81tpO6/1Azxqa1HGpH1g3AlyuzWvDdXf2aS32ssizXo7NHrWIjQvHLikYmQrkobCsQk9qO2J1dZPwzHl9fmcQz4Ich8YViYDFLlpJcp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHUaQn2O; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a843bef98so129548266b.2
        for <cgroups@vger.kernel.org>; Thu, 22 Aug 2024 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724348864; x=1724953664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d+/3JN2j+IR6X0GnobgQBaQc+2mwLkx4YG52rHVeyw=;
        b=UHUaQn2OiZcFMYqxYSMjSs0W0DAvkitoOOxF3eDluxLbmWJEysZwui5IRxE2W1JARh
         T2fKRdP8THj4vE4qYOHRre7c/EcW2kdZ9RxjgN+l5FCts8OdH8cxyA+pQwDmr5wgKRZ3
         G7D3jyKZTsk92EYMxz+MIh8BPpkxu3JaRawmlG9y/O5DA02NtlAVLPDq9waKbcZ/Lln8
         sHMuIprTAjl+Bp7cdhGxeoJLdHbtfndbfFVQbFpnVGE5APO7Uxnt3KqOnaY+HapR3W0T
         lDvwtLEMWc8LYhxiaK66wR6bzda2zaTPbixXY0i/6Ju5rbKqvqB9rvY6e8tiTQmWQsNL
         R3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348864; x=1724953664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d+/3JN2j+IR6X0GnobgQBaQc+2mwLkx4YG52rHVeyw=;
        b=acHnnWOSt0545ZfwMS0BFU5E4aMLzTAuFDlRsugcbFqivt0LHwhZ4OkG474+sK+1XX
         Lkc7MBLLOhLGuDsVdX/qHZ07sUcFpoZnd4F7n+IXSefYdejQf07F3IuqZTutnkZKJNk9
         lbUrz5PO1PUrUckilUqG8YaMg9rEYOpA0PL8AhRhOCoagI64zjovW795InrWaRu1NKVX
         uV9UXBgEoObQpbHUyjCWLSM8UdEgzKkSoYWjmfIzkoL/EJTcy17xv/QuC9B2WVJGoa1E
         IOq4+l0Y/PAhXq6L9eFaF4YHhmnqqZuAnbx0Ld4DeJwSWyfm4MAtnAIhloAnlVNW4iMx
         tKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUclI1vMs3BJuP39SXFRTWwEzNYzQEYoqPjV65lLO6hZ7VgQAxmrgraM/1KDBD9BGF+CfsE/s3C@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TSHFZuXu6Q/NIZs2mrhKtHPHIMRmuzakLgwv103TK5NJZDwB
	JJ8dedHwtlU+tmVhbOrYApkrKFEWWZrUNjngwqPQ6DwE0FuqumtcWSrGkJZOKJ3PHmDqArlqwyT
	F939RlexSg/eDSkeu3p+l8PMR1oSpEexRLDw/
X-Google-Smtp-Source: AGHT+IEIB/sAcCVMEpN3z08j+zbYb8nUxKknSRWyl3cnas6NGtB+MeRmDWhfLCACOfDLHCFajCUgiqMgcKAl/lGIRG8=
X-Received: by 2002:a17:907:5cb:b0:a86:700f:93c0 with SMTP id
 a640c23a62f3a-a8691b64e4emr280264866b.35.1724348863010; Thu, 22 Aug 2024
 10:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816144344.18135-1-me@yhndnzj.com> <20240816144344.18135-2-me@yhndnzj.com>
 <CAJD7tkYRiA7113ehpXoiafJtk8Z+j6nV_bQWK0xoX3KaK6=wcQ@mail.gmail.com> <9e39ed273b5e25e3d2f33c5a2b8e3131efbfcedc.camel@yhndnzj.com>
In-Reply-To: <9e39ed273b5e25e3d2f33c5a2b8e3131efbfcedc.camel@yhndnzj.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 22 Aug 2024 10:47:05 -0700
Message-ID: <CAJD7tkYpKA+iGFsan6B0GWT6_bOPX+83hjMQnmR11F6WX1vhiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests: test_zswap: add test for hierarchical zswap.writeback
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:44=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
>
> On 2024-08-19 at 12:19 -0700, Yosry Ahmed wrote:
> > On Fri, Aug 16, 2024 at 7:44=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrot=
e:
> > >
> > > Ensure that zswap.writeback check goes up the cgroup tree.
> >
> > Too concise :) Perhaps a little bit of description of what you are
> > doing would be helpful.
>
> The patch has been merged into mm-unstable tree. Do I need to
> send a v3 to resolve the comments?

You can send a new version and Andrew usually replaces them. If the
changes are too trivial sometimes Andrew is nice enough to make
amendments directly :)

>
> > >
> > > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > > ---
> > >  tools/testing/selftests/cgroup/test_zswap.c | 69 ++++++++++++++---
> > > ----
> > >  1 file changed, 48 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/cgroup/test_zswap.c
> > > b/tools/testing/selftests/cgroup/test_zswap.c
> > > index 190096017f80..7da6f9dc1066 100644
> > > --- a/tools/testing/selftests/cgroup/test_zswap.c
> > > +++ b/tools/testing/selftests/cgroup/test_zswap.c
> > > @@ -263,15 +263,13 @@ static int test_zswapin(const char *root)
> > >  static int attempt_writeback(const char *cgroup, void *arg)
> > >  {
> > >         long pagesize =3D sysconf(_SC_PAGESIZE);
> > > -       char *test_group =3D arg;
> > >         size_t memsize =3D MB(4);
> > >         char buf[pagesize];
> > >         long zswap_usage;
> > > -       bool wb_enabled;
> > > +       bool wb_enabled =3D *(bool *) arg;
> > >         int ret =3D -1;
> > >         char *mem;
> > >
> > > -       wb_enabled =3D cg_read_long(test_group,
> > > "memory.zswap.writeback");
> > >         mem =3D (char *)malloc(memsize);
> > >         if (!mem)
> > >                 return ret;
> > > @@ -288,12 +286,12 @@ static int attempt_writeback(const char
> > > *cgroup, void *arg)
> > >                 memcpy(&mem[i], buf, pagesize);
> > >
> > >         /* Try and reclaim allocated memory */
> > > -       if (cg_write_numeric(test_group, "memory.reclaim",
> > > memsize)) {
> > > +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
> > >                 ksft_print_msg("Failed to reclaim all of the
> > > requested memory\n");
> > >                 goto out;
> > >         }
> > >
> > > -       zswap_usage =3D cg_read_long(test_group,
> > > "memory.zswap.current");
> > > +       zswap_usage =3D cg_read_long(cgroup, "memory.zswap.current");
> > >
> > >         /* zswpin */
> > >         for (int i =3D 0; i < memsize; i +=3D pagesize) {
> > > @@ -303,7 +301,7 @@ static int attempt_writeback(const char
> > > *cgroup, void *arg)
> > >                 }
> > >         }
> > >
> > > -       if (cg_write_numeric(test_group, "memory.zswap.max",
> > > zswap_usage/2))
> > > +       if (cg_write_numeric(cgroup, "memory.zswap.max",
> > > zswap_usage/2))
> > >                 goto out;
> > >
> > >         /*
> > > @@ -312,7 +310,7 @@ static int attempt_writeback(const char
> > > *cgroup, void *arg)
> > >          * If writeback is disabled, memory reclaim will fail as
> > > zswap is limited and
> > >          * it can't writeback to swap.
> > >          */
> > > -       ret =3D cg_write_numeric(test_group, "memory.reclaim",
> > > memsize);
> > > +       ret =3D cg_write_numeric(cgroup, "memory.reclaim", memsize);
> > >         if (!wb_enabled)
> > >                 ret =3D (ret =3D=3D -EAGAIN) ? 0 : -1;
> > >
> > > @@ -321,12 +319,38 @@ static int attempt_writeback(const char
> > > *cgroup, void *arg)
> > >         return ret;
> > >  }
> > >
> > > +static int test_zswap_writeback_one(const char *cgroup, bool wb)
> > > +{
> > > +       long zswpwb_before, zswpwb_after;
> > > +
> > > +       zswpwb_before =3D get_cg_wb_count(cgroup);
> > > +       if (zswpwb_before !=3D 0) {
> > > +               ksft_print_msg("zswpwb_before =3D %ld instead of
> > > 0\n", zswpwb_before);
> > > +               return -1;
> > > +       }
> > > +
> > > +       if (cg_run(cgroup, attempt_writeback, (void *) &wb))
> > > +               return -1;
> > > +
> > > +       /* Verify that zswap writeback occurred only if writeback
> > > was enabled */
> > > +       zswpwb_after =3D get_cg_wb_count(cgroup);
> > > +       if (zswpwb_after < 0)
> > > +               return -1;
> > > +
> > > +       if (wb !=3D !!zswpwb_after) {
> > > +               ksft_print_msg("zswpwb_after is %ld while wb is
> > > %s",
> > > +                               zswpwb_after, wb ? "enabled" :
> > > "disabled");
> > > +               return -1;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  /* Test to verify the zswap writeback path */
> > >  static int test_zswap_writeback(const char *root, bool wb)
> > >  {
> > > -       long zswpwb_before, zswpwb_after;
> > >         int ret =3D KSFT_FAIL;
> > > -       char *test_group;
> > > +       char *test_group, *test_group_child =3D NULL;
> > >
> > >         test_group =3D cg_name(root, "zswap_writeback_test");
> > >         if (!test_group)
> > > @@ -336,29 +360,32 @@ static int test_zswap_writeback(const char
> > > *root, bool wb)
> > >         if (cg_write(test_group, "memory.zswap.writeback", wb ? "1"
> > > : "0"))
> > >                 goto out;
> > >
> > > -       zswpwb_before =3D get_cg_wb_count(test_group);
> > > -       if (zswpwb_before !=3D 0) {
> > > -               ksft_print_msg("zswpwb_before =3D %ld instead of
> > > 0\n", zswpwb_before);
> > > +       if (test_zswap_writeback_one(test_group, wb))
> > >                 goto out;
> > > -       }
> > >
> > > -       if (cg_run(test_group, attempt_writeback, (void *)
> > > test_group))
> > > +       if (cg_write(test_group, "memory.zswap.max", "max"))
> > > +               goto out;
> >
> > Why is this needed? Isn't this the default value?
>
> attempt_writeback() would modify it.

Oh yes, missed that.

>
> > > +       if (cg_write(test_group, "cgroup.subtree_control",
> > > "+memory"))
> > >                 goto out;
> > >
> > > -       /* Verify that zswap writeback occurred only if writeback
> > > was enabled */
> > > -       zswpwb_after =3D get_cg_wb_count(test_group);
> > > -       if (zswpwb_after < 0)
> > > +       test_group_child =3D cg_name(test_group,
> > > "zswap_writeback_test_child");
> > > +       if (!test_group_child)
> > > +               goto out;
> > > +       if (cg_create(test_group_child))
> > > +               goto out;
> >
> > I'd rather have all the hierarchy setup at the beginning of the test,
> > before the actual test logic. I don't feel strongly about it though.
> >
> > > +       if (cg_write(test_group_child, "memory.zswap.writeback",
> > > "1"))
> > >                 goto out;
> >
> > Is the idea here that we always hardcode the child's zswap.writeback
> > to 1, and the parent's zswap.writeback changes from 0 to 1, and we
> > check that the parent's value is what matters?
> > I think we need a comment here.
>
> Yes, indeed.
>
> > TBH, I expected a separate test that checks different combinations of
> > parent and child values (e.g. also verifies that if the parent is
> > enabled but child is disabled, writeback is disabled).
>
> That's (implicitly) covered by the test itself IIUC? The parent cgroup
> here is in turn the child of root cgroup.

This assumes that the root has zswap writeback enabled, but that's a
fair assumption as otherwise all the writeback tests will fail.

TBH I'd prefer a standalone test rather than these implicitly tested scenar=
ios.

