Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49796CEEC
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2019 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390302AbfGRNds (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Jul 2019 09:33:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfGRNds (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Jul 2019 09:33:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so25651652wml.0;
        Thu, 18 Jul 2019 06:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9w1xxlHb/VEIpzdOOWwd1xtDNvnBNKHtKvEhPQVLgKA=;
        b=KER3JAZGgGC06GRuyr1CVWqVBXWHufbAleZKGNZGccPGsUc8923TZC06WJ7Q44n+OH
         kkYJG01x3l4R0w732S6ZAk5rN5nj9PRZNGALD+0mtDz3NbS0fZMeN2RcER4He5am1l1Q
         A8TTErxagdYj0MT+wCpSwWOG7rqYiRT55HB0SIF7+qgHAQ8IvQF2aLH3Qy/kvWXZ5cto
         bCINuEvt3soVj4k/+9yfMOH9n/aNGoD0KZMuUJ0EohTQ1SoP19K7QSG7BvBu2bzTGMZM
         l7sFvhz3+NZ+9fjqgGtsU9vs+0JacTWBMhuRdkjV8xQTVnaWaed+8ESdJMFZX158zZFA
         b7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=9w1xxlHb/VEIpzdOOWwd1xtDNvnBNKHtKvEhPQVLgKA=;
        b=FrBqBKSiX2an1gCFRlyMBuFTGCmPs4Z+TDlPH7VQy8Ilr3TJcopmY0LnP9LTxiUd/N
         kXl/Q1uw8oF7H4oBs5I1liUghcfl/AQWjvHKphGM2XINnnBDWhG223AU4jQcRCcNLzyP
         CytpolvQsDzmenmbcurB9Q2IpUMRkogH5VSDG19J89CM4EY2/FGFbEGZZPSbpbtRIWf2
         wCvQyOKAajREH1HL709cOdGNUSULAPa5K8K3RJAEnJn3eYihxdz94TfUIE9a+jWp0O9I
         HW606wsP5TsruCAacUONygev0/5ftdIxy8nqLR7hFrUPcEokj65eD3kAvYFIeT64nhuz
         IQYg==
X-Gm-Message-State: APjAAAVQkzAx+ZubI3RvgNezoAvSaDg0GA0Kmmq5fy+t7z8QdP38Y39y
        wOiHZXD7UiULcvw7vxHanwuxxqJmf8SfxjS1jAs=
X-Google-Smtp-Source: APXvYqzuJh3Hy3Ru8paI3yEnCV73MOWotWHyH7qILTT7R9V8heWXKM69BvZV/N9oyqTlPgxWoXieY/Os6srlHcmFKRI=
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr41836156wmf.2.1563456824835;
 Thu, 18 Jul 2019 06:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561381826.git.zhangweiping@didiglobal.com>
In-Reply-To: <cover.1561381826.git.zhangweiping@didiglobal.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 18 Jul 2019 21:33:07 +0800
Message-ID: <CAA70yB5wsa9+Tb5AYvvq9YHUm79PVhQDcq_amYKjt2WwGqCc_g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support Weighted Round Robin for blkcg and nvme
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, keith.busch@intel.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Weiping Zhang <zhangweiping@didiglobal.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=
=8824=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:34=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> This series try to add Weighted Round Robin for block cgroup and nvme
> driver. When multiple containers share a single nvme device, we want
> to protect IO critical container from not be interfernced by other
> containers. We add blkio.wrr interface to user to control their IO
> priority. The blkio.wrr accept five level priorities, which contains
> "urgent", "high", "medium", "low" and "none", the "none" is used for
> disable WRR for this cgroup.
>
> The first patch add an WRR infrastucture for block cgroup.
>
> We add extra four hareware contexts at blk-mq layer,
> HCTX_TYPE_WRR_URGETN/HIGH/MEDIUM/LOW to allow device driver maps
> different hardsware queues to dirrenct hardware context.
>
> The second patch add a nvme_ctrl_ops named get_ams to get the expect
> Arbitration Mechanism Selected, now this series only support nvme-pci.
> This operations will check both CAP.AMS and nvme-pci wrr queue count,
> to decide enable WRR or RR.
>
> The third patch rename write_queues module parameter to read_queues,
> that can simplify the calculation the number of defaut,read,poll,wrr
> queue.
>
> The fourth patch skip the empty affinity set, because nvme may have
> 7 affinity sets, and some affinity set may be empty.
>
> The last patch add support nvme-pci Weighted Round Robin with Urgent
> Priority Class, we add four module paranmeters as follow:
>         wrr_urgent_queues
>         wrr_high_queues
>         wrr_medium_queues
>         wrr_low_queues
> nvme-pci will set CC.AMS=3D001b, if CAP.AMS[17]=3D1 and wrr_xxx_queues
> larger than 0. nvme driver will split hardware queues base on the
> read/pool/wrr_xxx_queues, then set proper value for Queue Priority
> (QPRIO) in DWORD11.
>
> fio test:
>
> CPU:    Intel(R) Xeon(R) Platinum 8160 CPU @ 2.10GHz
> NVME:   Intel SSDPE2KX020T8 P4510 2TB
>
> [root@tmp-201812-d1802-818396173 low]# nvme show-regs /dev/nvme0n1
> cap     : 2078030fff
> version : 10200
> intms   : 0
> intmc   : 0
> cc      : 460801
> csts    : 1
> nssr    : 0
> aqa     : 1f001f
> asq     : 5f7cc08000
> acq     : 5f5ac23000
> cmbloc  : 0
> cmbsz   : 0
>
> Run fio-1, fio-2, fio-3 in parallel,
>
> For RR(round robin) these three fio nearly get same iops or bps,
> if we set blkio.wrr for different priority, the WRR "high" will
> get more iops/bps than "medium" and "low".
>
>
>
> RR:
> fio-1: echo "259:0 none" > /sys/fs/cgroup/blkio/high/blkio.wrr
> fio-2: echo "259:0 none" > /sys/fs/cgroup/blkio/medium/blkio.wrr
> fio-3: echo "259:0 none" > /sys/fs/cgroup/blkio/low/blkio.wrr
>
> WRR:
> fio-1: echo "259:0 high" > /sys/fs/cgroup/blkio/high/blkio.wrr
> fio-2: echo "259:0 medium" > /sys/fs/cgroup/blkio/medium/blkio.wrr
> fio-3: echo "259:0 low" > /sys/fs/cgroup/blkio/low/blkio.wrr
>
> rwtest=3Drandread
> fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D32 --filename=3D/dev/nvme0n=
1 --direct=3D1 --runtime=3D60 --numjobs=3D8 --rw=3D$rwtest --name=3Dtest$1 =
--group_reporting
>
> Randread 4K     RR              WRR
> -------------------------------------------------------
> fio-1:          220 k           395 k
> fio-2:          220 k           197 k
> fio-3:          220 k           66  k
>
> rwtest=3Drandwrite
> fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D32 --filename=3D/dev/nvme0n=
1 --direct=3D1 --runtime=3D60 --numjobs=3D8 --rw=3D$rwtest --name=3Dtest$1 =
--group_reporting
>
> Randwrite 4K    RR              WRR
> -------------------------------------------------------
> fio-1:          150 k           295 k
> fio-2:          150 k           148 k
> fio-3:          150 k           51  k
>
> rwtest=3Dread
> fio --bs=3D512k --ioengine=3Dlibaio --iodepth=3D32 --filename=3D/dev/nvme=
0n1 --direct=3D1 --runtime=3D60 --numjobs=3D8 --rw=3D$rwtest --name=3Dtest$=
1 --group_reporting
>
> read 512K       RR              WRR
> -------------------------------------------------------
> fio-1:          963 MiB/s       1704 MiB/s
> fio-2:          950 MiB/s       850  MiB/s
> fio-3:          961 MiB/s       284  MiB/s
>
> rwtest=3Dread
> fio --bs=3D512k --ioengine=3Dlibaio --iodepth=3D32 --filename=3D/dev/nvme=
0n1 --direct=3D1 --runtime=3D60 --numjobs=3D8 --rw=3D$rwtest --name=3Dtest$=
1 --group_reporting
>
> write 512K      RR              WRR
> -------------------------------------------------------
> fio-1:          890 MiB/s       1150 MiB/s
> fio-2:          871 MiB/s       595  MiB/s
> fio-3:          895 MiB/s       188  MiB/s
>
>
> Changes since V2:
>  * drop null_blk related patch, which adds a new NULL_Q_IRQ_WRR to
>         simulte nvme wrr policy
>  * add urgent tagset map for nvme driver
>  * fix some problem in V2, suggested by Minwoo
>
> Changes since V1:
>  * reorder HCTX_TYPE_POLL to the last one to adopt nvme driver easily.
>  * add support WRR(Weighted Round Robin) for nvme driver
>
> Weiping Zhang (5):
>   block: add weighted round robin for blkcgroup
>   nvme: add get_ams for nvme_ctrl_ops
>   nvme-pci: rename module parameter write_queues to read_queues
>   genirq/affinity: allow driver's discontigous affinity set
>   nvme: add support weighted round robin queue
>
>  block/blk-cgroup.c         |  89 ++++++++++++++++
>  block/blk-mq-debugfs.c     |   4 +
>  block/blk-mq-sched.c       |   6 +-
>  block/blk-mq-tag.c         |   4 +-
>  block/blk-mq-tag.h         |   2 +-
>  block/blk-mq.c             |  12 ++-
>  block/blk-mq.h             |  20 +++-
>  block/blk.h                |   2 +-
>  drivers/nvme/host/core.c   |   9 +-
>  drivers/nvme/host/nvme.h   |   2 +
>  drivers/nvme/host/pci.c    | 246 ++++++++++++++++++++++++++++++++++++---=
------
>  include/linux/blk-cgroup.h |   2 +
>  include/linux/blk-mq.h     |  14 +++
>  include/linux/interrupt.h  |   2 +-
>  include/linux/nvme.h       |   3 +
>  kernel/irq/affinity.c      |   4 +
>  16 files changed, 362 insertions(+), 59 deletions(-)
>

Hi Jens,

Would you give some comments for this series.

Thanks


> --
> 2.14.1
>
