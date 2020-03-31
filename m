Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D6199A28
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgCaPry (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 11:47:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40985 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPry (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 11:47:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so18680835qtv.8;
        Tue, 31 Mar 2020 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+cb3bISW4bZmT92F1j7Pnq/uvLuSPQAD/l0XluG3es=;
        b=CZ/zV+JpODQPLEkTvr5bV1RtBpJRe9fHt7rTi1ZlaBgKVi9+wGb7JWDMSyVv0LFEsD
         o7PNPQNrt5OdGEe2WyyKKey7Y+vGvDbN3ZH4ABhpa4VnHcXwOIxT7GUBNx/KZLCkmWEk
         lrVuQgPUpgsHRfGXRvtQO3g0TW5D0OAiH81tJGPLzmcM0WGR4NBc/+UWiH2Z1VKmj6Gp
         mUinuOWxNArJRaIiJVjAmIbvhJuf9+2XxQZh8Bx8SBloKhJWEPzEszXl58bmi8CifTLw
         nT3J0bmpXMxgKhC6fTOKnt6huiA+8g/NT10Ysn2FSkTRzgZBVwIgHoorZyCh5XjndMoQ
         EmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+cb3bISW4bZmT92F1j7Pnq/uvLuSPQAD/l0XluG3es=;
        b=bnvLL4zLzmTWj2wEelTUM0jQvjTMNWA3KKP5sI+4aXODXwLJuTL6Zhrt2qRVuzn22n
         ypxeVzoNkadvzPlGnmpBV9cKlsL6uYj0/T0cL0JS6UnZTNm2W9zlU/cQ+D1BnzNx9v3j
         UMuAGJUZsS5EL6KxvGtDhhLpzSMrpgjgvwhGtErTDlJzlKK7lv+oIOULX7lY61OHS5w/
         TYmS4W9+gf3icDJotsm/2GBJFwOChyM2x3/zX78m63YC9/cvt/ZOa36mZLl1IGotGmll
         fVe2PGjWDNbXBCXtMxPmR0uHECjdEVwtkPkRFS8Pd0j3C2VlxXjmij/Mun1fuQvrVIkH
         F6tA==
X-Gm-Message-State: ANhLgQ35zGSctUMPYbdCBLvHGBrPnZphncq883aFlI509lOO+8RoYpDq
        Ol1d8NSN28dL5IqQgmIYyYcTbrTAf7o9xOM44jY=
X-Google-Smtp-Source: ADFU+vueFmwtyA1v+7pm/DjQa8uSCIHLcdiNP3fePAGUXFX+W1vqv3fkaAD0xsN2YQXUI2KJCFntt5b47zvPrwXIakg=
X-Received: by 2002:ac8:18c3:: with SMTP id o3mr5923041qtk.49.1585669672947;
 Tue, 31 Mar 2020 08:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com> <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com> <20200331143635.GS162390@mtj.duckdns.org>
In-Reply-To: <20200331143635.GS162390@mtj.duckdns.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 31 Mar 2020 23:47:41 +0800
Message-ID: <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
To:     Tejun Heo <tj@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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

Tejun Heo <tj@kernel.org> =E4=BA=8E2020=E5=B9=B43=E6=9C=8831=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello, Weiping.
>
> On Tue, Mar 31, 2020 at 02:17:06PM +0800, Weiping Zhang wrote:
> > Recently I do some cgroup io weight testing,
> > https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test
> > I think a proper io weight policy
> > should consider high weight cgroup's iops, latency and also take whole
> > disk's throughput
> > into account, that is to say, the policy should do more carfully trade
> > off between cgroup's
> > IO performance and whole disk's throughput. I know one policy cannot
> > do all things perfectly,
> > but from the test result nvme-wrr can work well.
>
> That's w/o iocost QoS targets configured, right? iocost should be able to
> achieve similar results as wrr with QoS configured.
>
Yes, I have not set Qos target.
> > From the following test result, nvme-wrr work well for both cgroup's
> > latency, iops, and whole
> > disk's throughput.
>
> As I wrote before, the issues I see with wrr are the followings.
>
> * Hardware dependent. Some will work ok or even fantastic. Many others wi=
ll do
>   horribly.
>
> * Lack of configuration granularity. We can't configure it granular enoug=
h to
>   serve hierarchical configuration.
>
> * Likely not a huge problem with the deep QD of nvmes but lack of queue d=
epth
>   control can lead to loss of latency control and thus loss of protection=
 for
>   low concurrency workloads when pitched against workloads which can satu=
rate
>   QD.
>
> All that said, given the feature is available, I don't see any reason to =
not
> allow to use it, but I don't think it fits the cgroup interface model giv=
en the
> hardware dependency and coarse granularity. For these cases, I think the =
right
> thing to do is using cgroups to provide tagging information - ie. build a
> dedicated interface which takes cgroup fd or ino as the tag and associate
> configurations that way. There already are other use cases which use cgro=
up this
> way (e.g. perf).
>
Do you means drop the "io.wrr" or "blkio.wrr" in cgroup, and use a
dedicated interface
like /dev/xxx or /proc/xxx?

I see the perf code:
struct fd f =3D fdget(fd)
struct cgroup_subsys_state *css =3D
css_tryget_online_from_dir(f.file->f_path.dentry,
        &perf_event_cgrp_subsys);

Looks can be applied to block cgroup in same way.

Thanks your help.
