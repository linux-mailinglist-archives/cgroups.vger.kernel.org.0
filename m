Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DF367FCF
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhDVLvh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 07:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhDVLvg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 07:51:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EDDE6144D;
        Thu, 22 Apr 2021 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619092262;
        bh=z3h6YeQAhM+sSuIksdggFIgSAlh6qSpvkJNTNnVlLNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYNMr2xWX/yND8JBq0t2hkwmg6pKsHfVnqELHfiuLEDxRGfVkIzHyjzbO6PEkyRKG
         /GTnVv4ea1HEVpVHzCeKw1dtdzypNko79NspvGYUild9WSNvvSPz4Ojv/2xmbGhDkg
         PSooLz/SMRl71Pi48iR81HwqtG62zwOG0dwEMvgU=
Date:   Thu, 22 Apr 2021 13:50:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 15/16] memcg: enable accounting for tty-related objects
Message-ID: <YIFjI3zHVQr4BjHc@kroah.com>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
 <YIFcqcd4dCiNcILj@kroah.com>
 <YIFhuwlXKaAaY3IU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFhuwlXKaAaY3IU@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 01:44:59PM +0200, Michal Hocko wrote:
> On Thu 22-04-21 13:23:21, Greg KH wrote:
> > On Thu, Apr 22, 2021 at 01:37:53PM +0300, Vasily Averin wrote:
> > > At each login the user forces the kernel to create a new terminal and
> > > allocate up to ~1Kb memory for the tty-related structures.
> > 
> > Does this tiny amount of memory actually matter?
> 
> The primary question is whether an untrusted user can trigger an
> unbounded amount of these allocations.

Can they?  They are not bounded by some other resource limit?

greg k-h
