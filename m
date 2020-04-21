Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2F1B2498
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDULGR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 07:06:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42646 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDULGQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 07:06:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id j2so15959378wrs.9
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 04:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2nkEiPu8uzKgfWBfH+N6bOnXiYHqmdeCCwtF75WBrZI=;
        b=HL7UAeFEOAn/CmFkf8vIY7CFFRkUqBjb7ISN8yx0nTqZFr+q6DiBUQoEorDCZA8Gin
         KcSxFmz6hmxNfzD79dyg7D3SOFS3pQiWdrdAaw0CSRKrPxDMkp+IY5I7Crt6CE+R1ATt
         /649AbvlP5nZ+B++5HVtJZO413lkfvS26i3BuxUt+IX4Kwptb61MTk2CF0WDmy/HZi3T
         fLM9W8bbpZhtYBu08GwrqRaL3iK4sMw7zXCXxjkCLOEyRfTAx7xvJDSZ8ehGpYewB8Im
         FVXlAUxQXEkXOBvs7vt2vdfd+ySczn5So2NNvdR7w4fk6uVrL6OXklte5gLR+j0TJMOB
         oQWQ==
X-Gm-Message-State: AGi0PuZGgHLJ1sf9JUPriBOoaHD1G4AbMrH3RdROK0unhK3gsfaN+UMf
        jzC23gplUam2+mDrzpVNEe8=
X-Google-Smtp-Source: APiQypI/MweFCuZznGg//eUIIqXcEw1/HuGfprCFuIVCQ6pCwNymcQ39WpMXnD/OF0nxFa5hDK+c8Q==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr23379143wrr.299.1587467174727;
        Tue, 21 Apr 2020 04:06:14 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id s11sm3251624wrw.71.2020.04.21.04.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 04:06:13 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:06:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200421110612.GD27314@dhcp22.suse.cz>
References: <CALvZod4ftvXCu8SbQUXwTGVvx5K2+at9h30r28chZLXEB1JdfQ@mail.gmail.com>
 <20200417173615.GB43469@mtj.thefacebook.com>
 <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
 <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420170650.GA169746@mtj.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 20-04-20 13:06:50, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 20, 2020 at 07:03:18PM +0200, Michal Hocko wrote:
> > I have asked about the semantic of this know already and didn't really
> > get any real answer. So how does swap.high fit into high limit semantic
> > when it doesn't act as a limit. Considering that we cannot reclaim swap
> > space I find this really hard to grasp.
> 
> memory.high slow down is for the case when memory reclaim can't be depended
> upon for throttling, right? This is the same. Swap can't be reclaimed so the
> backpressure is applied by slowing down the source, the same way memory.high
> does.

Hmm, but the two differ quite considerably that we do not reclaim any
swap which means that while no reclaimable memory at all is pretty much
the corner case (essentially OOM) the no reclaimable swap is always in
that state. So whenever you hit the high limit there is no other way
then rely on userspace to unmap swap backed memory or increase the limit.
Without that there is always throttling. The question also is what do
you want to throttle in that case? Any swap backed allocation or swap
based reclaim? The patch throttles any allocations unless I am
misreading. This means that also any other !swap backed allocations get
throttled as soon as the swap quota is reached. Is this really desirable
behavior? I would find it quite surprising to say the least.

I am also not sure about the isolation aspect. Because an external
memory pressure might have pushed out memory to the swap and then the
workload is throttled based on an external event. Compare that to the
memory.high throttling which is not directly affected by the external
pressure.

There is also an aspect of non-determinism. There is no control over
the file vs. swap backed reclaim decision for memcgs. That means that
behavior is going to be very dependent on the internal implementation of
the reclaim. More swapping is going to fill up swap quota quicker.

> It fits together with memory.low in that it prevents runaway anon allocation
> when swap can't be allocated anymore. It's addressing the same problem that
> memory.high slowdown does. It's just a different vector.

I suspect that the problem is more related to the swap being handled as
a separate resource. And it is still not clear to me why it is easier
for you to tune swap.high than memory.high. You have said that you do
not want to set up memory.high because it is harder to tune but I do
not see why swap is easier in this regards. Maybe it is just that the
swap is almost never used so a bad estimate is much easier to tolerate
and you really do care about runaways?
-- 
Michal Hocko
SUSE Labs
