Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B681AE232
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDQQX7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgDQQX6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 12:23:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56FC061A0C
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 09:23:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b10so2395942qtt.9
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D81ZHtrbqiwN618Bg4B7aPUCBzzVXf/vmH57VSxsIY4=;
        b=aiPTtHFEp4KVgthHvdAD03AyuQ9cu09DZc3IgvSIUb2DOuuWxUTORySKuFjXakFqHn
         BIhCvxgrp4gmwHUqZL/slxGBP+DEGbPGufukryYKxB8hbxsQZMbKLhd6IS9tP6bXnGei
         W0bR5Lt/w0vPxbT7PhW8AozoqUmDO5NCxBZR+oW2fcuwkzZJ15phuOfjCUduUMxyzLTl
         MlHjMCOdpZGLpxfjXgp+k/x6bDLwl6kxUPsq3Ih8ehx/Wkvonm0IyCX9QRMyLVFEUSV4
         BmbXWZBT/vbTuyHUl3L9AO/ak6pHiaif/8DvuXzZsnH1ew4BGz4v1lgOnEx2eDoE3HyV
         idiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D81ZHtrbqiwN618Bg4B7aPUCBzzVXf/vmH57VSxsIY4=;
        b=aO+TxJKiWjXtED9s0edkpIWW1CB6LBfw6jrKEa9DVW4Pe3gl1DGMjYXkqYAav5yArV
         MEOZuRTSnTg3Ulrw9hNNrCYAXyKxXgm+Mk3j9DYFwfTTMUZvPw90GRm5SCG8Ruuy8Xa5
         aq+RTLkQ30c71eZomgsjgpfWgL826S6VPL3xuZBb8iDi+W49RWmSK+uQ1EZ7qNluyjYx
         oQHEUoMNtTCnXSIpPucR3+XROZh39EfDqUYZgI4NKw8mCEyy8MPZp4AxrrCRwi652use
         jTZKrVoCPBpx09mFsXj0o7cjsILQMZ7BkRSnNOtxzntoX6kXMlK38QO8oz4Q8QOutYJY
         Tu+g==
X-Gm-Message-State: AGi0PuaEQXcWe5cYxVkuUCg6aah20PEa18cRHYE/sO3BQUXhcQyK3T+a
        fpn2epPoCh6k3Bj0WKMdD2k=
X-Google-Smtp-Source: APiQypJtYYnsPvdg6q1oBIp+Rc7BATM1Vk8sdmM0zaAe04Om3YWEGlWa6hC7qX3ptcl/CTC9SBPIlw==
X-Received: by 2002:aed:370a:: with SMTP id i10mr3904083qtb.114.1587140637522;
        Fri, 17 Apr 2020 09:23:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c4b0])
        by smtp.gmail.com with ESMTPSA id i4sm17315649qkh.27.2020.04.17.09.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:23:56 -0700 (PDT)
Date:   Fri, 17 Apr 2020 12:23:55 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200417162355.GA43469@mtj.thefacebook.com>
References: <20200417010617.927266-1-kuba@kernel.org>
 <CALvZod78ZUhU+yr2x1h_gv+VgVGTPnSSGKh_+fd+MeiAKreJvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod78ZUhU+yr2x1h_gv+VgVGTPnSSGKh_+fd+MeiAKreJvg@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Apr 17, 2020 at 09:11:33AM -0700, Shakeel Butt wrote:
> On Thu, Apr 16, 2020 at 6:06 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Tejun describes the problem as follows:
> >
> > When swap runs out, there's an abrupt change in system behavior -
> > the anonymous memory suddenly becomes unmanageable which readily
> > breaks any sort of memory isolation and can bring down the whole
> > system.
> 
> Can you please add more info on this abrupt change in system behavior
> and what do you mean by anon memory becoming unmanageable?

In the sense that anonymous memory becomes essentially memlocked.

> Once the system is in global reclaim and doing swapping the memory
> isolation is already broken. Here I am assuming you are talking about

There currently are issues with anonymous memory management which makes them
different / worse than page cache but I don't follow why swapping
necessarily means that isolation is broken. Page refaults don't indicate
that memory isolation is broken after all.

> memcg limit reclaim and memcg limits are overcommitted. Shouldn't
> running out of swap will trigger the OOM earlier which should be
> better than impacting the whole system.

The primary scenario which was being considered was undercommitted
protections but I don't think that makes any relevant differences.

This is exactly similar to delay injection for memory.high. What's desired
is slowing down the workload as the available resource is depleted so that
the resource shortage presents as gradual degradation of performance and
matching increase in resource PSI. This allows the situation to be detected
and handled from userland while avoiding sudden and unpredictable behavior
changes.

Thanks.

-- 
tejun
