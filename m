Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6479F5ED
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 02:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjINAew (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 20:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjINAew (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 20:34:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3721727;
        Wed, 13 Sep 2023 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zW8A+jmgUiM8HsI9YE4GX2QGkquAFh76d1jbcjosgrA=; b=i9wJCjYQOucX6E86EF3igFqgNG
        hPekTdaRPjXMgVVF9cHAjxTrTvqnkb2YWAqeRe/SlrLFW2JxYuNraUHvU/ZhVluyELRRLTA8dnTUf
        bCcE37si7zygJaX6tL94iOo+1nM5ExW1S2xAa0yfEq5dkj5Dk/ay7GeLEv6O2gB79BuvXtM0YltTz
        wFwYZahAPPGBtE8/apUAiG4j8kjGKksuWA7bGqa2YoptfKxXsW5EthC9/ga+Tt3593pFKFm+IzvXm
        tfhntSvAeWAXDW0zkl9/OHF7UAQBVfzmiAEVFQqM3C3iwJMealto2WwHuNdsLMT7Racfb/DsrPhNP
        7rj5NAAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qgaJM-005sdx-2k;
        Thu, 14 Sep 2023 00:34:24 +0000
Date:   Thu, 14 Sep 2023 01:34:24 +0100
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
Subject: Re: [PATCH 05/19] fs: assign an anon dev_t in common code
Message-ID: <20230914003424.GD800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-6-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:09:59AM -0300, Christoph Hellwig wrote:

> diff --git a/fs/super.c b/fs/super.c
> index bbe55f0651cca4..5c685b4944c2d6 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -787,7 +787,7 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	struct super_block *s = NULL;
>  	struct super_block *old;
>  	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
> -	int err;
> +	int err = 0;
>  
>  retry:
>  	spin_lock(&sb_lock);
> @@ -806,14 +806,26 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	}
>  
>  	s->s_fs_info = fc->s_fs_info;
> -	err = set(s, fc);
> -	if (err) {
> -		s->s_fs_info = NULL;
> -		spin_unlock(&sb_lock);
> -		destroy_unused_super(s);
> -		return ERR_PTR(err);
> +	if (set) {
> +		err = set(s, fc);
> +		if (err) {
> +			s->s_fs_info = NULL;

Pointless (as the original had been); destroy_unused_super() doesn't
even look at ->s_fs_info.

> +			goto unlock_and_destroy;
> +		}
>  	}
>  	fc->s_fs_info = NULL;

Here we are transferring the ownership from fc to superblock; it used to sit
right next to insertion into lists and all failure exits past that point must
go through deactivate_locked_super(), so ->kill_sb() would be called on those
and it would take care of s->s_fs_info.  However, your variant has that
ownership transfer done at the point before get_anon_bdev(), and that got
you a new failure exit where you are still calling destroy_unused_super():

> +	if (!s->s_dev) {
> +		/*
> +		 * If the file system didn't set a s_dev (which is usually only
> +		 * done for block based file systems), set an anonymous dev_t
> +		 * here now so that we always have a valid ->s_dev.
> +		 */
> +		err = get_anon_bdev(&s->s_dev);
> +		if (err)
> +			goto unlock_and_destroy;

This.  And that's a leak - fc has no reference left in it, and your
unlock_and_destroy won't even look at what's in ->s_fs_info, let alone know
what to do with it.

IOW, clearing fc->s_fs_info should've been done after that chunk.

And looking at the change in sget(),

> +	if (set) {
> +		err = set(s, data);
> +		if (err)
> +			goto unlock_and_destroy;
>  	}
> +
> +	if (!s->s_dev) {
> +		err = get_anon_bdev(&s->s_dev);
> +		if (err)
> +			goto unlock_and_destroy;
> +	}

I'd rather expressed it (both there and in sget_fc() as well) as
	if (set)
		err = set(s, data);
	if (!err && !s->s_dev)
		err = get_anon_bdev(&s->s_dev);
	if (err)
		goto unlock_and_destroy;

That's really what your transformation does - you are lifting the
calls of get_anon_bdev() (in guise of set_anon_super()) from the
tails of 'set' callbacks into the caller, making them conditional
upon the lack of other errors from 'set' and upon the ->s_dev left
zero and allow NULL for the case when that was all that had been
there.

The only place where you do something different is this:

> @@ -1191,7 +1191,6 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>  static int ceph_set_super(struct super_block *s, struct fs_context *fc)
>  {
>  	struct ceph_fs_client *fsc = s->s_fs_info;
> -	int ret;
>  
>  	dout("set_super %p\n", s);
>  
> @@ -1211,11 +1210,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
>  	s->s_flags |= SB_NODIRATIME | SB_NOATIME;
>  
>  	ceph_fscrypt_set_ops(s);
> -
> -	ret = set_anon_super_fc(s, fc);
> -	if (ret != 0)
> -		fsc->sb = NULL;
> -	return ret;
> +	return 0;

fsc->sb = NULL has disappeared here; it *is* OK (the caller won't look at
fsc->sb after failed sget_fc()), but that's worth a mention somewhere.
A separate commit removing that clearing fsc->sb in ceph_set_super(),
perhaps?
