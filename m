Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852D360E6DF
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiJZR6O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJZR6G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 13:58:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B269F708F;
        Wed, 26 Oct 2022 10:58:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h185so15591487pgc.10;
        Wed, 26 Oct 2022 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kWYOvEh6BjR2AjkkXhVP2bGBtthES4knBdJs4bSieXw=;
        b=JxuwH3+wKiwD51DJmL5Ej4OLluLCIQR787eGi7DLmcqoLPOw2LnXWd8a6THfNg6DaB
         K2NJY2K/W7SAh5AA0XGrG3y4396tHkg1GjNeFUxDHww0n4RgmhUDJEjhl8aumuNKZLIc
         1C/qPg5HTV62j+mV1DAPUPvBREsSzL4nL2KH/6RdVscl3Wu7uKfJx0PlokgyWN65g3zS
         2ZtUc0qyWHFtPgqvupmx2BNFNzO0l41+HPTZjYavUWpZXbp0CVsVK60oCHRCiAjw4n0n
         qKqZcLy3+5+l3AQu1m/woiPjI2NkhvV5dnqAku1q/sDvwe2zPKatVGP+3udALryMEsAW
         VsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWYOvEh6BjR2AjkkXhVP2bGBtthES4knBdJs4bSieXw=;
        b=ekUf9cnaYnrahoE47WlN/vAtJFuTQ9BPf5U6cT9Q3cKa9FQhyn4yzusfbC1xWd7Wqc
         kNtB+iUx0gONlAJ/uvzPcmPu0iRGldSUPbL8TGch6h6AWWSIUmmcNgN2modeKKX/TbwO
         biPVGxTdGtXya3yIDSPnvdALjjIEZI4oCdsiBlXikEBoaqo+ueh7ftPsY+6dXOHxQTwv
         5Iz4zlYFIMvoKFN4ES3ro20gQ18cMANnbWojh+4YWWnSQ/n4YxB1MNxxb/xBN8HaKDRf
         IeHlL52azK6Gt5ZbTOUCUXon5ap7l6i0V13SbkHNOg/uyRmREs/mHHqd9TixFL6INKdb
         NCBw==
X-Gm-Message-State: ACrzQf1DGNhhkhhllZXWT6vYlqf/PSiwEu22sbqYO/hljiE8RnLovgUb
        ZekDcDbeYZDF8Z8DlEV35pZ413s2DdTH1a6h+9k=
X-Google-Smtp-Source: AMsMyM4TLjq9KZz4YfohLxEle0QaPH142diKESYY5GrC16jdTAkB9i9kvb0y75PP6eA5xvtlFeYqFu2h/pjZBGmP7Rk=
X-Received: by 2002:a05:6a02:20c:b0:461:74e5:ce9f with SMTP id
 bh12-20020a056a02020c00b0046174e5ce9fmr38996374pgb.294.1666807084824; Wed, 26
 Oct 2022 10:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221026074343.6517-1-feng.tang@intel.com> <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
In-Reply-To: <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 Oct 2022 10:57:52 -0700
Message-ID: <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 26-10-22 20:20:01, Feng Tang wrote:
> > On Wed, Oct 26, 2022 at 05:19:50PM +0800, Michal Hocko wrote:
> > > On Wed 26-10-22 16:00:13, Feng Tang wrote:
> > > > On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
> > > > > On 10/26/22 1:13 PM, Feng Tang wrote:
> > > > > > In page reclaim path, memory could be demoted from faster memory tier
> > > > > > to slower memory tier. Currently, there is no check about cpuset's
> > > > > > memory policy, that even if the target demotion node is not allowd
> > > > > > by cpuset, the demotion will still happen, which breaks the cpuset
> > > > > > semantics.
> > > > > >
> > > > > > So add cpuset policy check in the demotion path and skip demotion
> > > > > > if the demotion targets are not allowed by cpuset.
> > > > > >
> > > > >
> > > > > What about the vma policy or the task memory policy? Shouldn't we respect
> > > > > those memory policy restrictions while demoting the page?
> > > >
> > > > Good question! We have some basic patches to consider memory policy
> > > > in demotion path too, which are still under test, and will be posted
> > > > soon. And the basic idea is similar to this patch.
> > >
> > > For that you need to consult each vma and it's owning task(s) and that
> > > to me sounds like something to be done in folio_check_references.
> > > Relying on memcg to get a cpuset cgroup is really ugly and not really
> > > 100% correct. Memory controller might be disabled and then you do not
> > > have your association anymore.
> >
> > You are right, for cpuset case, the solution depends on 'CONFIG_MEMCG=y',
> > and the bright side is most of distribution have it on.
>
> CONFIG_MEMCG=y is not sufficient. You would need to enable memcg
> controller during the runtime as well.
>
> > > This all can get quite expensive so the primary question is, does the
> > > existing behavior generates any real issues or is this more of an
> > > correctness exercise? I mean it certainly is not great to demote to an
> > > incompatible numa node but are there any reasonable configurations when
> > > the demotion target node is explicitly excluded from memory
> > > policy/cpuset?
> >
> > We haven't got customer report on this, but there are quite some customers
> > use cpuset to bind some specific memory nodes to a docker (You've helped
> > us solve a OOM issue in such cases), so I think it's practical to respect
> > the cpuset semantics as much as we can.
>
> Yes, it is definitely better to respect cpusets and all local memory
> policies. There is no dispute there. The thing is whether this is really
> worth it. How often would cpusets (or policies in general) go actively
> against demotion nodes (i.e. exclude those nodes from their allowes node
> mask)?
>
> I can imagine workloads which wouldn't like to get their memory demoted
> for some reason but wouldn't it be more practical to tell that
> explicitly (e.g. via prctl) rather than configuring cpusets/memory
> policies explicitly?
>
> > Your concern about the expensive cost makes sense! Some raw ideas are:
> > * if the shrink_folio_list is called by kswapd, the folios come from
> >   the same per-memcg lruvec, so only one check is enough
> > * if not from kswapd, like called form madvise or DAMON code, we can
> >   save a memcg cache, and if the next folio's memcg is same as the
> >   cache, we reuse its result. And due to the locality, the real
> >   check is rarely performed.
>
> memcg is not the expensive part of the thing. You need to get from page
> -> all vmas::vm_policy -> mm -> task::mempolicy

Yeah, on the same page with Michal. Figuring out mempolicy from page
seems quite expensive and the correctness can't be guranteed since the
mempolicy could be set per-thread and the mm->task depends on
CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.

>
> --
> Michal Hocko
> SUSE Labs
>
