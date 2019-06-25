Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB20F55267
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2019 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfFYOqO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jun 2019 10:46:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37241 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfFYOqN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jun 2019 10:46:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so18220191wrr.4;
        Tue, 25 Jun 2019 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ipnuQjfciWwK+BlZByf58DzZNa4gsBdZOo7ikTtTIMw=;
        b=FSRqdLvBdvronyCtpim5+l9E+h9a9vaas0wXpS0TXqQvpKV+tBzkIeVppWJ/Jww0fn
         UcJPSoJK5bcQ6TFJiO2NgGPgt81Ly1TuLFfnbKtoePZqSRK/Rt81qIz7Kf52qQbOpDsO
         82ex+zUyd/8q/qugljWolTkDe8ERUoMneY4cJgKNxtLnkZe+GdwKWfdLg1sQknuKgfht
         /KxS1Eh656itKwqwO/h0Q3WXxJ6YkPTyfn5niu3fjGrwHsvHnl7gfCAMuwU36qS7Gter
         UvO/1zktR9wVDB9RqtpUdQC8oAf6EwB0QhWwfQ/KkWOP85Je4no2nABspNSTJ5iQzNkP
         n5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ipnuQjfciWwK+BlZByf58DzZNa4gsBdZOo7ikTtTIMw=;
        b=QYpLdwikmVHI02RI8G0BMlNOI8+TKBA9BjH3vUr4Ll8WmdaDsxaCHWGr2PYNWpIDlF
         sx18EC4FIqsb/Phg9PyPk5oN4Sj7emb7kIvoQpyV4bQr6mj8DxGVENr7BjW+AYpvjARL
         BvC/Es1qilyYUTFdJjf77iNr3HoBhwPAmQliAN19Fak1/IJXmGWin6BaIO3ASOsl1nHo
         Mapl/5r4SkBMb3DwqkuigdrNGsNwaCwqDLKyJX3IEe0vuNTAKECP8AcQ94U1pq1dVl9y
         9q/6KXKPQOrKtJWzQ7LdQimI8/p5cflSEW+LqgZ+5/jmcOVjh5kYijeVlLp4dRc3Gyv/
         x47A==
X-Gm-Message-State: APjAAAVbF0sgMaK+LXEgGSg6aDQOqCkViP4/iZY+uXJQx3GWEAAcR9QH
        6qnkgpFHAZVIMWDT9rZpNtdjWxclulPpDi3Getk=
X-Google-Smtp-Source: APXvYqw2nuRw92OheWpoWIH6glD26zC5vmhdXMTFaa0upqvAZHH25TgIqQkPbSlXWmi/dQZ+48fNAUkAsIxVt73ySP8=
X-Received: by 2002:adf:ea45:: with SMTP id j5mr21971894wrn.281.1561473970978;
 Tue, 25 Jun 2019 07:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <2c916063e19cc3f33376d7bb0fb8a5ff10ea42db.1561385989.git.zhangweiping@didiglobal.com>
 <20190624201256.GC6526@minwooim-desktop>
In-Reply-To: <20190624201256.GC6526@minwooim-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 25 Jun 2019 22:46:02 +0800
Message-ID: <CAA70yB4DJdN8qJAMs7D3tzHxrsHofB65pTzk5mn8UY=1aKWyZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] nvme: add get_ams for nvme_ctrl_ops
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
> On 19-06-24 22:29:05, Weiping Zhang wrote:
> > The get_ams() will return the AMS(Arbitration Mechanism Selected)
> > from the driver.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
>
> Hello, Weiping.
>
> Sorry, but I don't really get what your point is here.  Could you please
> elaborate this patch a little bit more?  The commit description just
> says a function would just return the AMS from nowhere..
>
I will add more detail description for this operation in commit message,
when we enable nvme controller, we need to know the correct AMS setting.

 There two cases for NVME_CC_AMS_RR:
1. nvme controller doesn't support AMS, now we set ams to NVME_CC_AMS_RR.
2. nvme controller support AMS, but the user did not want to enable
it, for example
set all wrr_xxx_queue to 0.

We only set ams to NVME_CC_AMS_WRRU if nvme controller support WRR and
the user want to enable it explictly.

nvme_enable_ctrl is a common function for nvme-pci, nvme-rdma, nvme-tcp,
it needs to konw the correct AMS setting from different nvme driver by
this operation.

