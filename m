Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844AD4214A4
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbhJDRC2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbhJDRC2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 13:02:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED43C061746;
        Mon,  4 Oct 2021 10:00:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h1so4358626pfv.12;
        Mon, 04 Oct 2021 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pqoXBReWZTHvQNJRRiye0Xfo5/CYCSyS20QIvLAs+Oc=;
        b=RNg9WE6gurFAuclja1md8Z0NgpR7kRF419Lfq/1FBEY4FvTK31TnekkHmWasNe+C81
         2Qf24+qnVfqCnBg0pl5JqIUNn59KlKxY5SE2ATXqXyduo1FxV2Xeh1OO2kubNdwNtjAG
         UJm8LWP4NkJzpKHwR5RMCdClAlMDlQgqf3bxnhmk1oWWLHaFxrpyOZkeXcZC+qtCv1pj
         INwuFn3eMzaewx9I9bsaLSnK3FtI4iqkTTdaeomSYzFf5J8USqmB60JPQKAZHaYVbMx0
         6Pn3qDDShj9beVqCvMwxJQRZmRgdDAQ6C8SdugwvvlDnnjdMOQjhDXtBm/mNQ4o5YSMd
         Tujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pqoXBReWZTHvQNJRRiye0Xfo5/CYCSyS20QIvLAs+Oc=;
        b=FxEneqrR7zqTCHsiDXKHW9uNKM2/P0uLnTMbMUbx5LdnDPQmtKtMecqV4NHZHq97AX
         SMznq6pk7xekMdC9SeUCMqJwLBkrvsO1ztPAPaetlWCGLLEMHL/nsZaoe/0afYfYwpsv
         HzOtz6H2WZBThdvcOhqqlYxoF96MhcpqG4Hx1+ngRpCdFLg8XaFNAEnCOVlQR5mdOOU2
         Bv9jbPZJ3qsPo55w+wdYFdIfIEQhKRkAgbcZX1wYlnzbetjcPzOe0NmI/wOkc71SI1pq
         tJJjUaIpj7mg2rTNIFlPNChGVXTWuzIBHlV8YujH8NkeCxRfBiJHioFjK4RPVA4OqfFy
         7Jyg==
X-Gm-Message-State: AOAM533CRYnvjjgSe9LsP89vtmrzcGIjRf4jx9fKY9LvQSCZDi+HHxi4
        fv/7xTQEOqI+pRv/Mc0PHGPqYKRPXj8=
X-Google-Smtp-Source: ABdhPJxMWd4M2kuY8tYPE253PYtBDVkN+DYkbo48TWI1lG9x9kT024XE7UME1r6mMjAR6b7cFRKHIw==
X-Received: by 2002:aa7:93d2:0:b0:44b:e5e8:f89e with SMTP id y18-20020aa793d2000000b0044be5e8f89emr25864519pff.52.1633366838049;
        Mon, 04 Oct 2021 10:00:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u19sm9594742pfg.18.2021.10.04.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:00:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Oct 2021 07:00:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: rstat: optimize flush through speculative test
Message-ID: <YVszNI97NAAYpHpm@slm.duckdns.org>
References: <20210929235936.2859271-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929235936.2859271-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Shakeel.

On Wed, Sep 29, 2021 at 04:59:36PM -0700, Shakeel Butt wrote:
> Currently cgroup_rstat_updated() has a speculative already-on-list test
> to check if the given cgroup is already part of the rstat update tree.
> This helps in reducing the contention on the rstat cpu lock. This patch
> adds the similar speculative not-on-list test on the rstat flush
> codepath.
> 
> Recently the commit aa48e47e3906 ("memcg: infrastructure to flush memcg
> stats") added periodic rstat flush. On a large system which is not much
> busy, most of the per-cpu rstat tree would be empty. So, the speculative
> not-on-list test helps in eliminating unnecessary work and potentially
> reducing contention on the rstat cpu lock. Please note this might
> introduce temporary inaccuracy but with the frequent and periodic flush
> this would not be an issue.
> 
> To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
> a system with swap-on-zram and the file was pushed to swap through
> memory.force_empty interface. On reading the whole file, the memcg stat
> flush in the refault code path is triggered. With this patch, we
> observed 38% reduction in the read time of 8 GiB file.

The patch looks fine to me but that's a lot of reduction in read time. Can
you elaborate a bit on why this makes such a huge difference? Who's hitting
on that lock so hard?

Thanks.

-- 
tejun
