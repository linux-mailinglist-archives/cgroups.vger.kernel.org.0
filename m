Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21729A3461
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2019 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH3Jpa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Aug 2019 05:45:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49392 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3Jpa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Aug 2019 05:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sRzfMxg/wb0LZA+yxxNDj+QkDWg9yL2CpESWkv5XC/w=; b=l2LwR+WZLkNuEzUTAdmtkXcm3
        oa334e4Rqs8Yq0Nq0CkLdOVet4f+H8YYMmJl5clWcQPgJMbRjzcpWXQ6/knfmZGiAbW+iUnLpPM86
        Tpciv6IJKV3YWiNZ3Fao3+MXOt0npZRncrUeki+/Wi0i4AisF5qYv5mxoiFq5bCpO19dWGPkXBwFU
        QTY7D5N0yj38gVn+oYJnJFElg/HqbY6ZYY+s1gFnZBlynLvagoR2ZoAqY0wxJDTPC0XUvNeBWsDgh
        PDFR5latRRys33U67/D7R7baHn1Jz23RMdDtFJgbiytvOTchW1XXcDTFwFJA4qsyVcWRG/Ed21htd
        26cnQEJDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3dSu-0000tZ-1d; Fri, 30 Aug 2019 09:45:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B6A93035D7;
        Fri, 30 Aug 2019 11:44:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 290FF29AD350F; Fri, 30 Aug 2019 11:45:05 +0200 (CEST)
Date:   Fri, 30 Aug 2019 11:45:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v14 1/6] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190830094505.GA2369@hirez.programming.kicks-ass.net>
References: <20190822132811.31294-1-patrick.bellasi@arm.com>
 <20190822132811.31294-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822132811.31294-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 22, 2019 at 02:28:06PM +0100, Patrick Bellasi wrote:
> +#define _POW10(exp) ((unsigned int)1e##exp)
> +#define POW10(exp) _POW10(exp)

What is this magic? You're forcing a float literal into an integer.
Surely that deserves a comment!

> +struct uclamp_request {
> +#define UCLAMP_PERCENT_SHIFT	2
> +#define UCLAMP_PERCENT_SCALE	(100 * POW10(UCLAMP_PERCENT_SHIFT))
> +	s64 percent;
> +	u64 util;
> +	int ret;
> +};
> +
> +static inline struct uclamp_request
> +capacity_from_percent(char *buf)
> +{
> +	struct uclamp_request req = {
> +		.percent = UCLAMP_PERCENT_SCALE,
> +		.util = SCHED_CAPACITY_SCALE,
> +		.ret = 0,
> +	};
> +
> +	buf = strim(buf);
> +	if (strncmp("max", buf, 4)) {

That is either a bug, and you meant to write: strncmp(buf, "max", 3), or
it is not, and then you could've written: strcmp(buf, "max")

But as written it doesn't make sense.

> +		req.ret = cgroup_parse_float(buf, UCLAMP_PERCENT_SHIFT,
> +					     &req.percent);
> +		if (req.ret)
> +			return req;
> +		if (req.percent > UCLAMP_PERCENT_SCALE) {
> +			req.ret = -ERANGE;
> +			return req;
> +		}
> +
> +		req.util = req.percent << SCHED_CAPACITY_SHIFT;
> +		req.util = DIV_ROUND_CLOSEST_ULL(req.util, UCLAMP_PERCENT_SCALE);
> +	}
> +
> +	return req;
> +}

