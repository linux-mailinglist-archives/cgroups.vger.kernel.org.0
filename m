Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F916FBB64
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEHXYV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 May 2023 19:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHXYU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 May 2023 19:24:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B44C0F;
        Mon,  8 May 2023 16:24:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ab13da70a3so50719635ad.1;
        Mon, 08 May 2023 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683588259; x=1686180259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWUewLtyjjleyCE27N0mgy++XbZ3xZJBSp9FQArDlQU=;
        b=cMgyvKzfMRZ5F6dobb+hxpXJmFiFNPdymS/AneW1qDN9sWCmT/PL8mluUI+VSw0I7L
         yLOTKnHDqulRpFgPTlbgJ068wRQv3ph93VqvAylgj0TBV9hjoWcIyVwstwcQo6JoKuBf
         GfmMQ9iDoviqnYAGxX0P1lj/KwdXQcJk+6KOxAIbdfgXgu9sNn0HBGqbnRIvJ30Wm0fG
         gDB/Txt23JlWHtP7he4FGgXwIz+m1WwbgFCcKj6sXoBdsA9RU8kz5nsushGnw8lEzrBQ
         JDOGRmm5Sj7o913tB4WBuCs3EcWn7K50tzAM96peisZmCKkOYcTUdyN0crppKzcxCPco
         89bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683588259; x=1686180259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWUewLtyjjleyCE27N0mgy++XbZ3xZJBSp9FQArDlQU=;
        b=Ypf0qFB/mmaBOeSBGzNjh+MyoXDnLKWFMSbCqTnOMAsC/vS2o9cVzLm5gEipvoawHm
         gpwYfDbumGuR2jfDz5gBoVtpn563vnUbGU/UhFylBn4wr+4ZHxOqKZH2mYdIpgz2/0XA
         wSRVIuCyVSq8OPPEyWGYsJT46xL+lL4bnn5kIpB5FsQhqrCHbOzGfZRLQ3apZRuFKspw
         SzoRoemxkCUjVUlL/cn3c6P/tRBkrZyII/a+j7cyYaN2831E69gRMZrwbi3yEqDXQ+GH
         mZgAUzpvD6K+glFkdwQfgdVBOhBAbyvuR5nBLro7ebdTg1ayy0/3LP805X2Ex7OlzmSF
         TLRA==
X-Gm-Message-State: AC+VfDzslq4mEHimEgzUFVsG3VWK5pywXB2HcIsIcIchG03irSydyHBg
        6zcmqv7hzkZxYkJ0dF/An/NJF2TYuyI=
X-Google-Smtp-Source: ACHHUZ7Ywzg5sOXXcxQByghXAZO4WL2DDYhOxV9eqxNVmgAEUcQow7sUQy+/dUNbzjCenv4IHOqiPg==
X-Received: by 2002:a17:902:ec83:b0:1ac:4d01:dff8 with SMTP id x3-20020a170902ec8300b001ac4d01dff8mr14216942plg.45.1683588258763;
        Mon, 08 May 2023 16:24:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902988d00b001aaff9be643sm32647plp.89.2023.05.08.16.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:24:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:24:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Message-ID: <ZFmEoBoX15FIpyW1@slm.duckdns.org>
References: <20230508075854.17215-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508075854.17215-1-juri.lelli@redhat.com>
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

On Mon, May 08, 2023 at 09:58:48AM +0200, Juri Lelli wrote:
> Qais reported [1] that iterating over all tasks when rebuilding root
> domains for finding out which ones are DEADLINE and need their bandwidth
> correctly restored on such root domains can be a costly operation (10+
> ms delays on suspend-resume). He proposed we skip rebuilding root
> domains for certain operations, but that approach seemed arch specific
> and possibly prone to errors, as paths that ultimately trigger a rebuild
> might be quite convoluted (thanks Qais for spending time on this!).
> 
> This is v3 of an alternative approach (v2 at [4]) to fix the problem.
> 
>  01/06 - Rename functions deadline with DEADLINE accounting (cleanup
>          suggested by Qais) - no functional change
>  02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
>          from scheduler operations - and we also fix some problems
>          associated to percpu_cpuset_rwsem)
>  03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
>  04/06 - Use this information to only perform the costly iteration if
>          DEADLINE tasks are actually present in the cpuset for which a
>          corresponding root domain is being rebuilt
>  05/06 - Create DL BW alloc, free & check overflow interface for bulk
>          bandwidth allocation/removal - no functional change 
>  06/06 - Fix bandwidth allocation handling for cgroup operation
>          involving multiple tasks
> 
> With respect to the v2 posting [4]
> 
>  1 - rebase on top of Linus' tree as of today (ac9a78681b92)
>  2 - add the 'why' to 5/6 changelog - Peter
>  3 - explicitly say that we need to keep cpuset_mutex a mutex for PI on
>      2/6 - Peter
> 
> This set is also available from
> 
> https://github.com/jlelli/linux.git deadline/rework-cpusets

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
