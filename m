Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46296273FCD
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIVKmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 06:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgIVKmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 06:42:55 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4851C0613CF
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 03:42:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a12so15623147eds.13
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d1+yTgS/nDdjZEJi5XLFsbasjOospBGkZinpc5mGS48=;
        b=NTQO2+kjCrvdbjEFL+8qa0xnM8j2aFkI4YIcOCf4DCtwzIrmLrmov9WqKk+Wh+vi4c
         gCqSG+yI5jbUdW0ZVX5erknsxE3avoRsk7dEgDoLscAWzHi9kia5w25FMnOnzVtYelst
         N+N+jIm2n4VgPnzMfUEdrh/Ou7cDYiyq+cqLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d1+yTgS/nDdjZEJi5XLFsbasjOospBGkZinpc5mGS48=;
        b=iMburQeho76xxPgXZIM5Z8FloPK5lVhdLwmcBGVtM7dTHhKmKXpR3rEPWkhcvY56r5
         8rVbNy4M360pI2lsqe92h5B4eK7lIZBkDPlPFIeN5KgKIgY8JMm4XfLVTmQZDw5zuflO
         q2lVEMwdcnXyLBgg/IoK8iYeEvwd2lJKco+JRcGdOhjXdkz/Qgc13yB2Cihmf3dPIYh6
         Rv+GSXV3aghnt0Q2NqYm0g6viQ4Phvfpzm5kJDmDhl58HcPpa8uViXZXuwJ2F8UiA0vV
         plOYsz1xHIzFV9ZNalxWVG5qJk9IhqR8+eVWhpe0zotPJxyVZl3zFukc2dTxp0wW7Q5t
         nIqg==
X-Gm-Message-State: AOAM533FCgfp3tIvtXA6YecLgtnY2RqfnBQ9TEWRXLHx/BS2s4npRgdS
        foYrqgJvrEPpB6TwSW/3gvp0AQ==
X-Google-Smtp-Source: ABdhPJyLjjf0N1v9YU9XDgeN4pEzCTJKyLcJJ5cAqsBsxayr1kBl20EtWfgNKP9UQ2nNgW/Tp4JosQ==
X-Received: by 2002:a05:6402:202a:: with SMTP id ay10mr3317444edb.36.1600771373203;
        Tue, 22 Sep 2020 03:42:53 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:7783])
        by smtp.gmail.com with ESMTPSA id 16sm10724717edx.72.2020.09.22.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 03:42:52 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:42:52 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Chunxin Zang <zangchunxin@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [External] Re: [PATCH] mm/memcontrol: Add the drop_cache
 interface for cgroup v2
Message-ID: <20200922104252.GB9682@chrisdown.name>
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
 <20200921081200.GE12990@dhcp22.suse.cz>
 <CALOAHbDKvT58UFjxy770VDxO0VWABRYb7GVwgw+NiJp62mB06w@mail.gmail.com>
 <20200921110505.GH12990@dhcp22.suse.cz>
 <CAKRVAeN5U6S78jF1n8nCs5ioAdqvVn5f6GGTAnA93g_J0daOLw@mail.gmail.com>
 <20200922095136.GA9682@chrisdown.name>
 <CAKRVAePisoOg8QBz11gPqzEoUdwPiJ-9Z9MyFE2LHzR-r+PseQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKRVAePisoOg8QBz11gPqzEoUdwPiJ-9Z9MyFE2LHzR-r+PseQ@mail.gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chunxin Zang writes:
>On Tue, Sep 22, 2020 at 5:51 PM Chris Down <chris@chrisdown.name> wrote:
>>
>> Chunxin Zang writes:
>> >My usecase is that there are two types of services in one server. They
>> >have difference
>> >priorities. Type_A has the highest priority, we need to ensure it's
>> >schedule latency、I/O
>> >latency、memory enough. Type_B has the lowest priority, we expect it
>> >will not affect
>> >Type_A when executed.
>> >So Type_A could use memory without any limit. Type_B could use memory
>> >only when the
>> >memory is absolutely sufficient. But we cannot estimate how much
>> >memory Type_B should
>> >use. Because everything is dynamic. So we can't set Type_B's memory.high.
>> >
>> >So we want to release the memory of Type_B when global memory is
>> >insufficient in order
>> >to ensure the quality of service of Type_A . In the past, we used the
>> >'force_empty' interface
>> >of cgroup v1.
>>
>> This sounds like a perfect use case for memory.low on Type_A, and it's pretty
>> much exactly what we invented it for. What's the problem with that?
>
>But we cannot estimate how much memory Type_A uses at least.

memory.low allows ballparking, you don't have to know exactly how much it uses.  
Any amount of protection biases reclaim away from that cgroup.

>For example:
>total memory: 100G
>At the beginning, Type_A was in an idle state, and it only used 10G of memory.
>The load is very low. We want to run Type_B to avoid wasting machine resources.
>When Type_B runs for a while, it used 80G of memory.
>At this time Type_A is busy, it needs more memory.

Ok, so set memory.low for Type_A close to your maximum expected value.
