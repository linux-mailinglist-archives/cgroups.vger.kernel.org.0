Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E136DFD81
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDLS1p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDLS1n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 14:27:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D340F1;
        Wed, 12 Apr 2023 11:27:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-634b28df952so1055086b3a.2;
        Wed, 12 Apr 2023 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681324061; x=1683916061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Tb4IA2hxKxJJ3RN6D1gKaTZIjLOtDf6PRFb4BO0b70=;
        b=RLhJz9AWjqHov+WhKyEDR+6h+R9ZRGrwVpCnrwr7mS4AYOaQcP/3wLlt/e+w1kHoF2
         g066b9b7dcTfzUBN38Ui3VHndJTO8xge2sl4J5IdBiQD1w1UDZkjT3UURa8dJtHboKQl
         nLMOa35cMN2chosn1wyWPBSipx59lQmh7nwS1vXxLDXlBXwGRFxdeylsnT9hcmZVOSah
         TsCgbzGvQKJwJlCXa3Cw70+r5JaZVtW/GCI58dRr2MFToEM4X8XASJUIcCZwEiece+RH
         USzHP1SUDJNUOObjoWFSJFCoriH4KORWDSHtO//wi5/SP/YuoDSHhyczQ0D6fKHEOYRb
         p+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324061; x=1683916061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Tb4IA2hxKxJJ3RN6D1gKaTZIjLOtDf6PRFb4BO0b70=;
        b=PS2tHJe7aidiP3x3X6CWslInkp0GHgTFDW7dUvBbOn9qz11Ypb+Ch4GMEFPyAUm4oe
         zflNyMu5p+Cwkp6OOCx/TuX7is4kECJja7RsiKTQLQQjUZdgJfPBF13wCi950gVlW6Uv
         t3UXORMV6wQZZVSbBnwSlEjQmhCjsfJq7DCYD8z4frITsd93IoBm2wq6/Yc79wGpy9b0
         6qjk9AnDfwAJF5cXjKSFBYOeAdPydce8POGFlAcoNerdIQvT9R/9b2laW+MXQv37c+es
         OXKXw7jt/p0n/qI32FeTJ/qyz6a5LxR3L9c1jWOC0IVEFkxkOXjHXky0rheCcMcDq75Z
         DUSg==
X-Gm-Message-State: AAQBX9cpuu/hvi6o9qlbzS7adqoF7Zo3mvUMRe0sy10iB+5q2oILucbu
        ItHMw8Bg4offaGr85sTUjoE=
X-Google-Smtp-Source: AKy350az9rmSKkut4yI+spNz0kLGpItPNRnTGtVQaZKcKWQMqi4BXAdLrP101GdIpJCJN7+eAlhwPg==
X-Received: by 2002:aa7:843a:0:b0:63a:edfa:e216 with SMTP id q26-20020aa7843a000000b0063aedfae216mr8043492pfn.14.1681324061379;
        Wed, 12 Apr 2023 11:27:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b006328ee1e56csm8470937pfw.2.2023.04.12.11.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:27:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 08:27:39 -1000
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
Subject: Re: [PATCH v4 5/5] cgroup/cpuset: Optimize out unneeded
 cpuset_can_fork/cpuset_cancel_fork calls
Message-ID: <ZDb4G2jgQFK8h8Ys@slm.duckdns.org>
References: <20230411133601.2969636-1-longman@redhat.com>
 <20230411133601.2969636-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411133601.2969636-6-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 11, 2023 at 09:36:01AM -0400, Waiman Long wrote:
> The newly introduced cpuset_can_fork() and cpuset_cancel_fork() calls
> are only needed when the CLONE_INTO_CGROUP flag is set which is not
> likely. Adding an extra cpuset_can_fork() call does introduce a bit
> of performance overhead in the fork/clone fastpath. To reduce this
> performance overhead, introduce a new clone_into_cgroup_can_fork flag
> into the cgroup_subsys structure. This flag, when set, will call the
> can_fork and cancel_fork methods only if the CLONE_INTO_CGROUP flag
> is set.
> 
> The cpuset code is now modified to set this flag. The same cpuset
> checking code in cpuset_can_fork() and cpuset_cancel_fork() will have
> to stay as the cgroups can be different, but the cpusets may still be
> the same. So the same check must be present in both cpuset_fork() and
> cpuset_can_fork() to make sure that attach_in_progress is correctly set.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Waiman, I'm not necessarily against this optimization but can we at least
have some performance numbers to show that this is actually meaningful?
Given how heavy our fork path is, I'm not too sure this would show up in any
meaningful way.

Thanks.

-- 
tejun
