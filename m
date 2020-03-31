Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7658B199B99
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgCaQba (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 12:31:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38369 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731081AbgCaQb3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 12:31:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so23688972qke.5;
        Tue, 31 Mar 2020 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3e9ikjR7lUfigAH3hUl/FtkvucG7jL188AkHtbtxXwU=;
        b=JFffBG1O7hZhrL4iWKk+o5lwqbdFv84JlaqpK1TtGAaPpOY13zvdft43vmDz/CcmTQ
         nIHnNWsxIL0clp4kNgoxK0yQlGE98tVc7k9BZ+Aqj6wYm5nS2HCVA2SbKrU9fXydw8IB
         iWd7CDUllGJqvAqA8gggeh9RXn3bjDLGVF8C90bnvIopC1wIOhQ36QT3f0aufrC/iC/T
         SYPRvEgdHQcCB9EB5fGpEsED3mwVOy9S3w3yMl9SdggcVFZBQW9UvaTeJ2Both4xMGzZ
         lDLNirOa07shniq/V7jr1WOxVJ3IVPZJQlvZa+1IcsAKyOO8UT9j4q1l9/1ctw0DOTLF
         A+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3e9ikjR7lUfigAH3hUl/FtkvucG7jL188AkHtbtxXwU=;
        b=CBkeOc0Ad9un/cu8UHhd60liPejJle0uZJnVLsPrGT7ftg5I3IbB88FGiUT3rqyaps
         mbw80miybL1heKY/Qi1yb91J7R8f4SyxxgQTE9yPJfIe0u/bS5jruvJbaBu4IDj/Is3i
         zj6MAW6d7YuKa3n2z83N5BSXr/+Lt1h958TkeVQMIlrsnvCI5mbPwawMQ3KeX33y4rzb
         Vx32yy0Zxg9H+pXOIt1/a4El/krtsTEXMfYXB8wYeczrBMOVVM0yAO8g9+jXB5JfxEJz
         E+GWlqciZj4qzc8hyqOE3dnXRLYUL75j738A4y+TnFDvx8aP2j7E4bTKQB6TwXyIm/t/
         um/g==
X-Gm-Message-State: ANhLgQ2nP8IuAhT60uzrZObBzFeq9fKKijJdk7ZH+m2sDLHK+J51hE8O
        26K5NDdHKFDiejK//0gjAbIMN9JtJBZWqrVqAak=
X-Google-Smtp-Source: ADFU+vv7XLsSmd0U+NVmBqN6EeeGNyZH+7V3R7M+qo+XNg5DADsMkKTg2jxXha8xl3BLAFxZYuJpn4eJIrre1h9PmJM=
X-Received: by 2002:a37:bf06:: with SMTP id p6mr5907892qkf.477.1585672288628;
 Tue, 31 Mar 2020 09:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com> <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
 <20200331143635.GS162390@mtj.duckdns.org> <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
 <20200331155139.GT162390@mtj.duckdns.org> <20200331155257.GA22994@lst.de>
In-Reply-To: <20200331155257.GA22994@lst.de>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 1 Apr 2020 00:31:17 +0800
Message-ID: <CAA70yB6PYH-W8-RRd7nxXOvpg6n+_-h_BLm6JA3EbLmsYG-ZSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2020=E5=B9=B43=E6=9C=8831=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 31, 2020 at 11:51:39AM -0400, Tejun Heo wrote:
> > Hello,
> >
> > On Tue, Mar 31, 2020 at 11:47:41PM +0800, Weiping Zhang wrote:
> > > Do you means drop the "io.wrr" or "blkio.wrr" in cgroup, and use a
> > > dedicated interface
> > > like /dev/xxx or /proc/xxx?
> >
> > Yes, something along that line. Given that it's nvme specific, it'd be =
best if
> > the interface reflects that too - e.g. through a file under
> > /sys/block/nvme*/device/. Jens, Christoph, what do you guys think?
>
> I'm pretty sure I voiced my opinion before - I think the NVMe WRR
> queueing concept is completely broken and I do not thing we should
> support it at all.
Hi Christoph,

Would you like to share more detail about why NVMe WRR is broken?
