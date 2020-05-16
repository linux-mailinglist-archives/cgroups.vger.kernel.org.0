Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3721D5DB8
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2020 03:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEPBmv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgEPBmv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 21:42:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A27C061A0C
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 18:42:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 50so5450321wrc.11
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kS8OYMG072jDcI6wkY/z+PD46Du/tMZhKnhnXKRsoeo=;
        b=AH0puOca79INHP4Gyjk8o8AyxnmdUlm/s7CIZkXpa4xvSasJLmdH8L2vWT0y+OPoA2
         I0dBbUpqu90pgUFRkEbf4DKo2KVJwQ7QIFWnpt9s6w4TNSbgkI5skacNqeGVjFYdGK2v
         XfuM/QsPsOjBfWclFvjZVsVcN2YdvdcuqqfPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS8OYMG072jDcI6wkY/z+PD46Du/tMZhKnhnXKRsoeo=;
        b=boLXHq7ju+18CYKb7MLhdzIUQ/uyd0AYqZeH0c18lC+gRad7n0FdiiEs3ZxpuviA4D
         O0fD1fPdXfjR9pifNT2KZoItxfTAXE5anBBYrSa0FUoEOgZkao+uMvruccjdtGfpSYkj
         d/VCJ+yfmhURNUjh1oUClgXSnJMyy1Q3ptsfQH+zS6na2D3ZgQZCgOrKKLKsyyzXeA2u
         P920HhSB093DLKceqNSDiIPo1SdVHQE1qeQ8KfT526VEdsCs+dKSa25aSxRpkdqK+PtM
         oudba48zdPAO7fbGqNPfTpA1Xa3JRENZFA82Aqoikx0cQs+ViW/YZamaEbpfGnTfEh64
         u79A==
X-Gm-Message-State: AOAM533tISkL+yLywf2JSEdlft6LEJc1AxLuFf4XMqGsmZ6WMwoxu9BK
        abJxORUr0B/NG/3WOYiQw6elBA==
X-Google-Smtp-Source: ABdhPJygr4YRwvdn5bQj/+FRk7Jk9MpKoXCmkZ5L4Hgg+hvUMxR3NbMw1h1nDwgPO85GahUNXx18VA==
X-Received: by 2002:adf:9b91:: with SMTP id d17mr6892266wrc.183.1589593368152;
        Fri, 15 May 2020 18:42:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id x5sm6315441wro.12.2020.05.15.18.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 18:42:47 -0700 (PDT)
Date:   Sat, 16 May 2020 02:42:47 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
Message-ID: <20200516014247.GA8578@chrisdown.name>
References: <20200508170630.94406-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200508170630.94406-1-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey Shakeel,

Shakeel Butt writes:
>One way to measure the efficiency of memory reclaim is to look at the
>ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
>not updated consistently at the system level and the ratio of these are
>not very meaningful. The pgsteal and pgscan are updated for only global
>reclaim while pgrefill gets updated for global as well as cgroup
>reclaim.
>
>Please note that this difference is only for system level vmstats. The
>cgroup stats returned by memory.stat are actually consistent. The
>cgroup's pgsteal contains number of reclaimed pages for global as well
>as cgroup reclaim. So, one way to get the system level stats is to get
>these stats from root's memory.stat, so, expose memory.stat for the root
>cgroup.
>
>	from Johannes Weiner:
>	There are subtle differences between /proc/vmstat and
>	memory.stat, and cgroup-aware code that wants to watch the full
>	hierarchy currently has to know about these intricacies and
>	translate semantics back and forth.
>
>	Generally having the fully recursive memory.stat at the root
>	level could help a broader range of usecases.
>
>Signed-off-by: Shakeel Butt <shakeelb@google.com>
>Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

The patch looks great, thanks. To that extent you can add my ack:

Acked-by: Chris Down <chris@chrisdown.name>

One concern about the API now exposed, though: to a new cgroup v2 user this 
looks fairly dodgy as a sole stat file (except for cgroup.stat) at the root. If 
I used cgroup v2 for the first time and only saw memory.stat and cgroup.stat 
there, but for some reason io.stat and cpu.stat are not available at the root 
but are available everywhere else, I think my first thought would be that the 
cgroup v2 developers must have been on some strong stuff when they came up with 
this ;-)

Even if they're only really duplicating information available elsewhere right 
now, have you considered exposing the rest of the stat files as well so that 
the API maintains a bit more consistency? As a bonus, that also means userspace 
applications can parse in the same way from the root down.
