Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897BB151478
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2020 04:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBDDLh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Feb 2020 22:11:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35480 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgBDDLh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Feb 2020 22:11:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so16591962qki.2;
        Mon, 03 Feb 2020 19:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AQPvBn3+mpVQXLNFO7ln9Q3PQvFlywhORrkpfNdpRp4=;
        b=lx/YInbrNokwp5yZHxjAiGDoPWM9E2DKV37xld9nufJgcj4+Tu1yfL43ucz5nevePk
         LnNz27D4HpwIJGOaTtk8C0MnOYpbcXav3fJZY1FTPUOUG1wd2ISFOdZw4aXORQ0UotB3
         aPQMrXfuZ9/XNp4AIJOLGII5exFcPoOrViq9q3w3ZpzwInKdATwSVGJjkuJJyU6XRao4
         Y/ce3+O/FdwAZchKSzYBNHF22kFxA7zs3yzQfoJnOmxc+h6c/dZPdPxpon6xN25l17HF
         UyJS4pIwV5OLOvhsvCt4lMEbafQFOGDHUXmz8sdLPFUjMFAtgWdOkMEVYcwKUhSU7XO6
         wLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AQPvBn3+mpVQXLNFO7ln9Q3PQvFlywhORrkpfNdpRp4=;
        b=F6zcQsi+r4uYlfqOUPpOqk0hjz16J2kh/PrHfnXx0lTUFVP7k60sI0Knww8Wns6d4o
         x/keRPgcESYv0a9V+BLQXGG2bHqrNMY8jSK3g0rUKk4PGxGVI4Nz6FVd0qc7DFZIGms6
         n7bkPwFlRr0gpyZF6FnOIHskCrPAbrSKV7WlFvA3C6JQThzylog75lldJm7nnAUzU+OQ
         G3weri47nvReL9SEdMxpcbPn+LLqbZhqm0Rnx1axZ8qvGd71nefrWpr70Kan2OBm6cuC
         LAfBvoy8C2xMWE0C3iWUnBpJrw0YlI4Evmw5ThWCFI6LPU7KqiqnEu4xAPVN5K0F+1Vt
         AG7w==
X-Gm-Message-State: APjAAAUe7F4k2styQt+S9rVfPmBcabM3aN2syTthFIR/40sevAuAXVTJ
        N64YdLpkzBkTMPFbQ7kleKMPv1//cAT/P533SmjM5pG5
X-Google-Smtp-Source: APXvYqwLxRaEyV3jwYdLDHu21TDE2JoYFeQudgfpqPsVtLg1JHeGtIi431wOJ0Z8XJYxLgSzUWQB3rh7Kr+aDHb0gag=
X-Received: by 2002:ae9:e10e:: with SMTP id g14mr27537827qkm.430.1580785896457;
 Mon, 03 Feb 2020 19:11:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580211965.git.zhangweiping@didiglobal.com>
 <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
 <871rrevfmz.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rrevfmz.fsf@nanos.tec.linutronix.de>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 4 Feb 2020 11:11:25 +0800
Message-ID: <CAA70yB7ThwiaGFkM6J-cja4OcD0oH_6KTwH7vpmp9mVG0Xte4w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] genirq/affinity: allow driver's discontigous
 affinity set
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, keith.busch@intel.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2020=E5=B9=B42=E6=9C=881=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=885:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Weiping Zhang <zhangweiping@didiglobal.com> writes:
>
> > nvme driver will add 4 sets for supporting NVMe weighted round robin,
> > and some of these sets may be empty(depends on user configuration),
> > so each particular set is assigned one static index for avoiding the
> > management trouble, then the empty set will be been by
> > irq_create_affinity_masks().
>
> What's the point of an empty interrupt set in the first place? This does
> not make sense and smells like a really bad hack.
>
> Can you please explain in detail why this is required and why it
> actually makes sense?
>
Hi Thomas,
Sorry to late reply, I will post new patch to avoid creating empty sets.
In this version, nvme add extra 4 sets, because nvme will split its
io queues into 7 parts (poll, default, read, wrr_low, wrr_medium,
wrr_high, wrr_urgent),
the poll queues does not use irq, so nvme will has at most 6 irq sets.
And nvme driver use
two variables(dev->io_queues[index] and affd->set_size[index]) to
track how many queues/irqs
in each part. And the user may set some queues count to 0, for example:
nvme use 96 io queues.

default
dev->io_queues[0]=3D90
affd->set_size[0] =3D 90

read
dev->io_queues[1]=3D0
affd->set_size[1] =3D 0

wrr low
dev->io_queues[2]=3D0
affd->set_size[2] =3D 0

wrr medium
dev->io_queues[3]=3D0
affd->set_size[3] =3D 0

wrr high
dev->io_queues[4]=3D6
affd->set_size[4] =3D 6

wrr urgent
dev->io_queues[5]=3D0
affd->set_size[5] =3D 0

In this case the index from 1 to 3 will has 0 irqs.

But actually, it's no need to use fixed index for io_queues and set_size,
nvme just tells irq engine, how many irq_sets it has, and how may irqs
in each set,
so i will post V5 to solve this problem.
        nr_sets =3D 1;
        dev->io_queues[HCTX_TYPE_DEFAULT] =3D nr_default;
        affd->set_size[nr_sets - 1] =3D nr_default;
        dev->io_queues[HCTX_TYPE_READ] =3D nr_read;
        if (nr_read) {
                nr_sets++;
                affd->set_size[nr_sets - 1] =3D nr_read;
        }
        dev->io_queues[HCTX_TYPE_WRR_LOW] =3D nr_wrr_low;
        if (nr_wrr_low) {
                nr_sets++;
                affd->set_size[nr_sets - 1] =3D nr_wrr_low;
        }
        dev->io_queues[HCTX_TYPE_WRR_MEDIUM] =3D nr_wrr_medium;
        if (nr_wrr_medium) {
                nr_sets++;
                affd->set_size[nr_sets - 1] =3D nr_wrr_medium;
        }
        dev->io_queues[HCTX_TYPE_WRR_HIGH] =3D nr_wrr_high;
        if (nr_wrr_high) {
                nr_sets++;
                affd->set_size[nr_sets - 1] =3D nr_wrr_high;
        }
        dev->io_queues[HCTX_TYPE_WRR_URGENT] =3D nr_wrr_urgent;
        if (nr_wrr_urgent) {
                nr_sets++;
                affd->set_size[nr_sets - 1] =3D nr_wrr_urgent;
        }
        affd->nr_sets =3D nr_sets;

Thanks
Weiping
