Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B0F688940
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 22:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjBBVvO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 16:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjBBVvN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 16:51:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB37EAD17;
        Thu,  2 Feb 2023 13:50:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m13so3281762plx.13;
        Thu, 02 Feb 2023 13:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyvgXXfLdb8BqZbi4tqxl6AzdTG+8pKKl4n84qa8mHw=;
        b=FLARCyjXgCWruhv8HxY2D5u3alu0rFNTa28H7ltJbldeBu+27e3g7SsbgllMXeH6wc
         IchjL6Q5AgVhtRULvKVvTSdrhps+qiuYSVxaw7Ph9ZiKz7rTLwcR9lvtCtQiTaUEecnr
         BhpWtyT24fdu0gq7RUEn2DfHm/BR3zfVa2fs+WOUa9JeTTG7H9IlAbp1IBcnyYpv42xz
         tcddBjqKwnNaTZTaiedcXvaZwKWG3VhVBNi601iKp72PEot/UPog3ESgRLSBl2Dxyp+o
         fS+QRYK1upK+Ixt60oiHU+Ax5uR2vMb+G7pMO3yqreEVMZahc0/jqs+Xyu7rglFu3Uo1
         BNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyvgXXfLdb8BqZbi4tqxl6AzdTG+8pKKl4n84qa8mHw=;
        b=eDTQ9nfiiRKjN2swswxDDgtLFYBMIgT5un5+tZ0AZti8J0OHIdwcY2nrpxR9QuY+Pp
         pdKlIKR6rB0J0xV6Zcvs48AHhkzGu05gO7yxWHBiUksD3dVVOFDv9oASLfqy69X93nFk
         ye4i/hhtEDHYSFogsSa696pwkdXbPql2d+IPvDE93qgHbRZp20sm1dbuUc/QYmsm/YHW
         5POkw2p0ORhG/WC6uzg0/Jp4ChUt4g2G2/XZhHyU5vAUnfBLUakQGxoRBXmspKTJLK4h
         yMbLq5g1ZiqxGIXnS8eXJI25NjmQtZV3TkS4pd651ak2wCZqtPUX8++d2xVix0uc6Nqw
         62Xw==
X-Gm-Message-State: AO0yUKX6D7AKzNZy3fYfHVY4O+1QttmUACBHTBYUNrMRoiqAQsxJ71rc
        kUqF88bH84k6QLDt9FDmE1w=
X-Google-Smtp-Source: AK7set/C7FbmGENcIZWZX7WnwCsAGxvyQdusGMtjvbz1oTcV5nJt56jD76z6ClTKSt3A8sj8YsnJPQ==
X-Received: by 2002:a05:6a20:439f:b0:be:c874:b7d9 with SMTP id i31-20020a056a20439f00b000bec874b7d9mr8407805pzl.21.1675374657275;
        Thu, 02 Feb 2023 13:50:57 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id x3-20020a63aa43000000b004d4547cc0f7sm260666pgo.18.2023.02.02.13.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:50:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 11:50:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <Y9wwP4LF9vgreO3U@slm.duckdns.org>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
 <d630ca53-71f0-c735-fbc3-e826479aa86b@redhat.com>
 <Y9wSC1Wxlm8CKKlN@hirez.programming.kicks-ass.net>
 <2bc730db-704d-080b-6869-02f6d0035fad@redhat.com>
 <Y9whrU4IUeleqdrt@slm.duckdns.org>
 <75de91db-d3bc-0c0e-6199-ef00591e8878@redhat.com>
 <8787b5f7-9822-e49b-0357-d0ce224ca920@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8787b5f7-9822-e49b-0357-d0ce224ca920@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 04:05:14PM -0500, Waiman Long wrote:
> 
> On 2/2/23 15:53, Waiman Long wrote:
> > 
> > On 2/2/23 15:48, Tejun Heo wrote:
> > > On Thu, Feb 02, 2023 at 03:46:02PM -0500, Waiman Long wrote:
> > > > > > I will work on a patchset to do that as a counter offer.
> > > > > We will need a small and simple patch for /urgent, or I will need to
> > > > > revert all your patches -- your call.
> > > > > 
> > > > > I also don't tihnk you fully appreciate the ramifications of
> > > > > task_cpu_possible_mask(), cpuset currently gets that quite wrong.
> > > > OK, I don't realize the urgency of that. If it is that urgent, I
> > > > will have
> > > > no objection to get it in for now. We can improve it later on.
> > > > So are you
> > > > planning to get it into the current 6.2 rc or 6.3?
> > > > 
> > > > Tejun, are you OK with that as you are the cgroup maintainer?
> > > Yeah, gotta fix the regression but is there currently a solution
> > > which fixes
> > > the regression but doesn't further break other stuff?
> > 
> > I believe there is a better way to do that, but it will need more time
> > to flex out. Since cpuset_cpus_allowed() is only used by
> > kernel/sched/core.c, Peter will be responsible if it somehow breaks
> > other stuff.
> 
> Maybe my cpuset patch that don't update task's cpumask on cpu offline event
> can help. However, I don't know the exact scenario where the regression
> happen, so it may not.

Neither patch looks like they would break anything. That said, the patches
aren't trivial and we're really close to the merge window, so I'd really
appreciate if you can take a look and test a bit before we send these
Linus's way. We can replace it with a better solution afterwards.

Thanks.

-- 
tejun
