Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075B69E2F0
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 16:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjBUPCK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 10:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjBUPCG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 10:02:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C892B628;
        Tue, 21 Feb 2023 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bCEktfZQBYOidtJzxUm4n6P8jzrl5z+36FM412yPsqs=; b=JDpD0PpWH3pnX8EYDtfDPUDLIy
        S10rBhUk23wKDrJcvT4gwTBjEdQTEO8uKioDDQMoHCwBLn3wlR476k9xVsrPQKWksABn/2jpJ7R4w
        aPbh/wOeH17i+dXF6Adx64cKbCrkz18407TYKbZn7U8vkTXkOtqi374xKlqiF0ra5RjDIbuSPOM70
        6DelKoWS68hL6HpdwmIstsS/hXfpR8N301EpkJ++hWFXgZztyyV9tvQ4ILrVoPRAjwLvYIeKBwW9R
        kVnvhJmGZU1oAwH9+P+00TX9twcvYMbmkfzBR6yZ+6ulIy60wp/Q7BKKcereIOrFkKYtQnv0mPFD+
        zyRULY4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUU8z-00Ch0m-0F; Tue, 21 Feb 2023 15:01:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49EA430020B;
        Tue, 21 Feb 2023 16:01:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3107F2007A8C6; Tue, 21 Feb 2023 16:01:22 +0100 (CET)
Date:   Tue, 21 Feb 2023 16:01:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH v10 6/9] sched/fair: Add sched group latency support
Message-ID: <Y/TcwkmiVXJmQ9nw@hirez.programming.kicks-ass.net>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113141234.260128-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 13, 2023 at 03:12:31PM +0100, Vincent Guittot wrote:

> +static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
> +				    struct cftype *cft)
> +{
> +	int prio, delta, last_delta = INT_MAX;
> +	s64 weight;
> +
> +	weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> +	weight = div_s64(weight, get_sleep_latency(false));
> +
> +	/* Find the closest nice value to the current weight */

This comment isn't entirely accurate, since we only have the nice_write
interface below, this will be an exact match. The thing with weight is
that we first had the raw weight value interface and then the nice
interface had to map random values back to a 'nice' value.

Arguably we can simply store the raw nice value in write and print it
out again here.

> +	for (prio = 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio++) {
> +		delta = abs(sched_latency_to_weight[prio] - weight);
> +		if (delta >= last_delta)
> +			break;
> +		last_delta = delta;
> +	}
> +
> +	return LATENCY_TO_NICE(prio-1);
> +}
> +
> +static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
> +				     struct cftype *cft, s64 nice)
> +{
> +	s64 latency_offset;
> +	long weight;
> +	int idx;
> +
> +	if (nice < MIN_LATENCY_NICE || nice > MAX_LATENCY_NICE)
> +		return -ERANGE;
> +
> +	idx = NICE_TO_LATENCY(nice);
> +	idx = array_index_nospec(idx, LATENCY_NICE_WIDTH);
> +	weight = sched_latency_to_weight[idx];
> +
> +	latency_offset = weight * get_sleep_latency(false);
> +	latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
> +
> +	return sched_group_set_latency(css_tg(css), latency_offset);
> +}
