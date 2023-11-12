Return-Path: <cgroups+bounces-340-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C07E92E0
	for <lists+cgroups@lfdr.de>; Sun, 12 Nov 2023 22:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7BB1C2048A
	for <lists+cgroups@lfdr.de>; Sun, 12 Nov 2023 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FC1A585;
	Sun, 12 Nov 2023 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4mpKFpH"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543F18640
	for <cgroups@vger.kernel.org>; Sun, 12 Nov 2023 21:25:18 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E463211D;
	Sun, 12 Nov 2023 13:25:17 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41cd6e1d4fbso22541711cf.1;
        Sun, 12 Nov 2023 13:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699824316; x=1700429116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOSPMLYo2Er1eDVoJWgNm5S1s3Vd5FOOXWgd1fuJ8N4=;
        b=l4mpKFpHSCXmtSa6bK6oQMnUpBWMDqCWvSYI5FfC/5xmZxasDY6+HBqLFiR7xKGLXX
         n32CRQPM9bw/FkCtpobBi0LBI4rC69m9w4OyXDocXRZCiQH1FLTuIJXUFG9QWHN7Xj3d
         0YXJjDaLwQebIBKQT+IsnIHCV2rTj3a5BfZBrvkBpZV9dBkUs7OrshiKGD41oCcWjwSX
         xVgmHJc2as5OCTJ2nOwatrZo+5ijCw2sM8n+ys/Vbu/1FIfjfiAA0lAd6Z5jW/b1+JOY
         ctuoRZDIdshFLpeaBxCf611ryoUF3VtzZvhYmxrdqfEz4Se/KenEcEfZ39AI0M7ALwwt
         JBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699824316; x=1700429116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOSPMLYo2Er1eDVoJWgNm5S1s3Vd5FOOXWgd1fuJ8N4=;
        b=TSWjsA+ubBGPYTe8fooWYnEQvd7sKRQcquRfhNHRePII1QJvd0aDiv2xIE+ynlXM9O
         EXdbH8rL6eSJoWuA9R96qYOus1gKeF/RFIubm/N0zgzTieYhnIL+j+9kzY7RW9ehZHGi
         5qIvzawiaPPMYWh78KkiZr3EX3NCk4doM+QiirOSrdkmq7TcS7Mg3b0PQXzWqP3v7EWl
         U7vDH3WUbvEM0NDJcVyJ+/BCdtdtPLzmufuDX3e2GB17huLzrsZbDXueQkzwGecN/nK4
         G/dwn6eRtQcWxrLtnKe6kts0CPI3j5qY1AWI+MU72rWad6Y2WXbL+Q3JjEnySdlA3fke
         0wmw==
X-Gm-Message-State: AOJu0YyTl4PVjQNgQ2MkYhzHx0elmPeAPC8zrBxxvMqkpLFveD4rDHtS
	V0iBU+iM7I984P4QABokILI=
X-Google-Smtp-Source: AGHT+IF+zwg2Dbl1pdsQfv8ztEKfFQJdNbFe20Omwohg2mqPaiYfe4ISX8w3J3NCOYiXfxD8o6Qn5w==
X-Received: by 2002:ac8:5c0c:0:b0:41c:d41b:1b99 with SMTP id i12-20020ac85c0c000000b0041cd41b1b99mr5125217qti.35.1699824316114;
        Sun, 12 Nov 2023 13:25:16 -0800 (PST)
Received: from localhost ([164.86.0.75])
        by smtp.gmail.com with ESMTPSA id h12-20020ac8568c000000b00421b14f7e7csm1424378qta.48.2023.11.12.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 13:25:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Nov 2023 15:25:07 -0600
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v3 1/3] cgroup/rstat: Reduce cpu_lock hold time in
 cgroup_rstat_flush_locked()
Message-ID: <ZVFCs5MpynXgXnWY@mtj.duckdns.org>
References: <20231104031303.592879-1-longman@redhat.com>
 <20231104031303.592879-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104031303.592879-2-longman@redhat.com>

On Fri, Nov 03, 2023 at 11:13:01PM -0400, Waiman Long wrote:
> When cgroup_rstat_updated() isn't being called concurrently with
> cgroup_rstat_flush_locked(), its run time is pretty short. When
> both are called concurrently, the cgroup_rstat_updated() run time
> can spike to a pretty high value due to high cpu_lock hold time in
> cgroup_rstat_flush_locked(). This can be problematic if the task calling
> cgroup_rstat_updated() is a realtime task running on an isolated CPU
> with a strict latency requirement. The cgroup_rstat_updated() call can
> happen when there is a page fault even though the task is running in
> user space most of the time.
> 
> The percpu cpu_lock is used to protect the update tree -
> updated_next and updated_children. This protection is only needed when
> cgroup_rstat_cpu_pop_updated() is being called. The subsequent flushing
> operation which can take a much longer time does not need that protection
> as it is already protected by cgroup_rstat_lock.
> 
> To reduce the cpu_lock hold time, we need to perform all the
> cgroup_rstat_cpu_pop_updated() calls up front with the lock
> released afterward before doing any flushing. This patch adds a new
> cgroup_rstat_updated_list() function to return a singly linked list of
> cgroups to be flushed.
> 
> Some instrumentation code are added to measure the cpu_lock hold time
> right after lock acquisition to after releasing the lock. Parallel
> kernel build on a 2-socket x86-64 server is used as the benchmarking
> tool for measuring the lock hold time.
> 
> The maximum cpu_lock hold time before and after the patch are 100us and
> 29us respectively. So the worst case time is reduced to about 30% of
> the original. However, there may be some OS or hardware noises like NMI
> or SMI in the test system that can worsen the worst case value. Those
> noises are usually tuned out in a real production environment to get
> a better result.
> 
> OTOH, the lock hold time frequency distribution should give a better
> idea of the performance benefit of the patch.  Below were the frequency
> distribution before and after the patch:
> 
>      Hold time        Before patch       After patch
>      ---------        ------------       -----------
>        0-01 us           804,139         13,738,708
>       01-05 us         9,772,767          1,177,194
>       05-10 us         4,595,028              4,984
>       10-15 us           303,481              3,562
>       15-20 us            78,971              1,314
>       20-25 us            24,583                 18
>       25-30 us             6,908                 12
>       30-40 us             8,015
>       40-50 us             2,192
>       50-60 us               316
>       60-70 us                43
>       70-80 us                 7
>       80-90 us                 2
>         >90 us                 3
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Applied this one to cgroup/for-6.8. Will wait for the updated version for
the other patches.

Thanks.

-- 
tejun

