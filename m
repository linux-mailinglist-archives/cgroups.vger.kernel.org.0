Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CCB55275
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2019 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfFYOtJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jun 2019 10:49:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46408 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfFYOtJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jun 2019 10:49:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so18175853wrw.13;
        Tue, 25 Jun 2019 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jzJplX7Dwi+ZkfGmgePioN8ABN01AVCN3IQ/Lax0Uyc=;
        b=PEzzxsZwFiO4iQZm4auXmkqkc+EjdzC/b20ulKqVZF2TXPZYQKsSjIDWLzx/4dSQms
         rmhlv6ltlPwAT3By0xJWrwxbdVY6JKMt5l/8PJVRUnGXQ7L083gy/W9bIf2Mp2+/3+2H
         apEsf+kWn6smKa1PomQlq/+iIHR3Y5mLCVBGAe/KijzQlL+ZlK+IaU99yrsuNngWVxXK
         l4zGbtG7wQ+V/eUmTVk3Ij1QYE2wuqJU2B/XsbPbN3qdTf9SWJkQWEoMtIuCO4x7zJHM
         XR5peFI0iQyv+ZHoCcWiXGR5RtZop6n8XE2ZK/+eG0WwI+PePKjKpOSplMkmb9XGMjkH
         5q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jzJplX7Dwi+ZkfGmgePioN8ABN01AVCN3IQ/Lax0Uyc=;
        b=ekA7d4cPBzkX5kipIsgAWqfyvrbRNN6CVQtb9XLj9FSMKImAm0n9dIAUB3cPsbECXL
         Frtvz5YKQiRo9IPdmyGxqfnUVUoQW/aKBKzEi52We0kxPM+iMxjHeBs7L+ydF4RrUzIn
         dBaVAYGBxhnykDK0A58ATh4fXvjm5AziBDHEWjVcKtaS1Hv6jFQBfWtQQPOYRPm2ROH7
         6YQE30PGhs3SRVujxLUNzdGjNvC6H+AIEZxkqRU8ZTk+QknMaeV5a7/zIua/krAfJ5GM
         AwO3qHBA9Kygnt3RCmhJ0uyWE5WsgHfl2WEt1t9holx9jDEZTjfT6S1xt3s6WqkQqSJy
         jXdw==
X-Gm-Message-State: APjAAAWYJrJDUDL61On9+qKECCHhhne0z43zkltbL2DHFgsnVmbuz/NM
        rfJV9xM9t4M/JulRuS4gwTAfpJwkIsS3H+iRlOU=
X-Google-Smtp-Source: APXvYqwEhAfob2tq0T/JqOKDguzQ6tHbe3VinRkLT8FqixJMW0kUkRYlG3p6BUjaNXtA1+2evyNhxYNRyNLbSQoPjWs=
X-Received: by 2002:adf:ea45:: with SMTP id j5mr21982384wrn.281.1561474146563;
 Tue, 25 Jun 2019 07:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
 <20190624200445.GB6526@minwooim-desktop>
In-Reply-To: <20190624200445.GB6526@minwooim-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 25 Jun 2019 22:48:57 +0800
Message-ID: <CAA70yB5arvfaUsktN-cvd0yHpRi+FwFjL4r5_jTRWM8+rBVdnA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] nvme-pci: rename module parameter write_queues to read_queues
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, keith.busch@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Minwoo Im <minwoo.im.dev@gmail.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 19-06-24 22:29:19, Weiping Zhang wrote:
> > Now nvme support three type hardware queues, read, poll and default,
> > this patch rename write_queues to read_queues to set the number of
> > read queues more explicitly. This patch alos is prepared for nvme
> > support WRR(weighted round robin) that we can get the number of
> > each queue type easily.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
>
> Hello, Weiping.
>
> Thanks for making this patch as a separated one.  Actually I'd like to
> hear about if the origin purpose of this param can be changed or not.
>
> I can see a log from Jens when it gets added her:
>   Commit 3b6592f70ad7("nvme: utilize two queue maps, one for reads and
>                        one for writes")
>   It says:
>   """
>   NVMe does round-robin between queues by default, which means that
>   sharing a queue map for both reads and writes can be problematic
>   in terms of read servicing. It's much easier to flood the queue
>   with writes and reduce the read servicing.
>   """
>
> So, I'd like to hear what other people think about this patch :)
>

This patch does not change its original behavior, if we set read_queue
greater than 0, the read and write request will use different tagset map,
so they will use different hardware queue.

> Thanks,
>
> > ---
> >  drivers/nvme/host/pci.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 5d84241f0214..a3c9bb72d90e 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -68,10 +68,10 @@ static int io_queue_depth =3D 1024;
> >  module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, =
0644);
> >  MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >=3D 2");
> >
> > -static int write_queues;
> > -module_param(write_queues, int, 0644);
> > -MODULE_PARM_DESC(write_queues,
> > -     "Number of queues to use for writes. If not set, reads and writes=
 "
> > +static int read_queues;
> > +module_param(read_queues, int, 0644);
> > +MODULE_PARM_DESC(read_queues,
> > +     "Number of queues to use for reads. If not set, reads and writes =
"
> >       "will share a queue set.");
> >
> >  static int poll_queues;
> > @@ -211,7 +211,7 @@ struct nvme_iod {
> >
> >  static unsigned int max_io_queues(void)
> >  {
> > -     return num_possible_cpus() + write_queues + poll_queues;
> > +     return num_possible_cpus() + read_queues + poll_queues;
> >  }
> >
> >  static unsigned int max_queue_count(void)
> > @@ -2021,18 +2021,16 @@ static void nvme_calc_irq_sets(struct irq_affin=
ity *affd, unsigned int nrirqs)
> >        * If only one interrupt is available or 'write_queue' =3D=3D 0, =
combine
> >        * write and read queues.
> >        *
> > -      * If 'write_queues' > 0, ensure it leaves room for at least one =
read
> > +      * If 'read_queues' > 0, ensure it leaves room for at least one w=
rite
> >        * queue.
> >        */
> > -     if (!nrirqs) {
> > +     if (!nrirqs || nrirqs =3D=3D 1) {
> >               nrirqs =3D 1;
> >               nr_read_queues =3D 0;
> > -     } else if (nrirqs =3D=3D 1 || !write_queues) {
> > -             nr_read_queues =3D 0;
> > -     } else if (write_queues >=3D nrirqs) {
> > -             nr_read_queues =3D 1;
> > +     } else if (read_queues >=3D nrirqs) {
> > +             nr_read_queues =3D nrirqs - 1;
> >       } else {
> > -             nr_read_queues =3D nrirqs - write_queues;
> > +             nr_read_queues =3D read_queues;
> >       }
> >
> >       dev->io_queues[HCTX_TYPE_DEFAULT] =3D nrirqs - nr_read_queues;
> > --
> > 2.14.1
> >
