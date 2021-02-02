Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D4F30CEC9
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 23:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhBBW0B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 17:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhBBWYx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 17:24:53 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87867C0613ED
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 14:24:11 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h7so30418736lfc.6
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNAOPiZhBvntC8C14bTzDHN942diSkXcNrN3eK3rI1U=;
        b=py//dvYEibEFwVmLb4PAzjrsTA3YCydFXpiKsTfJi98dIVrg7qVsUn1zCwPK/765J/
         xrxxSxQX34Z5IqSMuCDIcyPNpFXaT6T/zkIQIiYAC7f+RArYPsUtyQj8fLsxWvPGFJQ6
         Yl40cJATocGMAb/9yXMC7R1+HkxigN0/ks8Zgc91TApzoAVqBSnBZjmIZiKauDYWUF1N
         OMrxP2/N93d7LP6Pz8DOpiBEGq4iTW3u84Q1agudNIm3TaixbI+oz0WhuOXFiGxVlbyI
         n4KOlzRwFVBigG+zifCDblUVxu256mnuXXn89LsK4p3TXqjTFNn0xo+btKP8wd57wFTK
         cZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNAOPiZhBvntC8C14bTzDHN942diSkXcNrN3eK3rI1U=;
        b=oyhme3hYbd2Q0hIxXVD4nYw0o1zL53wAA6wkFZJYpoPSzLfizBQSjR3CdbQ1ucYguU
         jRJJgqv4+cD+LHhjXfsNLcFDHa2d8kTgFnueFvUXIuc11IFjo4qep6LJm9LqqM3nHOQq
         9d/Ys5pEPfb8SGL3p9Ebgne9XQTIpvMCKhhZgAFfvCvop3wTSGvdfvNZnoOHmKoH0Ux0
         Yjkpj0GQQL/2V6gpjQXL39fkW7y8OAlTuOIaOHatCcy3G7WvNyy03cnqH/52KWGuCc+k
         WI2JCSRfAFjYPo8p2gx1ONjANRxjGK+RbJNQt7pUpZOR5aFQZlKWqdEFg4HvY6aNzZw9
         TqPg==
X-Gm-Message-State: AOAM5307YraKX6CeQFnSWNfCnT2V1LdJ6eTt/JHUybekGtGktnKPdFil
        40yDDwQeU5ZXdntJNZLZ1Ob8ajOW3XFaQnTxilHjPA==
X-Google-Smtp-Source: ABdhPJxDKyG3Si6gHUp6yAdVzfGVlKmjgT+cjTkuQvXlB6iWVZokLvFIiH+94cQ/ka0xQ52TT6xd3w4eTNBbQYoHFlI=
X-Received: by 2002:a05:6512:79:: with SMTP id i25mr38591lfo.549.1612304649273;
 Tue, 02 Feb 2021 14:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20210202184746.119084-1-hannes@cmpxchg.org> <20210202184746.119084-2-hannes@cmpxchg.org>
In-Reply-To: <20210202184746.119084-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Feb 2021 14:23:57 -0800
Message-ID: <CALvZod6fHOhGN2exBSsRS4+KMzXE=1O7ALF2Hq4ehjvVFW6+ig@mail.gmail.com>
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 2, 2021 at 12:18 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The memcg hotunplug callback erroneously flushes counts on the local
> CPU, not the counts of the CPU going away; those counts will be lost.
>
> Flush the CPU that is actually going away.
>
> Also simplify the code a bit by using mod_memcg_state() and
> count_memcg_events() instead of open-coding the upward flush - this is
> comparable to how vmstat.c handles hotunplug flushing.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I think we need Fixes: a983b5ebee572 ("mm: memcontrol: fix excessive
complexity in memory.stat reporting")

Reviewed-by: Shakeel Butt <shakeelb@google.com>
