Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E271DBAA4
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgETREo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 13:04:44 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43058 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgETREf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 13:04:35 -0400
Received: by mail-ej1-f66.google.com with SMTP id a2so4815953ejb.10;
        Wed, 20 May 2020 10:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CKAKs6M+xNNbpSPK3MJ4q3ECcAhYBkNGaDaHvUvffAI=;
        b=m9hRbchndHeslfXhoMg/Mv1clGOmYJmuYqp33IrMygOj52oFeA05Pz//544VTAZaJg
         gxWU+K9F5WrPk973PeDypbYx4saBvWTx3aNRnVNnboUMd8QU/jcwWoyjHQCgleUtIqLP
         jBiw95j5uB84y/p6KVlshlxv1M3sqCHuZ+69H6csoEpwlVA+YS8W2tG0e4+bB/eP/AQU
         occSbxooBL0q/JCyWee5edgsqcnneySoqOKqppCIcHpicz5t7tl5gh7YpcbuA729l0rK
         QYugQuHZmdn3F6LYskrh794GfcbhpQV9LD6v7OofbgaOT2tkcrHt/Fwyju9B7qeKYiON
         caeQ==
X-Gm-Message-State: AOAM530l2TnJT9dojU+Xpk1SLQ+HCqWYft9B14QTxyrmJ4Cr/bE+qOjR
        v0YkQo5voChFqWcbd55qtMY=
X-Google-Smtp-Source: ABdhPJzqWwufjnHkD8jYZguqLqj575Aq4c2shzdQXyx4VVRTNVsIf3LPCCbL8tdzsKopnGIHXMVIgQ==
X-Received: by 2002:a17:907:a98:: with SMTP id by24mr10749ejc.365.1589994272954;
        Wed, 20 May 2020 10:04:32 -0700 (PDT)
Received: from localhost (ip-37-188-251-131.eurotel.cz. [37.188.251.131])
        by smtp.gmail.com with ESMTPSA id m8sm2364861ejk.100.2020.05.20.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:04:32 -0700 (PDT)
Date:   Wed, 20 May 2020 19:04:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200520170430.GG6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520165131.GB630613@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-05-20 12:51:31, Johannes Weiner wrote:
> On Wed, May 20, 2020 at 06:07:56PM +0200, Michal Hocko wrote:
> > On Wed 20-05-20 15:37:12, Chris Down wrote:
> > > In Facebook production, we've seen cases where cgroups have been put
> > > into allocator throttling even when they appear to have a lot of slack
> > > file caches which should be trivially reclaimable.
> > > 
> > > Looking more closely, the problem is that we only try a single cgroup
> > > reclaim walk for each return to usermode before calculating whether or
> > > not we should throttle. This single attempt doesn't produce enough
> > > pressure to shrink for cgroups with a rapidly growing amount of file
> > > caches prior to entering allocator throttling.
> > > 
> > > As an example, we see that threads in an affected cgroup are stuck in
> > > allocator throttling:
> > > 
> > >     # for i in $(cat cgroup.threads); do
> > >     >     grep over_high "/proc/$i/stack"
> > >     > done
> > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > > 
> > > ...however, there is no I/O pressure reported by PSI, despite a lot of
> > > slack file pages:
> > > 
> > >     # cat memory.pressure
> > >     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
> > >     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
> > >     # cat io.pressure
> > >     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
> > >     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
> > >     # grep _file memory.stat
> > >     inactive_file 1370939392
> > >     active_file 661635072
> > > 
> > > This patch changes the behaviour to retry reclaim either until the
> > > current task goes below the 10ms grace period, or we are making no
> > > reclaim progress at all. In the latter case, we enter reclaim throttling
> > > as before.
> > 
> > Let me try to understand the actual problem. The high memory reclaim has
> > a target which is proportional to the amount of charged memory. For most
> > requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
> > N is the number of memcgs in excess up the hierarchy). I can see to be
> > insufficient if the memcg is already in a large excess but if the
> > reclaim can make a forward progress this should just work fine because
> > each charging context should reclaim at least the contributed amount.
> > 
> > Do you have any insight on why this doesn't work in your situation?
> > Especially with such a large inactive file list I would be really
> > surprised if the reclaim was not able to make a forward progress.
> 
> The workload we observed this in was downloading a large file and
> writing it to disk, which means that a good chunk of that memory was
> dirty. The first reclaim pass appears to make little progress because
> it runs into dirty pages.

OK, I see but why does the subsequent reclaim attempt makes a forward
progress? Is this just because dirty pages are flushed in the mean time?
Because if this is the case then the underlying problem seems to be that
the reclaim should be throttled on dirty data.

> > Now to your patch. I do not like it much to be honest.
> > MEM_CGROUP_RECLAIM_RETRIES is quite arbitrary and I neither like it in
> > memory_high_write because the that is an interruptible context so there
> > shouldn't be a good reason to give up after $FOO number of failed
> > attempts. try_charge and memory_max_write are slightly different because
> > we are invoking OOM killer based on the number of failed attempts.
> 
> The same is true for memory.high. We are invoking the userspace OOM
> killer when memory.high reclaim fails and we put tasks to sleep.

Right but there is no way to indicate that the reclaim has failed when
writing to memory.high.

> The actual number of retries is arbitrary, correct. That's because OOM
> is arbitrary. It's a sampled state, and this is our sampling period.
> 
> But it's not that important. The much more important thing is that we
> continue reclaiming as long as there is forward progress. How many
> times we retry when there is no forward progress is less critical -
> but it's nice to have the same cutoff for OOM situations everywhere.
> 
> > Also if the current high reclaim scaling is insufficient then we should
> > be handling that via memcg_nr_pages_over_high rather than effectivelly
> > unbound number of reclaim retries.
> 
> ???

I am not sure what you are asking here.

-- 
Michal Hocko
SUSE Labs
