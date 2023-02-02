Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5B268888C
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBBUtB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 15:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjBBUss (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 15:48:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327CB47C;
        Thu,  2 Feb 2023 12:48:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so6797544pjb.4;
        Thu, 02 Feb 2023 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9T0aTLZbkN8XqrJT/9QUriZzH/uz3lyoG7H0b5y1+Us=;
        b=JqOSyKSx/Q04WMXyzVA64PFu7mjTc7g1areNDs9DvDPhAH1PrnblGFeHkNqjRvTblJ
         t4fgGhLvbUHsb22rIXKxlZbNYo6s4DBES9ED6XtqIrl7G7la7/uR3AwnBBiPR+5hVOhc
         8yr+yXcS+Z8Wz7xE6PQww6X8bb0Nkq9hO4iwAmPj3hHt0Gqc8ukdiF4tR21qkWALxW/n
         BCJdBQJ89sswDZto8VKi/MaVkWshYKrRwRWy4sX/VNekdN+1Gf4n10V1d9MeZBIjViPy
         PvgKGCYZ71/OP+JhYY+zZAf4t4HpT4u9ZYA18IWzsucztkrtgjzSN124vlc1oKDwnbXw
         gEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T0aTLZbkN8XqrJT/9QUriZzH/uz3lyoG7H0b5y1+Us=;
        b=KVIKrpnO9xiKtsHLaE7Q2IKghzVezltXweszFIwglfEiVpHRA0RlTeG6ZQRWjYFAVi
         1gdXObFMcfx/eTas8ZgcmeFXtpEpJ6aSKunbhgz4YtMbj76wOk4QK8c/dFimACpc9rh9
         Gepv6TwdNphCKhX3C98+S3/LgvYCy7+mvFyWClOxs4l9KTKz6dqMnYaDw0i/JZY9+8vR
         tOHGDxReiskpDR6X+8wsz2GpwXEw+pYHc+cy1FUG0AWd4LjRsN85N70AbFqfzXeTW6th
         +8sHGYjQkVJz84QBV3KCQ1zGwN8eirUWWTGHeQQYpDqQEmGBPX/Mu1Zq14h5RsNHLvhb
         ozRg==
X-Gm-Message-State: AO0yUKVDFbNSigLHbGCT9JAT5dgOC1tepZ6e2nfW+3T9iGMi7FSzgIHn
        EnlG2zI7QI5CdvFIzYkhqhDWE5Phkv0=
X-Google-Smtp-Source: AK7set9uPi7JmyRa1ouGm6laTu/uFtoH2Gcb1QXUtoYnBpoSF2b2t45LwSn/OnKEsR1h72ES1iMrkg==
X-Received: by 2002:a17:902:e3c3:b0:194:46e0:1b61 with SMTP id r3-20020a170902e3c300b0019446e01b61mr5668266ple.63.1675370926980;
        Thu, 02 Feb 2023 12:48:46 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id bt22-20020a056a00439600b0056be1581126sm102115pfb.143.2023.02.02.12.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:48:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 10:48:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <Y9whrU4IUeleqdrt@slm.duckdns.org>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
 <d630ca53-71f0-c735-fbc3-e826479aa86b@redhat.com>
 <Y9wSC1Wxlm8CKKlN@hirez.programming.kicks-ass.net>
 <2bc730db-704d-080b-6869-02f6d0035fad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc730db-704d-080b-6869-02f6d0035fad@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 03:46:02PM -0500, Waiman Long wrote:
> > > I will work on a patchset to do that as a counter offer.
> > We will need a small and simple patch for /urgent, or I will need to
> > revert all your patches -- your call.
> > 
> > I also don't tihnk you fully appreciate the ramifications of
> > task_cpu_possible_mask(), cpuset currently gets that quite wrong.
> 
> OK, I don't realize the urgency of that. If it is that urgent, I will have
> no objection to get it in for now. We can improve it later on. So are you
> planning to get it into the current 6.2 rc or 6.3?
> 
> Tejun, are you OK with that as you are the cgroup maintainer?

Yeah, gotta fix the regression but is there currently a solution which fixes
the regression but doesn't further break other stuff?

Thanks.

-- 
tejun
