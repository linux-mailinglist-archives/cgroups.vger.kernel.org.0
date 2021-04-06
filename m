Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039C73558FE
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbhDFQPj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346327AbhDFQPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Apr 2021 12:15:36 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A21C06174A;
        Tue,  6 Apr 2021 09:15:26 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y12so11543716qtx.11;
        Tue, 06 Apr 2021 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FH0gnE912P3ws0Ef1o02PZUZDtCA2hsCwBkvlqrhqr8=;
        b=RvNzrXJsEBRv4/QkFT7ccs9FMS2KM2Xyywtg7PWDOWn7jMBbsyZXO/k7WRgMaanGPN
         rv4m+Wv9iIfIUS3Peaosb0BctfUnrdEv8eV21o1jufNd71pyz4wr0Bqxrcnk6Simu+0p
         wZRUykd08TqGTZozklIkK0DOPXv8HzYlzgogV96QJSgudJNM+KrF+85QdrMuuZyl7Crd
         qznc+SXXfZWsxgML+LvnXpj3PM+0IXxtJylpXCSCzaYrstIvtuNfnwROH1hqoWwib4FM
         P91SFGXp6SrumY5usXE8ocFHq4HQ65aK+2oKXyPqmKbet/12Wt7rPmV7PI94NgYFjZfk
         lv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FH0gnE912P3ws0Ef1o02PZUZDtCA2hsCwBkvlqrhqr8=;
        b=Z2RsiezsyRhH98in5vGCEBa6LkTMkbGTktQd2eWTqOvUBzu4IeiouDSyTOQUyoffRY
         VP2WDMoE8kzn4lKN+ZvC/UbgPMPsrYw3mZzlf0AutiRrYeDIyKkMqesQxdsBMskiZ49/
         499ctBmH5Awh6iWUNpQbj5mue3Q2eyVwEoHH3Vwa/GyIvcjUcNuYJ5PQ1KMcdRBY24OL
         Q6Q7xNdyViDBoQSeg3E0GMB34pwjhVbl7cSQ+E4dEd0cCiMFuJW7tAOk0ylqmVzexzQ1
         jCpujyLIJ4y2UnJi8X6Jy7c0mC9FVmM2CWkMD2KSzvJn94CsAJ2yx32RglwJhVtLzyDn
         TK8g==
X-Gm-Message-State: AOAM5322CPQ+0jfPK6jxQEqH8cPjKIhpi7j18b77AXsOOWxHfCrWdc+d
        T4J57RE4U5HItku5wFkQ3Lw=
X-Google-Smtp-Source: ABdhPJwXSd+mzXmgVz0J7ZXpask32WLYHZQ2uVaBp1FzYl11KpaCpx6P6JXpp+nP+nB/mt7P0qFohQ==
X-Received: by 2002:a05:622a:1192:: with SMTP id m18mr26880316qtk.27.1617725726032;
        Tue, 06 Apr 2021 09:15:26 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id o26sm12843511qko.83.2021.04.06.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:15:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Apr 2021 12:15:24 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Quentin Perret <qperret@google.com>, Wei Wang <wvw@google.com>
Subject: Re: [PATCH] cgroup: Relax restrictions on kernel threads moving out
 of root cpu cgroup
Message-ID: <YGyJHAlLKqng2WeS@slm.duckdns.org>
References: <1617714261-18111-1-git-send-email-pkondeti@codeaurora.org>
 <YGxjwKbec68sCcqo@slm.duckdns.org>
 <20210406152715.GB21941@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406152715.GB21941@codeaurora.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Apr 06, 2021 at 08:57:15PM +0530, Pavan Kondeti wrote:
> Yeah. The workqueue attrs comes in handy to reduce the nice/prio of a
> background workqueue if we identify that it is cpu intensive. However, this
> needs case by case analysis, tweaking etc. If there is no other alternative,
> we might end up chasing the background workers and reduce their nice value.

There shouldn't be that many workqueues that consume a lot of cpu cycles.
The usual culprit is kswapd, IO related stuff (writeback, encryption), so it
shouldn't be a long list and we want them identified anyway.

> The problem at our hand (which you might be knowing already) is that, lets say
> we have 2 cgroups in our setup and we want to prioritize UX over background.
> IOW, reduce the cpu.shares of background cgroup. This helps in prioritizing
> Task-A and Task-B over Task-X and Task-Y. However, each individual kworker
> can potentially have CPU share equal to the entire UX cgroup.
> 
> -kworker/0:0
> -kworker/1:0
> - UX
> ----Task-A
> ----Task-B
> - background
> ----Task-X
> ----Task-Y
> Hence we want to move all kernel threads to another cgroup so that this cgroup
> will have CPU share equal to UX.
> 
> The patch presented here allows us to create the above setup. Any other
> alternative approaches to achieve the same without impacting any future
> designs/requirements?

Not quite the same but we already have
/sys/devices/virtual/workqueue/cpumask which affects all unbound workqueues,
so maybe a global default priority knob would help here?

Thanks.

-- 
tejun
