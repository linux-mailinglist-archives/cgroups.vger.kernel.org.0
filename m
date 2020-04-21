Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1D1B2BF6
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDUQLp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 12:11:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUQLo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 12:11:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id k13so15894235wrw.7
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 09:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xGOHcB1wdXfLpDSjYFqP5FMVUkbxcEYVFuq7uOGvyw=;
        b=dy+X5xGqwI/63V0Cpa9w9xffah//tHMjs7XJU869Pa/bkDzGRIx6e7zXjF5XvWpzik
         k/uWJ9MyF8lvW/wLzMfs0ZnsHG/UJQAPdnmQXC+9xV2JlioPxb3HSK/NSelt1UTQ2Qkb
         IjPWjnv7eM+OfcLrEOlFG2aJiDsfbTigridWZaqaHoNJnvATBwIHucmTNNAPA6HgxEbr
         UrreviIWeG1LwhMFXYvyY61/kpKVbU47UyRgC7w14ljyfqr2GGgTRWEPc3OKo44jlPNN
         FvJ/m2DyBgrDP5eGMG4Dy2tB8kbtdc8UrcqdDPLZndjgx/tsQ53lUwZLEj/3ry9/Px9T
         Npkg==
X-Gm-Message-State: AGi0PuZUrDd7imRnd6Dc64pCvd/zqKELmlcC50kTxeBSlhJ+Cx06Cchc
        +CV9myLluCQL5JOoP2p7jy9sXxXs
X-Google-Smtp-Source: APiQypKS8jKnIGiQyPPCQosgOYHv5MHCWZ8AHYPCghFIWT4yfUyjRCRiF6lOgnoHwFYeudLGhF2leQ==
X-Received: by 2002:a5d:6945:: with SMTP id r5mr27002238wrw.363.1587485501193;
        Tue, 21 Apr 2020 09:11:41 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id m8sm4394137wrx.54.2020.04.21.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:11:40 -0700 (PDT)
Date:   Tue, 21 Apr 2020 18:11:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200421161138.GL27314@dhcp22.suse.cz>
References: <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
 <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142746.GA341682@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-04-20 10:27:46, Johannes Weiner wrote:
> On Tue, Apr 21, 2020 at 01:06:12PM +0200, Michal Hocko wrote:
[...]
> > I am also not sure about the isolation aspect. Because an external
> > memory pressure might have pushed out memory to the swap and then the
> > workload is throttled based on an external event. Compare that to the
> > memory.high throttling which is not directly affected by the external
> > pressure.
> 
> Neither memory.high nor swap.high isolate from external pressure.

I didn't say they do. What I am saying is that an external pressure
might punish swap.high memcg because the external memory pressure would
eat up the quota and trigger the throttling.

It is fair to say that this externally triggered interference is already
possible with swap.max as well though. It would likely be just more
verbose because of the oom killer intervention rather than a slowdown.

> They
> are put on cgroups so they don't cause pressure on other cgroups. Swap
> is required when either your footprint grows or your available space
> shrinks. That's why it behaves like that.
> 
> That being said, I think we're getting lost in the implementation
> details before we have established what the purpose of this all
> is. Let's talk about this first.

Thanks for describing it in the length. I have a better picture of the
intention (this should have been in the changelog ideally). I can see
how the swap consumption throttling might be useful but I still dislike the
proposed implementation. Mostly because of throttling of all allocations
regardless whether they can contribute to the swap consumption or not.
-- 
Michal Hocko
SUSE Labs
