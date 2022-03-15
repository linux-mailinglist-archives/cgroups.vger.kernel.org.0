Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34394DA67B
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 00:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiCOXzy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Mar 2022 19:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiCOXzy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Mar 2022 19:55:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58243BCA9
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 16:54:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v35so1497986ybi.10
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xlurKCUM4YSmUkIVypyj8embDeL9DxbXlFAmffyKHk=;
        b=YWSK8NXNXoQdi7hNWVycl/TbZbyaLklUKLlRfiKBEuWLOF0/L8MCT0qMoSamK0odp1
         j/F0IyEUGNK+I3IIPuzjui1frCebhVZ9JzC3hxOaH49yz/TV//yBMXsn3GwArjSJBjX/
         /szB69aoQsdlXaDuD9NLam6OVNouDpHdu8VHZOQfqsJz0CW1ouuoBlG2bMqGTzWer6Dq
         8zsJ9oBClj/hG+jKc0nVWkuyA//yiT9P1VXVfp/65DB3it2wGfiHtlJiItXbHWEY+8cy
         VXPi46LE0urxlF6Oqm2TONwHpQmLC01YM7qYzT34XlkZ+UHBpRfXX2py4hD9hjU2nwY6
         kuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xlurKCUM4YSmUkIVypyj8embDeL9DxbXlFAmffyKHk=;
        b=TovmD1VOOA9/VfznzFx22oezto/Q2YXqVlcH7zFBWUjwTV5MVJpuoZYdNKa4/LqDON
         O6rRmUI1ayg0Yc/V60QGDCAB04QhOf5W0Q9rjmv5H3fKosykQc4dZ5s97uO2EK1IBGXn
         60x/r+POCyNZaKFcHPmFPUcIlhgH9LevPPHtkaeq0zjgkcWfownk43zYy0LjqnEB4msa
         ZVIDR+S2AfdUlgvCY4StCZxV0sEeerYhECjDP3pPqsZLAgBZmykJmbQwPPzG8dph1GC4
         mnv1PTDZAj8oe5neOpAkuhXIJ6ISlU2fnPZKY3JVSU1N9DvKPdCmKDAbm6UD8iXpuir8
         o4mQ==
X-Gm-Message-State: AOAM531gsrYjXnG7SSP70zEogpEG0utZ3UGlV+bnbxJ4Osn3FVe1/rq5
        oHVIUTPSAgsB89sB76gctVG42IqItUhyD9pvLEC16egJ
X-Google-Smtp-Source: ABdhPJyXnv1OMttTW2JO06Rn+iGeJjL2Lv4q5O+H1QnrFGuqxc3fK1fudN8WFHLZ7KkjEvxcg+EaKAV57rcM715cdlg=
X-Received: by 2002:a25:73d3:0:b0:629:173d:7c5f with SMTP id
 o202-20020a2573d3000000b00629173d7c5fmr25509514ybc.328.1647388480032; Tue, 15
 Mar 2022 16:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <20220312071623.19050-2-richard.weiyang@gmail.com> <Yi8Qu/1V4H1M9qZV@dhcp22.suse.cz>
 <20220314225150.fhwny4yhxgjevwxx@master> <YjBT6emPlZD1lg5z@dhcp22.suse.cz>
In-Reply-To: <YjBT6emPlZD1lg5z@dhcp22.suse.cz>
From:   Wei Yang <richard.weiyang@gmail.com>
Date:   Wed, 16 Mar 2022 07:54:29 +0800
Message-ID: <CADZGycbApX1D8sn4kCXmpYoB2m3Ysn9Ew-6rmdr6Rfhfv6jRjw@mail.gmail.com>
Subject: Re: [Patch v2 2/3] mm/memcg: __mem_cgroup_remove_exceeded could
 handle a !on-tree mz properly
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 15, 2022 at 4:52 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 14-03-22 22:51:50, Wei Yang wrote:
> > On Mon, Mar 14, 2022 at 10:54:03AM +0100, Michal Hocko wrote:
> > >On Sat 12-03-22 07:16:22, Wei Yang wrote:
> > >> There is no tree operation if mz is not on-tree.
> > >
> > >This doesn't explain problem you are trying to solve nor does it make
> > >much sense to me TBH.
> > >
> >
> > This just tries to make the code looks consistent.
>
> I guess this is rather subjective. One could argue that the check is
> more descriptive because it obviously removes the node from the tree
> when it is on the tree.

Hmm... maybe yes.

If someone else prefer the original one, I am ok with it.

> --
> Michal Hocko
> SUSE Labs
