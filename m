Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5216026A
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2020 09:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgBPIJr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Feb 2020 03:09:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39702 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgBPIJr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Feb 2020 03:09:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id c5so10018227qtj.6;
        Sun, 16 Feb 2020 00:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dNEzfTwUBmfbDmP8jHrIogG2oGgC1+4D3raZbBbSc2I=;
        b=VmKAFLhpDtAwHFCSjp+NzMIgHyhm7krjkidskFg0N+Fgdz3R8JDO3b8ne9kX2NFKY+
         N/GybcS2uUJYFLbORG6aDUumIctsLO+Be5ocFLSryqNoTi+9rDFflc5gpxK+RKw1+Io/
         n88bkYbb9GtMZ/vk5gE20Oue9ZjRBfLFFDCNBLu+HP1A2TycZn6CtUMlARKRH4vGlG4M
         ig34rD5d25IBzbXpRYhrTD01cJRhTk9nw4VwW4ldj26nRlASBkqDb3QHKjwIJg6/eOCD
         MMD6AR29nHG9e3OxFlZGf9E7wRVQhM5ujrZu534Vpv+52f9/1EdXj4e0dwx5Bp2ei4oZ
         JmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dNEzfTwUBmfbDmP8jHrIogG2oGgC1+4D3raZbBbSc2I=;
        b=VfHtnrsmKl/URU+kHaUAv3G5HFNSPhYdIG9Ce1wsDV/GhflDerjacvV9AFyGy5zu/S
         wby6buuJNTIJ39hH6NwjAy9G6mUrqJicVf9jEU/L8rqLpVhEmJ91h9mHSmhbK4ZEPcm0
         k/ye1dQ++OGUhWjqV2L7s46sXwJrg3y/mp1+v3dZGYPgMzeknw3INhy3wgs9LTfPJQqT
         lgb3n24Zv89rI/pWyJNIXSLa538MJG4XRdy9YQ5+bHRnhGU+uEjAjkhJxqwQkVQg2TKP
         ZHZFXKzrpfZYKjpXsJq+IZYK31zEubUrBgoIE9iX4f/mAVNzTRen3V5/4kTLU3c7H8gB
         CnLA==
X-Gm-Message-State: APjAAAUOpTjwDPCTaeUUWt7qnGDRjIerK6I1mqWxBc6HrtQNr9dMWbhA
        soHsXE0PwmBfsEZHtCO6y3b2XK/Se5ETb6d+Eww=
X-Google-Smtp-Source: APXvYqyWsEgZR3nj4ltlF/cwwuK/9RC88Bxi124aJCUSlJQqix+GJMRtc5vW2gcs32HrxaV4C+AM8gxZqKNu36C+0WQ=
X-Received: by 2002:ac8:47cc:: with SMTP id d12mr9206563qtr.246.1581840585855;
 Sun, 16 Feb 2020 00:09:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580786525.git.zhangweiping@didiglobal.com> <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Sun, 16 Feb 2020 16:09:34 +0800
Message-ID: <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Keith Busch <kbusch@kernel.org> =E4=BA=8E2020=E5=B9=B42=E6=9C=884=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Feb 04, 2020 at 11:30:45AM +0800, Weiping Zhang wrote:
> > This series try to add Weighted Round Robin for block cgroup and nvme
> > driver. When multiple containers share a single nvme device, we want
> > to protect IO critical container from not be interfernced by other
> > containers. We add blkio.wrr interface to user to control their IO
> > priority. The blkio.wrr accept five level priorities, which contains
> > "urgent", "high", "medium", "low" and "none", the "none" is used for
> > disable WRR for this cgroup.
>
Hi Bush,

> The NVMe protocol really doesn't define WRR to be a mechanism to mitigate
> interference, though. It defines credits among the weighted queues
> only for command fetching, and an urgent strict priority class that
> starves the rest. It has nothing to do with how the controller should
> prioritize completion of those commands, even if it may be reasonable to
> assume influencing when the command is fetched should affect its
> completion.
>
Thanks your feedback, the fio test result on WRR shows that, the high-wrr-f=
io
get more bandwidth/iops and low latency. I think it's a good feature
for the case
that run multiple workload with different priority, especially for
container colocation.

> On the "weighted" strict priority, there's nothing separating "high"
> from "low" other than the name: the "set features" credit assignment
> can invert which queues have higher command fetch rates such that the
> "low" is favoured over the "high".
>
If there is no limitation in the hardware controller, we can add more
checking in
"set feature command". I think mostly people won't give "low" more
credits than "high",
it really does not make sense.

> There's no protection against the "urgent" class starving others: normal
> IO will timeout and trigger repeated controller resets, while polled IO
> will consume 100% of CPU cycles without making any progress if we make
> this type of queue available without any additional code to ensure the
> host behaves..
>
I think we can just disable it in the software layer , actually, I have no =
real
application need this.

> On the driver implementation, the number of module parameters being
> added here is problematic. We already have 2 special classes of queues,
> and defining this at the module level is considered too coarse when
> the system has different devices on opposite ends of the capability
> spectrum. For example, users want polled queues for the fast devices,
> and none for the slower tier. We just don't have a good mechanism to
> define per-controller resources, and more queue classes will make this
> problem worse.
>
We can add a new "string" module parameter, which contains a model number,
in most cases, the save product with a common prefix model number, so
in this way
nvme can distinguish the different performance devices(hign or low end).
Before create io queue, nvme driver can get the device's Model number(40 By=
tes),
then nvme driver can compare device's model number with module parameter, t=
o
decide how many io queues for each disk;

/* if model_number is MODEL_ANY, these parameters will be applied to
all nvme devices. */
char dev_io_queues[1024] =3D "model_number=3DMODEL_ANY,
poll=3D0,read=3D0,wrr_low=3D0,wrr_medium=3D0,wrr_high=3D0,wrr_urgent=3D0";
/* these paramters only affect nvme disk whose model number is "XXX" */
char dev_io_queues[1024] =3D "model_number=3DXXX,
poll=3D1,read=3D2,wrr_low=3D3,wrr_medium=3D4,wrr_high=3D5,wrr_urgent=3D0;";

struct dev_io_queues {
        char model_number[40];
        unsigned int poll;
        unsgined int read;
        unsigned int wrr_low;
        unsigned int wrr_medium;
        unsigned int wrr_high;
        unsigned int wrr_urgent;
};

We can use these two variable to store io queue configurations:

/* default values for the all disk, except whose model number is not
in io_queues_cfg */
struct dev_io_queues io_queues_def =3D {};

/* user defined values for a specific model number */
struct dev_io_queues io_queues_cfg =3D {};

If we need multiple configurations( > 2), we can also extend
dev_io_queues to support it.

> On the blk-mq side, this implementation doesn't work with the IO
> schedulers. If one is in use, requests may be reordered such that a
> request on your high-priority hctx may be dispatched later than more
> recent ones associated with lower priority. I don't think that's what
> you'd want to happen, so priority should be considered with schedulers
> too.
>
Currently, nvme does not use io scheduler by defalut, if user want to make
wrr compatible with io scheduler, we can add other patches to handle this.

> But really, though, NVMe's WRR is too heavy weight and difficult to use.
> The techincal work group can come up with something better, but it looks
> like they've lost interest in TPAR 4011 (no discussion in 2 years, afaics=
).

For the test result, I think it's a useful feature.
It really gives high priority applications high iops/bandwith and low laten=
cy,
and it makes software very thin and simple.
