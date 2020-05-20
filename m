Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAD81DBA3A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgETQv4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgETQvz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 12:51:55 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F7C061A0E
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 09:51:55 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t25so3129119qtc.0
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uCbIDnmbNb/xu62b5tooWAb+6qi8tujvE6x6ac0v/iU=;
        b=h9J16NzSlg3JV6ahuk3Cz7vW9mS71GGHOJsvtWXV/OhEqA115o493JYJT5neianrkT
         8nb/lO4XJjaix3BGuGg7pGmHyyrmqlSmT44lwrhNwmLORSVOHl0fjA+p6k7EF01If26v
         Vtvc1KweE5OUCkM3/Por0KoMn8ykmOGsBB5H8z39O/Tb6axHXh6a+3ZMoky6Md6iuZk+
         HDee2q5k6T0Dn4ugXpn9HlqPjl0wjA+VELcBuoY3l37PIObJdU8TvHkGglRjKiW0ODnb
         JCizuvakRxoXGSr2L/HDSHWCk5lpVA13/B7kAR9YVydF2g7LZVdrsYh9+kchKd36A+a6
         QhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uCbIDnmbNb/xu62b5tooWAb+6qi8tujvE6x6ac0v/iU=;
        b=GZx4SRDpdK/X8vHR5rUa62phvInu8Nhonmq2wp0TIH2PzTd61xQcqN3wjvzyLUzwYZ
         d6NQ2mcG1Rx9BePCGAhsFGoaTa9vo5Hgv5jQdufRM1qMo7cqPPsQTAyarB48o/UHRXMG
         wvWLTZr+eLclF8HuLTN3ZIyOBECGVyfHqIHDiRLerWuAFtkEQHwSW+fJmu7BpAUnySgC
         XBTa71Sgw+A4S4xm23FphGMkHgCVHlTOuZhF77gwe0RXJGEVI3nWRtvgCPRUBmOFm9FO
         8HkBmA6RhCZE3s05eCVn43QgIyYlPBRKxAOCbegkZBYjE9hfzDmlL4x8d2mfG96wXZZY
         9nkw==
X-Gm-Message-State: AOAM532KNRDSuYLMwSZSOx8ZRb9Ypq9fkTvxkA1uLgwHvZ6sM+rYA/pa
        ezeRkn/Oyf5YeJ8IC+P/VYx67g==
X-Google-Smtp-Source: ABdhPJw6ggJ8wCSJvBlsLOuaKgIMkvBTDwzygxZftVoWK3+Q5wPJrDCRnCOYTf/UH4XJd5VTz0QvZw==
X-Received: by 2002:aed:3949:: with SMTP id l67mr5993780qte.313.1589993514300;
        Wed, 20 May 2020 09:51:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id f198sm2663370qke.46.2020.05.20.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:51:53 -0700 (PDT)
Date:   Wed, 20 May 2020 12:51:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200520165131.GB630613@cmpxchg.org>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520160756.GE6462@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 20, 2020 at 06:07:56PM +0200, Michal Hocko wrote:
> On Wed 20-05-20 15:37:12, Chris Down wrote:
> > In Facebook production, we've seen cases where cgroups have been put
> > into allocator throttling even when they appear to have a lot of slack
> > file caches which should be trivially reclaimable.
> > 
> > Looking more closely, the problem is that we only try a single cgroup
> > reclaim walk for each return to usermode before calculating whether or
> > not we should throttle. This single attempt doesn't produce enough
> > pressure to shrink for cgroups with a rapidly growing amount of file
> > caches prior to entering allocator throttling.
> > 
> > As an example, we see that threads in an affected cgroup are stuck in
> > allocator throttling:
> > 
> >     # for i in $(cat cgroup.threads); do
> >     >     grep over_high "/proc/$i/stack"
> >     > done
> >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > 
> > ...however, there is no I/O pressure reported by PSI, despite a lot of
> > slack file pages:
> > 
> >     # cat memory.pressure
> >     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
> >     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
> >     # cat io.pressure
> >     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
> >     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
> >     # grep _file memory.stat
> >     inactive_file 1370939392
> >     active_file 661635072
> > 
> > This patch changes the behaviour to retry reclaim either until the
> > current task goes below the 10ms grace period, or we are making no
> > reclaim progress at all. In the latter case, we enter reclaim throttling
> > as before.
> 
> Let me try to understand the actual problem. The high memory reclaim has
> a target which is proportional to the amount of charged memory. For most
> requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
> N is the number of memcgs in excess up the hierarchy). I can see to be
> insufficient if the memcg is already in a large excess but if the
> reclaim can make a forward progress this should just work fine because
> each charging context should reclaim at least the contributed amount.
> 
> Do you have any insight on why this doesn't work in your situation?
> Especially with such a large inactive file list I would be really
> surprised if the reclaim was not able to make a forward progress.

The workload we observed this in was downloading a large file and
writing it to disk, which means that a good chunk of that memory was
dirty. The first reclaim pass appears to make little progress because
it runs into dirty pages.

> Now to your patch. I do not like it much to be honest.
> MEM_CGROUP_RECLAIM_RETRIES is quite arbitrary and I neither like it in
> memory_high_write because the that is an interruptible context so there
> shouldn't be a good reason to give up after $FOO number of failed
> attempts. try_charge and memory_max_write are slightly different because
> we are invoking OOM killer based on the number of failed attempts.

The same is true for memory.high. We are invoking the userspace OOM
killer when memory.high reclaim fails and we put tasks to sleep.

The actual number of retries is arbitrary, correct. That's because OOM
is arbitrary. It's a sampled state, and this is our sampling period.

But it's not that important. The much more important thing is that we
continue reclaiming as long as there is forward progress. How many
times we retry when there is no forward progress is less critical -
but it's nice to have the same cutoff for OOM situations everywhere.

> Also if the current high reclaim scaling is insufficient then we should
> be handling that via memcg_nr_pages_over_high rather than effectivelly
> unbound number of reclaim retries.

???
