Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5091E495B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390824AbgE0QIt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390823AbgE0QIt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 May 2020 12:08:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B1FC05BD1E
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 09:08:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so9726267qtq.11
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8h0j9dH4yYJY4/vfPJevkjnamNxkzeTwIjaJ077JR0=;
        b=wr9R8e/kt+6YZN51MgGSrgrQKN+iV0+U0w3YDiUZds+tcdj7UMMAPuL2YRAryMtohX
         VNKbvNrG4bIjPWETOEhzA2c4U/E+X4CVY2EgJ/5ySPQ3LlqJidyQIRGPfTzASiiFnl+S
         uHmbW0X2xvXgxyXg4abfE1eHxfYdyOP2KHd5y4aqtb2dKO5FWfHDDlvh4G4leXuoDM2X
         6k6SD1XYo3XXhbqc/Ijv/Mz+1Egec9v2tRNzcTRPdOlPecpv6ZUeA9Eni8M8qGoWVGYI
         25JlCJx5lZcI/qzgwceu2T05yXTObMsf3EZfQHFHZ6afE2C5Lsf9qFojbh1qNErXd8RZ
         b0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8h0j9dH4yYJY4/vfPJevkjnamNxkzeTwIjaJ077JR0=;
        b=NFqf1OqgK9t22HdqJN+OZPlY06W1OpLcDuBzg+jW8SORX4Kr/aD4PfBgm6UetvBIsD
         Zz0qw2lByaEjmUeGChlGidq3L3s+c0WniubFnzjloJjub6qoRGaDIKXzfDKsmJtQU1I6
         8/9dyual/P2BUEscrIteLVCnoPczLeYfb6ZT1+qeLp+F+NUrZYMBQ6T7RmuK/f9b0Wga
         YHOL2jo5wyRmvdKnVc1Qqg3nNm9ABPwGUYSrQqNZuZKyoc7HlpLtkppS08Yb/NYeR68F
         9WC7S7XMxfemVLjwQWIrWOH+dGMp/gvKBKc13spudVEifP1SBd/KnLNe1vnOWsfIywHD
         fzrQ==
X-Gm-Message-State: AOAM531O57TjlxuB/TsnSfopHIvldtGr2iMCm2SGf+Y9pbRjbILtLuSL
        loSRapNRuWWL3VVa4iH2LIUHig==
X-Google-Smtp-Source: ABdhPJy5UGsbDyy2tFB1CZRSSq0mPUHmpiz0WO0wsfMt60nuAnhNi+TNUDnh/WaDsCnTkdOrWSy7Rg==
X-Received: by 2002:ac8:42ce:: with SMTP id g14mr4989535qtm.117.1590595727478;
        Wed, 27 May 2020 09:08:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id f14sm2558579qka.70.2020.05.27.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:08:46 -0700 (PDT)
Date:   Wed, 27 May 2020 12:08:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH cgroup/for-5.8] cgroup: add cpu.stat file to root cgroup
Message-ID: <20200527160821.GC42293@cmpxchg.org>
References: <20200526200800.3969430-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526200800.3969430-1-boris@bur.io>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 26, 2020 at 01:08:00PM -0700, Boris Burkov wrote:
> Currently, the root cgroup does not have a cpu.stat file. Add one which
> is consistent with /proc/stat to capture global cpu statistics that
> might not fall under cgroup accounting.
> 
> We haven't done this in the past because the data are already presented
> in /proc/stat and we didn't want to add overhead from collecting root
> cgroup stats when cgroups are configured, but no cgroups have been
> created.
> 
> By keeping the data consistent with /proc/stat, I think we avoid the
> first problem, while improving the usability of cgroups stats.
> We avoid the second problem by computing the contents of cpu.stat from
> existing data collected for /proc/stat anyway.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Suggested-by: Tejun Heo <tj@kernel.org>

Looks good to me, but Boris can you please update
Documentation/admin-guide/cgroup-v2.rst as well in this patch?

  cpu.stat
        A read-only flat-keyed file which exists on non-root cgroups.

Thanks!
