Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8D7A15E
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2019 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfG3Gjv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Jul 2019 02:39:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46680 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfG3Gjv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Jul 2019 02:39:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so61561943edr.13;
        Mon, 29 Jul 2019 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zYQAxBettPtStNQE5fAZLmFzaIswYZZXO3tKKpC/bAE=;
        b=DLeEOGpACpUsFdAW/vzvp2L2aQp+qrinDlxmAofpfkU5tgpTo1pxzGEOqdic1Ogy9y
         HJa+m1QQSStZdiTADDGujXWZly+2rfiWr1+u2Y3wiRXy0NoTU/eXNGRCinjnsXVTjq8T
         wDwYVH0kOoh3H+zq39G9QKdd8daFvxZGZsjOBuhSGgLelvedqxGK3SSJGLN6ibCGa0C6
         jYRyaswMM6njWmGNHBVt+LOu/NrkIHtmmFfGU8E/aYcKHmd4Y9+H7/GxAkN73qu3mQvm
         nEHzkCScnQyPqnI44Wnq2Pmo52SBt6UQ8RGZRKwHVuNj+irI/yjDgSBUJjal8th6egaO
         3J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYQAxBettPtStNQE5fAZLmFzaIswYZZXO3tKKpC/bAE=;
        b=qy2AlreTJ4zFvYk8GdZR8SburI6W/ctgc3+O6Fj0DsSnesPg3wIvppS82xLlxwrK04
         mD2gHITgodbTDWfkPkksWipUakg43aUvomkLHD4wS61Knd3MbxgdFJKAUofzOKayHfov
         jzvqmhM2+as2/ZbBPUe9LhVmfowGmVwsE/JUcncz5vu94nH2D8nwmWxUW+i2sOLjT0d4
         MZdYSxSHbwLJ3tL3Ck8TLJ5wCpWrQZ5A+pypajeg3F2M8cr8UFScOj/JielMSojVnx8i
         7cp+765aWCYsDcyi/3F8kYT4lIgZNP46dZucocVefCyEsF4NotcRLb0NqPmNx0nQJPMT
         hUhA==
X-Gm-Message-State: APjAAAUhmy6zX4d18PGzvaWmxd2M+O0hJoa6cHedBf9gvFiWYfvqJr39
        gT8oPWxfTAbHp5eDMdpjUtSzLTu1SxS8s51RlOo=
X-Google-Smtp-Source: APXvYqzN8HSv4Bw31YfSX79NTRpbLwIs8OmAB2/jiSv95TgGf7K6FCqBBWGOUel991k3BeSd6sDUm6jRorzfE6fc1KU=
X-Received: by 2002:aa7:ca41:: with SMTP id j1mr101952769edt.149.1564468789374;
 Mon, 29 Jul 2019 23:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190729151346.9280-1-hslester96@gmail.com> <201907292117.DA40CA7D@keescook>
In-Reply-To: <201907292117.DA40CA7D@keescook>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 30 Jul 2019 14:39:40 +0800
Message-ID: <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
To:     Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Kees Cook <keescook@chromium.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 29, 2019 at 11:13:46PM +0800, Chuhong Yuan wrote:
> > strncmp(str, const, len) is error-prone.
> > We had better use newly introduced
> > str_has_prefix() instead of it.
>
> Wait, stop. :) After Laura called my attention to your conversion series,
> mpe pointed out that str_has_prefix() is almost redundant to strstarts()
> (from 2009), and the latter has many more users. Let's fix strstarts()
> match str_has_prefix()'s return behavior (all the existing callers are
> doing boolean tests, so the change in return value won't matter), and
> then we can continue with this replacement. (And add some documentation
> to Documenation/process/deprecated.rst along with a checkpatch.pl test
> maybe too?)
>

Thanks for your advice!
Does that mean replacing strstarts()'s implementation with
str_has_prefix()'s and then use strstarts() to substitute
strncmp?

I am not very clear about how to add the test into checkpatch.pl.
Should I write a check for this pattern or directly add strncmp into
deprecated_apis?

> Actually I'd focus first on the actually broken cases first (sizeof()
> without the "-1", etc):
>
> $ git grep strncmp.*sizeof | grep -v -- '-' | wc -l
> 17
>
> I expect the "copy/paste" changes could just be a Coccinelle script that
> Linus could run to fix all the cases (and should be added to the kernel
> source's list of Coccinelle scripts). Especially since the bulk of the
> usage pattern are doing literals like this:
>

Actually I am using a Coccinelle script to detect the cases and
have found 800+ places of strncmp(str, const, len).
But the script still needs some improvement since it has false
negatives and only focuses on detecting, not replacement.
I can upload it after improvement.
In which form should I upload it? In a patch's description or put it
in coccinelle scripts?

> arch/alpha/kernel/setup.c:   if (strncmp(p, "mem=3D", 4) =3D=3D 0) {
>
> $ git grep -E 'strncmp.*(sizeof|, *[0-9]*)' | wc -l
> 2565
>
> And some cases are weirdly backwards:
>
> tools/perf/util/callchain.c:  if (!strncmp(tok, "none", strlen(tok))) {
>
> -Kees
>

I think with the help of Coccinelle script, all strncmp(str, const, len)
can be replaced and these problems will be eliminated. :)

Regards,
Chuhong

> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  kernel/cgroup/rdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
> > index ae042c347c64..fd12a227f8e4 100644
> > --- a/kernel/cgroup/rdma.c
> > +++ b/kernel/cgroup/rdma.c
> > @@ -379,7 +379,7 @@ static int parse_resource(char *c, int *intval)
> >                       return -EINVAL;
> >               return i;
> >       }
> > -     if (strncmp(value, RDMACG_MAX_STR, len) =3D=3D 0) {
> > +     if (str_has_prefix(value, RDMACG_MAX_STR)) {
> >               *intval =3D S32_MAX;
> >               return i;
> >       }
> > --
> > 2.20.1
> >
>
> --
> Kees Cook
