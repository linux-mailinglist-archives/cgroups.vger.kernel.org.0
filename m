Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8560E15C477
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgBMPrh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 10:47:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37252 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387954AbgBMPrf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 10:47:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so7316494wme.2;
        Thu, 13 Feb 2020 07:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5uXyT83XmwzqIv81PcbryxoH+hy+LWMbBfLl6tfeT00=;
        b=f71fp5kRilWeZ/X85i7HXAUlHqEhhruaM2RwVQK3n6Iw47YcZ06vYnSzKFuTLPu0N7
         LvAHl7U02QhaLtgbEJEwHVel5bEe5gzq7SFNPwnKD34htkcQv+a28S6/RrgwoRmLHs+P
         HZDmrteNcLAcQLgH3OnRfSu6ui3UGkRCYksiobKno2+55PZk7xNX05037hR3CLPlpngd
         1DYrMO/aNHsu5znR1YS7UAxkQmUd+rUWyY6K0r4rGbMsXEzkZZdEOoTVidMP4HzV13B8
         rs0RwUHOPZm3h9bjXlIJZo9uEdaWLcWvCJQ0no/LSaQaLR0cJqNagLmDSuksJhfHk2Rq
         udFw==
X-Gm-Message-State: APjAAAWgoof23i1f0tYia8kbgDV9hZOO7Jiwtd3iyvSbcpIQZHsutpA5
        i7jlK3UF7FR5L4iyb7Xj7dM=
X-Google-Smtp-Source: APXvYqySk5ibJ4zkMSmy5HjIdccuefOJG5Dt7qTPHsKlLzNxOGy6HMI9u8O36DZcSV4dUIWKcQ6T5A==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr6215705wme.125.1581608853032;
        Thu, 13 Feb 2020 07:47:33 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id s8sm3464724wrt.57.2020.02.13.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:47:32 -0800 (PST)
Date:   Thu, 13 Feb 2020 16:47:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213154731.GE31689@dhcp22.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213135348.GF88887@mtj.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 13-02-20 08:53:48, Tejun Heo wrote:
> Hello, Michal.
> 
> On Thu, Feb 13, 2020 at 08:40:49AM +0100, Michal Hocko wrote:
> > So how are we going to deal with hierarchies where the actual workload
> > of interest is a leaf deeper in the hierarchy and the upper levels of
> > the hierarchy are shared between unrelated workloads?  Look at how
> > systemd organizes system into cgroups for example (slices vs. scopes)
> > and say you want to add a protection to a single user or a service.
> 
> The above scenario where descendants of a cgroup behave unrelated to
> each other sound plausible in theory but doesn't really work in
> practice because memory management is closely tied with IO and all IO
> control mechanisms are strictly hierarchical and arbitrate
> level-by-level.
>
> A workload's memory footprint can't be protected without protecting
> its IOs and a descendant cgroup's IOs can't be protected without
> protecting its ancestors, so implementing that in memory controller in
> isolation, while doable, won't serve many practical purposes. It just
> ends up creating cgroups which are punished on memory while greedly
> burning up IOs.
> 
> The same pattern for CPU control, so for any practical configuration,
> the hierarchy layout has to follow the resource distribution hierarchy
> of the system - it's what the whole thing is for after all. The
> existing memory.min/low semantics is mostly from failing to recognize
> them being closely intertwined with IO and resembling weight based
> control mechanisms, and rather blindly copying memory.high/max
> behaviors, for which, btw, individual configurations may make sense.

Well, I would tend to agree but I can see an existing cgroup hierarchy
imposed by systemd and that is more about "logical" organization of
processes based on their purpose than anything resembling resources.
So what can we do about that to make it all work?
-- 
Michal Hocko
SUSE Labs
