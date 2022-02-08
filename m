Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683174AE155
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 19:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385211AbiBHSqq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 13:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiBHSqq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 13:46:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3311C061579;
        Tue,  8 Feb 2022 10:46:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso3799054pjh.5;
        Tue, 08 Feb 2022 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1liiLSuYIW9j6jQFc6OEJ1fextR2u28LmbY2MxPqeU4=;
        b=S4F32V8+CrxKsU7uCl/D8b+9z3GIEhP7EcY0HQyP6a4Hu1ugw4jLGnFWrpWzLRUaGF
         Tj4HjXVQvz8ks8LPynj0KVjdf5Tj0h5J61V+9uAFNbcQDmlWfP7jtXXQ1dwDXWkDMwLB
         iHzvT8dXNqLFszTi/YK6SCqTGJ5kiT90rTT5U5E0wlIXy141dM9iNa4WwYMzdxRgScUs
         JExdPpR3P2/2+b4bKe2FDui3LbPhAh16wU0RJyK8IwB9PW3/t3IJhUVT32PR4e7viY3d
         60XxmnbcPlNvyGToKFK1BXwHHV61S3/t/6BRgpSODpc3Y9pspU7+lz+6mjb69xSeIi8p
         ntUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1liiLSuYIW9j6jQFc6OEJ1fextR2u28LmbY2MxPqeU4=;
        b=e2fKtLCiOu/3PlQwHg86pyJB2iqvYO4EKtCCHqlmEcCopymoHjGi/Qjqng95PVqTKa
         +TLJr2cy/Hq6XPI2RnNrE95I3D3Eh2fMTIUg+Yibjc3nSuZOR+rWQKd5k3nndNWW2LFR
         PiZb7O/jujx5tP7mSpiDtaRK4q4cUJw19SDz14dghbi6GRJOP7PCDyE2q7c4/flVh6E1
         REcHnQWpXHP7iYFr4qfx0SKFeniOIm6BmFYckuF4clzZrVzDGRfQUSm7Qd/qsA395U7D
         r8kfkLH9shkWeYRz5lqhCMWnH1rQskoKj6HhO4HaqcTuNT8OtmDIkTCOsi5KhDtavxZH
         JgJA==
X-Gm-Message-State: AOAM532ALlEbBLcwFEh46RZcNEaJmGA0DE7+fEDw3NK+lhAdGB6aWpxk
        ZIoah2NiI6z8Zje8LVhd0GI=
X-Google-Smtp-Source: ABdhPJzsEIHLpJu4kGvR+7B3jOvpPzjM3SrTIwdPu5T2WZl6Atr1q8P8HTecjaSMgvRaZefcTzUU5A==
X-Received: by 2002:a17:903:1c8:: with SMTP id e8mr5493027plh.75.1644346005089;
        Tue, 08 Feb 2022 10:46:45 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id r7sm6433149pgv.15.2022.02.08.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:46:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Feb 2022 08:46:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 02/12] cgroup: rstat: Make cgroup_rstat_cpu_lock name
 readable
Message-ID: <YgK6k4TXnRbm02dh@slm.duckdns.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220208184208.79303-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184208.79303-3-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 08, 2022 at 10:41:58AM -0800, Namhyung Kim wrote:
> The raw_spin_lock_init() uses the argument to name its lockdep map.
> But passing per_cpu_ptr() macro directly makes it a very very long
> name as it expanded like below:
> 
>   ({ do { const void *__vpp_verify = (typeof((&cgroup_rstat_cpu_lock) ...
> 
> Let's fix it by passing a local variable instead.  With this change,
> the name now looks like:
> 
>   cgrp_rstat_cpu_lock
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

but maybe add a comment explaining what's going on?

Thanks.

-- 
tejun
