Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC18971A5B
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfGWO35 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 10:29:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfGWO34 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 10:29:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so38801529wma.1;
        Tue, 23 Jul 2019 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T+ucanRlN4v00bCj+V9TWieMN0M4BoMWf+6f7FC6bAA=;
        b=gQ/V/Kgk2dWanp/KXQhCBr0KJKWqquPK27y24HLK0FJzKOLlf5Cm7tefm2CrJmJKl/
         e7hIxteKhMruQi8hMcCB+4t4z5bjLw3j7xrpiAniv/csxJeyOvqdyFmS6c5uOrNRs+ck
         NAxAHGd9UFgkK71wCLhjZHgWe8f2ZEi9qe2Y0xQJOnHSjFQIxjRzRd0nULv7NAHKFIi3
         9ckf/xG2uyAD+FZs02UaImyAEfQ7hT3RJv1qq+2NaLFxEG33Kgj589rL7Tj58BlI1V4r
         hqGvWo8AB3R1Pu/jWR29eyoiPq5if0NcvdEhrCIoTFvjSHOVmiUcGTKYYGg5azTmXlQ2
         in7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T+ucanRlN4v00bCj+V9TWieMN0M4BoMWf+6f7FC6bAA=;
        b=ggTH2d8faeWZIOP9ADkKd7+LmxbN07kJTZ//oJ8WTMXK6ZVSb8FwcNEZVhlbuT3LR/
         nFu24+5yPQCMnhgOFV5GvZRFbqwjaSQ9mZYJfoDL8zpdCFs12k+kH6lqqKaJ4tKr+7yl
         +kbde1yAD97X5uTTLPasUP2W9LwYADcl5sQofgb3hKvf2Gs7TmAQblBKlTTgBtcC4V6v
         19J4ygER5SrQdaeONI/Jv+b1ysRm8HZyjzUd9pwnFTMaLObS0g+4Zer7TaN13Xs6xtRB
         98gU2C4eNt7auTpV5ZZLuc8NUMP5ON/zC4pccZsu1uzAC35xJZXTEA1s3dmXA7VxWBd7
         5qjg==
X-Gm-Message-State: APjAAAXtj0oRKIwDYOa1/ZRv+rjR9675jwxFvCU++Vn9Wr2Mk422DOCc
        wYMHxeRag3dSbCF2eUGEZW9ivR5ii34ZdylzpJ4=
X-Google-Smtp-Source: APXvYqxtjGdc0X5DgIjGIR/fBYrgXZ6QVvG6t43yMN7+jj0gbuq+mxyzv1SxW3j1Ghs6r1ykg0hciXwlkERlfceRn1E=
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr68132355wmf.2.1563892193986;
 Tue, 23 Jul 2019 07:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1333161d2c64dbe93f9dcd0814ffaf6d00216d58.1561385989.git.zhangweiping@didiglobal.com>
 <20190718135916.GC696309@devbig004.ftw2.facebook.com>
In-Reply-To: <20190718135916.GC696309@devbig004.ftw2.facebook.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 23 Jul 2019 22:29:48 +0800
Message-ID: <CAA70yB5cjengLDTUN3U02yuBmn+dxi2KreegD+u2RohejUocsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] block: add weighted round robin for blkcgroup
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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

Tejun Heo <tj@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8818=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello, Weiping.
>
> On Mon, Jun 24, 2019 at 10:28:51PM +0800, Weiping Zhang wrote:
> > +static const char *blk_wrr_name[BLK_WRR_COUNT] =3D {
> > +     [BLK_WRR_NONE]          =3D "none",
> > +     [BLK_WRR_LOW]           =3D "low",
> > +     [BLK_WRR_MEDIUM]        =3D "medium",
> > +     [BLK_WRR_HIGH]          =3D "high",
> > +     [BLK_WRR_URGENT]        =3D "urgent",
> > +};
>
Hello Tejun,

> cgroup controllers must be fully hierarchical which the proposed
> implementation isn't.  While it can be made hierarchical, there's only
> so much one can do if there are only five priority levels.
>

These priority are fully mapped to nvme specification except WRR_NONE.
The Weighted Round Robin only support some of nvme devices, not all nvme
support this feature, if you think the name of blkio.wrr is too common
for block layer
I like to rename it to blkio.nvme.wrr. This patchset implent a simple inter=
face
to user, if user want to use this feature they should to know the Qos
of WRR provided by
nvme device is accetable for their applicatiions. The NVME WRR is a
simple and usefull
feature, I want to give user one more option when they select a proper
io isolation policy.
It's not a general io isolation method, like what blkio.throttlle or
iocost did, it just implement
a simple mapping between application and nvme hardware submission
queue,  not add
any extra io statistic at block layer. The weight of (high, medium,
low) and the burst can be
changed by nvme-set-feature command. But this patchset does not
support that, will be
added in the feature.

> Can you please take a look at the following?
>
>   http://lkml.kernel.org/r/20190710205128.1316483-1-tj@kernel.org
>
> In comparison, I'm having a bit of hard time seeing the benefits of
> this approach.  In addition to the finite level limitation, the actual
> WRR behavior would be device dependent and what each level means is
> likely to fluctuate depending on the workload and device model.
>
From the test result(sequtial and random) it seems the high priority
can get more
bps/iops than lower priority. If device cannot guarantee the io
latency when mixture
IOs issued to the device, I think, for WRR,  the software should tune Weigt=
h of
high,medium, low and arbitration burst may provide a more stable
latency, like what
iocost does(tune overall io issue rate).

> I wonder whether WRR is something more valuable to help internal queue
> management rather than being exposed to userspace directly.
>
> Thanks.
>
> --
> tejun
