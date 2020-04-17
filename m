Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8F1AE28C
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 18:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDQQyq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 12:54:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42136 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDQQyq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 12:54:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id j2so3825689wrs.9
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 09:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FW0vSyyo0qvVOuBi7CQAsNq0t4MXGsecyCjJ8GqgamE=;
        b=S7hdEvcoZTZA4cBZ/ds1ns5F3+o2btA8uJ4L2xrT7YKoITfEW5mbSvG1fTtGVlr4XS
         HsmTV6HpAo5uhtu8M0gfYDKyAbNuDmz4wrl2KkTbz36MspxztPB+G8tZSG5BPQY7T42Q
         YBII9USvkKbzYLbAgSWBd1TQf3Vv6i/Z5qhawsMaqPOTrCt4mcdOu5kpNtFi7o5m7+9z
         7p3EeKlMPUJx2mON3gUfYJjnhy8VSjdF0vds/2xcB8RiqNGOeorDwv5j249zQU5LBzqU
         kdkrxXPO8GhBMn0/V/sOIYNj1wEM+GsJlILtx/e71bXdQ6fWqjC7l1eig9wlpROamEso
         /oPQ==
X-Gm-Message-State: AGi0PuawS1HbXWvkwk5IfDkNhTyxYStw+zFRdNUKWjE67d/ev1AQ7qYi
        bX1/1g+0mWj7cUHLg/hZXxtrprXs
X-Google-Smtp-Source: APiQypLDd3ekreCu05R3EPJB+e14qhGROBncfuiFEbfkX5EiySZqM1NiQIoSNMIoKwphZdkSVXX5Pw==
X-Received: by 2002:a5d:6582:: with SMTP id q2mr4898992wru.343.1587142484406;
        Fri, 17 Apr 2020 09:54:44 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id 91sm19080391wra.37.2020.04.17.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:54:43 -0700 (PDT)
Date:   Fri, 17 Apr 2020 18:54:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 1/2] memcg: folding CONFIG_MEMCG_SWAP as default
Message-ID: <20200417165442.GT26707@dhcp22.suse.cz>
References: <1587134624-184860-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200417155317.GS26707@dhcp22.suse.cz>
 <CALvZod7Xa4Xs=7zC8OZ7GOfvfDBv+yNbGCzBxeoMgAeRGRtw0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7Xa4Xs=7zC8OZ7GOfvfDBv+yNbGCzBxeoMgAeRGRtw0A@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 17-04-20 09:41:04, Shakeel Butt wrote:
> On Fri, Apr 17, 2020 at 9:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 17-04-20 22:43:43, Alex Shi wrote:
> > > This patch fold MEMCG_SWAP feature into kernel as default function. That
> > > required a short size memcg id for each of page. As Johannes mentioned
> > >
> > > "the overhead of tracking is tiny - 512k per G of swap (0.04%).'
> > >
> > > So all swapout page could be tracked for its memcg id.
> >
> > I am perfectly OK with dropping the CONFIG_MEMCG_SWAP. The code that is
> > guarded by it is negligible and the resulting code is much easier to
> > read so no objection on that front. I just do not really see any real
> > reason to flip the default for cgroup v1. Why do we want/need that?
> >
> 
> Yes, the changelog is lacking the motivation of this change. This is
> proposed by Johannes and I was actually expecting the patch from him.
> The motivation is to make the things simpler for per-memcg LRU locking
> and workingset for anon memory (Johannes has described these really
> well, lemme find the email). If we keep the differentiation between
> cgroup v1 and v2, then there is actually no point of this cleanup as
> per-memcg LRU locking and anon workingset still has to handle the
> !do_swap_account case.

All those details really have to go into the changelog. I have to say
that I still do not understand why the actual accounting swap or not
makes any difference for per per-memcg LRU. Especially when your patch
keeps the kernel command line parameter still in place.

Anyway, it would be much more simpler to have a patch that drops the
CONFIG_MEMCG_SWAP and a separate one which switches the default
beahvior. I am not saying I am ok with the later but if the
justification is convincing then I might change my mind.
-- 
Michal Hocko
SUSE Labs
