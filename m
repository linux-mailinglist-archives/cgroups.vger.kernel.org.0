Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372B8376844
	for <lists+cgroups@lfdr.de>; Fri,  7 May 2021 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhEGPtS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbhEGPtS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 May 2021 11:49:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925D1C061574;
        Fri,  7 May 2021 08:48:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620402497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u8xnyANDKNSkvt5YrG1NH2QAtW1TH6g1ROBYf6y7AZU=;
        b=IZYl6+DJTBqwM43/24DZhOJZSwEFcEfUhKM6FcsIN2N3Gk6uIWqGcGYantoO7ZsywhadY4
        QntLGZZ9KefJF1aULowbN95fV067yAfjBEvPZc1JZUtis3JPVcY4HhSDcv+Gglr4MXgsob
        RXct+DIHg4eK9JuRGNmGIcO8MEcf8dZw/b8e/4OBMje7mRHo5kfkXF361SAWNlT0iO0xeJ
        q3gpBwhQ+A21e8sqFBoxHX1kplK20F7uct9wMpi4QrKmGKoQLgfauZlaPkLXGFFp/zrPJa
        yS4UlVZyRnDu7+YywDDvBWEHcD91eUuPnbQlK49RunI2QAA8AR8BC6moMImJqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620402497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u8xnyANDKNSkvt5YrG1NH2QAtW1TH6g1ROBYf6y7AZU=;
        b=srWkvOdm1PfhZYesjT3FoEpAkq2deSBQJg0/rXJc39X1HwHUPeF25zYNpoLy3rRcgs5DTU
        tEB8NhbpI3GmgJCQ==
To:     Vasily Averin <vvs@virtuozzo.com>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/16] memcg: enable accounting for posix_timers_cache slab
In-Reply-To: <41e1ebc8-4f95-4a3f-3665-3fe139786d8e@virtuozzo.com>
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com> <41e1ebc8-4f95-4a3f-3665-3fe139786d8e@virtuozzo.com>
Date:   Fri, 07 May 2021 17:48:16 +0200
Message-ID: <87r1iimtof.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28 2021 at 09:53, Vasily Averin wrote:

> A program may create multiple interval timers using timer_create().
> For each timer the kernel preallocates a "queued real-time signal",
> Consequently, the number of timers is limited by the RLIMIT_SIGPENDING
> resource limit. The allocated object is quite small, ~250 bytes,
> but even the default signal limits allow to consume up to 100 megabytes
> per user.
>
> It makes sense to account for them to limit the host's memory consumption
> from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
