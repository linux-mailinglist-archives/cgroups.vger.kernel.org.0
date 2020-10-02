Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10F2814B7
	for <lists+cgroups@lfdr.de>; Fri,  2 Oct 2020 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbgJBOLo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Oct 2020 10:11:44 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:44754 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBOLo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Oct 2020 10:11:44 -0400
Received: by mail-oo1-f66.google.com with SMTP id 4so360331ooh.11;
        Fri, 02 Oct 2020 07:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gesR1T7BjDx7faU3zrJze9mnQNTvk17XfofPixkh6R8=;
        b=QW8OOsrdMU3X1mmWnuPD1RPNM1RSkCRFqhJD//qTq0SyAXJ8Hhumtw9ErobE+i4eWC
         LLflRUs+NkycEgZ/Y3iKa0ck8w4Rb6lJdE02LhBgnsT4QSNvoZKXP/QZ1gcwAsR/TlEG
         tOxO6YhLUzMfORdHGvhk1wh0E/zvj/7TslSF4XqgArrcH3xA+t4gGPuxUCoH4Wa/bkYL
         kqMHSCYtmuH9Ez/5S9GwIa9zetXLPUH2HDk01ycfQmP5flKFrAIfvd/Mi416jAvzANFk
         cdlLSq7v+JDhxEcjyvJbNsz7lcXxUcE4kgKJnAgRHkxhCTmJA6CaNNK2X5+wJU7zwLL/
         lQUA==
X-Gm-Message-State: AOAM530vxyF1ujhCm9/hqMFKRGSLG1OakTCfiOxPvKJIv5ck1wLU8S5N
        eMb+5baVWyUhZTLcI2N/vGWd7hZraP4qxSeqtxdD2B2M
X-Google-Smtp-Source: ABdhPJyOChhrOxMlaFI5j/v7n2WWIa9JJ6DsWupxqoyuqq9cx0MDNFvfbr/1n5VWiIB1HK6C3AQJgvKcYqwj5k3CjaE=
X-Received: by 2002:a4a:e946:: with SMTP id v6mr2068079ood.38.1601647903052;
 Fri, 02 Oct 2020 07:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200925161447.1486883-1-hch@lst.de> <20200925161447.1486883-3-hch@lst.de>
 <CAJZ5v0h8TbOZ=seE8+OqFKTRxOYK25aTXDam7Lez0VR5qnkM3Q@mail.gmail.com> <20201002065015.GA9691@lst.de>
In-Reply-To: <20201002065015.GA9691@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 16:11:30 +0200
Message-ID: <CAJZ5v0hN7S0Tg8UTQCTLSsZw-n+9pHQBjvscWcBC4gpA5jPCuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM/hibernate: remove the bogus call to get_gendisk in software_resume
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
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

On Fri, Oct 2, 2020 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 30, 2020 at 05:45:27PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Sep 25, 2020 at 6:15 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > get_gendisk grabs a reference on the disk and file operation, so this
> > > code will leak both of them while having absolutely no use for the
> > > gendisk itself.
> > >
> > > This effectively reverts commit 2df83fa4bce421f
> > > ("PM / Hibernate: Use get_gendisk to verify partition if resume_file is integer format")
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Can you pick it up through the PM tree?  The big rework in this area
> I have planned won't land before 5.11 anyway.

Will do, thanks!
