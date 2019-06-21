Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0464EADE
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 16:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUOiZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 10:38:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43601 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUOiZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 10:38:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so6808181wru.10;
        Fri, 21 Jun 2019 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mg4igNcdFGJjlqUrOaFCGZrcCaYIMam+p6zdeSPxPvc=;
        b=HolW+Ln/MTbIlbglAKIqv4mn4QoufFGkjBdVTNwFlsd6VXZwwKy0a4ZVyeuC2c3e1M
         lplICypTsvlW4Lpp35f3+12IXh2UK7Yz+orv41jsTBBjuyHMsdt54H/jZPtKykdGzkGu
         TlaDSuqcPRFonbuCyWEV2t9Fa9q961c4RR+8MKdM8MKLixtbfW5YE4if3ve4phjKCV0B
         Yt8Q2LznP1BHAtRcXeS6PtPk7LWaMuxTTelgQuP0FgJpwOhk0kHOWjlCNK55wAkbZZfB
         ItcKg3R22Vmtgrc4NTaK2q7mxngdwiALONbL0n+4AQXmtQRAAzN5n/ORijhrrykdedke
         4PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mg4igNcdFGJjlqUrOaFCGZrcCaYIMam+p6zdeSPxPvc=;
        b=rVOJ1dwwaQxrNIllIBFxGs2Rm9WyM7PBv4gYhYzZKP1XbP+swlJLpFyBt1OsRzeWAa
         VNonlAbtl+Gd5woGwGhUmjhVZuJdlHD28T77ApjeyNPH9xKny+Lr/MUiMM4iHXY3UTil
         OHfEWcslwRGnlzJ1TEdpHoVJhcAkkA1ZTB+kG7JflrIR7U7DQdk3kcK/Jv8aGr95kxh+
         xcW9aFF1GaT2RdmpDF4YaMaJbGvf7EeeAMwU3XW9c202liqj68inbN815vF1Ybb2jbpq
         LY+hFuk5vNDlLC2dd5uuoQij3ZJaKLhd97Rj70x8kv3iSLP1Wkmqx7Kq4JXbDUGBHc4c
         WHlA==
X-Gm-Message-State: APjAAAWfAgLLHtTYhrlsKUEdD/nwYt6dAmQzPE89dqNBtuiGoV1BGs4f
        TcJoMLCx5txrYraoH8/BtlXZJZA7N3qksFijq+c=
X-Google-Smtp-Source: APXvYqxgNS6HCWeaPUZQDuc4O7/qWeVp7JTpYf2RoizpKDkJP4bU7rtNi8UOegdq2/LghlKd4cvAb/ZbYYQ9JQiP2q0=
X-Received: by 2002:a5d:4708:: with SMTP id y8mr2327119wrq.85.1561127902504;
 Fri, 21 Jun 2019 07:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
 <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
 <20190620141614.GB12032@minwooim-desktop>
In-Reply-To: <20190620141614.GB12032@minwooim-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 21 Jun 2019 22:38:12 +0800
Message-ID: <CAA70yB5hnrbkgMPkb2nZtKn5iagxZRe=JRhQkYFGhmYwKuWiYw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] nvme: add support weighted round robin queue
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Minwoo,

Thanks your feedback.

Minwoo Im <minwoo.im.dev@gmail.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8820=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:17=E5=86=99=E9=81=93=EF=BC=9A
>
> > -static int write_queues;
> > -module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
> > -MODULE_PARM_DESC(write_queues,
> > -     "Number of queues to use for writes. If not set, reads and writes=
 "
> > +static int read_queues;
> > +module_param_cb(read_queues, &queue_count_ops, &read_queues, 0644);
> > +MODULE_PARM_DESC(read_queues,
> > +     "Number of queues to use for reads. If not set, reads and writes =
"
> >       "will share a queue set.");
>
> Before starting my review for this, I'd like to talk about this part
> first.  It would be better if you can split this change from this commit
> into a new one because it just replaced the write_queues with
> read_queues which is directly mapped to HCTX_TYPE_READ.  This change
> might not be critical for the WRR implementation.
>
Yes, I'll split it into a sperate patch, the reason why I rename it to
read is that
it can siplify the calulation for wrr related queue count.
> >
> >  static int poll_queues =3D 0;
> >  module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
> >  MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO."=
);
> >
> > +static int wrr_high_queues =3D 0;
>
> Nitpick here: maybe we don't need to 0-initialize static variables
> explicitly.
ok, I will rebase this patch set to nvme-5.3 branch.

