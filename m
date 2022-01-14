Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1148E2CB
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 04:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiANDF7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 22:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236176AbiANDF7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jan 2022 22:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642129558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qRzrcQpKhxjVsYnkGq5z9O81TnKWlSU7qX48opWvZU=;
        b=Ft/G2yafRDNHZUUH5wiBfS/2nRqxNLEcijVyAS/SvLzWFRSGY/MsUAtBMfWmLH5v4G42yc
        09zL9HtfWpry/eYDpGt8Jx6DJAKuAF70fzYgTUUaEQ2kIbi1UKSydvOF1TLQhdQtwXUKhf
        84n6tXL9r6sBChDLafZqLymh99RbxS0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-dcNi8iWwMb-ZC_jhlFlcLw-1; Thu, 13 Jan 2022 22:05:57 -0500
X-MC-Unique: dcNi8iWwMb-ZC_jhlFlcLw-1
Received: by mail-lf1-f71.google.com with SMTP id d25-20020a194f19000000b0042b469bd916so5297958lfb.21
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 19:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5qRzrcQpKhxjVsYnkGq5z9O81TnKWlSU7qX48opWvZU=;
        b=zpiM9P5GFKLsBH2SRzxPyfz4qnp6KCYq1oA9Tnq0neLYe0PPQpEaoJyLcM/XGcdXZP
         ubVJ56gjUm6nAUMtYH1qhHO4B/voJwER3jLXHT/w5v7hmgMjGr1ZzJ7QVfqzH7FZDZrL
         EAgVNIA4EGexgPzkgJohRuQgw3TdevCjjeeaJbmCLa2/hfVZ+E4RpQkjN2ZhdUWQCUae
         5trOIv/llHDG1DZ36yVPq6cPp+KcXfTtRnZV+U8paa6XINLyg3CqSBs9ZeGVlXJ4gDEv
         u8GzB/fQI+3t5bFEMvSv2SAEjQeEf3XLb1fbA0h04BMDFWLPi3ITAcRq+eyJrWpkPyxb
         a+Og==
X-Gm-Message-State: AOAM533z1Q4YvLDYjkCMRtaJekDYyn16YocotKeI6JioXFu9zxLxb7l/
        ZFBA9gaxpf9UynV4eab8g4iFLhw0iuRENqk0AlVaNj2gEaIHBcrf1vlFRkXXF7klQZuzZjTw0ca
        SDKDsfd1/8S4VBGRgDAiJem119GG6DCBskw==
X-Received: by 2002:a2e:b90f:: with SMTP id b15mr5401810ljb.129.1642129556041;
        Thu, 13 Jan 2022 19:05:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxV9mSOpTPo0eRKZfgAFlp6l/UXKRmNy84FGs8BK8hyaZTPK6j0sxrTBSPA9kY3mZ9mJJYn8LOBfPtkSKvZJcU=
X-Received: by 2002:a2e:b90f:: with SMTP id b15mr5401791ljb.129.1642129555740;
 Thu, 13 Jan 2022 19:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20220110134758.2233758-1-yukuai3@huawei.com> <20220110134758.2233758-3-yukuai3@huawei.com>
 <Yd5FkuhYX9YcgQkZ@T590> <2221953d-be40-3433-d46c-f40acd044482@huawei.com>
