Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68BF17B964
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2020 10:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCFJhZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Mar 2020 04:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgCFJhZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 6 Mar 2020 04:37:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285B82073D;
        Fri,  6 Mar 2020 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583487443;
        bh=IyUEI189KLN7NzOaIC0uGsky+Dq/9mgX0pL869AYwTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBzdM3smU80fwbieeRIomBESOd0DAz9uNN+Igc9aRMBcF/aZLhWV5tX27iDxdrekL
         bIAwhkwRSbudL4mBN5282Sl4Q1//0tti6yNvgzVzwSHEg3FKbFuobj7vzH0Wuh7piN
         zBZFBkRXduhi6m4lDqWCWuM3bQ1dmvPkue2723wI=
Date:   Fri, 6 Mar 2020 10:37:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, shakeelb@google.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
Message-ID: <20200306093720.GA3630348@kroah.com>
References: <20200305211632.15369-1-dxu@dxuuu.xyz>
 <20200305211632.15369-2-dxu@dxuuu.xyz>
 <58c6e6dafabea52e5b030d18b83c13e4f43ab8e3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c6e6dafabea52e5b030d18b83c13e4f43ab8e3.camel@perches.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 06, 2020 at 12:49:51AM -0800, Joe Perches wrote:
> On Thu, 2020-03-05 at 13:16 -0800, Daniel Xu wrote:
> > It's not really necessary to have contiguous physical memory for xattr
> > values. We no longer need to worry about higher order allocations
> > failing with kvmalloc, especially because the xattr size limit is at
> > 64K.
> 
> So why use vmalloc memory at all?
> 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> ']
> > @@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
> >  	if (len < sizeof(*new_xattr))
> >  		return NULL;
> >  
> > -	new_xattr = kmalloc(len, GFP_KERNEL);
> > +	new_xattr = kvmalloc(len, GFP_KERNEL);
> 
> Why is this sensible?

See the thread on v1

> vmalloc memory is a much more limited resource.

Large chunks of "len" is much more limited :)

thanks,

greg k-h
