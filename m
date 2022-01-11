Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014448ADE6
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 13:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiAKMuS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 07:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbiAKMuR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 07:50:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CCC061751;
        Tue, 11 Jan 2022 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W5BA8bVjbfO+zVPSB0b1V93TDMPABwb7zzlwyo/Fyu8=; b=iiIkc3leMxv70UeLMw0yGiGQs7
        E6r0A3ny4GRM6CVlsCg4uoCJnMk0HUJoz+PJ667IPpG46j2VMzjtdt08X3TFwORiaQHC4zvBHBW0C
        95EGXjc0HpgtJEllAruGRUEEN8uSCpyOJp6/UxyE8FG94ihqw2igLi2ioIuEl9H8JM1thv5rPA3k+
        H5/NduHj6i80KbHiAZQ4EO1zmrpBDOS/kbYnDlYqHkU3I7SsFjqYtbFi2mxfJzMsSZJnMwqqPei+A
        JEOc/c10EFQ47KzJJEhpmeggCRzVmh1cT/uTb77yKbMxeMJWjORA/j3rKHpzy8kkFLZts5gfE96Ez
        f9FHI8OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7GbD-003GBk-MQ; Tue, 11 Jan 2022 12:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CC2C3001CD;
        Tue, 11 Jan 2022 13:50:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE64B2B32354B; Tue, 11 Jan 2022 13:49:59 +0100 (CET)
Date:   Tue, 11 Jan 2022 13:49:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: add cpu.stat_percpu
Message-ID: <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
References: <20220107234138.1765668-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107234138.1765668-1-joshdon@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 07, 2022 at 03:41:37PM -0800, Josh Don wrote:

> +	seq_puts(seq, "usage_usec");
> +	for_each_possible_cpu(cpu) {
> +		cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> +		val = cached_bstat->cputime.sum_exec_runtime;
> +		do_div(val, NSEC_PER_USEC);
> +		seq_printf(seq, " %llu", val);
> +	}
> +	seq_puts(seq, "\n");
> +
> +	seq_puts(seq, "user_usec");
> +	for_each_possible_cpu(cpu) {
> +		cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> +		val = cached_bstat->cputime.utime;
> +		do_div(val, NSEC_PER_USEC);
> +		seq_printf(seq, " %llu", val);
> +	}
> +	seq_puts(seq, "\n");
> +
> +	seq_puts(seq, "system_usec");
> +	for_each_possible_cpu(cpu) {
> +		cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> +		val = cached_bstat->cputime.stime;
> +		do_div(val, NSEC_PER_USEC);
> +		seq_printf(seq, " %llu", val);
> +	}
> +	seq_puts(seq, "\n");

This is an anti-pattern; given enough CPUs (easy) this will trivially
overflow the 1 page seq buffer.

People are already struggling to fix existing ABI, lets not make the
problem worse.
