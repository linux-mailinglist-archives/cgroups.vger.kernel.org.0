Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB35879F575
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjIMX1o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjIMX1o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 19:27:44 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEDC1BCB;
        Wed, 13 Sep 2023 16:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pRKVep8tw/s8sIQ3F3dLcxRmfmkpqBcJ/0UUTodWZc8=; b=FSfwnimiuTJG9Nm4GWjPkE+/Wl
        tdV1zvdS6cLMU1eSiUbY8aNFgyY7VQe+ltAjMNDv/dFOBn2zXb2GJmoM0Q+HqNaldcCxZJd/HHbLS
        BS2Utl/AQSnkp62Hq1Ba8VSl5CAjDs4/vWgUYs7tXto9ItzMznllk1eotmCw7YFN4Yb//dDV7CVvc
        54SMFgAY1WobfE2n6xKuFEMcX8ZzeTOuD9dnL52KitAk8ad/sVhORTWorrkMhkBDt+Q0w1pZFo2rk
        hA7/Xa6WGJW4FOIuxYkjT6WFQJl2lC/Rrm2ri36l78qEwhTEW/mywJIOwB8jeGiEic5YnFO/2b7PA
        fXYiSf1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qgZGK-005rzK-1u;
        Wed, 13 Sep 2023 23:27:12 +0000
Date:   Thu, 14 Sep 2023 00:27:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
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
Message-ID: <20230913232712.GC800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-4-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:09:57AM -0300, Christoph Hellwig wrote:
> Releasing an anon dev_t is a very common thing when freeing a
> super_block, as that's done for basically any not block based file
> system (modulo the odd mtd special case).  So instead of requiring
> a special ->kill_sb helper and a lot of boilerplate in more complicated
> file systems, just release the anon dev_t in deactivate_locked_super if
> the super_block was using one.
> 
> As the freeing is done after the main call to kill_super_notify, this
> removes the need for having two slightly different call sites for it.

Huh?  At this stage in your series freeing is still in ->kill_sb()
instances, after the calls of kill_anon_super() you've turned into
the calls of generic_shutdown_super().

You do split it off into a separate method later in the series, but
at this point you are reopening the same UAF that had been dealt with
in dc3216b14160 "super: ensure valid info".

Either move the introduction of ->free_sb() before that one, or
split it into lifting put_anon_bdev() (left here) and getting rid
of kill_anon_super() (after ->free_sb() introduction).
