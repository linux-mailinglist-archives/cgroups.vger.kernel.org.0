Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D8A1928DA
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2020 13:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYMth (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Mar 2020 08:49:37 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]:44080 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCYMth (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Mar 2020 08:49:37 -0400
Received: by mail-qv1-f50.google.com with SMTP id f7so910762qvr.11;
        Wed, 25 Mar 2020 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iz+O4JY70/I6593EiYb3vc9QehOFE8IiCgzzBxiW4a8=;
        b=eKBMcEjgLZnyeEd11yYfakt9CIsppElK+QY7MTSFwKvXZW/YKZ7ZmTS5bsV3G/bC3d
         6/JF2+vOQUDQl5o2zVCDog0GopXRG3lV5vxmUKLSTjuqKceWTb1biDHq9++h+QCjOszV
         OyOdMIHPmW4OAWDXt3LmJ3qe1I8DI3PbkD1L4LucYNKQyJlRVF/K1xiLq8ormRElmWnk
         DaVEtB5gGmmHTDQEdWWDwY4sVf1gSQ2+9X2bSbmaOLVEcFCTazyz+PQlezXPGNPqxsri
         00nFyYipB7MDDMxrstPkCW0VMiE/aLDqivvyhOAFvLuZZxPncSSEzxJC22sWBemBPf8q
         Bumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iz+O4JY70/I6593EiYb3vc9QehOFE8IiCgzzBxiW4a8=;
        b=lGXeUakr1e/8FxSEkxWxev1SdKJv3I2c9OY/HLTrxCRcm+XmSiFCuynBZSJvu82NaA
         3aC6ptk2IfX3YX1iNoUZWXXniBZstci0uftEnAhR6D8GsusSXOpirRGwta/3M+GGLUfd
         zHv5n/lUcNhl+YsKfqTenaul0CwqKTiX4L+AYxG9wwYw8H/4gWCsNklOrciqIOLhW1tP
         lC7U3Mj0Ch8z8JE72Gs1u4PzUWuRPtbP/VDf/oLIirwucaEbo2D7RQU2B4sgln0paJzt
         Zx3qjlvPrnePHpN9n4hdRFFhsu45w+LQdRtCXytXqZFHvEJ80Zd0SFlR22wdIWjemN6L
         WTDg==
X-Gm-Message-State: ANhLgQ32CiwUJqcTKFpAcaMS/4+WbC1woOE+YDRa/FcrKJx2KrkyOb3n
        5fYgpqs/6sxtVCFQiN8PqJpHnsd43bDH6dtFLmD8hzXHYwY=
X-Google-Smtp-Source: ADFU+vsty0PfeBjsXXPyBQ1ZiWxEC3jTwTYvNjh4h8Px8HLr/oAJn5U9IcjMz5ooQ10q6+FwSEY8DYseUI8RlJ6Umek=
X-Received: by 2002:a05:6214:11ec:: with SMTP id e12mr2946998qvu.89.1585140575879;
 Wed, 25 Mar 2020 05:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584728740.git.zhangweiping@didiglobal.com> <20200324182725.GG162390@mtj.duckdns.org>
In-Reply-To: <20200324182725.GG162390@mtj.duckdns.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 25 Mar 2020 20:49:24 +0800
Message-ID: <CAA70yB7a7VjgPLObe-rzfV0dLAumeUVy0Dps+dY5r-Guq2Susg@mail.gmail.com>
Subject: Re: [RFC 0/3] blkcg: add blk-iotrack
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Tejun Heo <tj@kernel.org> =E4=BA=8E2020=E5=B9=B43=E6=9C=8825=E6=97=A5=E5=91=
=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 21, 2020 at 09:20:36AM +0800, Weiping Zhang wrote:
> > The user space tool, which called iotrack, used to collect these basic
> > io statistics and then generate more valuable metrics at cgroup level.
> > From iotrack, you can get a cgroup's percentile for io, bytes,
> > total_time and disk_time of the whole disk. It can easily to evaluate
> > the real weight of the weight based policy(bfq, blk-iocost).
> > There are lots of metrics for read and write generate by iotrack,
> > for more details, please visit: https://github.com/dublio/iotrack.
> >
> > Test result for two fio with randread 4K,
> > test1 cgroup bfq weight =3D 800
> > test2 cgroup bfq weight =3D 100
> >
> > Device      io/s   MB/s    %io    %MB    %tm   %dtm  %d2c %hit0 %hit1 %=
hit2 %hit3 %hit4 %hit5  %hit6  %hit7 cgroup
> > nvme1n1 44588.00 174.17 100.00 100.00 100.00 100.00 38.46  0.25 45.27 9=
5.90 98.33 99.47 99.85  99.92  99.95 /
> > nvme1n1 30206.00 117.99  67.74  67.74  29.44  67.29 87.90  0.35 47.82 9=
9.22 99.98 99.99 99.99 100.00 100.00 /test1
> > nvme1n1 14370.00  56.13  32.23  32.23  70.55  32.69 17.82  0.03 39.89 8=
8.92 94.88 98.37 99.53  99.77  99.85 /test2
>
> Maybe this'd be better done with bpf?
>
Hi Tejun,

How about support both iotrack and bpf?
If it's ok I want to add bpf support in another patchset, I saw that
iocost_monitor.py was base on drgn, maybe write a new script
"biotrack" base on drgn.

For this patchset, iotrack can work well, I'm using it to monitor
block cgroup for
selecting a proper io isolation policy.

Thanks a ton
Weiping
> --
> tejun
