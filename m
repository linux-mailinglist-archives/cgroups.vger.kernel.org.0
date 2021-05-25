Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5FB39017C
	for <lists+cgroups@lfdr.de>; Tue, 25 May 2021 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhEYNCE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhEYNCD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 May 2021 09:02:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B0C061574
        for <cgroups@vger.kernel.org>; Tue, 25 May 2021 06:00:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j184so8183225qkd.6
        for <cgroups@vger.kernel.org>; Tue, 25 May 2021 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y28saWW4RbQx7WFyioP30Xg1gnMSgGnjvex8TrgoAmQ=;
        b=SmfdiXxkr36Ea/32dUzc9goah/P/GDAmfDbfC23QxapWU+TYijU+tfipqVELo7UnNb
         kCjW74Q30JDB5fgFGsHqgJCEmxBDKG9IApVbKABuX/KOwPBR0S9vlJjymq+MrMGk51h3
         6ydpK/iuWp9N2XdHcbwhGAfcdpizobjsabPIpm0tzrNvmu9Bxekatij9qaP2uru6JWkm
         9Q/bdYcBQsR1yN1XYUK+IHclcbpDWwfEhDxrstMqMj+GfnNWOoDjxxvTrZpSn3pYUBV+
         tBirFOf/cNxOyaXXED4cDuzfXDrAdEmlM6leYVvOPcAJrsNxmqDTUvm5putYq5K3bzNj
         AP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y28saWW4RbQx7WFyioP30Xg1gnMSgGnjvex8TrgoAmQ=;
        b=SnPjYh9CST15OfIHdyJ6MrsLv71vEZqpMBrjCE3rC3vnhac+LaJ7QdlWS15ZggnZaK
         8YjmqOmbQtCOOOMfFxuz/4t4jn0WsH6ZcciwrdSlMPlWjhrGt5dAHWP85TkJIpyPAWUo
         jW03HIpzdgdDubYHMgeh/KRM7vpwgCImNe9epwfw+euUjXrG/9Ad2OlxlriKaIO0qo69
         dw9onebZDJIa62D+gpyTlKo2ujKvuGOz7OCwePggucad2MuIy2oqBhEDtHEJNwr1Ulj0
         h0bOJGPzuTXBcw47SxNMBqsStXsCv/sieHAEChNw/5OEDKs2UuTdCkkj0VfwdCfWW6G/
         F7Aw==
X-Gm-Message-State: AOAM531nSSvGxz0Zsfxh0d9zue0r37UmliEZazeT27baxmZeluaIl3EE
        hmL3PEqxIB3c23rMEq/Wp4pSpQ==
X-Google-Smtp-Source: ABdhPJweYIK4QVt1oGBJstiLAQCOmbfbqmVA42aSLZNXQ/Hhy/JZ23PoCnqA1TrO1jkKqaIdstwAUA==
X-Received: by 2002:a37:9a44:: with SMTP id c65mr23489338qke.152.1621947632397;
        Tue, 25 May 2021 06:00:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4f4e])
        by smtp.gmail.com with ESMTPSA id o5sm4565264qkl.25.2021.05.25.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 06:00:31 -0700 (PDT)
Date:   Tue, 25 May 2021 09:00:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, mingo@redhat.com,
        peterz@infradead.org, shakeelb@google.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        minchan@kernel.org, corbet@lwn.net, bristot@redhat.com,
        paulmck@kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de, macro@orcam.me.uk,
        viresh.kumar@linaro.org, mike.kravetz@oracle.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <YKz07nx3E8UEo1xa@cmpxchg.org>
References: <20210524195339.1233449-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524195339.1233449-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 24, 2021 at 12:53:39PM -0700, Suren Baghdasaryan wrote:
> PSI accounts stalls for each cgroup separately and aggregates it at each
> level of the hierarchy. This causes additional overhead with psi_avgs_work
> being called for each cgroup in the hierarchy. psi_avgs_work has been
> highly optimized, however on systems with large number of cgroups the
> overhead becomes noticeable.
> Systems which use PSI only at the system level could avoid this overhead
> if PSI can be configured to skip per-cgroup stall accounting.
> Add "cgroup_disable=pressure" kernel command-line option to allow
> requesting system-wide only pressure stall accounting. When set, it
> keeps system-wide accounting under /proc/pressure/ but skips accounting
> for individual cgroups and does not expose PSI nodes in cgroup hierarchy.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
