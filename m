Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D277B7CCC99
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbjJQTvL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjJQTvK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 15:51:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282CBF0;
        Tue, 17 Oct 2023 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GNBVHxO35CtDJJ50FQl58Qlyu6FwrHZDEfJe+KyOfnA=; b=TOLZFA3ZsXFSoHiXsJUWtNefxf
        /7Ldgtep1APqXhU3Pnqp43XUP8SdedLg/FnZnEa23b65yJg1PfwulbjHBUlUTaUICa4TsIf6p6dZf
        zVGDN0pNEzmeQFLKd0mQN/u8ANpEZVs+GsafaCNfu8XON4VcC/6GlURdiGwVltij/6p+JrNRqP66N
        Ot4MY5I81RTajeTMxvIckOEqNf94el+KrpwOPumLy5wVHCrvO8B0HZ3w2LxgTiCZRNCYrPdYECmdl
        yJtunmqBT9I9ddYUnyIH+5Bp6kTy7ZaMtLmUkYG7kqdRIIJ3hUHRbCCF97ijTRlTKUnW46xBK+4nq
        +sYDDQ4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qsq5R-0027ua-2y;
        Tue, 17 Oct 2023 19:50:42 +0000
Date:   Tue, 17 Oct 2023 20:50:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Heiko Carstens <hca@linux.ibm.com>,
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
Message-ID: <20231017195041.GQ800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230926093834.GB13806@lst.de>
 <20230926212515.GN800259@ZenIV>
 <20231002064646.GA1799@lst.de>
 <20231009215754.GL800259@ZenIV>
 <20231010-zulagen-bisschen-9657746c1fc0@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-zulagen-bisschen-9657746c1fc0@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 10:44:09AM +0200, Christian Brauner wrote:
> > list removal should happen after generic_shutdown_super().  Sure, you
> > want the superblock to serve as bdev holder, which leads to fun
> > with -EBUSY if mount comes while umount still hadn't closed the
> > device.  I suspect that it would make a lot more sense to
> > introduce an intermediate state - "held, but will be released
> > in a short while".  You already have something similar, but
> > only for the entire disk ->bd_claiming stuff.
> > 
> > Add a new primitive (will_release_bdev()), so that attempts to
> > claim the sucker will wait until it gets released instead of
> > failing with -EBUSY.  And do *that* before generic_shutdown_super()
> > when unmounting something that is block-based.  Allows to bring
> > the list removal back where it used to be, no UAF at all...
> 
> This is essentially equivalent to what is done right now. Only that this
> would then happen in the block layer. I'm not sure it would buy us that
> much. In all likelyhood we just get a range of other issues to fix.

The difference is, we separate the "close the block device" (which
can't be done until we stopped generating any IO on it, obviously)
from "tell anyone who wants to claim the sucker that we are going
to release it and they just need to wait".  That can be done before
generic_shutdown_super(), or from it (e.g. from ->put_super()),
untangling the ordering mess.
