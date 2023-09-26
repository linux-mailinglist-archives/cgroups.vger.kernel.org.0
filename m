Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E57AE976
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjIZJlm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjIZJll (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 05:41:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF4B3;
        Tue, 26 Sep 2023 02:41:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DEB6468AA6; Tue, 26 Sep 2023 11:41:30 +0200 (CEST)
Date:   Tue, 26 Sep 2023 11:41:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 03/19] fs: release anon dev_t in deactivate_locked_super
Message-ID: <20230926094130.GC13806@lst.de>
References: <20230913111013.77623-1-hch@lst.de> <20230913111013.77623-4-hch@lst.de> <20230913232712.GC800259@ZenIV> <20230914023705.GH800259@ZenIV> <20230914053843.GI800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914053843.GI800259@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 06:38:43AM +0100, Al Viro wrote:
> It's worse - look at the rationale for 2c18a63b760a "super: wait until
> we passed kill super".  Basically, "don't remove from the lists
> until after block device closing".  IOW, we have

As of this stage we don't even touch anything related to block devices..

> That was *NOT* what a recent rework had done.  Block device closing had never
> been inside ->put_super() - at no point since that (closing, that is) had been
> introduced back in 0.97 ;-)  ->put_super() predates it (0.95c+).
> 
> The race is real, but the cause is not some kind of move of blkdev_put().
> Your 2ea6f68932f7 "fs: use the super_block as holder when mounting file
> systems" is where it actually came from.
> 
> Christoph, could you explain what the hell do we need that for?  It does
> create the race in question and AFAICS 2c18a63b760a (and followups trying
> to plug holes in it) had been nothing but headache.

Because it allows us to actually get from the bdev to the holder directly,
someting we've badly neeed for a while.