In-Reply-To: <2221953d-be40-3433-d46c-f40acd044482@huawei.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Fri, 14 Jan 2022 11:05:44 +0800
Message-ID: <CAFj5m9KmHB6FtUZ3E42BMZo+=aNNfn2bLu=kNhBOsRdxbfT6nw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     mkoutny@suse.com, paulmck@kernel.org, tj@kernel.org,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 13, 2022 at 04:46:18PM +0800, yukuai (C) wrote:
> =E5=9C=A8 2022/01/12 11:05, Ming Lei =E5=86=99=E9=81=93:
> > Hello Yu Kuai,
> >
> > On Mon, Jan 10, 2022 at 09:47:58PM +0800, Yu Kuai wrote:
> > > Throttled bios can't be issued after del_gendisk() is done, thus
> > > it's better to cancel them immediately rather than waiting for
> > > throttle is done.
> > >
> > > For example, if user thread is throttled with low bps while it's
> > > issuing large io, and the device is deleted. The user thread will
> > > wait for a long time for io to return.
> > >
> > > Noted this patch is mainly from revertion of commit 32e3374304c7
> > > ("blk-throttle: remove tg_drain_bios") and commit b77412372b68
> > > ("blk-throttle: remove blk_throtl_drain").
> > >
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-throttle.c | 77 +++++++++++++++++++++++++++++++++++++++++=
+++
> > >   block/blk-throttle.h |  2 ++
> > >   block/genhd.c        |  2 ++
> > >   3 files changed, 81 insertions(+)
> >
> > Just wondering why not take the built-in way in throtl_upgrade_state() =
for
> > canceling throttled bios? Something like the following, then we can avo=
id
> > to re-invent the wheel.
> >
> >   block/blk-throttle.c | 38 +++++++++++++++++++++++++++++++-------
> >   block/blk-throttle.h |  2 ++
> >   block/genhd.c        |  3 +++
> >   3 files changed, 36 insertions(+), 7 deletions(-)
> >
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index cf7e20804f1b..17e56b2e44c4 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -1816,16 +1816,11 @@ static void throtl_upgrade_check(struct throtl_=
grp *tg)
> >             throtl_upgrade_state(tg->td);
> >   }
> > -static void throtl_upgrade_state(struct throtl_data *td)
> > +static void __throtl_cancel_bios(struct throtl_data *td)
> >   {
> >     struct cgroup_subsys_state *pos_css;
> >     struct blkcg_gq *blkg;
> > -   throtl_log(&td->service_queue, "upgrade to max");
> > -   td->limit_index =3D LIMIT_MAX;
> > -   td->low_upgrade_time =3D jiffies;
> > -   td->scale =3D 0;
> > -   rcu_read_lock();
> >     blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) =
{
> >             struct throtl_grp *tg =3D blkg_to_tg(blkg);
> >             struct throtl_service_queue *sq =3D &tg->service_queue;
> > @@ -1834,12 +1829,41 @@ static void throtl_upgrade_state(struct throtl_=
data *td)
> >             throtl_select_dispatch(sq);
> >             throtl_schedule_next_dispatch(sq, true);
> Hi, Ming Lei
>
> I'm confused that how can bios be canceled here?
> tg->iops and tg->bps stay untouched, how can throttled bios
> dispatch?

I thought that throttled bios will be canceled by 'tg->disptime =3D jiffies=
 - 1;'
and the following dispatch schedule.

But looks it isn't enough, since tg_update_disptime() updates
->disptime. However,
this problem can be solved easily by not updating ->disptime in case that w=
e are
canceling.

> >     }
> > -   rcu_read_unlock();
> >     throtl_select_dispatch(&td->service_queue);
> >     throtl_schedule_next_dispatch(&td->service_queue, true);
> >     queue_work(kthrotld_workqueue, &td->dispatch_work);
> >   }
> > +void blk_throtl_cancel_bios(struct request_queue *q)
> > +{
> > +   struct cgroup_subsys_state *pos_css;
> > +   struct blkcg_gq *blkg;
> > +
> > +   rcu_read_lock();
> > +   spin_lock_irq(&q->queue_lock);
> > +   __throtl_cancel_bios(q->td);
> > +   spin_unlock_irq(&q->queue_lock);
> > +   rcu_read_unlock();
> > +
> > +   blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg)
> > +           del_timer_sync(&blkg_to_tg(blkg)->service_queue.pending_tim=
er);
> > +   del_timer_sync(&q->td->service_queue.pending_timer);
>
> By the way, I think delete timer will end up io hung here if there are
> some bios still be throttled.

Firstly ->queue_lock is held by blk_throtl_cancel_bios(), so no new bios
will be throttled.

Also if we don't update ->disptime, any new bios throttled after releasing
->queue_lock will be dispatched soon.


Thanks,
Ming

