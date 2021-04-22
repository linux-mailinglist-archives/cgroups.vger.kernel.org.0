Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922F336803C
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 14:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhDVMWv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 08:22:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:40092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236150AbhDVMWv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 08:22:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619094136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgmJ6eYbK2bVLn7ba6Q4A6jznipcJvHPjy1e8O/CEY4=;
        b=o5GLJm3U3s8CkgH8E1ETOR00fZVLg/OrxMM2QhaKp3owlgI151sC9lS2FUnYC0ENt/+mMm
        RetoPyoShDzGyc0OV/sng8gXtNzwp7JCY5ddH9IqziJ71FE/Lby1oYelSkg/MuF4/5dsGt
        S/cgqulLNUvIGewanWWQBE5ED4EsRMg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1AA8B016;
        Thu, 22 Apr 2021 12:22:15 +0000 (UTC)
Date:   Thu, 22 Apr 2021 14:22:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 15/16] memcg: enable accounting for tty-related objects
Message-ID: <YIFqcr9mYqf+9s1H@dhcp22.suse.cz>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
 <YIFcqcd4dCiNcILj@kroah.com>
 <YIFhuwlXKaAaY3IU@dhcp22.suse.cz>
 <YIFjI3zHVQr4BjHc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFjI3zHVQr4BjHc@kroah.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 22-04-21 13:50:59, Greg KH wrote:
> On Thu, Apr 22, 2021 at 01:44:59PM +0200, Michal Hocko wrote:
> > On Thu 22-04-21 13:23:21, Greg KH wrote:
> > > On Thu, Apr 22, 2021 at 01:37:53PM +0300, Vasily Averin wrote:
> > > > At each login the user forces the kernel to create a new terminal and
> > > > allocate up to ~1Kb memory for the tty-related structures.
> > > 
> > > Does this tiny amount of memory actually matter?
> > 
> > The primary question is whether an untrusted user can trigger an
> > unbounded amount of these allocations.
> 
> Can they?  They are not bounded by some other resource limit?

I dunno. This is not my area. I am not aware of any direct rlimit (maybe
RLIMIT_NPROC) and maybe pid controller would help. But the changelog
should definitely mention that. Other patches tend to mention the
scenario they protect from this one should be more specific.
-- 
Michal Hocko
SUSE Labs
