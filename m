Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136354F8C53
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 05:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiDHCMg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 22:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiDHCMf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 22:12:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0EC15E89F
        for <cgroups@vger.kernel.org>; Thu,  7 Apr 2022 19:10:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e1so5580818ile.2
        for <cgroups@vger.kernel.org>; Thu, 07 Apr 2022 19:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zLo2uZAPFPb1a10/oiW+kNzLrd/tjhqt8zswWgEmmM=;
        b=RYo/qKEMhFXkj4EEEZGvJ6VFDZ+tSforE2IzUpicHlQ/MFAhXALefpKrPRB75mPtt+
         LwAN/p4WQS8oGGtRmuO+G5WEcMOa1EAvFqiDhlC7lh1l4ndUmWgIpMSACdklWU7vHuJ3
         bW+C65ucZLINuYcSBx07IA/fu5Txan3nuxAWjN+WLEs28JeBv3l7zgkDIyJWAHW6KN0i
         sdNZlbScPlrCV3G2u6yxXSZIi76DYmQM/NS2jmaCbCW5Q3K6BeBfnbtcU4hPI8vJzo/J
         R7jTf4zbZywtg+3GWrThOvSHBeJS30G1EO4VjtBChGE0fe2KHRnkUlzLjc/IABN0jZxt
         6xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zLo2uZAPFPb1a10/oiW+kNzLrd/tjhqt8zswWgEmmM=;
        b=w23cPsRubEx4/6dFKO9XWME2BDzEwZZsHICPDF9Vtx/nc5VQJuIN7Zp/i5uvNWBGNf
         qyPKAWHTWCHJx0uMank8OP44OfYOy+u/boRym/DLAlMcIhsxswxlhOykkidgm88/89d7
         ChSyjVODCZpvIbRa0ffH9eZljsEpAr0vRnfjXjdvAFioStLSODkisatSgryHutwp9Vik
         VP6Fsq9GE5txH+rY31KB4xeY6667F/uK5SuzD8M0xvw828P4dUOzB2Eze4H/yR0rtl/z
         ut1Nz3hn2hMAw4T67suK3Yvu5YpXK+grPUQexSTWfwXwE0TyrEQkvdiYLaK1cmte4+F9
         PHjA==
X-Gm-Message-State: AOAM533Gxl53cDc4/P7lMFDLCkqEHH9qpm4tq0Jao4FYKHjq84e2VZev
        2uW+IvfoEVooBXIF245ZirmIcF50NY06fthh57COdQ==
X-Google-Smtp-Source: ABdhPJzywFSFz4PYO+zLQREwaiNdmfPXBeHr0ksmWhzLo32ltQANJedCo3Fi6YRF+TuO6wKPeYFJE6Q3/rK52iGg5U8=
X-Received: by 2002:a92:ca45:0:b0:2ca:810e:7855 with SMTP id
 q5-20020a92ca45000000b002ca810e7855mr1672675ilo.303.1649383831471; Thu, 07
 Apr 2022 19:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkcEMdsi9G5y8mX4@dhcp22.suse.cz> <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
 <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
 <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
 <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com> <215bd7332aee0ed1092bad4d826a42854ebfd04a.camel@linux.intel.com>
 <CAAPL-u_aAbDOmATSA8ZvjnfBk_7EoXvLoh0etM0fB0aY1845VQ@mail.gmail.com> <df6110a09cacc80ee1cbe905a71273a5f3953e16.camel@linux.intel.com>
In-Reply-To: <df6110a09cacc80ee1cbe905a71273a5f3953e16.camel@linux.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 7 Apr 2022 19:10:20 -0700
Message-ID: <CAAPL-u-oF5HQ26w1czNCmA5VadXOfC54GbGpSppva86YEkefyA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 7, 2022 at 4:11 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Thu, 2022-04-07 at 15:12 -0700, Wei Xu wrote:
>
> >
> > (resending in plain-text, sorry).
> >
> > memory.demote can work with any level of memory tiers if a nodemask
> > argument (or a tier argument if there is a more-explicitly defined,
> > userspace visible tiering representation) is provided.  The semantics
> > can be to demote X bytes from these nodes to their next tier.
> >
>
> We do need some kind of userspace visible tiering representation.
> Will be nice if I can tell the memory type, nodemask of nodes in tier Y with
>
> cat memory.tier_Y
>
>
> > memory_dram/memory_pmem assumes the hardware for a particular memory
> > tier, which is undesirable.  For example, it is entirely possible that
> > a slow memory tier is implemented by a lower-cost/lower-performance
> > DDR device connected via CXL.mem, not by PMEM.  It is better for this
> > interface to speak in either the NUMA node abstraction or a new tier
> > abstraction.
>
> Just from the perspective of memory.reclaim and memory.demote, I think
> they could work with nodemask.  For ease of management,
> some kind of abstraction of tier information like nodemask, memory type
> and expected performance should be readily accessible by user space.
>

I agree.  The tier information should be provided at the system level.
One suggestion is to have a new directory "/sys/devices/system/tier/"
for tiers, e.g.:

/sys/devices/system/tier/tier0/memlist: all memory nodes in tier 0.
/sys/devices/system/tier/tier1/memlist: all memory nodes in tier 1.

We can discuss this tier representation in a new thread.

> Tim
>
> >
> > It is also desirable to make this interface stateless, i.e. not to
> > require the setting of memory_dram.reclaim_policy.  Any policy can be
> > specified as arguments to the request itself and should only affect
> > that particular request.
> >
> > Wei
>
