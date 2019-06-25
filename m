Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B760552DF
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2019 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfFYPGs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jun 2019 11:06:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46876 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbfFYPGs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jun 2019 11:06:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so18249297wrw.13;
        Tue, 25 Jun 2019 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xByavRLEp3hyk80ImZC5g4m0uX3mEmi564FcqH3YV+4=;
        b=tlWS7Yz/W15rn9kS5pEmeU24xPWl3dLfYtvp0mWhQmAot8015j2JyJ/BEdnE4UNHlv
         dIjyCMwhJ8L3mcIvAHiKRA8PKFd7DqHm4KlizLrT2LQcxldjvoTtJ0LoeYTlNehrD9is
         3YcdhDBFkWdNmtO1hAIcYdnPq4a0M0qpdAubTA6Hv2IExWUMY6lwq52+nq3CsDBvo2tw
         z+AnGfkN22D9VSkDEBEAtP1elKGsS1EL8YSBSrw4wa1cfXJDtdsvNKoa82YrAgyBM6yd
         4GlpdNjhb0atXlInpT7sbEKiSw4ME7wvNL7wncCy87+gTfKAb+1UjkaJIDZjd1Z4xkW5
         UnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xByavRLEp3hyk80ImZC5g4m0uX3mEmi564FcqH3YV+4=;
        b=FMdpVc/snzCM8dZ9IxNINOqmnc8eW1UYdfAmnUUOQYhbUHc6OPal3wHp5Q5FvGLuHm
         4ZkO1mzunYQgu7qaUIyru/4DPCLO1DW8RxUqDs0hj6V8Z69ZDSY8KIuV7zuAtEbdIRzB
         pp5gShxI6xblsUfbI1UgAqjv+sB5Kb3MeRqiMuSBHXktDWlzJfxdR88lmToaMI3c3rXe
         IUfjlew/+GP9/XyjXgI9K15Hn+rmvIO8KndcNo+xu0pNfx2LUt8hAdyp1/7ucR/qZ7t7
         SpS4onUOBYlUOHlnptLDZCZng7Pv/+qMa/YDZJfucneGFFzUXm+HmdchIBUaUfSYEpfL
         35Iw==
X-Gm-Message-State: APjAAAUloA7IpphoN5t9DwaOBH0O7OLnagPsM1GoH4HK01ZfPvty6s5R
        GMFk6Y7eP+4K6sISEjCnslWdK802ixqmgWIBY+E=
X-Google-Smtp-Source: APXvYqySP4F5Gxe4WqMw/8I6UbqzE8WfAQHLiEoyP8KIfDZ7Te8L72vf7YDad41QFdhXdBq0u6l1+OAqGSVMoHAdb7I=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr38109440wrn.160.1561475206440;
 Tue, 25 Jun 2019 08:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
 <20190624202110.GD6526@minwooim-desktop>
In-Reply-To: <20190624202110.GD6526@minwooim-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 25 Jun 2019 23:06:36 +0800
Message-ID: <CAA70yB4Japiic4wAG=5ud8LrS2E-SaKxeV8yqG6j0pMCFTWjNQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] nvme: add support weighted round robin queue
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, keith.busch@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Minwoo Im <minwoo.im.dev@gmail.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:01=E5=86=99=E9=81=93=EF=BC=9A
>
> > @@ -2627,7 +2752,30 @@ static int nvme_pci_get_address(struct nvme_ctrl=
 *ctrl, char *buf, int size)
> >
> >  static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
> >  {
> > -     *ams =3D NVME_CC_AMS_RR;
> > +     /* if deivce doesn't support WRR, force reset wrr queues to 0 */
> > +     if (!NVME_CAP_AMS_WRRU(ctrl->cap)) {
> > +             wrr_low_queues =3D 0;
> > +             wrr_medium_queues =3D 0;
> > +             wrr_high_queues =3D 0;
> > +             wrr_urgent_queues =3D 0;
>
> Could we avoid this kind of reset variables in get_XXX() function?  I
> guess it would be great if it just tries to get some value which is
> mainly focused to do.

I think its ok, when we use these variables in nvme_setup_irqs,
we can check ctrl->wrr_enabled, if it was false, skip all wrr_xxx_queues.
In other words, if ctrl->wrr_enabled is true, at least we have one wrr queu=
e.

>
> > +
> > +             *ams =3D NVME_CC_AMS_RR;
> > +             ctrl->wrr_enabled =3D false;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * if device support WRR, check wrr queue count, all wrr queues a=
re
> > +      * 0, don't enable device's WRR.
> > +      */
> > +     if ((wrr_low_queues + wrr_medium_queues + wrr_high_queues +
> > +                             wrr_urgent_queues) > 0) {
> > +             *ams =3D NVME_CC_AMS_WRRU;
> > +             ctrl->wrr_enabled =3D true;
> > +     } else {
> > +             *ams =3D NVME_CC_AMS_RR;
> > +             ctrl->wrr_enabled =3D false;
>
> These two line can be merged into above condition:
It's ok, and merge comments for NVME_CC_AMS_RR.
>
>         if (!NVME_CAP_AMS_WRRU(ctrl->cap) ||
>                 wrr_low_queues + wrr_medium_queues + wrr_high_queues +
>                         wrr_urgent_queues <=3D 0) {
>                 *ams =3D NVME_CC_AMS_RR;
>                 ctrl->wrr_enabled =3D false;
>         }
