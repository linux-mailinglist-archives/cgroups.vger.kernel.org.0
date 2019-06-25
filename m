Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3FE55298
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2019 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfFYOzW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jun 2019 10:55:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44223 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfFYOzV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jun 2019 10:55:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so18217580wrl.11;
        Tue, 25 Jun 2019 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nQl+kry098BAN4ziHwHdwhs+dskL6lReHJUDAXsmPwM=;
        b=d8kFT8Uefh9+6U+HQxiWM6eBbwSmgwiJDtX31TzyClbisj7GCdOkXoDPDoUEkghrJV
         gpG+dPSFaMwHFAVoh+lsnYJutX2SijP5xJs4s/tNgJ6IWEg/wFdyhLBYVzpR8LtoNdiu
         mjnv4MYLek7bg1cdUoGvGDrhMY+Yn6YpbA/HyZjSPA7pJT6rBo9FC7XhTvvcq/8N9rnt
         0/PP+PAVc/QicS8Vet7YQBzhf7ikc9+MoRqVoiIcnY8zJCnVbKnkoEl9k6UpuoAhFWDW
         UletLRN3Omc8qy9UTXp0WTmUdy3XNXG4WHVpJvwsU+KeA/3OsMb4l2J69GRAjEIta3HG
         qbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nQl+kry098BAN4ziHwHdwhs+dskL6lReHJUDAXsmPwM=;
        b=EO2E9hUalgjBYhEQSldRcV3NLAH+2WZ4FgkR2ErRMxr3PbxwWTphKlOjz/uNybfS9X
         8l0woBBxD62glHW30qzIQahxkIT6Ngz3vL7hVg/oCl0LuY8TrKQI0KqSGiC1uiy1b7b8
         gt1+OctRKue3bzQD8evBkXIQkhjYQvNND2c7CgqA9G8QPmVAlWcxacOVn0l9oht2ne+N
         DsN1ClU5MsZKBYE3wzD4xu6rwy+82G0yXslSbpfOgm5Q1vht1Zt6mvYOgJq8WBVcLLfL
         c7OqggHgPGVxcoic3hmrBLCYZLEW3WyFH3Abar94L2Sh875hvd3bAyozUW8vAjeRpkhD
         7yJA==
X-Gm-Message-State: APjAAAWExLnC5ABxtUi5KOl51l8uCCxl7NTmFH3twGuP2+IszA5ffsw0
        X5qo8p/aH5RY+y86Ngr9ZwyhWUq/vTsJOiGLHqw=
X-Google-Smtp-Source: APXvYqxrlHSWu1Sck5rxhiHDWTpobNGP630f6OXNYuENXzSYApE9EChSGqtoEftG3W1tObIPS5KaGNsMVyxeVqmItcI=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr38064132wrn.160.1561474519785;
 Tue, 25 Jun 2019 07:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
 <alpine.DEB.2.21.1906241740320.32342@nanos.tec.linutronix.de>
 <20190625021411.GD23777@ming.t460p> <alpine.DEB.2.21.1906250811150.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906250811150.32342@nanos.tec.linutronix.de>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 25 Jun 2019 22:55:10 +0800
Message-ID: <CAA70yB7xNf14-Ex1zq3mbBm_EEtLspmDDYBjOXibrMZS8r7ODQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous
 affinity set
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, keith.busch@intel.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2019=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:36=E5=86=99=E9=81=93=EF=BC=9A
>
> MIng,
>
> On Tue, 25 Jun 2019, Ming Lei wrote:
> > On Mon, Jun 24, 2019 at 05:42:39PM +0200, Thomas Gleixner wrote:
> > > On Mon, 24 Jun 2019, Weiping Zhang wrote:
> > >
> > > > The driver may implement multiple affinity set, and some of
> > > > are empty, for this case we just skip them.
> > >
> > > Why? What's the point of creating empty sets? Just because is not a r=
eal
> > > good justification.
> >
> > Patch 5 will add 4 new sets for supporting NVMe's weighted round robin
> > arbitration. It can be a headache to manage so many irq sets(now the to=
tal
> > sets can become 6) dynamically since size of anyone in the new 4 sets c=
an
> > be zero, so each particular set is assigned one static index for avoidi=
ng
> > the management trouble, then empty set will be seen by
> > irq_create_affinity_masks().
> >
> > So looks skipping the empty set makes sense because the API will become
> > easier to use than before.
>
Hello Ming,
Thanks your detail explanation.

> That makes sense, but at least some of that information wants to be in th=
e
> change log and not some uninformative description of what the patch does.
>
> I was not Cc'ed on the rest of the patches so I had exactly zero context.
>
Hello Thomas,

I am sorry I didn't cc you the full patchset, I will add more detail
description in
commit message at V4.

> Thanks,
>
>         tglx
