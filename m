Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BB7B4B9D
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 08:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjJBGqx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 02:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJBGqx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 02:46:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6119E;
        Sun,  1 Oct 2023 23:46:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB46A68C7B; Mon,  2 Oct 2023 08:46:46 +0200 (CEST)
Date:   Mon, 2 Oct 2023 08:46:46 +0200
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
Message-ID: <20231002064646.GA1799@lst.de>
References: <20230913111013.77623-1-hch@lst.de> <20230913111013.77623-4-hch@lst.de> <20230913232712.GC800259@ZenIV> <20230926093834.GB13806@lst.de> <20230926212515.GN800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926212515.GN800259@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 10:25:15PM +0100, Al Viro wrote:
> Before your patch: foo_kill_super() calls kill_anon_super(),
> which calls kill_super_notify(), which removes the sucker from
> the list, then frees ->s_fs_info.  After your patch:
> removal from the lists happens via the call of kill_super_notify()
> *after* both of your methods had been called, while freeing
> ->s_fs_info happens from the method call.  IOW, you've restored
> the situation prior to "super: ensure valid info".  The whole
> point of that commit had been to make sure that we have nothing
> in the lists with ->s_fs_info pointing to a freed object.
> 
> It's not about free_anon_bdev(); that part is fine - it's the
> "we can drop the weird second call site of kill_super_notify()"
> thing that is broken.

The point has been to only release the anon dev_t after
kill_super_notify, to prevent two of them beeing reused.

Which we do as the free_anon_bdev is done directly in
deactivate_locked_super.  The new ->free_sb for non-block file systems
frees resources, but none of them matter for sget.

