Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9DD4F0827
	for <lists+cgroups@lfdr.de>; Sun,  3 Apr 2022 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbiDCGse (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Apr 2022 02:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiDCGse (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Apr 2022 02:48:34 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D2377FB
        for <cgroups@vger.kernel.org>; Sat,  2 Apr 2022 23:46:41 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id y16so4746099ilc.7
        for <cgroups@vger.kernel.org>; Sat, 02 Apr 2022 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6+k/4Om7VsqLidja8hb8+QMIWaL5Tmj1wC2cL00ays=;
        b=nOlAijP5ZZ9vsdwJxJUZqAvchhR2fSeQGoSus10DZCtVRxLYXfh3CaMWft73tMME1m
         t8EEPpLhVAmbmIitm4y9QYf8gD29WnqYP9IPk0DbsJRQ306l1QfJlfZBvwV0n6/apy1q
         kE/dBq22AAuWR+VBcGZKlXr/FEVoU2mgB22M1LxnKoR+KLx+gi822+ieZ9bQV5DPkPDX
         rv0cbX0UhZ/st6FHWyCx4nSEY24sHkWVOJgCK96qcxkxAp+J+AvawMuPwG3FbWM+qvsh
         z1YzQW9HvQJnNjv85bt720LiaBD3IDsndMwp3VULMTwSwWfSyKEqFX+sUpd6E8sAOFuU
         nD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6+k/4Om7VsqLidja8hb8+QMIWaL5Tmj1wC2cL00ays=;
        b=fL/Kudfbh8g8i9vEdIlycVbRovxyhsru0vEj2NUvRp+4ha0m3R9dnEDFuAzs2BXN6N
         aaM2NUNtWbLVt2XIROb9lqJqrogVXKR8qQifG0Md8c7L7FSgZNLH1FBbGFdpwh0yaw9t
         ydo+41w1bo+P/qk3hqc/ckRrgqVV4MuYOy5SuVFbuNuMjwuLh53kv2QBUYAwSJFB26L5
         K7vm3PMROqxZjuuGVkurgoQ+xHKXg0ODKPiMFyL3Cxl3L2ZfKh9ZuTIkaJiySUXwatE3
         O3+jUh6HjeNDQw1FKnfBWboO5kL5r1w6TJFQX3Ka04wLOthNFcfPc+8GehEG7LgDi5Ne
         aOmA==
X-Gm-Message-State: AOAM531+QxXmTUV/6CJRCDzr9sjZZ4SfAMep8sMSUzy3wfdT3USiGiDy
        +smcNzSwBQJYtWga29PhZpVLziXQwuzryqVaD+5o5g==
X-Google-Smtp-Source: ABdhPJzFIevVMEisQ9Pwvrh3Lhxnl9EwRG1TSPfzOF/+7Ua2Imr8RieK1XhYkaSWk0BECbaP9FsQ3vwbj4/V5Fwy9OA=
X-Received: by 2002:a92:d94d:0:b0:2c8:45a5:926b with SMTP id
 l13-20020a92d94d000000b002c845a5926bmr3208155ilq.310.1648968400437; Sat, 02
 Apr 2022 23:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkcEMdsi9G5y8mX4@dhcp22.suse.cz> <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
 <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Sat, 2 Apr 2022 23:46:29 -0700
Message-ID: <CAAPL-u_zLTs6cMSN8sOtktCHKncfSWo+qWxXU7_iL3hhwhL8QA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 2, 2022 at 1:13 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> > On Fri, Apr 1, 2022 at 6:54 AM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> On Thu 31-03-22 08:41:51, Yosry Ahmed wrote:
> >> > From: Shakeel Butt <shakeelb@google.com>
> >> >
>
> [snip]
>
> >> > Possible Extensions:
> >> > --------------------
> >> >
> >> > - This interface can be extended with an additional parameter or flags
> >> >   to allow specifying one or more types of memory to reclaim from (e.g.
> >> >   file, anon, ..).
> >> >
> >> > - The interface can also be extended with a node mask to reclaim from
> >> >   specific nodes. This has use cases for reclaim-based demotion in memory
> >> >   tiering systens.
> >> >
> >> > - A similar per-node interface can also be added to support proactive
> >> >   reclaim and reclaim-based demotion in systems without memcg.
> >> >
> >> > For now, let's keep things simple by adding the basic functionality.
> >>
> >> Yes, I am for the simplicity and this really looks like a bare minumum
> >> interface. But it is not really clear who do you want to add flags on
> >> top of it?
> >>
> >> I am not really sure we really need a node aware interface for memcg.
> >> The global reclaim interface will likely need a different node because
> >> we do not want to make this CONFIG_MEMCG constrained.
> >
> > A nodemask argument for memory.reclaim can be useful for memory
> > tiering between NUMA nodes with different performance.  Similar to
> > proactive reclaim, it can allow a userspace daemon to drive
> > memcg-based proactive demotion via the reclaim-based demotion
> > mechanism in the kernel.
>
> I am not sure whether nodemask is a good way for demoting pages between
> different types of memory.  For example, for a system with DRAM and
> PMEM, if specifying DRAM node in nodemask means demoting to PMEM, what
> is the meaning of specifying PMEM node? reclaiming to disk?
>
> In general, I have no objection to the idea in general.  But we should
> have a clear and consistent interface.  Per my understanding the default
> memcg interface is for memory, regardless of memory types.  The memory
> reclaiming means reduce the memory usage, regardless of memory types.
> We need to either extending the semantics of memory reclaiming (to
> include memory demoting too), or add another interface for memory
> demoting.
