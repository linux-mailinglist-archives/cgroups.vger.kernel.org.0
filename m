Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7821D58A9
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEOSJ3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSJ2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 14:09:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5BFC061A0C
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 11:09:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b6so3471787qkh.11
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtzLCBVok8XlbDgDkip+DgPbXfjB0Ty8UH/3nIag75g=;
        b=PWW0GHaOTt1grzeYKkoIvWRXSG1ezxAQ+T3eDFecYfulUEoEJYp420H3TUxznxZXQ1
         9lmGHfjOikCYafK145P0664YqWXjwb4EGqCEWKoudJakCv8Dw1OXKswDI/STZl84s0oj
         FdHtIChT8Sant8We8ACswlssnUtp1DMS9fkJLszaFdnX3veOh9/6Cx9Liy4idE0Ng0ft
         t1uS6PEF6Jr4UxM7+nsO1+Vcco4BLQ36HwyN/C+YXmXX+cx7z/wgen2muSrBI9qh39hf
         6/CXUnvoyK9hziUMbIPb/ehW4roSn+H/XCPV41JvgL3t2j69yBmk3DHDxruevgNlwBEx
         927w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtzLCBVok8XlbDgDkip+DgPbXfjB0Ty8UH/3nIag75g=;
        b=QNms4Y+C9PbjIwuTSnNFcg/irS7nf8+NO0qpKc8XtOq2UJ5bOrPrjxyHpiGCHV1FuI
         EPJUMRTDLg8PFzKtGurPvl72u0E+Wr/jEGwujbJpG3Cy7AvowylO/vSCV1BksFTM/jIZ
         mdF5eWJ9dr5St6ad1kJvs2/wVOOFwOaGpiyoO8w0kS+fBOtX/XfaAqL7EkUAe1fGl2Jn
         NtA6Hy9oOHJcZAzSIWBfGEXVDBIWYUYlSSDicVLH9/X1DhCygpMJ8LYFOSnOrrpAqqlH
         Ngh43nAfGzs+rux6LDcF2f6FRLqYJVA7Y59C8OCrv6juN/O5TLg8izzuQuui/1Rr8g2F
         uqgw==
X-Gm-Message-State: AOAM533bkVi7afS89ju6z2B9szhLH0TbV4ypbeNYoGQUQDaC+NUrtQiD
        zdQdOFJ+EzMEMtDEhjLzBoYKvg==
X-Google-Smtp-Source: ABdhPJysqfBouqJQhvsnrhs4XntBJ+MuFFmcGCdoQqqmwUBGOQ1dCTh6LZSFcednwifZXtSzt759Bg==
X-Received: by 2002:ae9:e418:: with SMTP id q24mr4580879qkc.69.1589566167550;
        Fri, 15 May 2020 11:09:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:90a4])
        by smtp.gmail.com with ESMTPSA id z15sm2113327qkg.70.2020.05.15.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:09:26 -0700 (PDT)
Date:   Fri, 15 May 2020 14:09:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
Message-ID: <20200515180906.GA630613@cmpxchg.org>
References: <20200508170630.94406-1-shakeelb@google.com>
 <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz>
 <20200515132421.GC591266@cmpxchg.org>
 <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com>
 <20200515150026.GA94522@carbon.DHCP.thefacebook.com>
 <CALvZod5EHzK-UzS9WgkzpZ2T+WwA8LottxrTzUi3qFwvUbOk4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5EHzK-UzS9WgkzpZ2T+WwA8LottxrTzUi3qFwvUbOk4w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 10:49:22AM -0700, Shakeel Butt wrote:
> On Fri, May 15, 2020 at 8:00 AM Roman Gushchin <guro@fb.com> wrote:
> > On Fri, May 15, 2020 at 06:44:44AM -0700, Shakeel Butt wrote:
> > > On Fri, May 15, 2020 at 6:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > You're right. It should only bypass the page_counter, but still set
> > > > page->mem_cgroup = root_mem_cgroup, just like user pages.
> >
> > What about kernel threads? We consider them belonging to the root memory
> > cgroup. Should their memory consumption being considered in root-level stats?
> >
> > I'm not sure we really want it, but I guess we need to document how
> > kernel threads are handled.
> 
> What will be the cons of updating root-level stats for kthreads?

Should kernel threads be doing GFP_ACCOUNT allocations without
memalloc_use_memcg()? GFP_ACCOUNT implies that the memory consumption
can be significant and should be attributed to userspace activity.

If the kernel thread has no userspace entity to blame, it seems to
imply the same thing as a !GFP_ACCOUNT allocation: shared public
infrastructure, not interesting to account to any specific cgroup.

I'm not sure if we have such allocations right now. But IMO we should
not account anything from kthreads, or interrupts for that matter,
/unless/ there is a specific active_memcg that was set by the kthread
or the interrupt.
