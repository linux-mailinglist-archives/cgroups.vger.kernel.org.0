Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0525220F46
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfEPTjq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 15:39:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46265 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfEPTjq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 15:39:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so2994187qkb.13
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T3TWfXblftMryTy5YYe1QuFSmBPKVGwU4LtYZZy44sM=;
        b=EuP2JyMWZuEqQSSb9qm8/VH2TZKA4tAva0HtQq/15iOG1B1O0/fO89PMURETeyFVI2
         hVxIKel+zvtrbTdSObuGsGc+8w1r+K7bphTHsjtag9CivpW6pMw2oKXEJWSaj3o861hd
         SlF19YKR458DlftlqqQpYTtO6uDWvNS2ZcdOvsmtXOuCx1YNmKDxF5pGp0YHtCevcVvS
         zzRkjO02U0671TgFPmasooXsfQ7BChSx07bFNCBPGN/J0D4XVbz//4mzF1X5zFAgJYVw
         MX1bB+iuNjswJC8X5vMl9LVXClrPJycBS7YflKUlUVEKMPBlHHqYu9buUwg7zTvb8Eit
         r0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T3TWfXblftMryTy5YYe1QuFSmBPKVGwU4LtYZZy44sM=;
        b=qtIjVj+6fXFzFmAxw5SFfHjxVOeXxeNDsCDEJV6EBhsgk74GDCvbTxF/U9Z4K/FF6o
         lQLOVKT+dwj2xHfRSxWtL1WrDWrWFx+VdE7DX8TCfa83uaZ4gYlJg6FS4Eb79g0XJdL7
         nWzEO8TFcqLCgXCUx0vw2P3N6+jLlphsq97JXF1aYRemSYwoVEfQTKYz96bQ64Hy07vM
         zDhTwsqFSvEBveHcdT323aSKQl0zycOVDV7uw8yqvowGtY2Ninkh1eu2tzNELFGhdWfR
         CB4YcoOLc/V6clajQBexWjrYmGEeHk++uM0ZiEvwIg4G01EA1FIVQsHa8Bs5AqJz02E/
         7ukA==
X-Gm-Message-State: APjAAAXE5lgUPFgSddJdQ31DR8e0TLVgGsm0cDxTMdPqx11XyyIyKVun
        9TKlJL178r8PXxAruqEoLv9oFg==
X-Google-Smtp-Source: APXvYqyXzrPmLnUTegboDPa0coBi3GOvuV8AelsOB+QspwM/SsH6lEIYJ92uf26Wi1L4lY0Wnysh4g==
X-Received: by 2002:a05:620a:12ea:: with SMTP id f10mr41900883qkl.28.1558035585171;
        Thu, 16 May 2019 12:39:45 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id x23sm2066157qto.20.2019.05.16.12.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 12:39:44 -0700 (PDT)
Date:   Thu, 16 May 2019 15:39:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        tj@kernel.org, guro@fb.com, dennis@kernel.org,
        chris@chrisdown.name,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-ID: <20190516193943.GA26439@cmpxchg.org>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz>
 <20190516175655.GA25818@cmpxchg.org>
 <20190516180932.GA13208@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516180932.GA13208@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 08:10:42PM +0200, Michal Hocko wrote:
