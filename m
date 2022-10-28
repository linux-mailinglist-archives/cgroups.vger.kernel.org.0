Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B9611914
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ1RRF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 13:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJ1RRE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 13:17:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7351DD891;
        Fri, 28 Oct 2022 10:17:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h2so5380351pgp.4;
        Fri, 28 Oct 2022 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/iFIiIQ4V/YG7z76viQuYS3yb9ejhlzHXVIf3GCB3g=;
        b=A8GT3O8vI9X19QgBEVf5E/OPc4lfK8HPm3Ew/a9eW0pnni7NeBYGN/DULPE7VIYPgU
         8COLbv4fiUgLlvbWvkSLCRHfDiV77xFtFIjjifwEPx46vRJV0xJswjtD8h7GKbi3Rlx2
         BFjQaN2GQWxaNjQBQQxy7HS9p4eX45eM1mZUv2Wy7bCXKErkuorc5epRjiYVPAPkzjSq
         4jhaUF3y/T8IMdnGR4KqXvRXXIaj9KGe/eUaHTqBz4cmektDnj3a7mloDOomkPWPyh3v
         VqeK15PZdA0RYo82JNHNXe9zPF2nlSflG8XS6+ejLG1NHAcxDWxd5mGjXtMy/2xgo8CY
         hlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/iFIiIQ4V/YG7z76viQuYS3yb9ejhlzHXVIf3GCB3g=;
        b=6yTmhM5SkMA3sgYQpOrbznD2E9xt8whvm6j0C6CKhop4fhZQscW0Eye/4XuSlAVq9I
         ofN0tDIhXwORHNzxfPRSuW8c2EWBWCZQK7mRtl1qaDQXRhBXWrE81ce4J7ICpXjEowMn
         DY/v2n5VX0QSvTusp+mtpXZu04JD0odLDA/WcFe2cVhyIvi/jHovSvDtAj+PmBhUtWLI
         3VsAyuiCAtUpp+X3BlZABbiqUIHm/tr4r8+5G1a7by0HEIHmC1SB0+CSE70kh2l2NlsP
         lglE3+NZ4+ZDN8CIGMeFliydbvINWPTV+JTWDU83EDbS3XdMwAJ6B0ONLAR6mojVmVdM
         4INw==
X-Gm-Message-State: ACrzQf1VfPrb3Q+u2I1yER1hkJMvHrX75MjPRjxGlSQBuVmCqPhvinyB
        oMFAeiwgPb6r7RyvG3Naqgo7/gAfdDr6S4xFRqg=
X-Google-Smtp-Source: AMsMyM76O004qf5Q1nEkt4XBQVb3BWLSFy4Chj1tPZawp9u8P41jJzxgjw5cAOrp2TMqFZROVn9SzHKoyZ2QW2rhB9I=
X-Received: by 2002:a05:6a02:20c:b0:461:74e5:ce9f with SMTP id
 bh12-20020a056a02020c00b0046174e5ce9fmr493837pgb.294.1666977423378; Fri, 28
 Oct 2022 10:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221026074343.6517-1-feng.tang@intel.com> <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
 <Y1ovOeEPXT1fxCuc@feng-clx> <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
 <7b5f533d-4b2e-b45b-ee42-5e1cc3e8a279@linux.ibm.com>
In-Reply-To: <7b5f533d-4b2e-b45b-ee42-5e1cc3e8a279@linux.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 Oct 2022 10:16:50 -0700
Message-ID: <CAHbLzkrqaCF8wvtsAmvaZUqCAoRfO1qPSFyK7bVq5O5m1zuksg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Feng Tang <feng.tang@intel.com>, "Hocko, Michal" <mhocko@suse.com>,
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

On Thu, Oct 27, 2022 at 10:09 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/27/22 11:25 PM, Yang Shi wrote:
> > On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
> >>
> >> On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
> >>> On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
> >> [...]
> >>>>>> This all can get quite expensive so the primary question is, does the
> >>>>>> existing behavior generates any real issues or is this more of an
> >>>>>> correctness exercise? I mean it certainly is not great to demote to an
> >>>>>> incompatible numa node but are there any reasonable configurations when
> >>>>>> the demotion target node is explicitly excluded from memory
> >>>>>> policy/cpuset?
> >>>>>
> >>>>> We haven't got customer report on this, but there are quite some customers
> >>>>> use cpuset to bind some specific memory nodes to a docker (You've helped
> >>>>> us solve a OOM issue in such cases), so I think it's practical to respect
> >>>>> the cpuset semantics as much as we can.
> >>>>
> >>>> Yes, it is definitely better to respect cpusets and all local memory
> >>>> policies. There is no dispute there. The thing is whether this is really
> >>>> worth it. How often would cpusets (or policies in general) go actively
> >>>> against demotion nodes (i.e. exclude those nodes from their allowes node
> >>>> mask)?
> >>>>
> >>>> I can imagine workloads which wouldn't like to get their memory demoted
> >>>> for some reason but wouldn't it be more practical to tell that
> >>>> explicitly (e.g. via prctl) rather than configuring cpusets/memory
> >>>> policies explicitly?
> >>>>
> >>>>> Your concern about the expensive cost makes sense! Some raw ideas are:
> >>>>> * if the shrink_folio_list is called by kswapd, the folios come from
> >>>>>   the same per-memcg lruvec, so only one check is enough
> >>>>> * if not from kswapd, like called form madvise or DAMON code, we can
> >>>>>   save a memcg cache, and if the next folio's memcg is same as the
> >>>>>   cache, we reuse its result. And due to the locality, the real
> >>>>>   check is rarely performed.
> >>>>
> >>>> memcg is not the expensive part of the thing. You need to get from page
> >>>> -> all vmas::vm_policy -> mm -> task::mempolicy
> >>>
> >>> Yeah, on the same page with Michal. Figuring out mempolicy from page
> >>> seems quite expensive and the correctness can't be guranteed since the
> >>> mempolicy could be set per-thread and the mm->task depends on
> >>> CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
> >>
> >> Yes, you are right. Our "working" psudo code for mem policy looks like
> >> what Michal mentioned, and it can't work for all cases, but try to
> >> enforce it whenever possible:
> >>
> >> static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
> >>                 unsigned long addr, void *arg)
> >> {
> >>         bool *skip_demotion = arg;
> >>         struct mempolicy *mpol;
> >>         int nid, dnid;
> >>         bool ret = true;
> >>
> >>         mpol = __get_vma_policy(vma, addr);
> >>         if (!mpol) {
> >>                 struct task_struct *task;
> >>                 if (vma->vm_mm)
> >>                         task = vma->vm_mm->owner;
> >
> > But this task may not be the task you want IIUC. For example, the
> > process has two threads, A and B. They have different mempolicy. The
> > vmscan is trying to demote a page belonging to thread A, but the task
> > may point to thread B, so you actually get the wrong mempolicy IIUC.
> >
>
> But if we swap out this page and fault back in via thread B the page would
> get allocated as per thread B mempolicy. So if we demote based on thread B
> policy are we breaking anything?

If the page is demoted by following thread B's mempolicy, didn't it
already break thread A's mempolicy in the first place if you care
about it? If thread A and thread B have the same mempolicy, then it is
not a problem.

Actually there is another problem for shared page. If a page is shared
by two processes, P1 and P2, when you do rmap walk to find the task,
you may find two contradict mempolicy, what mempolicy would you like
to obey? Do you have to save all the intermediate mempolicy results
somewhere or you just bail out once the first mempolicy is found?

>
> -aneesh
>
>