> > ---
> >  drivers/nvme/host/core.c | 9 ++++++++-
> >  drivers/nvme/host/nvme.h | 1 +
> >  drivers/nvme/host/pci.c  | 6 ++++++
> >  include/linux/nvme.h     | 1 +
> >  4 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index b2dd4e391f5c..4cb781e73123 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1943,6 +1943,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 =
cap)
> >        */
> >       unsigned dev_page_min =3D NVME_CAP_MPSMIN(cap) + 12, page_shift =
=3D 12;
> >       int ret;
> > +     u32 ams =3D NVME_CC_AMS_RR;
> >
> >       if (page_shift < dev_page_min) {
> >               dev_err(ctrl->device,
> > @@ -1951,11 +1952,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u6=
4 cap)
> >               return -ENODEV;
> >       }
> >
> > +     /* get Arbitration Mechanism Selected */
> > +     if (ctrl->ops->get_ams) {
>
> I just wonder if this check will be valid because this patch just
> register the function nvme_pci_get_ams() without any conditions.
The nvme-pci, nvme-rdma,, should make sure that the ams is valid,
for example check CAP.AMS and other conditions.
>
> > +             ctrl->ops->get_ams(ctrl, &ams);
> > +             ams &=3D NVME_CC_AMS_MASK;
> > +     }
> > +
> >       ctrl->page_size =3D 1 << page_shift;
> >
> >       ctrl->ctrl_config =3D NVME_CC_CSS_NVM;
> >       ctrl->ctrl_config |=3D (page_shift - 12) << NVME_CC_MPS_SHIFT;
> > -     ctrl->ctrl_config |=3D NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
> > +     ctrl->ctrl_config |=3D ams | NVME_CC_SHN_NONE;
> >       ctrl->ctrl_config |=3D NVME_CC_IOSQES | NVME_CC_IOCQES;
> >       ctrl->ctrl_config |=3D NVME_CC_ENABLE;
> >
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index ea45d7d393ad..9c7e9217f78b 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -369,6 +369,7 @@ struct nvme_ctrl_ops {
> >       void (*submit_async_event)(struct nvme_ctrl *ctrl);
> >       void (*delete_ctrl)(struct nvme_ctrl *ctrl);
> >       int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> > +     void (*get_ams)(struct nvme_ctrl *ctrl, u32 *ams);
>
> Can we just have a return value for the AMS value?
Both these two methods are acceptable to me.
>
> >  };
> >
> >  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 189352081994..5d84241f0214 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2627,6 +2627,11 @@ static int nvme_pci_get_address(struct nvme_ctrl=
 *ctrl, char *buf, int size)
> >       return snprintf(buf, size, "%s", dev_name(&pdev->dev));
> >  }
> >
> > +static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
> > +{
> > +     *ams =3D NVME_CC_AMS_RR;
> > +}
> > +
> >  static const struct nvme_ctrl_ops nvme_pci_ctrl_ops =3D {
> >       .name                   =3D "pcie",
> >       .module                 =3D THIS_MODULE,
> > @@ -2638,6 +2643,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_o=
ps =3D {
> >       .free_ctrl              =3D nvme_pci_free_ctrl,
> >       .submit_async_event     =3D nvme_pci_submit_async_event,
> >       .get_address            =3D nvme_pci_get_address,
> > +     .get_ams                =3D nvme_pci_get_ams,
>
> Question: Do we really need this being added to nvme_ctrl_ops?
>
> Also If 5th patch will make this function much more than this, then it
> would be great if you describe this kind of situation in description :)
>
> >  };
> >
> >  static int nvme_dev_map(struct nvme_dev *dev)
> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index da5f696aec00..8f71451fc2fa 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -156,6 +156,7 @@ enum {
> >       NVME_CC_AMS_RR          =3D 0 << NVME_CC_AMS_SHIFT,
> >       NVME_CC_AMS_WRRU        =3D 1 << NVME_CC_AMS_SHIFT,
> >       NVME_CC_AMS_VS          =3D 7 << NVME_CC_AMS_SHIFT,
> > +     NVME_CC_AMS_MASK        =3D 7 << NVME_CC_AMS_SHIFT,
> >       NVME_CC_SHN_NONE        =3D 0 << NVME_CC_SHN_SHIFT,
> >       NVME_CC_SHN_NORMAL      =3D 1 << NVME_CC_SHN_SHIFT,
> >       NVME_CC_SHN_ABRUPT      =3D 2 << NVME_CC_SHN_SHIFT,
> > --
> > 2.14.1
> >
