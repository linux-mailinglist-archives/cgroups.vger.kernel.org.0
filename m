Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1B1B1284
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2020 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDTRDX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 13:03:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53486 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTRDX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 13:03:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id t63so337354wmt.3
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 10:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFcq+KJ7nex/3/zHos6XG2e5P8zQqGR75E6IUmO9bGA=;
        b=Qn04eMju/8h5bBFkayHGqN0x15/qEUVz7hEOdhsQEp6zZ1aty29PorEjm04weCyTF6
         wqD89DQUx8kdkiGuVlTYz5wIrDmLsZgFQw4EgvJcgcUvUmpmMbqA+7//PvgWC4qolqf/
         YccBYDGCYudctu6bSxuJXhKF6EqHJudYcsWq7kE9RNH/PVuYrepSbrtFnI3v54UrikVp
         DgMo0XYpnUujwh9rfPYKTjVwThJJ69OogIBfOY7gokjPFnQA4i0D0ygJjA7nC4gQEyKM
         5eJ2dOjcuv6SlUawU57u0L3i/bDftNCB06cXxGTfFNtP1H1aSMH59PfTFHjH2YHQdr27
         Iptw==
X-Gm-Message-State: AGi0PubsNSsIoDn/9p7ON6zhdCtYcgiLZ8mrCH1XWThre5rI8i7kIav/
        bNKJGWnj+B91MYGYh64TbM8=
X-Google-Smtp-Source: APiQypKmtS5iiplXI7XLeYNuhSv1crqhGJVS4inBpCPIiVv3e1+nHngOa4d7S0OfSto48QKXMj9AYg==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr331081wmf.168.1587402201215;
        Mon, 20 Apr 2020 10:03:21 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id n2sm122205wrq.74.2020.04.20.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:03:19 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:03:18 +0200
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
Message-ID: <20200420170318.GV27314@dhcp22.suse.cz>
References: <CALvZod78ZUhU+yr2x1h_gv+VgVGTPnSSGKh_+fd+MeiAKreJvg@mail.gmail.com>
 <20200417162355.GA43469@mtj.thefacebook.com>
 <CALvZod4ftvXCu8SbQUXwTGVvx5K2+at9h30r28chZLXEB1JdfQ@mail.gmail.com>
 <20200417173615.GB43469@mtj.thefacebook.com>
 <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
 <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420164740.GF43469@mtj.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 20-04-20 12:47:40, Tejun Heo wrote:
[...]
> > Coming back to this path series, to me, it seems like the patch series
> > is contrary to the vision you are presenting. Though the users are not
> > setting memory.[high|max] but they are setting swap.max and this
> > series is asking to set one more tunable i.e. swap.high. The approach
> > more consistent with the presented vision is to throttle or slow down
> > the allocators when the system swap is near full and there is no need
> > to set swap.max or swap.high.

I have the same impression as Shakeel here. The overall information we
have here is really scarce.
 
> It's a piece of the puzzle to make memory protection work comprehensively.
> You can argue that the fact swap isn't protection based is against the
> direction but I find that argument rather facetious as swap is quite
> different resource from memory and it's not like I'm saying limits shouldn't
> be used at all. There sure still are missing pieces - ie. slowing down on
> global depletion, but that doesn't mean swap.high isn't useful.

I have asked about the semantic of this know already and didn't really
get any real answer. So how does swap.high fit into high limit semantic
when it doesn't act as a limit. Considering that we cannot reclaim swap
space I find this really hard to grasp.

We definitely need more information here!
-- 
Michal Hocko
SUSE Labs
