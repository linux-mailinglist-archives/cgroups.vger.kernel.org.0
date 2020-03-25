Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7497A192E8D
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2020 17:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCYQpn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Mar 2020 12:45:43 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43018 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYQpn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Mar 2020 12:45:43 -0400
Received: by mail-qt1-f173.google.com with SMTP id a5so2713324qtw.10;
        Wed, 25 Mar 2020 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eNUeOGNC+DqnOKpMcPE0ACLXrDfm22ZmBEJ3IFoM+oc=;
        b=g8qcCd9PRxGBiwF85aE5iYlhbw2CijtCWSs3nyjSo0GOoqTepNjYsfDZXPDMhOQeB7
         Pp4RfdK6bGPix5F1v5baMp5fI+xO6jSu6PcffkQYuWJtNbElXGTPVve05YJdKYxvI47z
         DOKvQOIOhRlThaHzEHEktHPIraHIixq44zeZ/9vChOxRdxrjOpdBU+1UiLFzx6lAX67q
         nuIuRnMLn56yMmRzlZppxpeTnQKa6XxSpR4CpEVgH57q8cM552yWskXzhCC/3Xcw8zvI
         TYzKOxDodDXtiqmAI+GkajfuuZ60gFeMwQynRWiZAl7gOkg/mtbLYErMMr9Gq1PImP/S
         Pm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eNUeOGNC+DqnOKpMcPE0ACLXrDfm22ZmBEJ3IFoM+oc=;
        b=Yci/MvmfTWvSOhre8E3RG9XFCnzSrrYyPS5afaGk/6uNHtuSTmcVzD3L2vgBGh0d/m
         681xlcu2weQy1wjoPZTI0kURmTiVy/LZljWp6qsmY+so55APs2t1Dv9Elvdj4BjxhN//
         t4DZO501+spSOLORhUekb69zJS22fyuXbLA9vKmBaFsc+uV2P8ACw+2eGkgl9ewtnRfh
         wvPYYO16WHUmSmhRD6p8zZ06+MvmfWhCgahlN7aThVmqwYclKzkOVchJ6VeQDwaCRH0d
         8L5oWhY+0dheVIUYiXIIhLNUlNfUj2g6KwMnI1oE3WTf98/P66ZyP9g9lZ7s/UgeapBL
         OiYw==
X-Gm-Message-State: ANhLgQ2ciT6nrse8LCnJuoPsmxKHTf7eNcfRd0Aps7Tmjr6tPbxVmhiA
        IAXsOADcxdtykkFrgf55muhk6flOCvWRBq6YHq67JoNbWI4=
X-Google-Smtp-Source: ADFU+vvGrcGHLMgT08+auD/+5xwHPXAIqQWP/i8/08HZbHJFJtcPV9tQiVYENkLlYNuErjkO3WToMquoJEIUFcOKG+A=
X-Received: by 2002:ac8:7769:: with SMTP id h9mr3906340qtu.234.1585154741686;
 Wed, 25 Mar 2020 09:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
 <20200324182725.GG162390@mtj.duckdns.org> <CAA70yB7a7VjgPLObe-rzfV0dLAumeUVy0Dps+dY5r-Guq2Susg@mail.gmail.com>
 <20200325141236.GJ162390@mtj.duckdns.org>
In-Reply-To: <20200325141236.GJ162390@mtj.duckdns.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 26 Mar 2020 00:45:30 +0800
Message-ID: <CAA70yB5yH9H6-gaKfRSTmgd6vvzP4T9N7v-NAD0MsRL+YTexHw@mail.gmail.com>
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
=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 25, 2020 at 08:49:24PM +0800, Weiping Zhang wrote:
> > For this patchset, iotrack can work well, I'm using it to monitor
> > block cgroup for
> > selecting a proper io isolation policy.
>
> Yeah, I get that but monitoring needs tend to diverge quite a bit
> depending on the use cases making detailed monitoring often need fair
> bit of flexibility, so I'm a bit skeptical about adding a fixed
> controller for that. I think a better approach may be implementing
> features which can make dynamic monitoring whether that's through bpf,
> drgn or plain tracepoints easier and more efficient.
>
I agree with you, there are lots of io metrics needed in the real
production system.
The more flexible way is export all bio structure members of bio=E2=80=99s =
whole life to
the userspace without re-compiling kernel, like what bpf did.

Now the main block cgroup isolation policy:
 blk-iocost and bfq are weght based, blk-iolatency is latency based.
The blk-iotrack can track the real percentage for IOs,kB,on disk time(d2c),
and total time, it=E2=80=99s a good indicator to the real weight. For blk-i=
olatency, the
blk-iotrack has 8 lantency thresholds to show latency distribution, so if w=
e
change these thresholds around to blk-iolateny.target.latency, we can tune
the target latency to a more proper value.

blk-iotrack extends the basic io.stat. It just export the important
basic io statistics
for cgroup,like what /prof/diskstats for block device. And it=E2=80=99s eas=
y
programming,
iotrack just working like iostat, but focus on cgroup.

blk-iotrack is friendly with these block cgroup isolation policies, a
indicator for
cgroup weight and lantency.

Thanks
