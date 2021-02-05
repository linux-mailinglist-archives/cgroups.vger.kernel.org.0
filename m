Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC84311156
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhBERzp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 12:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhBEP2u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 10:28:50 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5CDC0617AA
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 09:10:31 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id es14so3783671qvb.3
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JSYiUbx9lBanOq4tbekqTAf5PAtDklDUpjXB1f72Qrc=;
        b=tM/dZEUeDe1AgSL5LylGwYfRT5+levhjDv8vOBR8fUAbDaWMIznPnPLamaZYjY3wzT
         g+cjA6pD7ZjdrM2mng9Mhako+BFslrJzcTyReIW3h3o2QgGnwwDoKQzvWVUktPepuyYF
         AQpeiGmjpMs3K7CIzmD/iIjPrJfmglw9FOMLa8DMpRqKtFq4n+aJwjjtM6lqRBeHo15z
         kMc5x+Y/a9DnW6WdEzSjR2PJZoQSYrOzjK7pChRoltFN0rOJYBKH6WVkXPnWme2gn3k3
         YwP8eOjnLw8SSf+taDiSenMwKUeZDxhJoWi9lzmTgxWYD8kMQD8Zdwho7ZOxqfsluBcS
         VKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JSYiUbx9lBanOq4tbekqTAf5PAtDklDUpjXB1f72Qrc=;
        b=Elnhxw12taSlD6Wns7k5ri0WWON4uipf53PIIz2HS/EJjFIOS28ZPQnMMnmKxKUQPO
         mp22yKp4absD/glcVky3ZmevTVpyOz6tNHDTt2jx039rRavMQ3oc6/AdRKmmPTr2OJ5x
         V/NVc9JbCvuolN1K6DSSxSbY//9aB5GEHJUnfmD5uMORxus4nlFdmimbE4k0B9+GJuGi
         49vHi70lgwRzp3QH5d+Hc0XIW1YeSClx1wVqWPXJPNB8HlDRJY/O8Lr2Vmbw+NPDe5eo
         4ZgV24n2xsUwz6mt/j05/JU98cHdEICXQnequFJKPteVPS2xCeDW0eundXc0weDtkrp2
         N+HA==
X-Gm-Message-State: AOAM5317ex6t9OUuwBDL+tGXUOaz6KX+YTkLDl67n9NeuiSvJM9/xSok
        93sM+sIAOesbR8BU7xcHVOo8jQ==
X-Google-Smtp-Source: ABdhPJwfv1gGAdP2jw5xSKMc6JrF213KOE1VJFhtyr1tERfRWP0BI2bHuc1NqNeFBd5A0OMvxYuzDA==
X-Received: by 2002:a0c:e8c8:: with SMTP id m8mr5266723qvo.33.1612545031139;
        Fri, 05 Feb 2021 09:10:31 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c22sm8495640qtp.19.2021.02.05.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 09:10:29 -0800 (PST)
Date:   Fri, 5 Feb 2021 12:10:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/7] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <YB18BF8b41RPra5b@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-8-hannes@cmpxchg.org>
 <YB1hhwVybr0x5M2j@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB1hhwVybr0x5M2j@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 05, 2021 at 04:17:27PM +0100, Michal Hocko wrote:
> On Tue 02-02-21 13:47:46, Johannes Weiner wrote:
> > There are two functions to flush the per-cpu data of an lruvec into
> > the rest of the cgroup tree: when the cgroup is being freed, and when
> > a CPU disappears during hotplug. The difference is whether all CPUs or
> > just one is being collected, but the rest of the flushing code is the
> > same. Merge them into one function and share the common code.
> 
> IIUC the only reason for the cpu == -1 special case is to avoid
> zeroying, right? Is this optimization worth the special case? The code
> would be slightly easier to follow without this.

Hm, it was less about the optimization and more about which CPU(s)
need(s) to be handled. But it's pretty silly the way it's written,
indeed. I'll move the for_each_online_cpu() to the caller and drop the
cpu==-1 special casing, it makes things much simpler and more obvious.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Anyway the above is not really a fundamental objection. It is more important
> to unify the flushing.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks. v2 is different, so I'll wait with taking the ack.
