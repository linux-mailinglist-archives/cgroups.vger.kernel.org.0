Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB60280DA6
	for <lists+cgroups@lfdr.de>; Fri,  2 Oct 2020 08:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgJBGuT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Oct 2020 02:50:19 -0400
Received: from verein.lst.de ([213.95.11.211]:51231 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgJBGuS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Oct 2020 02:50:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C736F68B02; Fri,  2 Oct 2020 08:50:15 +0200 (CEST)
Date:   Fri, 2 Oct 2020 08:50:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Minho Ban <mhban@samsung.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] PM/hibernate: remove the bogus call to get_gendisk
 in software_resume
Message-ID: <20201002065015.GA9691@lst.de>
References: <20200925161447.1486883-1-hch@lst.de> <20200925161447.1486883-3-hch@lst.de> <CAJZ5v0h8TbOZ=seE8+OqFKTRxOYK25aTXDam7Lez0VR5qnkM3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h8TbOZ=seE8+OqFKTRxOYK25aTXDam7Lez0VR5qnkM3Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 30, 2020 at 05:45:27PM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 25, 2020 at 6:15 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > get_gendisk grabs a reference on the disk and file operation, so this
> > code will leak both of them while having absolutely no use for the
> > gendisk itself.
> >
> > This effectively reverts commit 2df83fa4bce421f
> > ("PM / Hibernate: Use get_gendisk to verify partition if resume_file is integer format")
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Can you pick it up through the PM tree?  The big rework in this area
I have planned won't land before 5.11 anyway.
