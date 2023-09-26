Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DCD7AE964
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjIZJis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjIZJiq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 05:38:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96EF3;
        Tue, 26 Sep 2023 02:38:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B018168AA6; Tue, 26 Sep 2023 11:38:34 +0200 (CEST)
Date:   Tue, 26 Sep 2023 11:38:34 +0200
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
Message-ID: <20230926093834.GB13806@lst.de>
References: <20230913111013.77623-1-hch@lst.de> <20230913111013.77623-4-hch@lst.de> <20230913232712.GC800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913232712.GC800259@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 12:27:12AM +0100, Al Viro wrote:
> On Wed, Sep 13, 2023 at 08:09:57AM -0300, Christoph Hellwig wrote:
> > Releasing an anon dev_t is a very common thing when freeing a
> > super_block, as that's done for basically any not block based file
> > system (modulo the odd mtd special case).  So instead of requiring
> > a special ->kill_sb helper and a lot of boilerplate in more complicated
> > file systems, just release the anon dev_t in deactivate_locked_super if
> > the super_block was using one.
> > 
> > As the freeing is done after the main call to kill_super_notify, this
> > removes the need for having two slightly different call sites for it.
> 
> Huh?  At this stage in your series freeing is still in ->kill_sb()
> instances, after the calls of kill_anon_super() you've turned into
> the calls of generic_shutdown_super().

The above refers to freeing the anon dev_t, which at this stage is done
right after the kill_super_notify in generic_shutdown_super.

> You do split it off into a separate method later in the series, but
> at this point you are reopening the same UAF that had been dealt with
> in dc3216b14160 "super: ensure valid info".

How?

Old sequence before his patch:

	deactivate_locked_super()
	  -> kill_anon_super()
	    -> generic_shutdown_super()
	    -> kill_super_notify()
	    -> free_anon_bdev()
	  -> kill_super_notify()

New sequence with this patch:

	deactivate_locked_super()
	  -> generic_shutdown_super()
	    -> kill_super_notify()
	    -> free_anon_bdev()

