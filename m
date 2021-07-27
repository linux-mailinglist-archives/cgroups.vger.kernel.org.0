Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998613D6ECB
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 08:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhG0GJL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 02:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235557AbhG0GJK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 02:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE06661054;
        Tue, 27 Jul 2021 06:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627366151;
        bh=12GRn6/Ruq7Tv7H9GUSviN2q+t9S6N5v5Lcy9EzpXmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emP7gDqUhtszgWgqPv4PuPidiHYIboQejjWQj1WwmXBBwvX2vQwilrXcDdq6L4dCP
         vS+u7HfpvxdnYJ5eANYPI6cxxf4iV3aoRNPm1cGRaDJdBMKJu8cn3i3MMbeR/77yGH
         MTFdgXW5aqONYf6x3XCDALR0tCf3+FzZ9GaB91n4=
Date:   Tue, 27 Jul 2021 08:09:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/10] memcg: enable accounting for tty-related objects
Message-ID: <YP+jBbnAczNcK86D@kroah.com>
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
 <b8baa04f-e789-0321-b39d-07c5696ff755@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8baa04f-e789-0321-b39d-07c5696ff755@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 27, 2021 at 08:34:14AM +0300, Vasily Averin wrote:
> At each login the user forces the kernel to create a new terminal and
> allocate up to ~1Kb memory for the tty-related structures.
> 
> By default it's allowed to create up to 4096 ptys with 1024 reserve for
> initial mount namespace only and the settings are controlled by host admin.
> 
> Though this default is not enough for hosters with thousands
> of containers per node. Host admin can be forced to increase it
> up to NR_UNIX98_PTY_MAX = 1<<20.
> 
> By default container is restricted by pty mount_opt.max = 1024,
> but admin inside container can change it via remount. As a result,
> one container can consume almost all allowed ptys
> and allocate up to 1Gb of unaccounted memory.
> 
> It is not enough per-se to trigger OOM on host, however anyway, it allows
> to significantly exceed the assigned memcg limit and leads to troubles
> on the over-committed node.
> 
> It makes sense to account for them to restrict the host's memory
> consumption from inside the memcg-limited container.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/tty_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As this is independant of all of the rest, I'll just take this through
my tree now so that you do not have to keep resending it.

thanks,

greg k-h
