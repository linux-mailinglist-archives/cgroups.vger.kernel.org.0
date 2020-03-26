Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317ED194298
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 16:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgCZPI6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 11:08:58 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:32971 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgCZPI5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 11:08:57 -0400
Received: by mail-qk1-f173.google.com with SMTP id v7so6810908qkc.0;
        Thu, 26 Mar 2020 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v7owHCnct69sVSGTFZo23hO2nNZX5mJ9i48UAPStm8Q=;
        b=OYo+MZCZD9qQc+5Syq25CWi7ldhbTbqCtzNloZ5rcO6PkSCD4h9+BK1oIRjnxw4xxW
         1PKxXUTHHz3GlbqjT9vEB+xcjOzLx0Cx9r9dApziEa/dGEdBFKZXNx24EgGUbxJl0eV+
         daYOEUS6fFGCtmHze90408IEMKwi1K2blW8GZQTvAEKf3AZSZTVhSGklWL75NbSOc2MD
         EEjNsVcdShFaCMM+iNcD3LOlu0Qhqi2rEelVgo9rqE8W1Gn/cDURL/TeOEeAQrZnAGl6
         E+16v8g33VmlG99IPSlz8ORp8DveELwjJEFo+VO/g2XhQrnKd77rtxpRxq0idStIzK/H
         MEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v7owHCnct69sVSGTFZo23hO2nNZX5mJ9i48UAPStm8Q=;
        b=ZyszhxZ0ORVAS8Sx8ZYRTYpeuAw9++U5fVTkrr5OeaJH/v2WOUnkN98evbP6/zIU4/
         CQqVloIJjA/Ve1M8KN8yz12XyYqKPJCBOs/4JtnmSzRSul8bExd8bJ5Umm7DQVzZcTyi
         x40KRE5MErwF4c0fguMTzug1Y9QcZS505r/B7ZNhGQQtv21xMBJXzufZixrzZmD18xHz
         Kix+ANPzHlebTss6Luq4wzKobt8RCVBhOyOnJHCmCIT7UjVQ/1g3PEEN7LfcozHT8/K3
         b0OuvR5U3FjuG9fQH8k3ZfKXa1HSzVRvCTzKK6aqKmwro6Mo36SiJd+cwEe4YgKGkmRO
         wFOQ==
X-Gm-Message-State: ANhLgQ1sggm2toJ7syO23KUqtaN8edomGkJNkzQqVVH/xqKuQIkmQ40X
        T+rACbschqtkOqYBSe1SKg63cVy1LAcRQAEwFbs=
X-Google-Smtp-Source: ADFU+vtCI4zhyjNOkeAG0s817j2w7wxyuz3bjemFvEZ2arBIWjnIbcL6JEXV8MTMnczlyw+5YWIhk7LH3viYGA6QjQQ=
X-Received: by 2002:a37:4b97:: with SMTP id y145mr8866530qka.167.1585235336674;
 Thu, 26 Mar 2020 08:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
 <20200324182725.GG162390@mtj.duckdns.org> <CAA70yB7a7VjgPLObe-rzfV0dLAumeUVy0Dps+dY5r-Guq2Susg@mail.gmail.com>
 <20200325141236.GJ162390@mtj.duckdns.org> <CAA70yB5yH9H6-gaKfRSTmgd6vvzP4T9N7v-NAD0MsRL+YTexHw@mail.gmail.com>
In-Reply-To: <CAA70yB5yH9H6-gaKfRSTmgd6vvzP4T9N7v-NAD0MsRL+YTexHw@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 26 Mar 2020 23:08:45 +0800
Message-ID: <CAA70yB4e65nbV=ZA8OT-SUkq+ZQOGGB9e-3QKJ_PqXjVaXGvFA@mail.gmail.com>
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

Weiping Zhang <zwp10758@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8826=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Tejun Heo <tj@kernel.org> =E4=BA=8E2020=E5=B9=B43=E6=9C=8825=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:12=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Mar 25, 2020 at 08:49:24PM +0800, Weiping Zhang wrote:
> > > For this patchset, iotrack can work well, I'm using it to monitor
> > > block cgroup for
> > > selecting a proper io isolation policy.
> >
> > Yeah, I get that but monitoring needs tend to diverge quite a bit
> > depending on the use cases making detailed monitoring often need fair
> > bit of flexibility, so I'm a bit skeptical about adding a fixed
> > controller for that. I think a better approach may be implementing
> > features which can make dynamic monitoring whether that's through bpf,
> > drgn or plain tracepoints easier and more efficient.
> >
> I agree with you, there are lots of io metrics needed in the real
> production system.
> The more flexible way is export all bio structure members of bio=E2=80=99=
s whole life to
> the userspace without re-compiling kernel, like what bpf did.
>
> Now the main block cgroup isolation policy:
>  blk-iocost and bfq are weght based, blk-iolatency is latency based.
> The blk-iotrack can track the real percentage for IOs,kB,on disk time(d2c=
),
> and total time, it=E2=80=99s a good indicator to the real weight. For blk=
-iolatency, the
> blk-iotrack has 8 lantency thresholds to show latency distribution, so if=
 we
> change these thresholds around to blk-iolateny.target.latency, we can tun=
e
> the target latency to a more proper value.
>
> blk-iotrack extends the basic io.stat. It just export the important
> basic io statistics
> for cgroup,like what /prof/diskstats for block device. And it=E2=80=99s e=
asy
> programming,
> iotrack just working like iostat, but focus on cgroup.
>
> blk-iotrack is friendly with these block cgroup isolation policies, a
> indicator for
> cgroup weight and lantency.
>

Hi Tejun,

I do a testing at cgroup v2 and monitoring them by iotrack,
then I compare the fio's output and iotrack's, they can match well.

cgroup weight test:
/sys/fs/cgroup/test1
/sys/fs/cgroup/test2
test1.weight : test2.weight =3D 8 : 1

Now I just run randread-4K fio test by these three policy:
iocost, bfq, and nvme-wrr
For blk-iocost I run "iocost_coef_gen.py" and set result to the "io.cost.mo=
del".
259:0 ctrl=3Duser model=3Dlinear rbps=3D3286476297 rseqiops=3D547837
rrandiops=3D793881 wbps=3D2001272356 wseqiops=3D482243 wrandiops=3D483037

But iocost_test1 cannot get 8/(8+1) iops,  and the total disk iops
is 737559 < 79388, even I change rrandiops=3D637000.

test case     bw         iops       rd_avg_lat  rd_p99_lat
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
iocost_test1  1550478    387619     659.76      1662.00
iocost_test2  1399761    349940     730.83      1712.00
wrr_test1     2618185    654546     390.59      1187.00
wrr_test2     362613     90653      2822.62     4358.00
bfq_test1     714127     178531     1432.43     489.00
bfq_test2     178821     44705      5721.76     552.00


The detail test report can be found at:
https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test


> Thanks
