Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB87A221387
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2020 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgGORdz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jul 2020 13:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgGORdy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jul 2020 13:33:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED32C061755
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 10:33:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 207so2399450pfu.3
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PVtPnpDCnFAQV5fwXJEr/RSTBynO8Xc9u6VPuoN4lxA=;
        b=m+o1DG5c/kUGkAGKg+4+dMc3sD7jL5tBy8wqLGklDhgrqf3vjFdT77jGABzg9RUPAt
         XyP7bfZfakKBiM8EpPa4na/ojGxr4Sq2ANVLuQUQWAElOYsfwEYqDO0u8N/t16ayK4XT
         iVJTOLDCrLvwqcTkmdpqjCf8WQNDQsyvNb7We/6fpOL95rNZmN+2RLvMwv2yS1IG51Je
         wRFx7kcVbYKamIHIJvvS8YnodYPyqw2Q0alj0x7sIHHl5ZFp3LdlGzNM4RhlSulYx0HI
         v80pbORRaUrVa+WfDL3e5fR/kQHzO9TqunphHMMcwxDcN2RgoQ6mmy/gMRE4EFHuLYMv
         pvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PVtPnpDCnFAQV5fwXJEr/RSTBynO8Xc9u6VPuoN4lxA=;
        b=WRav0jWpNvqrHlr94dWj2tG74sgO78Ouz7ZC2v9FANELPv+YhVrm03Zy1nFjLa4rGt
         laa+qNnjKYItlLq4qD9XB0KxSh9ivbiobvfFAm38QicJnCcryYYsCxB5WbOaJ0UQsSKK
         lFDIbxAfzD4oAi2sd5KCmxr4ETnokevSZP2rlKn12IpwTI+y5/1xk4C2q5rIXACQ7Xu7
         D3QxJbP4H4HmUFzJ/qJcLVPx77mqx59wn2ag4QVOUGaRoav5fGEoePG73g1GQ2N/Eq8W
         QzZZBo78SGKFyOqtlhGSBgZS+O3EG2aAbPIDuWNvv51f5IYdirHyccNNQVuYxnwYKjcn
         mb2A==
X-Gm-Message-State: AOAM5333Oym8WakdC/fJk9cPJx+BL5DWpYp1QgM4KVEiw//U/059jknI
        kFMRu/lzaMLNpVozpW9Yfju2DA==
X-Google-Smtp-Source: ABdhPJwC6YWxRprlzzKpQux0td0cZKqnGWBYmUE/fwY7ZrMAKm28ifk0okyLyHdlM373de72fL4dVw==
X-Received: by 2002:a63:5b55:: with SMTP id l21mr723987pgm.348.1594834433632;
        Wed, 15 Jul 2020 10:33:53 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id q11sm2651130pjj.17.2020.07.15.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 10:33:53 -0700 (PDT)
Date:   Wed, 15 Jul 2020 10:33:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     SeongJae Park <sjpark@amazon.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Re: [patch] mm, memcg: provide a stat to describe reclaimable
 memory
In-Reply-To: <20200715071522.19663-1-sjpark@amazon.com>
Message-ID: <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com>
References: <20200715071522.19663-1-sjpark@amazon.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 15 Jul 2020, SeongJae Park wrote:

> > An alternative to this would also be to change from an "available" metric 
> > to an "anon_reclaimable" metric since both the deferred split queues and 
> > lazy freeable memory would pertain to anon.  This would no longer attempt 
> > to mimic MemAvailable and leave any such calculation to userspace
> > (anon_reclaimable + (file + slab_reclaimable) / 2).
> > 
> > With this route, care would need to be taken to clearly indicate that 
> > anon_reclaimable is not necessarily a subset of the "anon" metric since 
> > reclaimable memory from compound pages on deferred split queues is not 
> > mapped, so it doesn't show up in NR_ANON_MAPPED.
> > 
> > I'm indifferent to either approach and would be happy to switch to 
> > anon_reclaimable if others agree and doesn't foresee any extensibility 
> > issues.
> 
> Agreed, I was also once confused about the 'MemAvailable'.  The 'reclaimable'
> might be better to understand.
> 

Hi SeongJae,

I'm leaning in that direction now too, actually, because I reasoned that 
determining the precise amount of anon that can be reclaimed would require 
subtracting (file + slab_reclaimable) / 2, which is awkward :)

So I'll send a follow-up patch to add only an anon_reclaimable field which 
is good enough for our purposes unless others would like to have more 
discussion.

Thanks!
