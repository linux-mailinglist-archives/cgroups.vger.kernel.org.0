Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D538FB80
	for <lists+cgroups@lfdr.de>; Tue, 25 May 2021 09:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEYHQP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 03:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEYHQO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 May 2021 03:16:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C00AC061574;
        Tue, 25 May 2021 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uehh4cPPcsHkI+ofqFVA/9YB9cJWcIz/8uLMkzzVSu8=; b=XzNIiRP+DH+CDt+hgDALUsVNng
        lHK9X1wzN+4A/ZOIjAsp2FGB+pmCBn3/LS6bhLf+LJ/GHAcV4yf0BW0gox+4yPYa8eHdlHosrBbxl
        MASrTUt/7ygG5O/iH1++y+9o1GEBq7HSvHX0XpTIa91x3pZjopHo594ge099Q2ILpJChZ+67byR8E
        pdH3PO7Bx4vvjzdKWQaGS3SIKYPbzKCo+qQanGNUKKFg6Jj6EU8pLuuRkT9bs6dGKmsYYHZYgSwaU
        ueNQv0b24QFK0oiZTISUCNUY6EjEnz8Dn5pavsn5a5QMCbzi4WMkkRnvA06cJq2SSbTyrdx11evrU
        KnmL+Q9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llRFN-003DpG-DE; Tue, 25 May 2021 07:13:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96F153001E4;
        Tue, 25 May 2021 09:12:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76B0131474564; Tue, 25 May 2021 09:12:59 +0200 (CEST)
Date:   Tue, 25 May 2021 09:12:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        mingo@redhat.com, shakeelb@google.com, juri.lelli@redhat.com,
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
Message-ID: <YKyje/yNnwVyTcDB@hirez.programming.kicks-ass.net>
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

>  kernel/sched/psi.c                            | 30 +++++++-----

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