> On Thu 16-05-19 13:56:55, Johannes Weiner wrote:
> > On Wed, Feb 13, 2019 at 01:47:29PM +0100, Michal Hocko wrote:
> > > On Tue 12-02-19 14:45:42, Andrew Morton wrote:
> > > [...]
> > > > From: Chris Down <chris@chrisdown.name>
> > > > Subject: mm, memcg: consider subtrees in memory.events
> > > > 
> > > > memory.stat and other files already consider subtrees in their output, and
> > > > we should too in order to not present an inconsistent interface.
> > > > 
> > > > The current situation is fairly confusing, because people interacting with
> > > > cgroups expect hierarchical behaviour in the vein of memory.stat,
> > > > cgroup.events, and other files.  For example, this causes confusion when
> > > > debugging reclaim events under low, as currently these always read "0" at
> > > > non-leaf memcg nodes, which frequently causes people to misdiagnose breach
> > > > behaviour.  The same confusion applies to other counters in this file when
> > > > debugging issues.
> > > > 
> > > > Aggregation is done at write time instead of at read-time since these
> > > > counters aren't hot (unlike memory.stat which is per-page, so it does it
> > > > at read time), and it makes sense to bundle this with the file
> > > > notifications.
> > > > 
> > > > After this patch, events are propagated up the hierarchy:
> > > > 
> > > >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> > > >     low 0
> > > >     high 0
> > > >     max 0
> > > >     oom 0
> > > >     oom_kill 0
> > > >     [root@ktst ~]# systemd-run -p MemoryMax=1 true
> > > >     Running as unit: run-r251162a189fb4562b9dabfdc9b0422f5.service
> > > >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> > > >     low 0
> > > >     high 0
> > > >     max 7
> > > >     oom 1
> > > >     oom_kill 1
> > > > 
> > > > As this is a change in behaviour, this can be reverted to the old
> > > > behaviour by mounting with the `memory_localevents' flag set.  However, we
> > > > use the new behaviour by default as there's a lack of evidence that there
> > > > are any current users of memory.events that would find this change
> > > > undesirable.
> > > > 
> > > > Link: http://lkml.kernel.org/r/20190208224419.GA24772@chrisdown.name
> > > > Signed-off-by: Chris Down <chris@chrisdown.name>
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Cc: Michal Hocko <mhocko@kernel.org>
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Cc: Roman Gushchin <guro@fb.com>
> > > > Cc: Dennis Zhou <dennis@kernel.org>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > FTR: As I've already said here [1] I can live with this change as long
> > > as there is a larger consensus among cgroup v2 users. So let's give this
> > > some more time before merging to see whether there is such a consensus.
> > > 
> > > [1] http://lkml.kernel.org/r/20190201102515.GK11599@dhcp22.suse.cz
> > 
> > It's been three months without any objections.
> 
> It's been three months without any _feedback_ from anybody. It might
> very well be true that people just do not read these emails or do not
> care one way or another.

This is exactly the type of stuff that Mel was talking about at LSFMM
not even two weeks ago. How one objection, however absurd, can cause
"controversy" and block an effort to address a mistake we have made in
the past that is now actively causing problems for real users.

And now after stalling this fix for three months to wait for unlikely
objections, you're moving the goal post. This is frustrating.

Nobody else is speaking up because the current user base is very small
and because the idea that anybody has developed against and is relying
on the current problematic behavior is completely contrived. In
reality, the behavior surprises people and causes production issues.

> > Can we merge this for
> > v5.2 please? We still have users complaining about this inconsistent
> > behavior (the last one was yesterday) and we'd rather not carry any
> > out of tree patches.
> 
> Could you point me to those complains or is this something internal?

It's something internal, unfortunately, or I'd link to it.

In this report yesterday, the user missed OOM kills that occured in
nested subgroups of individual job components. They monitor the entire
job status and health at the top-level "job" cgroup: total memory
usage, VM activity and trends from memory.stat, pressure for cpu, io,
memory etc. All of these are recursive. They assumed they could
monitor memory.events likewise and were left in the assumption that
everything was fine when in reality there was OOM killing going on in
one of the leaves.

Such negative surprises really suck. But what's worse is that now that
they are aware of it, there is still no good solution for them because
periodically polling the entire subtree for events in leaves is not
practical. There could be a lot of cgroups, which is why we put so
much effort recently into improving the hierarchical stat aggregation.

I'd really like to get this fixed, and preferably in a way that does
deviate from upstream, and does not force the same downtimes and
wasted engineering hours on everybody who is going to switch to
cgroup2 in the next couple of years.
