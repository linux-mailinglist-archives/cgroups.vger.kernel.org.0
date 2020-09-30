Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323AF27EDB6
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgI3Ppk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 11:45:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39923 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3Ppj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Sep 2020 11:45:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id u25so2265450otq.6;
        Wed, 30 Sep 2020 08:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLYN4DZDwH7R2NlapAAUY3QJYvuRZTJWMNdqx5ssFgc=;
        b=pHRC04ZPwF+ycqsziBDV4z0AHCzDgwlRrVl9XwchuKO6Vol7KxmsXYiejfFqvk+hxp
         US1O+ajUpmqhW239Nf3CZ/1qoZqSpXkuHWecN3LKf9EdjM2JHEREJI9HnphxUTp/PRsW
         m0wCs2Nwj1H6A2Ko4N7LUabf7PAoPS4/d9mDrfq1bzV0YXMINd+x0xNGtU3XPGmn0Ktw
         9Qn2NKXr1xjuuwpzNFs4H2OjsqorAZvfs93GV7yqMEqJcYbh/zrszLFtPAg/lP4zm3JI
         NnkM3Dob/4SToCVrDduCj+MUnvmyhyYTbPdROebZ3MUSpvudplKrqFZ0Dj/sJbOTbdGn
         GRgw==
X-Gm-Message-State: AOAM5327ncUIFYaIjjZAwszeMNwHqTTjNqdcGCRC606CNj38HpPTNvVN
        Jd/MAnGpIcOYR0WCKnmUGANOXjppbCTaEdPaUcQ=
X-Google-Smtp-Source: ABdhPJzqXlb0zHSZaZNzwr5/qsG+1b1UNIBdXnbuu2s+WcgP8W4OEH88f8YoSjZZt44LtFCSSamxbIEldAz4zPwkqlw=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr1830532otp.167.1601480739002;
 Wed, 30 Sep 2020 08:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200925161447.1486883-1-hch@lst.de> <20200925161447.1486883-3-hch@lst.de>
In-Reply-To: <20200925161447.1486883-3-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Sep 2020 17:45:27 +0200
Message-ID: <CAJZ5v0h8TbOZ=seE8+OqFKTRxOYK25aTXDam7Lez0VR5qnkM3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM/hibernate: remove the bogus call to get_gendisk in software_resume
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Minho Ban <mhban@samsung.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 25, 2020 at 6:15 PM Christoph Hellwig <hch@lst.de> wrote:
>
> get_gendisk grabs a reference on the disk and file operation, so this
> code will leak both of them while having absolutely no use for the
> gendisk itself.
>
> This effectively reverts commit 2df83fa4bce421f
> ("PM / Hibernate: Use get_gendisk to verify partition if resume_file is integer format")
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/power/hibernate.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e7aa57fb2fdc33..7d0b99d2e69631 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -948,17 +948,6 @@ static int software_resume(void)
>
>         /* Check if the device is there */
>         swsusp_resume_device = name_to_dev_t(resume_file);
> -
> -       /*
> -        * name_to_dev_t is ineffective to verify parition if resume_file is in
> -        * integer format. (e.g. major:minor)
> -        */
> -       if (isdigit(resume_file[0]) && resume_wait) {
> -               int partno;
> -               while (!get_gendisk(swsusp_resume_device, &partno))
> -                       msleep(10);
> -       }
> -
>         if (!swsusp_resume_device) {
>                 /*
>                  * Some device discovery might still be in progress; we need
> --
> 2.28.0
>
