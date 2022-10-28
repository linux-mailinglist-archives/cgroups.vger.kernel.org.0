Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9391D61193C
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 19:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJ1RYH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 13:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1RYH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 13:24:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C02822AB58;
        Fri, 28 Oct 2022 10:24:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso10501504pjc.0;
        Fri, 28 Oct 2022 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uWRk2+cg4JD0YlEG67ex3jOV5izVRgHvNcMy0hsBnco=;
        b=prHkLIu5cEuWwbChfnUxhVQzBCXk/zyL6eJyK/Wb7otKwjaCrzIq3XW2UK2JzyS4Iw
         VO4x7PSyBtEh4QkOXnHq/Lchf8ySh5Aup5b999/W+GXjfDiCBa9zKxEzIVLmyrFfkU6b
         SxLhNhELaKSgqrlGHWUogD+HSabs65jM9+4kHVbrp6ET9tYi2P7z5K1nXsct2AjsxHF3
         vdNFvKJv3dmyRqhBxeOLIIYaE0Av+7Da2kGBtCNqhGpKN+30L8jrC0x8FkOv2RACZ0s3
         lp6K36RgYhat5D86/qQ7UbZmmLFIRiHR2RS0D/IBLYMUBqcsEXndnME3dYJ4SMTy+a0i
         Fh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWRk2+cg4JD0YlEG67ex3jOV5izVRgHvNcMy0hsBnco=;
        b=3ALP5fvrmmfa0GyuEkyVfid4qYUSGOLLedSdwQJSn6MW3qa6zhQmcCM4wd7TBVjhKv
         HZG7R62fLCDWOuprBKsMY6s54LPwT6mGNZBa+6Jb7S5Rc8bnd45s/HKA+AEsS//yOn3z
         tYLosxivVsRhs6K3gg/miRAwrzlixLY9ITrQC4/ZIVPpmu8PZX1KPamfBBfQgFUbUYK8
         DAykpVZwrtrl8rDKcaSvgJkYIc02wdKSdktdfHru9u2nz6EmiNFBWCxGRySrhiNpRGX8
         RTsRnUxtbOzXJccaqER4A2FRblCinumAeIJJnf2iNCcnu19FAciVzb3aeu3st8DU1c7y
         3tjA==
X-Gm-Message-State: ACrzQf2/wYAEHv0qgm8GF+Wq0StGblDq1gtM0w4FhuO8yOLVnQUzIIT0
        UourUokuD8QdDak/3gmwcuIFiweyr8EaiDd3zD0=
X-Google-Smtp-Source: AMsMyM4XcalM18oGVqqNW++pIXW4u2xD24d1lXvmoCR4zi6MoMUO15NIU8IpCwvDd/SilDSs/oM2Aipx+j1Q95CDMFY=
X-Received: by 2002:a17:902:e88a:b0:183:9ecb:ff85 with SMTP id
 w10-20020a170902e88a00b001839ecbff85mr3434plg.169.1666977846069; Fri, 28 Oct
 2022 10:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221026074343.6517-1-feng.tang@intel.com> <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
 <Y1ovOeEPXT1fxCuc@feng-clx> <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
 <Y1tOigFZeDzjPGsv@feng-clx> <87y1t0ijbk.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y1t0ijbk.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 Oct 2022 10:23:53 -0700
Message-ID: <CAHbLzkpO46yTiSVrKWRnABNW_PutuudEkB3RD-_YKxamW9SyaA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>, "Hocko, Michal" <mhocko@suse.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
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

On Thu, Oct 27, 2022 at 10:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Feng Tang <feng.tang@intel.com> writes:
>
> > On Thu, Oct 27, 2022 at 10:55:58AM -0700, Yang Shi wrote:
> >> On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
> >> >
> >> > On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
> >> > > On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
> >> > [...]
> >> > > > > > This all can get quite expensive so the primary question is, does the
> >> > > > > > existing behavior generates any real issues or is this more of an
> >> > > > > > correctness exercise? I mean it certainly is not great to demote to an
> >> > > > > > incompatible numa node but are there any reasonable configurations when
> >> > > > > > the demotion target node is explicitly excluded from memory
> >> > > > > > policy/cpuset?
> >> > > > >
> >> > > > > We haven't got customer report on this, but there are quite some customers
> >> > > > > use cpuset to bind some specific memory nodes to a docker (You've helped
> >> > > > > us solve a OOM issue in such cases), so I think it's practical to respect
> >> > > > > the cpuset semantics as much as we can.
> >> > > >
> >> > > > Yes, it is definitely better to respect cpusets and all local memory
> >> > > > policies. There is no dispute there. The thing is whether this is really
> >> > > > worth it. How often would cpusets (or policies in general) go actively
> >> > > > against demotion nodes (i.e. exclude those nodes from their allowes node
> >> > > > mask)?
> >> > > >
> >> > > > I can imagine workloads which wouldn't like to get their memory demoted
> >> > > > for some reason but wouldn't it be more practical to tell that
> >> > > > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> >> > > > policies explicitly?
> >> > > >
> >> > > > > Your concern about the expensive cost makes sense! Some raw ideas are:
> >> > > > > * if the shrink_folio_list is called by kswapd, the folios come from
> >> > > > >   the same per-memcg lruvec, so only one check is enough
> >> > > > > * if not from kswapd, like called form madvise or DAMON code, we can
> >> > > > >   save a memcg cache, and if the next folio's memcg is same as the
> >> > > > >   cache, we reuse its result. And due to the locality, the real
> >> > > > >   check is rarely performed.
> >> > > >
> >> > > > memcg is not the expensive part of the thing. You need to get from page
> >> > > > -> all vmas::vm_policy -> mm -> task::mempolicy
> >> > >
> >> > > Yeah, on the same page with Michal. Figuring out mempolicy from page
> >> > > seems quite expensive and the correctness can't be guranteed since the
> >> > > mempolicy could be set per-thread and the mm->task depends on
> >> > > CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
> >> >
> >> > Yes, you are right. Our "working" psudo code for mem policy looks like
> >> > what Michal mentioned, and it can't work for all cases, but try to
> >> > enforce it whenever possible:
> >> >
> >> > static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
> >> >                 unsigned long addr, void *arg)
> >> > {
> >> >         bool *skip_demotion = arg;
> >> >         struct mempolicy *mpol;
> >> >         int nid, dnid;
> >> >         bool ret = true;
> >> >
> >> >         mpol = __get_vma_policy(vma, addr);
> >> >         if (!mpol) {
> >> >                 struct task_struct *task;
> >> >                 if (vma->vm_mm)
> >> >                         task = vma->vm_mm->owner;
> >>
> >> But this task may not be the task you want IIUC. For example, the
> >> process has two threads, A and B. They have different mempolicy. The
> >> vmscan is trying to demote a page belonging to thread A, but the task
> >> may point to thread B, so you actually get the wrong mempolicy IIUC.
> >
> > Yes, this is a valid concern! We don't have good solution for this.
> > For memory policy, we may only handle the per-vma policy for now whose
> > cost is relatively low, as a best-effort try.
>
> Yes.  The solution isn't perfect, especially for multiple-thread
> processes with thread specific memory policy.  But the proposed code
> above can support the most common cases at least, that is, run workload
> with `numactl`.

Not only multi threads, but also may be broken for shared pages. When
you do rmap walk, you may get multiple contradict mempolicy, which one
would you like to obey?

TBH I'm not sure whether such half-baked solution is worth it or not,
at least at this moment. The cost is not cheap, but the gain may not
be worth it IMHO.

>
> Best Regards,
> Huang, Ying
