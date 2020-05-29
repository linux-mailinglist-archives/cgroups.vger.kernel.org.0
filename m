Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9D1E7A3A
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2020 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgE2KOQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 May 2020 06:14:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47039 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KOQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 May 2020 06:14:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id x6so2804037wrm.13;
        Fri, 29 May 2020 03:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fjFkfyPnmnUfjK5e2Sor0/7zNo8bV0z4i3upTl22etI=;
        b=SCKcij5o2xoAksurGFnAQCjmwbAATxb99+6DRffbNwxZ0wHQdPIB5gfZif40rqUvYj
         dily348aNOOiEsvxh5zPqyM3bVvL6XwsnKpJcUlOf6xnApip3J3S009VTOggnEYNUHU4
         J0iky8L7NEuIpFHHqneP8xUzC55xM5VC1PlP2a3yYqlVdEdZz2vRO9agqxLEXCI2kNLD
         u8GX1o1UcDzQRwitBn/GfsPnbOl2BPDMe5XI1P7+U4scCY9LPrRFvjzOTIIDn9X33Dq+
         1uSO6tK0NpbAGtA6rBeI3F/+AM4t8Y9kvIVlDo3we3kg7IMK/4nygpAYP75wdxZihk0b
         jubQ==
X-Gm-Message-State: AOAM531vBN/eo44+u4WjSJRhEKVjR7QJzdxfjmUHKRRfsTyaXOJB7VPA
        6i5S5gtN2OYA0TkV1ZheHH8=
X-Google-Smtp-Source: ABdhPJzn6aLmwokj6tmIfnCNGo7vbtKiJNtoOPTx7wRTRPgg9TfVmfq8xS6pGLVOfpzsROcTGZanFw==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr7777167wrv.330.1590747254204;
        Fri, 29 May 2020 03:14:14 -0700 (PDT)
Received: from localhost (ip-37-188-178-109.eurotel.cz. [37.188.178.109])
        by smtp.gmail.com with ESMTPSA id y17sm5355217wrn.12.2020.05.29.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:14:13 -0700 (PDT)
Date:   Fri, 29 May 2020 12:14:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200529101412.GJ4406@dhcp22.suse.cz>
References: <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
 <20200521173701.GX6462@dhcp22.suse.cz>
 <20200521184505.GA815980@cmpxchg.org>
 <20200528163101.GJ27484@dhcp22.suse.cz>
 <20200528164848.GB839178@chrisdown.name>
 <20200529073118.GE4406@dhcp22.suse.cz>
 <20200529100858.GA98458@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529100858.GA98458@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 29-05-20 11:08:58, Chris Down wrote:
> Michal Hocko writes:
> > > > > task->memcg_nr_pages_over_high is not vague, it's a best-effort
> > > > > mechanism to distribute fairness. It's the current task's share of the
> > > > > cgroup's overage, and it allows us in the majority of situations to
> > > > > distribute reclaim work and sleeps in proportion to how much the task
> > > > > is actually at fault.
> > > >
> > > > Agreed. But this stops being the case as soon as the reclaim target has
> > > > been reached and new reclaim attempts are enforced because the memcg is
> > > > still above the high limit. Because then you have a completely different
> > > > reclaim target - get down to the limit. This would be especially visible
> > > > with a large memcg_nr_pages_over_high which could even lead to an over
> > > > reclaim.
> > > 
> > > We actually over reclaim even before this patch -- this patch doesn't bring
> > > much new in that regard.
> > > 
> > > Tracing try_to_free_pages for a cgroup at the memory.high threshold shows
> > > that before this change, we sometimes even reclaim on the order of twice the
> > > number of pages requested. For example, I see cases where we requested 1000
> > > pages to be reclaimed, but end up reclaiming 2000 in a single reclaim
> > > attempt.
> > 
> > This is interesting and worth looking into. I am aware that we can
> > reclaim potentially much more pages during the icache reclaim and that
> > there was a heated discussion without any fix merged in the end IIRC.
> > Do you have any details?
> 
> Sure, we can look into this more, but let's do it separately from this patch
> -- I don't see that its merging should be contingent on that discussion :-)

Yes that is a separate issue.
-- 
Michal Hocko
SUSE Labs
