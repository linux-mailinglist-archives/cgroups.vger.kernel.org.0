Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B864136D34C
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhD1Hix (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 03:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhD1Hiv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 03:38:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C462613F3;
        Wed, 28 Apr 2021 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619595486;
        bh=QBnMC6nBzJ7jyPXp0bvf8FizKe3kkFoosH+sK00xjf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IelduBmo8Z3egwJsjYkZqs/jOFjlgurmn6LjPrBRBFKU7Vy3L97eMta9CDfcaSOlo
         NMPhseosskZD/a38E8FYsfJeUfx6Dm4LWJPHpKMaqR+EiLmz8XZiwMzdiPEp/rZ33T
         Phenb4Jn/pCUyjFzMOyuFbhe3YdTbxqBjMXfsJ2s=
Date:   Wed, 28 Apr 2021 09:38:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/16] memcg: enable accounting for tty-related objects
Message-ID: <YIkQ232vjPzFittf@kroah.com>
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
 <e1446e9c-3878-f545-b33e-389d55bf1396@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1446e9c-3878-f545-b33e-389d55bf1396@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28, 2021 at 09:54:16AM +0300, Vasily Averin wrote:
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