>
> > +module_param_cb(wrr_high_queues, &queue_count_ops, &wrr_high_queues, 0=
644);
> > +MODULE_PARM_DESC(wrr_high_queues, "Number of queues to use for WRR hig=
h.");
> > +
> > +static int wrr_medium_queues =3D 0;
> > +module_param_cb(wrr_medium_queues, &queue_count_ops, &wrr_medium_queue=
s, 0644);
> > +MODULE_PARM_DESC(wrr_medium_queues, "Number of queues to use for WRR m=
edium.");
> > +
> > +static int wrr_low_queues =3D 0;
> > +module_param_cb(wrr_low_queues, &queue_count_ops, &wrr_low_queues, 064=
4);
> > +MODULE_PARM_DESC(wrr_low_queues, "Number of queues to use for WRR low.=
");
> > +
> >  struct nvme_dev;
> >  struct nvme_queue;
> >
> > @@ -226,9 +238,17 @@ struct nvme_iod {
> >       struct scatterlist *sg;
> >  };
> >
> > +static inline bool nvme_is_enable_wrr(struct nvme_dev *dev)
> > +{
> > +     return dev->io_queues[HCTX_TYPE_WRR_LOW] +
> > +             dev->io_queues[HCTX_TYPE_WRR_MEDIUM] +
> > +             dev->io_queues[HCTX_TYPE_WRR_HIGH] > 0;
> > +}
>
> It looks like that it might be confused with AMS(Arbitration Mechanism
> Selected) in CC or CAP?  If it meant how many irqs for the sets were
> allocated, then can we have this function with another name like:
>         nvme_is_wrr_allocated or something indicating the irqsets
>
Yes, we should dectect AMS in CAP and CC, if we not enable WRR, we should
ignore all wrr_high/medium/low/urgent_queues.
For my point of view, this function is used for check if nvme enable WRR, s=
o
we should check AMS in both CAP and CC.
We also need define nvme_is_wrr_allocated which will be used when we
create io queues.
> > +
> >  static unsigned int max_io_queues(void)
> >  {
> > -     return num_possible_cpus() + write_queues + poll_queues;
> > +     return num_possible_cpus() + read_queues + poll_queues +
> > +             wrr_high_queues + wrr_medium_queues + wrr_low_queues;
> >  }
> >
> >  static unsigned int max_queue_count(void)
> > @@ -1534,11 +1558,46 @@ static void nvme_init_queue(struct nvme_queue *=
nvmeq, u16 qid)
> >       wmb(); /* ensure the first interrupt sees the initialization */
> >  }
> >
> > -static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool p=
olled)
> > +static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
> >  {
> >       struct nvme_dev *dev =3D nvmeq->dev;
> > -     int result;
> > +     int start, end, result, wrr;
> > +     bool polled =3D false;
> >       u16 vector =3D 0;
> > +     enum hctx_type type;
> > +
> > +     /* 0 for admain queue, io queue index >=3D 1 */
> > +     start =3D 1;
> > +     /* get hardware context type base on qid */
> > +     for (type =3D HCTX_TYPE_DEFAULT; type < HCTX_MAX_TYPES; type++) {
> > +             end =3D start + dev->io_queues[type] - 1;
> > +             if (qid >=3D start && qid <=3D end)
> > +                     break;
> > +             start =3D end + 1;
> > +     }
> > +
> > +     if (nvme_is_enable_wrr(dev)) {
>
> I think we need to check not only the irqset allocations, but also if the
> device is really supports WRR or not.
OK.
>
> > +             /* set read,poll,default to medium by default */
> > +             switch (type) {
> > +             case HCTX_TYPE_POLL:
> > +                     polled =3D true;
>
> Question: Is poll-queue not avilable to be used in case of !WRR?
>
Ya, I will fix it.
> > +             case HCTX_TYPE_DEFAULT:
> > +             case HCTX_TYPE_READ:
> > +             case HCTX_TYPE_WRR_MEDIUM:
> > +                     wrr =3D NVME_SQ_PRIO_MEDIUM;
>
> Also it seems like it could be named like flags because it will show the
> SQ priority.  What do you think?
>
It's ok, I will rename wrr to wrr_flag;
> > +                     break;
> > +             case HCTX_TYPE_WRR_LOW:
> > +                     wrr =3D NVME_SQ_PRIO_LOW;
> > +                     break;
> > +             case HCTX_TYPE_WRR_HIGH:
> > +                     wrr =3D NVME_SQ_PRIO_HIGH;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     } else {
> > +             wrr =3D 0;
>
> Would it be different with the following value ?
>         NVME_SQ_PRIO_URGENT     =3D (0 << 1)
> If it means no WRR, then can it be avoided the value which is already
> defined ?
I means no WRR, so I want to
#define NVME_SQ_PRIO_IGNORE NVME_SQ_PRIO_URGENT,
because if nvme's WRR is not enabled, the controller should ignore this fie=
ld.
>
> > +     }
> >
> >       clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
> >
>
> > @@ -2028,35 +2079,73 @@ static int nvme_setup_host_mem(struct nvme_dev =
*dev)
> >  static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int=
 nrirqs)
> >  {
> >       struct nvme_dev *dev =3D affd->priv;
> > -     unsigned int nr_read_queues;
> > +     unsigned int nr_total, nr, nr_read, nr_default;
> > +     unsigned int nr_wrr_high, nr_wrr_medium, nr_wrr_low;
> > +     unsigned int nr_sets;
> >
> >       /*
> >        * If there is no interupt available for queues, ensure that
> >        * the default queue is set to 1. The affinity set size is
> >        * also set to one, but the irq core ignores it for this case.
> > -      *
> > -      * If only one interrupt is available or 'write_queue' =3D=3D 0, =
combine
> > -      * write and read queues.
> > -      *
> > -      * If 'write_queues' > 0, ensure it leaves room for at least one =
read
> > -      * queue.
> >        */
> > -     if (!nrirqs) {
> > +     if (!nrirqs)
> >               nrirqs =3D 1;
> > -             nr_read_queues =3D 0;
> > -     } else if (nrirqs =3D=3D 1 || !write_queues) {
> > -             nr_read_queues =3D 0;
> > -     } else if (write_queues >=3D nrirqs) {
> > -             nr_read_queues =3D 1;
> > -     } else {
> > -             nr_read_queues =3D nrirqs - write_queues;
> > -     }
> >
> > -     dev->io_queues[HCTX_TYPE_DEFAULT] =3D nrirqs - nr_read_queues;
> > -     affd->set_size[HCTX_TYPE_DEFAULT] =3D nrirqs - nr_read_queues;
> > -     dev->io_queues[HCTX_TYPE_READ] =3D nr_read_queues;
> > -     affd->set_size[HCTX_TYPE_READ] =3D nr_read_queues;
> > -     affd->nr_sets =3D nr_read_queues ? 2 : 1;
> > +     nr_total =3D nrirqs;
> > +
> > +     nr_read =3D nr_wrr_high =3D nr_wrr_medium =3D nr_wrr_low =3D 0;
> > +
> > +     /* set default to 1, add all the rest queue to default at last */
> > +     nr =3D nr_default =3D 1;
> > +     nr_sets =3D 1;
> > +
> > +     nr_total -=3D nr;
> > +     if (!nr_total)
> > +             goto done;
> > +
> > +     /* read queues */
> > +     nr_sets++;
> > +     nr_read =3D nr =3D read_queues > nr_total ? nr_total : read_queue=
s;
> > +     nr_total -=3D nr;
> > +     if (!nr_total)
> > +             goto done;
> > +
> > +     /* wrr low queues */
> > +     nr_sets++;
> > +     nr_wrr_low =3D nr =3D wrr_low_queues > nr_total ? nr_total : wrr_=
low_queues;
> > +     nr_total -=3D nr;
> > +     if (!nr_total)
> > +             goto done;
> > +
> > +     /* wrr medium queues */
> > +     nr_sets++;
> > +     nr_wrr_medium =3D nr =3D wrr_medium_queues > nr_total ? nr_total =
: wrr_medium_queues;
>
> It looks like exceeded 80 chracters here.
I will fix it.
>
> > +     nr_total -=3D nr;
> > +     if (!nr_total)
> > +             goto done;
> > +
> > +     /* wrr high queues */
> > +     nr_sets++;
> > +     nr_wrr_high =3D nr =3D wrr_high_queues > nr_total ? nr_total : wr=
r_high_queues;
> > +     nr_wrr_high =3D nr =3D wrr_high_queues > nr_total ? nr_total : wr=
r_high_queues;
>
> Here also.
>
> If I misunderstood something here, please feel free to let me know.
>
Thanks very much for your feedback.
> Thanks,
