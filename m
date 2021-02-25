Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36E3258BB
	for <lists+cgroups@lfdr.de>; Thu, 25 Feb 2021 22:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhBYVgu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Feb 2021 16:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhBYVgs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Feb 2021 16:36:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86EAC06174A
        for <cgroups@vger.kernel.org>; Thu, 25 Feb 2021 13:36:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d2so4365264pjs.4
        for <cgroups@vger.kernel.org>; Thu, 25 Feb 2021 13:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/U0ItIv10awr48o0Xr67ORIR0R4cpmrKcS939Ry0u60=;
        b=aM51O6VgHioWd7XkWW6peAD4fP73FQxRl9onjbsDlp5Blv8GVDlbHlQ+bVRRjiux/q
         VIxiQcJR41IkzBS8pG7heU8OynV6hjepxqvlstpyFvUkQWJhAnBl+a6tpRtBk+ZyE13j
         zVdDJdwPN3PqFz/Ss1XlFCxH4TSZowvWFTJivJL+xB/l89cEcHmp/rYKIVkSu4LT8hga
         5nSYNt+3RUeWL1/NWf0uHLE+a5HhUal3ERbcabQPkwbKuVJfkwuRGqyfFarm3LfwfI8M
         Mj5tmQZmj/xixxD5TIyQNEkHBfKvZEGwiP/SS9Cz6oyw1sHAzZLiS2+UfBZj5WuIOQA8
         iO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/U0ItIv10awr48o0Xr67ORIR0R4cpmrKcS939Ry0u60=;
        b=M7oj4MmhT43TpKVkISD7neuZmz4nuplt3wm5Yl/lZiC9A6UjdHK53cxGVwjJHzHfJS
         BtnECfjzIyqMZOKvq0BoquP01RHgv+SXmcQaFvRPMjZh4Ei7fjiqV8YLRQ+dcvE2SynP
         M3Ol1r2+U9oPtUDa31jq2z9+7rnMxUE5FOQzzp5+zpE5B14ua2ywS2s4cwKjvt/BEMFe
         ZB7DEX7eJvZ4hi49OuycrzdrPf5St4jMAOmU9M5I3KjQDIQEH20v5Qe3rZwDQMnRc9YN
         OIVYRwLvOhA45YxGSdlV2AAQbFNrTXKLu7l10+HJL8zd5UK7DcehYhXikUShEAKbgdoe
         tJrw==
X-Gm-Message-State: AOAM5335kZ9q1jn+zPfsVPDFDz2idWsuDl9ZMGZyigTPBl+zUQwaQ6mo
        LSr8rrVTCEkxtIUaB/ZB/lwi8Q==
X-Google-Smtp-Source: ABdhPJx9m++KLr1Vney+yZ57/jgY0SoHkKVpS8hWdbbOKP+8KR9VogqbH4ylR1ahD/dOaJ4IAJ2uqQ==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr362628pjh.141.1614288968138;
        Thu, 25 Feb 2021 13:36:08 -0800 (PST)
Received: from [2620:15c:17:3:a902:4bab:58a0:3f05] ([2620:15c:17:3:a902:4bab:58a0:3f05])
        by smtp.gmail.com with ESMTPSA id 142sm600208pfz.196.2021.02.25.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:36:07 -0800 (PST)
Date:   Thu, 25 Feb 2021 13:36:06 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Shakeel Butt <shakeelb@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: enable memcg oom-kill for __GFP_NOFAIL
In-Reply-To: <20210223204337.2785120-1-shakeelb@google.com>
Message-ID: <f9a2aff-727b-445c-f6bd-613fc8725a@google.com>
References: <20210223204337.2785120-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 23 Feb 2021, Shakeel Butt wrote:

> In the era of async memcg oom-killer, the commit a0d8b00a3381 ("mm:
> memcg: do not declare OOM from __GFP_NOFAIL allocations") added the code
> to skip memcg oom-killer for __GFP_NOFAIL allocations. The reason was
> that the __GFP_NOFAIL callers will not enter aync oom synchronization
> path and will keep the task marked as in memcg oom. At that time the
> tasks marked in memcg oom can bypass the memcg limits and the oom
> synchronization would have happened later in the later userspace
> triggered page fault. Thus letting the task marked as under memcg oom
> bypass the memcg limit for arbitrary time.
> 
> With the synchronous memcg oom-killer (commit 29ef680ae7c21 ("memcg,
> oom: move out_of_memory back to the charge path")) and not letting the
> task marked under memcg oom to bypass the memcg limits (commit
> 1f14c1ac19aa4 ("mm: memcg: do not allow task about to OOM kill to bypass
> the limit")), we can again allow __GFP_NOFAIL allocations to trigger
> memcg oom-kill. This will make memcg oom behavior closer to page
> allocator oom behavior.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: David Rientjes <rientjes@google.com>
