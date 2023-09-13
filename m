Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6488579EE54
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 18:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjIMQfP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQfP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 12:35:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB82198B;
        Wed, 13 Sep 2023 09:35:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49C6C433C8;
        Wed, 13 Sep 2023 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694622910;
        bh=y6U3+knkB2KJUy0K+kKiKi2OQBqhEH8KYPTDWrdy8vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbSG8Ezy8yFgISuAMQN5RhWrtNTl3QqDSmiZMwwbTg+0oDugBRUdnwQc5j2qkdMD2
         1s6Rl/XAfLKNgYXUQh0tRfyK/x+EtKE0FbZoD5NKNq9bgy1vK7qgU3p3IEpfCsnpHZ
         6sTo/2em1zKqbF7iMKZUDjKUtpgdec9ZqPyZZzehDKx+RCrmR+C5zBmghTjK8bFrNZ
         r10ma5uo2ysAby9XfArHeRQFgLtpllaR49B9Kn8xBTgF/UhNB7g6WBoqm/gf219JAL
         cAjIovp8gUkGJgrlRCpYXvvezH6CR+ZkRs2Sqgqw/Ym/CEEDVjNCYnrRqY1AYdacqO
         DegJgzAJU4xUg==
Date:   Wed, 13 Sep 2023 18:35:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH 01/19] fs: reflow deactivate_locked_super
Message-ID: <20230913-betuchte-vervollkommnen-0609db0eaab8@brauner>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-2-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:09:55AM -0300, Christoph Hellwig wrote:
> Return early for the case where the super block isn't cleaned up to
> reduce level of indentation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/super.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2d762ce67f6e6c..127a17d958a482 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -476,27 +476,28 @@ static void kill_super_notify(struct super_block *sb)
>  void deactivate_locked_super(struct super_block *s)

I wouldn't mind s/s/sb/ here as well. So we stop using @s in some and
@sb in other places.

Otherwise looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
