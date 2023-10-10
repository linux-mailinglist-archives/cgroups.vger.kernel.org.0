Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173187BF654
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjJJIo0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjJJIoT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 04:44:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439BB6;
        Tue, 10 Oct 2023 01:44:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE21CC433CA;
        Tue, 10 Oct 2023 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696927457;
        bh=AklOIwjkDmHZ1qM9UpDtEjm30BDgtD6wXE6WJ8v7kog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7lOH156oFDWcy0YvnnmfIKiP+AA04u9jmSgZxeP9pFQRuB0xFOH6pNBpaqYfXqXp
         3mRaPYMrIgET9ngpczaZP0eVoEh95kzdTZCqkxCAPKxJ3wVR6Hnp+M54eurWuP+0M7
         wI8veqWTWaeqQcFbsSYLer/c5CfeMXYbxgK5GftSIl81sle/8orkomjomDP87716vQ
         AFyueGH7t8whd7YDB0EZIy3ggPZhJ4A6fI5v7mN/OpVjaq0V0yxfi4XHPHkIhAnYPx
         QNcZ4vokyqRLryzgaVzAPFzsRGCqCgub/0GMZWBX6BEbdxvLT75NoesRd06HwSJNdg
         Dly9CwNw/fNSw==
Date:   Tue, 10 Oct 2023 10:44:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
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
Message-ID: <20231010-zulagen-bisschen-9657746c1fc0@brauner>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230926093834.GB13806@lst.de>
 <20230926212515.GN800259@ZenIV>
 <20231002064646.GA1799@lst.de>
 <20231009215754.GL800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009215754.GL800259@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> list removal should happen after generic_shutdown_super().  Sure, you
> want the superblock to serve as bdev holder, which leads to fun
> with -EBUSY if mount comes while umount still hadn't closed the
> device.  I suspect that it would make a lot more sense to
> introduce an intermediate state - "held, but will be released
> in a short while".  You already have something similar, but
> only for the entire disk ->bd_claiming stuff.
> 
> Add a new primitive (will_release_bdev()), so that attempts to
> claim the sucker will wait until it gets released instead of
> failing with -EBUSY.  And do *that* before generic_shutdown_super()
> when unmounting something that is block-based.  Allows to bring
> the list removal back where it used to be, no UAF at all...

This is essentially equivalent to what is done right now. Only that this
would then happen in the block layer. I'm not sure it would buy us that
much. In all likelyhood we just get a range of other issues to fix.
