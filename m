Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A66D79B7
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbfJOPYX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 11:24:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43831 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733173AbfJOPYU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 11:24:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so25767731qtr.10
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2019 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aermn/Dt4ttLuAv+N2gyIczaxg1Onw7W29ecU8QQsuU=;
        b=Bq+rgeAkSV5v5wBQys2jjm4AZ0pYPa9/XbKBRpPOlBLfNDsDFE7Dkh3DWGe5g3gYls
         zokIj7GljcQdnKbVJYMiZaAgA6lYP1V007kxefUS5Z05OPBHVY3QjDFfkCz+ZM5xOtu8
         wZJwkm+DfQFAhfxaeYMaVMjY+5+ktdnUTtgoso6V8kcvdkmwLIVvazOVBh8rZU3eGh9t
         ciq6ne/xZOvY6PRQN2KQURHwfAr+9mnyxTCn1TNChxdpraybhn9Ecd9kueZeDRQ50fSp
         jgJ9IA47gzBVwjrnrK2s5e5Fhi13NdWivrn/Rt/tEWPlxR8UVm+zjL/dMtWsXFZnJ6I1
         IrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aermn/Dt4ttLuAv+N2gyIczaxg1Onw7W29ecU8QQsuU=;
        b=hgxMKZk7xpKWOdOJnFAuSrIaWM8Ib4+ruaEaJuo3ymNz0IGnbl5o2q9nGoc3e1yaci
         r6Xd+ghTMF3b1MJFd4TUnt+D9F/LQZKkgSiaswN8bp6w920MIWsmArFgaxvVHR9PCoZb
         fKParHJJ30gYAG6hw1l+Sg9IFmBgmA3xhLpejTHtYVxlFfGfCnT/S7M4PhxISW3mksen
         0AQvHMtk63LYuaJlXN5JAp3xsiVkvpJ5pdTEEYtENVdUeqzgGAbVMNw3gVpIr8umZ78S
         EHC4iInKTpNx4rIHetGzsstJz+u+IIwn+ulODxYwJkGRaW8by1M1zAZYmkYslI+rSI9/
         qv3w==
X-Gm-Message-State: APjAAAXp93Z/Z6QhAqs8Vo3rK7GCccIlhXPtbCk05ibFG+P1xzabZ812
        ePz/xWCyT2GWLZBVdLNCFnGQtw==
X-Google-Smtp-Source: APXvYqz941GLbmiz54RNqEsbgE0UItujkynZfJBfDKFFs3ov2ffiGy6mSongERFbiBR0eqrsTTNMrg==
X-Received: by 2002:ad4:40cc:: with SMTP id x12mr37693242qvp.1.1571153058790;
        Tue, 15 Oct 2019 08:24:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d056])
        by smtp.gmail.com with ESMTPSA id g8sm12718336qta.67.2019.10.15.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:24:17 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:24:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
Message-ID: <20191015152417.GA141964@cmpxchg.org>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
 <20191015135348.GA139269@cmpxchg.org>
 <89171a94-8b6f-e949-0078-10fa8fd26dfc@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89171a94-8b6f-e949-0078-10fa8fd26dfc@yandex-team.ru>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 15, 2019 at 05:04:44PM +0300, Konstantin Khlebnikov wrote:
> On 15/10/2019 16.53, Johannes Weiner wrote:
> > On Tue, Oct 15, 2019 at 11:09:59AM +0300, Konstantin Khlebnikov wrote:
> > > Mapped, dirty and writeback pages are also counted in per-lruvec stats.
> > > These counters needs update when page is moved between cgroups.
> > > 
> > > Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > 
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Please mention in the changelog that currently is nobody *consuming*
> > the lruvec versions of these counters and that there is no
> > user-visible effect. Thanks
> > 
> 
> Maybe just kill all these per-lruvec counters?
> I see only one user which have no alternative data source: WORKINGSET_ACTIVATE.
> 
> This will save some memory: 32 * sizeof(long) * nr_nodes * nr_cpus bytes

This is backwards, see my reply to Michal, as well as the patches at
https://lore.kernel.org/linux-mm/20190603210746.15800-1-hannes@cmpxchg.org/

We're not using the lruvec counters in all places where we should.
