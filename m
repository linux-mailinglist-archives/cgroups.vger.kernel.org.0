Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49606DFD75
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLS0i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDLS0h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 14:26:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41B59C6;
        Wed, 12 Apr 2023 11:26:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v9so17798999pjk.0;
        Wed, 12 Apr 2023 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681323996; x=1683915996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qe4SS5MwqgNNblasLyBUlGHPWf5yZ2STwXpKEpxvmgk=;
        b=D6xcB4D7MIBRR03l3RpjS/l27LEHg1viozYtwZQliZiaIVrC1xMrJpPnq8o1gzm14I
         JinmTIp358cI33pWMrORKQjFCOlJXwjAlLcNb5AnbynV6VZyjfLzDiWsLBViXVvEnLF4
         X9S/aXCudZ/20PGfQpYuRUbeRjP2nQ5kAcU5U2HcC/vzbH+MdXAWWMOwtDIsV6J6utNz
         JnD2Jd/YQmdasVSwJXw1J+yGtQcbhRmpXeOQLBQCzXWB1LM58DLi1p0FhFMlCEBCnlKi
         UM9H/rWDEcR6vfqsvyrKzg/07TW1DYjzNfX2+WXz47oV2qD6pQ3+mgdb1AQrsRpVHYOf
         bHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323996; x=1683915996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe4SS5MwqgNNblasLyBUlGHPWf5yZ2STwXpKEpxvmgk=;
        b=dDhCeT+C/SGiMAn+KHBYrv6TnlGIrHuYa9wMciU0NLwUp1Q0iRC5rzQQ5d2+zOiotd
         502SWJ+BB4V9mDq0b+1nRwxsp2XLiOqKMyANXRmiKSFW+FCzBnwawLgBRtuwX7o71pzr
         grHfqL+RhlW5/XiH+v0vZFV9Bpds1uFa98vPL/pU0NyN91oIBEHEK35T0T94hVDSbkSP
         nUnknBWpvedF7koS1J3vmfeIx7Lt7PX4rOiQaqRRtIfSsWT1txq70WSIpEO4xfhti5RA
         OSxNOB15GSWwL7cgeGYdbrfhjfGHlZQHZxcoqCW/+VghhS5F/Q9bq5s5rDfqgiipARNp
         /AWA==
X-Gm-Message-State: AAQBX9cwZoX4QK/+SNBW5vG941YrcpJ4Lgr2qWY2MR0sxZYBavOD377E
        YFxXKUDJF5lP3NXMwp/V5ajuKGyDazg=
X-Google-Smtp-Source: AKy350ZY15V6gkegcb0Q7rjtO2w8QTHnGTN1o6Fr4iEddJn3QSOwS1OoAKOb2SPug3kfMTM2pb/XiA==
X-Received: by 2002:a05:6a20:4a29:b0:e8:d62c:4aa9 with SMTP id fr41-20020a056a204a2900b000e8d62c4aa9mr15718758pzb.24.1681323995446;
        Wed, 12 Apr 2023 11:26:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm12017502pfh.56.2023.04.12.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:26:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 08:26:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v4 0/5] cgroup/cpuset: Fix CLONE_INTO_CGROUP problem &
 other issues
Message-ID: <ZDb32V9xcWOi2_CL@slm.duckdns.org>
References: <20230411133601.2969636-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411133601.2969636-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 11, 2023 at 09:35:56AM -0400, Waiman Long wrote:
>  v4:
>   - Add missing rcu_read_lock/unlock to cpuset_cancel_fork() in patch 3.
>   - Add patch 5 to reduce performance impact for the
>     non-CLONE_INTO_CGROUP case.
> 
>  v3:
>   - Update patches 2 & 3 to put task_cs() call under rcu_read_lock().
> 
>  v2:
>   - Drop v1 patch 3
>   - Add a new patch to fix an issue in cpuset_cancel_attach() and
>     another patch to add cpuset_can_fork() and cpuset_cacnel_fork()
>     methods.
> 
> The first patch in this series fixes a problem in
> cpuset_cancel_attach(). Patches 2 and 3 fixes the CLONE_INTO_CGROUP
> problem in cpuset. Patch 4 is a minor fix. The last patch is a
> performance optimization patch for the non-CLONE_INTO_CGROUP case.

Applied 1-4 to cgroup/for-6.3-fixes w/ stable cc'd. Given that the fixes are
a bit involved, the breakages have been there for quite a while and the
cpuset code has changed quite a bit, backporting might not be trivial tho.
Let's see how that goes.

Thanks.

-- 
tejun
