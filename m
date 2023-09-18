Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0C7A489E
	for <lists+cgroups@lfdr.de>; Mon, 18 Sep 2023 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbjIRLly (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Sep 2023 07:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbjIRLlj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Sep 2023 07:41:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80DFB3;
        Mon, 18 Sep 2023 04:41:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F2FC433C7;
        Mon, 18 Sep 2023 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695037293;
        bh=k5whRDb703pFSoW6vBuZiC/uLzAA5qCrmwIb0niMTaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aq8BDUPTeZUbSi6r80BUN/6MwH1BAmiHYY4SHfZ7onFlzdMGfEKZJql8eJgFd8kcU
         VSUGCximU6yLeulyz9sCP0KhTKpgfeEuARR1qg4bJb/2c3E2+Aaq/FI7E9KE3mXGPA
         mMkzDccqY/MfireMOZxTAFoqx04P3/eEENahXkm++IxXno8NknhrffAlyV8usX4nkg
         fRFkfnnveLguRIcv9+LTO4c7dt1uE+rem3E3BlUrXtrNJpo5JMLyLk57Bw4w+y0H+Q
         CpPUMugfzFQ2rqTkkxwCEL03tDYtT39/xBNsmqTbEmsL2yuFfD5IL+86z+BlChrW+f
         YsxfJTuf+MXoQ==
Date:   Mon, 18 Sep 2023 14:41:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH 06/19] qibfs: use simple_release_fs
Message-ID: <20230918114129.GA103601@unreal>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-7-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:00AM -0300, Christoph Hellwig wrote:
> qibfs currently has convoluted code to allow registering HCAs while qibfs
> is not mounted and vice versa.  Switch to using simple_release_fs every
> time an entry is added to pin the fs instance and remove all the boiler
> plate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/infiniband/hw/qib/qib.h      |   4 +-
>  drivers/infiniband/hw/qib/qib_fs.c   | 105 ++++++---------------------
>  drivers/infiniband/hw/qib/qib_init.c |  32 +++-----
>  3 files changed, 36 insertions(+), 105 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
