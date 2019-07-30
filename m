Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71E7AA0C
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2019 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfG3Nr6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Jul 2019 09:47:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37058 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfG3Nr5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Jul 2019 09:47:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so62668273eds.4;
        Tue, 30 Jul 2019 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3fepK0Jwe5W6w8k8YhbMt3CwG0aFRSUfnwoWIEoMNS4=;
        b=uOYi27sPVshsO12cRu1wgKTuW3aD1eYQnWnJ2Am1fF90xmwdBZJOFVJTT8BrZgmEwo
         ZnvRXMpvklk4YTSBvnvrEuqvIRBfxTWWk3hKpkNdCDHIjKcyePB6RlSuHLJINi71cbig
         UDS8L5FB1nzxRAGHZufvSU8oEaFBam8Yp8a1Prm3ti5hdJZDerZAju8AS4ViZS3gsZh9
         PYBqRMQleYpz887iXlk+SP1rIyyB2D/YqW85mmSu4BRWBno5a+WyzzjE3VPw2c/pao3H
         X9LP10UTo5/zQAPAzpMcph3soTiTW0oDStxuomLhYVyeQow+bpVeR63QBE9Jm62xV3i6
         2qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3fepK0Jwe5W6w8k8YhbMt3CwG0aFRSUfnwoWIEoMNS4=;
        b=HhhJkShQ5dRKzeFjbAGC618F18cWkVX4ZdtminHXEuSxTQi3oBf4HyZPKBupqYb95e
         6qMi7ogc/M5XK0XHHnNCxv4AluYLE1ISZ4N+sUTE7VSZxytaz908XXNrSN/0MQ7ptsZP
         BedBQBSEjkaGVXfiE0KHY1Z31sMPdzQE21LYOrj+vNsjqR/XNAOGQufKoF2qz4dorZ+f
         gBkrpdG2aiUpvNjcyvuBb/Z0TuZr37Pm4TIn14E2xVka/lR/fjD69zPrz+s/DxvvrQr0
         HM8bjUfN8wB9l/xgxzf/eO7Y8dLC2Xp5HgsdKv+1IbZvfiDg6/0JpIxvPLbOcwBrJWoY
         W6jQ==
X-Gm-Message-State: APjAAAWQupYX4gtkEoQGFO1zgdYHCWBhCHbOywWq8uM3FjYBFzlvdCl7
        3cIVYwTxSrg0mAACvKsuwfiD0MOjJIGz5XwluyU=
X-Google-Smtp-Source: APXvYqw0Lss1BrfXSJ8BL7bsixwvMwj0uTRxnSUvSMt/BOqrwM0Jqj7X+7JK7PBUHyqM6cDax7UE8TnfnJ8/Xc+V/d4=
X-Received: by 2002:a17:906:a350:: with SMTP id bz16mr91682077ejb.296.1564494475561;
 Tue, 30 Jul 2019 06:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190729151346.9280-1-hslester96@gmail.com> <201907292117.DA40CA7D@keescook>
 <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
In-Reply-To: <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 30 Jul 2019 21:47:46 +0800
Message-ID: <CANhBUQ3pYGwKng-wxsGn3tBj3z_kN-CZQL__5YTwwJuco=fH0w@mail.gmail.com>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
To:     Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chuhong Yuan <hslester96@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Kees Cook <keescook@chromium.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:26=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Jul 29, 2019 at 11:13:46PM +0800, Chuhong Yuan wrote:
> > > strncmp(str, const, len) is error-prone.
> > > We had better use newly introduced
> > > str_has_prefix() instead of it.
> >
> > Wait, stop. :) After Laura called my attention to your conversion serie=
s,
> > mpe pointed out that str_has_prefix() is almost redundant to strstarts(=
)
> > (from 2009), and the latter has many more users. Let's fix strstarts()
> > match str_has_prefix()'s return behavior (all the existing callers are
> > doing boolean tests, so the change in return value won't matter), and
> > then we can continue with this replacement. (And add some documentation
> > to Documenation/process/deprecated.rst along with a checkpatch.pl test
> > maybe too?)
> >
>
> Thanks for your advice!
> Does that mean replacing strstarts()'s implementation with
> str_has_prefix()'s and then use strstarts() to substitute
> strncmp?
>
> I am not very clear about how to add the test into checkpatch.pl.
> Should I write a check for this pattern or directly add strncmp into
> deprecated_apis?
>
> > Actually I'd focus first on the actually broken cases first (sizeof()
> > without the "-1", etc):
> >
> > $ git grep strncmp.*sizeof | grep -v -- '-' | wc -l
> > 17
> >
> > I expect the "copy/paste" changes could just be a Coccinelle script tha=
t
> > Linus could run to fix all the cases (and should be added to the kernel
> > source's list of Coccinelle scripts). Especially since the bulk of the
> > usage pattern are doing literals like this:
> >
>
> Actually I am using a Coccinelle script to detect the cases and
> have found 800+ places of strncmp(str, const, len).
> But the script still needs some improvement since it has false
> negatives and only focuses on detecting, not replacement.
> I can upload it after improvement.
> In which form should I upload it? In a patch's description or put it
> in coccinelle scripts?
>
> > arch/alpha/kernel/setup.c:   if (strncmp(p, "mem=3D", 4) =3D=3D 0) {
> >
> > $ git grep -E 'strncmp.*(sizeof|, *[0-9]*)' | wc -l
> > 2565
> >
> > And some cases are weirdly backwards:
> >
> > tools/perf/util/callchain.c:  if (!strncmp(tok, "none", strlen(tok))) {
> >

I find there are cases of this pattern are not wrong.
One example is kernel/irq/debugfs.c: if (!strncmp(buf, "trigger", size)) {

Thus I do not know whether I should include these cases in my script.

> > -Kees
> >
>
> I think with the help of Coccinelle script, all strncmp(str, const, len)
> can be replaced and these problems will be eliminated. :)
>
> Regards,
> Chuhong
>
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  kernel/cgroup/rdma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
> > > index ae042c347c64..fd12a227f8e4 100644
> > > --- a/kernel/cgroup/rdma.c
> > > +++ b/kernel/cgroup/rdma.c
> > > @@ -379,7 +379,7 @@ static int parse_resource(char *c, int *intval)
> > >                       return -EINVAL;
> > >               return i;
> > >       }
> > > -     if (strncmp(value, RDMACG_MAX_STR, len) =3D=3D 0) {
> > > +     if (str_has_prefix(value, RDMACG_MAX_STR)) {
> > >               *intval =3D S32_MAX;
> > >               return i;
> > >       }
> > > --
> > > 2.20.1
> > >
> >
> > --
> > Kees Cook
