Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB51AE5E2
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgDQTfm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgDQTfl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 15:35:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8221C061A0C
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 12:35:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so3665111qkl.10
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=luHo+qUc09xAb9CYN0R3dmgiGU/S+4Wd99hWa0GXwKA=;
        b=MBiKVb7DJCLk4GQ1nbBSQtQCKFUt+l6LpeFFuWqf3xwbWP4o5818o68yYbWoq6Fz/U
         8HjE5xb1+4bkeoJgjgyx7XeZ/7ls6NNzpT8nar90SqfK+md4ewztH2VASHSBYvEkBzoR
         TNPPR9Wnux0nZrPgnm/zI8w2c//1uhhd0Hxra6MHoSmH9rCQiPhBoDwR8Uydc1yZCnc3
         s/OtZhegf9pY2WyoZP7Hwj6JY6gVy8cM67GVCm1n7b/EVAFFUt1IZHPkQHtJY1gdy3jY
         bU+ZiTxDlY3SNjlIOwz7OhzqR1/KsGQ/qDY/dXoLnl4QG6zd9SvwHxjecQVs7pZIxthJ
         Nl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=luHo+qUc09xAb9CYN0R3dmgiGU/S+4Wd99hWa0GXwKA=;
        b=IFvpzlx7ZXXpnCA4JcrnasyhvqKE1EjcnnzpM3MJkxeHV+we5IKpXQdOEYy2gzjWX4
         jQUGaNOH4pMFeoj7tgD+/ql+GPAB7mLKv+pIHVxspa3TU9VNNybvj4ZZ4RV2B1KNyGYx
         uqNpvODuKjlMpZ8ikCCH/fERddp7vA+UBozXunCYJ+Bl9MudgVfJ7feNJ2lrOCrQltRh
         TJWnTaeYiASC9fzHep/+qzmVzhFGozJWBsUBiNKd0OCOjgrj58bmZXDWtcxg20073mZ/
         iG46glQVAv14+6/itk8nNFuUMugSxsbuVfILvd81UEIGZeYSJrtpYdR5gYQZkGyG4u0i
         4sjA==
X-Gm-Message-State: AGi0PuZHpXgW1yi/TAwN+k7okBCxIBEXLCBswjRXtsKl6+PEc0lCpLWY
        gAsrI4F//i1a6elRi1FGqeE=
X-Google-Smtp-Source: APiQypKjVv02a4OF8LwSx9Fb3j60W2MipDP/76S/wjlAS6GUyH09IKoLku0u6TZd7fWtf/8XxHLFEg==
X-Received: by 2002:a37:8903:: with SMTP id l3mr4741012qkd.486.1587152140720;
        Fri, 17 Apr 2020 12:35:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c4b0])
        by smtp.gmail.com with ESMTPSA id n10sm16706595qkk.105.2020.04.17.12.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:35:40 -0700 (PDT)
Date:   Fri, 17 Apr 2020 15:35:39 -0400
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
Message-ID: <20200417193539.GC43469@mtj.thefacebook.com>
References: <20200417010617.927266-1-kuba@kernel.org>
 <CALvZod78ZUhU+yr2x1h_gv+VgVGTPnSSGKh_+fd+MeiAKreJvg@mail.gmail.com>
 <20200417162355.GA43469@mtj.thefacebook.com>
 <CALvZod4ftvXCu8SbQUXwTGVvx5K2+at9h30r28chZLXEB1JdfQ@mail.gmail.com>
 <20200417173615.GB43469@mtj.thefacebook.com>
 <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Apr 17, 2020 at 10:51:10AM -0700, Shakeel Butt wrote:
> > Can you please elaborate concrete scenarios? I'm having a hard time seeing
> > differences from page cache.
> 
> Oh I was talking about the global reclaim here. In global reclaim, any
> task can be throttled (throttle_direct_reclaim()). Memory freed by
> using the CPU of high priority low latency jobs can be stolen by low
> priority batch jobs.

I'm still having a hard time following this thread of discussion, most
likely because my knoweldge of mm is fleeting at best. Can you please ELI5
why the above is specifically relevant to this discussion?

I'm gonna list two things that come to my mind just in case that'd help
reducing the back and forth.

* With protection based configurations, protected cgroups wouldn't usually
  go into direct reclaim themselves all that much.

* We do have holes in accounting CPU cycles used by reclaim to the orgins,
  which, for example, prevents making memory.high reclaim async and lets
  memory pressure contaminate cpu isolation possibly to a significant degree
  on lower core count machines in some scenarios, but that's a separate
  issue we need to address in the future.

> > cgroup A has memory.low protection and no other restrictions. cgroup B has
> > no protection and has access to swap. When B's memory starts bloating and
> > gets the system under memory contention, it'll start consuming swap until it
> > can't. When swap becomes depleted for B, there's nothing holding it back and
> > B will start eating into A's protection.
> >
> 
> In this example does 'B' have memory.high and memory.max set and by A

B doesn't have anything set.

> having no other restrictions, I am assuming you meant unlimited high
> and max for A? Can 'A' use memory.min?

Sure, it can but 1. the purpose of the example is illustrating the
imcompleteness of the existing mechanism 2. there's a big difference between
letting the machine hit the wall and waiting for the kernel OOM to trigger
and being able to monitor the situation as it gradually develops and respond
to it, which is the whole point of the low/high mechanisms.

Thanks.

-- 
tejun
