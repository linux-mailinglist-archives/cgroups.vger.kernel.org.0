Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59D60FF92
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiJ0R4P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ0R4N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 13:56:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D97173FC3;
        Thu, 27 Oct 2022 10:56:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v28so2168468pfi.12;
        Thu, 27 Oct 2022 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVm7aZyW+CMTvKks/nWdW9cjk0WMN5RRwT6XBFo/Bbo=;
        b=Lmp4haqg62jSPTMVt7d9MCXs1c3j00lCPvPsOAQ0titb+ed50HcvOAkE9yGqxXBma2
         /PQwVTsY5PgvWduYymQNuevWh4oY4ChC5HgWNN/DCqwIXUKQGjwsssKZB51RWk23wL0I
         ZQQn8ioan8+qzhWAlXSgA6b2aIY8QojkPatmgycaIPtPnHrC2ZMrBdvIImAnZJ3pKqqK
         NeCARE3Iu5bRQECnvZeyiiiMCWhJKDpiSkcn5IXwu8BBIDft5PL3/PmAHw1EztNgnLhr
         MfF9a+6Pz0EbQaIqDA0OgKGakzm6x+txZImxw8ylJiWWVjTfSi2+MhPykY01zKmGxLK5
         vJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVm7aZyW+CMTvKks/nWdW9cjk0WMN5RRwT6XBFo/Bbo=;
        b=gi/xBNccqeGMQZIkZ8c417TpRh3aHHwUHDkJOPCK0fHroieyzym01d4TGb6NccW86E
         emp1+rVl6g7it3ZJVIJFfPYq3eOJBehfX59drS6n45cjVJHzKCbSaTDT7r3a0ucGQ5e1
         Pa9pln2ahUew3M9uXkoeOew6GrMWi25/EaPp0tUHLPzAN9yurWlQzc7TslFZ0mjkT3AG
         fEp4G2D1UDfEoe5d0bzWJ3icdDb44c6VJ+8AN8qVoj7WLduJD/6DiRItPR6fmgdicZUM
         hAGinJqKPuWu3FKC9ABWmNnyVUqI2DLd9jgoDBw2Zkfw04pPSd81czY1gbwvcBEjqpMb
         Dazw==
X-Gm-Message-State: ACrzQf0+kiRixFrodVEWmYlbvsdrYxPeTqoVSf0SD+yhbJ44hQ9Eahwv
        giglwfCgF1163tfgExKGEvISRuAw5vDieUqwsZQ=
X-Google-Smtp-Source: AMsMyM4NrmDdoeDf6N/p9GfWf0nApUmVCEGaYVjCSZYARGrNuZ9dlxuaZ/+v8KVlAWDyUpnISCJD3PcV2Nx63Ew7A0g=
X-Received: by 2002:a05:6a00:24c2:b0:52e:7181:a8a0 with SMTP id
 d2-20020a056a0024c200b0052e7181a8a0mr50641394pfv.57.1666893371241; Thu, 27
 Oct 2022 10:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221026074343.6517-1-feng.tang@intel.com> <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com> <Y1ovOeEPXT1fxCuc@feng-clx>
In-Reply-To: <Y1ovOeEPXT1fxCuc@feng-clx>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 27 Oct 2022 10:55:58 -0700
Message-ID: <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Hocko, Michal" <mhocko@suse.com>,
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

On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
>
> On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
> > On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > > This all can get quite expensive so the primary question is, does the
> > > > > existing behavior generates any real issues or is this more of an
> > > > > correctness exercise? I mean it certainly is not great to demote to an
> > > > > incompatible numa node but are there any reasonable configurations when
> > > > > the demotion target node is explicitly excluded from memory
> > > > > policy/cpuset?
> > > >
> > > > We haven't got customer report on this, but there are quite some customers
> > > > use cpuset to bind some specific memory nodes to a docker (You've helped
> > > > us solve a OOM issue in such cases), so I think it's practical to respect
> > > > the cpuset semantics as much as we can.
> > >
> > > Yes, it is definitely better to respect cpusets and all local memory
> > > policies. There is no dispute there. The thing is whether this is really
> > > worth it. How often would cpusets (or policies in general) go actively
> > > against demotion nodes (i.e. exclude those nodes from their allowes node
> > > mask)?
> > >
> > > I can imagine workloads which wouldn't like to get their memory demoted
> > > for some reason but wouldn't it be more practical to tell that
> > > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> > > policies explicitly?
> > >
> > > > Your concern about the expensive cost makes sense! Some raw ideas are:
> > > > * if the shrink_folio_list is called by kswapd, the folios come from
> > > >   the same per-memcg lruvec, so only one check is enough
> > > > * if not from kswapd, like called form madvise or DAMON code, we can
> > > >   save a memcg cache, and if the next folio's memcg is same as the
> > > >   cache, we reuse its result. And due to the locality, the real
> > > >   check is rarely performed.
> > >
> > > memcg is not the expensive part of the thing. You need to get from page
> > > -> all vmas::vm_policy -> mm -> task::mempolicy
> >
> > Yeah, on the same page with Michal. Figuring out mempolicy from page
> > seems quite expensive and the correctness can't be guranteed since the
> > mempolicy could be set per-thread and the mm->task depends on
> > CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
>
> Yes, you are right. Our "working" psudo code for mem policy looks like
> what Michal mentioned, and it can't work for all cases, but try to
> enforce it whenever possible:
>
> static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
>                 unsigned long addr, void *arg)
> {
>         bool *skip_demotion = arg;
>         struct mempolicy *mpol;
>         int nid, dnid;
>         bool ret = true;
>
>         mpol = __get_vma_policy(vma, addr);
>         if (!mpol) {
>                 struct task_struct *task;
>                 if (vma->vm_mm)
>                         task = vma->vm_mm->owner;

But this task may not be the task you want IIUC. For example, the
process has two threads, A and B. They have different mempolicy. The
vmscan is trying to demote a page belonging to thread A, but the task
may point to thread B, so you actually get the wrong mempolicy IIUC.

>
>                 if (task) {
>                         mpol = get_task_policy(task);
>                         if (mpol)
>                                 mpol_get(mpol);
>                 }
>         }
>
>         if (!mpol)
>                 return ret;
>
>         if (mpol->mode != MPOL_BIND)
>                 goto put_exit;
>
>         nid = folio_nid(folio);
>         dnid = next_demotion_node(nid);
>         if (!node_isset(dnid, mpol->nodes)) {
>                 *skip_demotion = true;
>                 ret = false;
>         }
>
> put_exit:
>         mpol_put(mpol);
>         return ret;
> }
>
> static unsigned int shrink_page_list(struct list_head *page_list,..)
> {
>         ...
>
>         bool skip_demotion = false;
>         struct rmap_walk_control rwc = {
>                 .arg = &skip_demotion,
>                 .rmap_one = __check_mpol_demotion,
>         };
>
>         /* memory policy check */
>         rmap_walk(folio, &rwc);
>         if (skip_demotion)
>                 goto keep_locked;
> }
>
> And there seems to be no simple solution for getting the memory
> policy from a page.
>
> Thanks,
> Feng
>
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
> > >
> >
