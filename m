Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B171776DD
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 14:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgCCNTZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 08:19:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38549 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgCCNTY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 08:19:24 -0500
Received: by mail-qk1-f193.google.com with SMTP id h22so3295914qke.5;
        Tue, 03 Mar 2020 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dq0BrbehtK7dXyNHKSd+EsOqpyv9pUXKpu+rlI2sPy0=;
        b=dS7oPsIcp/43xUk811EfREN9F0E/R1GAaoEagaxvwV3+zlqbGtVcU7P352DpRveBUL
         o4ug8Ghz4tfQvW05T4Gyz6fehTJGT2/qKzvpsMjMfvX02AcUmTQ20N14TNAQGZFw93nD
         sy98slN9mRSb1T/Ef2+8W+i8p15qvv5oODLKp2ia0CyqILrUX8bVSq8qNWdsStPTI8iD
         ixRbGieZO9m/P702VfNAqnayQ30qKfCxC9CjmDMmWjKAI5I/b0OvBlNvtrTCjxS2KEM/
         N+UQy03P/OkJ4BDnTmfPQLM0ECxCdhNsARPcejnqcqXFtL+788rMYq13pgmYk5mkgZRK
         7M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Dq0BrbehtK7dXyNHKSd+EsOqpyv9pUXKpu+rlI2sPy0=;
        b=VFoljd7clZcYp5iDXsrXWJxF6LMAPb5bdq9x0HvdIZftGlqYMP3GYLs35qmalpAc0E
         E+zAuC1Oxs1aKFRF6MI+vYFEWF8ZewekZbNl2W2EWDNr1rFPb+ekfXdjVdtaZ7nYrjh7
         fsR9NkqWH1VHm0Uib2Wz2IoH7w0NBDdd3fZAYrVZnWZ9NVJVr7XXVN89BI46LToBmdo8
         cim1mJHwtrG8Xv15LJHO82ReD4Ily0rqEp9QKAj+0zqu92dqBvtd/7A6mc3MzIK9Dc+t
         yaSNHRsuXsKZyICcv+mqolLlWL6IzmbYKWzySSXUcsekb3h8WQi9pPnK+2Xe0I2My5zE
         SbJQ==
X-Gm-Message-State: ANhLgQ314g46v2o+ivvj+tTdBqzG0W84wAwG7MdRwle8tl05U5AkGPeN
        9wiotsUlsGZtjcI6uSk44wvI3+viif8=
X-Google-Smtp-Source: ADFU+vvF5+WTDJs1wG460WrGfpTxI7+RdZTc6LshJRnRDEWuGkFnJDLgH0/WGXKpwe1wsVKCyM/XlA==
X-Received: by 2002:a37:aa88:: with SMTP id t130mr4252977qke.452.1583241562821;
        Tue, 03 Mar 2020 05:19:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7f70])
        by smtp.gmail.com with ESMTPSA id j17sm12534162qth.27.2020.03.03.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:19:22 -0800 (PST)
Date:   Tue, 3 Mar 2020 08:19:21 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] kernfs: Add option to enable user xattrs
Message-ID: <20200303131921.GB5186@mtj.thefacebook.com>
References: <20200303013901.32150-1-dxu@dxuuu.xyz>
 <20200303013901.32150-2-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303013901.32150-2-dxu@dxuuu.xyz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Mar 02, 2020 at 05:39:00PM -0800, Daniel Xu wrote:
> +static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
> +				     struct dentry *unused, struct inode *inode,
> +				     const char *suffix, const void *value,
> +				     size_t size, int flags)
> +{
...
> +	if (value && atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
> +		ret = -ENOSPC;
> +		goto dec_out;
> +	}

So, we limit the number of user xattrs here but

> +	ret = kernfs_vfs_xattr_set(handler, unused, inode, suffix, value,
> +				   size, flags);

This will call into simple_xattr_set() which doesn't put any further
restriction on size and just calls GFP_KERNEL kmalloc on it allowing
users incur high-order allocations. Maybe it'd make sense to limit
both the number and size?

Thanks.

-- 
tejun
