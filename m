Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32DB39C52B
	for <lists+cgroups@lfdr.de>; Sat,  5 Jun 2021 04:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFECgO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Jun 2021 22:36:14 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:42613 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFECgN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Jun 2021 22:36:13 -0400
Received: by mail-qk1-f177.google.com with SMTP id o27so11307454qkj.9;
        Fri, 04 Jun 2021 19:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=29lRJsQjuBV2gkxHmcl0YVsXyBr/DK6wvVETfCNeSS8=;
        b=aSH8OR3l/TfW20lHlGMmlBEnNYwKTY0v8ReDqkEYtQHu5zJs4KWJRoMClaKHyHg94b
         2KRQPJX8RvzkJsaPljq1XDIm2Q1SXes1rxRAhzxPRJMmLJwIch/xhYeRd2V0Hofxhxn6
         HUNSe5Tra7C39A9YWrS3wPH4b+4O2NE/qdQ1b4aE+HlNwIY2FzAwj6pFFiX2LtZBHLA3
         0PCeTq/zQXTKAwYhvjf/RTO9AJWfyeivntfDgfjMcihsdvv5Z55jRj+QLHeJjV5mVpj4
         P1+QKq6Oi/8KH06mJJNfSYgiqQ08a8ndd+4HVD6xQ/ARs0mB1nqIlRWVeS0gXkAutKck
         p69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=29lRJsQjuBV2gkxHmcl0YVsXyBr/DK6wvVETfCNeSS8=;
        b=pgNIM1rQQ2qwNMu9cjFvX+NPDOIkAYpAp4UQFPx/Z7DjBr2bWHRITkayt7Xg6Exi09
         xNL82G8CcTPu4edCaKPyZ7jrS7a9RgAqH5XXH4JcRrcPT87Tk85FTL5IO+xdD05j0dd4
         aoZ8EqcBTIh8YtOEZ0pOr5pyE04CrC96eQSqjM1gXZqUasrBF5MXXPuTFD6XP7IWABoB
         2wflTa5QoW5F9s8+NTLJR2F8BdiB/5xEJAI+GYHFW7ZqB7cSlebQJi0leetvdfsff39K
         XTlaCFF06T5FQmOAhRI+aydyS7kjGINviePW3re0pMlaTyyFY0+zCBIhPeq/RSI4owK6
         FzgA==
X-Gm-Message-State: AOAM530IxdyWU9CYMD5GsOrDaRhYUDw2XfjOhjupsBEfqZ+iz1BktuYo
        gmwVGSd0k3G5sYn/V92d+Yo=
X-Google-Smtp-Source: ABdhPJwhKwm6a4V61vXZJdslM1kmfF6HFy08XQlmG5ri4zgtEbaCRSZHp+P0I6+EbWNCbzzzfNK4Aw==
X-Received: by 2002:a37:cc5:: with SMTP id 188mr7169959qkm.112.1622860393300;
        Fri, 04 Jun 2021 19:33:13 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id a134sm3536688qkg.114.2021.06.04.19.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:33:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 22:33:11 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: periodically flush the memcg stats
Message-ID: <YLriZxiWo+2hMI7g@slm.duckdns.org>
References: <20210604015640.2586269-1-shakeelb@google.com>
 <20210604061816.3110-1-hdanton@sina.com>
 <20210605015421.5096-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605015421.5096-1-hdanton@sina.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 05, 2021 at 09:54:21AM +0800, Hillf Danton wrote:
> The cond_resched() in cgroup_rstat_flush_locked() matches its appearence in
> your post [1]. So does unbound IMHO.

Ah yeah, this either needs CPU_INTENSIVE or UNBOUND, prolly the latter is
better.

> And the short stuff [2] looks to me like it is incorrect to queue a work
> acquiring mutex lock on to the system_wq. IOW the unbound wq is the right
> thing for any work that might sleep.

This part doesn't make sense. Blocking from per-cpu workqueue is completely
fine. What's not fine is consuming a lot of CPU cycles.

Thanks.

-- 
tejun
