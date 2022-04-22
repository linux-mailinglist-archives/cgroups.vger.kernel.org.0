Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A974A50ADC4
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 04:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443339AbiDVCcu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 22:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiDVCcc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 22:32:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F51D0CC
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 19:29:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bg9so6206472pgb.9
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 19:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vnwa2/E4TTvsZNdvRU29uFcAMGoetyFfng2lxAsZyvs=;
        b=i1aDJ+cBEN/Qi0ifvWu89VN2VtJEAI+sUbVu6CO17eUtch7Lc4hQk6+ROT49jL6OLb
         m19kGV7c4Ku7RsiVZieFkbNkwoFiYrXk2EbJxTzXlFy+iEqdeSHMzmTrZFtYLZGehrO2
         78TfXZ93IpSmgjFbprLy1RpRR1/MfIGKvkfleAnU/Y9ASAj+uNjV0FHWwQn3h0Hxguov
         6uIT34XqSqtOTLHKsHxDYLoX0EfRtHrEdCLBTn4MAQdoHSznb43hyaaTXbZvzZXJjSf5
         x5augORvT5fWzGVwH/qBPybU6plMoSpSjehao1MPjubdz6MWConLgheFyK9RQOZecART
         hS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vnwa2/E4TTvsZNdvRU29uFcAMGoetyFfng2lxAsZyvs=;
        b=3kBsJDAyFWgCeuMcBO+ebJMKPlnDaC/IMwPzE1QRCIQlGONN+48W107OkhMIq1Yvzu
         MZXe80xhlKeEewBAEh6kbvDlxnRK/rJOKQWL9qG0E8b+pfXVSAy/dM3E9q6X/HeFrCdX
         GTdlhrOBzS6URKPXyLPfE7esW3QreRTvbDmxkzeIqZcIqcsIfEtHvj5aLm5Yu+Q0PxsD
         g7k3Gg4Hwe75rQiKG+CAAIJ9oW0FR5a7FhUjWwhZzgNvVlStpoNoH7YLsDaEkADku0dE
         7383zV3l0XkueeuxASVPROp8NBJ+Q7TqC64i6aqHBC2HYOhbvyBoQyNNMHoXNb/DN0uf
         bk5g==
X-Gm-Message-State: AOAM530//MVY3LREjzOcGW/CFxdBvZ6O1HDoBzgivhyP/IsqLB61G6wT
        4j+dqEs3cEbBr1dNAoDToVFwRHTU/HgJpIsM
X-Google-Smtp-Source: ABdhPJy1JPBV19Zq+eQCHMebemfhqlw58lFdv0J33srKIMnQ3hu7/xkE7HYk7ATMdQ0s2RkOc08PTQ==
X-Received: by 2002:a63:6886:0:b0:3aa:9204:d1eb with SMTP id d128-20020a636886000000b003aa9204d1ebmr2070069pgc.63.1650594580714;
        Thu, 21 Apr 2022 19:29:40 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id 130-20020a621488000000b00505e6092973sm447810pfu.68.2022.04.21.19.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:29:40 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:29:36 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/memcg: Free percpu stats memory of dying memcg's
Message-ID: <YmITEEdEbaKCK3BN@FVFYT0MHHV2J.usts.net>
References: <20220421145845.1044652-1-longman@redhat.com>
 <YmGHYNuAp8957ouq@carbon>
 <112a4d7f-bc53-6e59-7bb8-6fecb65d045d@redhat.com>
 <YmGbmrH/Hg1VJlUc@carbon>
 <58c41f14-356e-88dd-54aa-dc6873bf80ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c41f14-356e-88dd-54aa-dc6873bf80ff@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 02:46:00PM -0400, Waiman Long wrote:
> On 4/21/22 13:59, Roman Gushchin wrote:
> > On Thu, Apr 21, 2022 at 01:28:20PM -0400, Waiman Long wrote:
> > > On 4/21/22 12:33, Roman Gushchin wrote:
> > > > On Thu, Apr 21, 2022 at 10:58:45AM -0400, Waiman Long wrote:
> > > > > For systems with large number of CPUs, the majority of the memory
> > > > > consumed by the mem_cgroup structure is actually the percpu stats
> > > > > memory. When a large number of memory cgroups are continuously created
> > > > > and destroyed (like in a container host), it is possible that more
> > > > > and more mem_cgroup structures remained in the dying state holding up
> > > > > increasing amount of percpu memory.
> > > > > 
> > > > > We can't free up the memory of the dying mem_cgroup structure due to
> > > > > active references in some other places. However, the percpu stats memory
> > > > > allocated to that mem_cgroup is a different story.
> > > > > 
> > > > > This patch adds a new percpu_stats_disabled variable to keep track of
> > > > > the state of the percpu stats memory. If the variable is set, percpu
> > > > > stats update will be disabled for that particular memcg. All the stats
> > > > > update will be forward to its parent instead. Reading of the its percpu
> > > > > stats will return 0.
> > > > > 
> > > > > The flushing and freeing of the percpu stats memory is a multi-step
> > > > > process. The percpu_stats_disabled variable is set when the memcg is
> > > > > being set to offline state. After a grace period with the help of RCU,
> > > > > the percpu stats data are flushed and then freed.
> > > > > 
> > > > > This will greatly reduce the amount of memory held up by dying memory
> > > > > cgroups.
> > > > > 
> > > > > By running a simple management tool for container 2000 times per test
> > > > > run, below are the results of increases of percpu memory (as reported
> > > > > in /proc/meminfo) and nr_dying_descendants in root's cgroup.stat.
> > > > Hi Waiman!
> > > > 
> > > > I've been proposing the same idea some time ago:
> > > > https://lore.kernel.org/all/20190312223404.28665-7-guro@fb.com/T/ .
> > > > 
> > > > However I dropped it with the thinking that with many other fixes
> > > > preventing the accumulation of the dying cgroups it's not worth the added
> > > > complexity and a potential cpu overhead.
> > > > 
> > > > I think it ultimately comes to the number of dying cgroups. If it's low,
> > > > memory savings are not worth the cpu overhead. If it's high, they are.
> > > > I hope long-term to drive it down significantly (with lru-pages reparenting
> > > > being the first major milestone), but it might take a while.
> > > > 
> > > > I don't have a strong opinion either way, just want to dump my thoughts
> > > > on this.
> > > I have quite a number of customer cases complaining about increasing percpu
> > > memory usages. The number of dying memcg's can go to tens of thousands. From
> > > my own investigation, I believe that those dying memcg's are not freed
> > > because they are pinned down by references in the page structure. I am aware
> > > that we support the use of objcg in the page structure which will allow easy
> > > reparenting, but most pages don't do that and it is not easy to do this
> > > conversion and it may take quite a while to do that.
> > The big question is whether there is a memory pressure on those systems.
> > If yes, and the number of dying cgroups is growing, it's worth investigating.
> > It might be due to the sharing of pagecache pages and this will be ultimately
> > fixed with implementing of the pagecache reparenting. But it also might be due
> > to other bugs, which are fixable, so it would be great to understand.
> 
> 
> Pagecache reparenting will probably fix the problem that I have seen. Is
> someone working on this?
>

We also encountered dying cgroup issue on our servers for a long time.
I have worked on this for a while and proposed a resolution [1] based
on obj_cgroup APIs to charge the LRU pages.

[1] https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/

Thanks.

