Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007FE2799F2
	for <lists+cgroups@lfdr.de>; Sat, 26 Sep 2020 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZOFa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 26 Sep 2020 10:05:30 -0400
Received: from verein.lst.de ([213.95.11.211]:59235 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZOFa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 26 Sep 2020 10:05:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2008168AFE; Sat, 26 Sep 2020 16:05:27 +0200 (CEST)
Date:   Sat, 26 Sep 2020 16:05:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Minho Ban <mhban@samsung.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] PM/hibernate: remove the bogus call to get_gendisk
 in software_resume
Message-ID: <20200926140526.GA10379@lst.de>
References: <20200925161447.1486883-1-hch@lst.de> <20200925161447.1486883-3-hch@lst.de> <20200925183828.GC7253@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925183828.GC7253@duo.ucw.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 25, 2020 at 08:38:28PM +0200, Pavel Machek wrote:
> > -	 * name_to_dev_t is ineffective to verify parition if resume_file is in
> > -	 * integer format. (e.g. major:minor)
> > -	 */
> > -	if (isdigit(resume_file[0]) && resume_wait) {
> > -		int partno;
> > -		while (!get_gendisk(swsusp_resume_device, &partno))
> > -			msleep(10);
> > -	}
> 
> I believe point of this code was to wait for resume device to appear
> -- see the resume_wait condition. It should not be simply removed.

But get_gendisk has absolutely no relation to a device appearing.  So
whatever this code tried to do doesn't make any sense.
