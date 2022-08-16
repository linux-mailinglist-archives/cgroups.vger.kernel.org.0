Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA775960EF
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiHPRUb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiHPRU3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 13:20:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F8F5FEF;
        Tue, 16 Aug 2022 10:20:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so10244731pjf.5;
        Tue, 16 Aug 2022 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=r91jzjWZhlEdAsAG7xnJCiSvfb9cchZedVFaXE4bjp4=;
        b=TvooP6Vs8oiEoPmqq4G62BVNWO56dW0DcKJ15qUCu0ZE9ECb409mZosxkdMVDSOj0a
         y2m0JwIDYAGdwXcSZXXK/5oOGh+IA6tmHPZpqSfdQaIm5M/Z2/Zy88MwZI0G6GHRbeXC
         mugphGGr+otsfCPJd58BcMJt3dzuyWsZ7gfLWkHWjakj1FEsFu+WTYyckNYIeWpTvJZ6
         NPMH6pk+NbDQSwtXJ6Y1Zjz3GF/ADed8ASD9bVoJukmUOgmtqTef2oNq7vSsrLPp9tRr
         YLrZjaVXBRmFC8uQstb8aaxgDfv+hYWb9Gy2+jdVAx/K8GTo8LBoA2D+wwyU5yTHh+/D
         uWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=r91jzjWZhlEdAsAG7xnJCiSvfb9cchZedVFaXE4bjp4=;
        b=tCTJaie62C5gd7e3VptO7SEHtov2+dt9WrG5hZGgK+9JZr+riLTXgnr/RB2aiMAWvt
         +Z18CR2JPD6/b+nCiB4lwippwcLfgtBx1CVX8+Tl7NGzZZ3AKP8CFQvBTHrxOhZ+JBIS
         2yo23bIB38dzT1SjRFVEubvz72j4lFqPQhuOxIUU/ak42a1Mu+E0bTYMDFuI88hXZuJ0
         an+jrwdfl549coOV2sYuwckBei//kO3kuCXAGr7UAmKhe3R6TvYgp5YrlkD3Z6CI445w
         qjbvQXOgnvWSyPmbrhQ8H6O3DRCpbNFP0P205V6J72kko24ZnyZ5FowjqemHVVml695z
         2FTQ==
X-Gm-Message-State: ACgBeo0qZ79H2FxDbP+GQ9ADSpyTnUPZqU0Hwp8Qy5MiauH5CXGA3Oh8
        sCxrP5pinxaCf486+dIYT5Q=
X-Google-Smtp-Source: AA6agR64VZz5ccV9Mq8nhQlttdjGhTpP/74xWW8SIPGFhdhMs8ibKywgtG8w3+gYadGwMen+2/m7BA==
X-Received: by 2002:a17:902:b184:b0:172:766e:7f35 with SMTP id s4-20020a170902b18400b00172766e7f35mr6974947plr.174.1660670427971;
        Tue, 16 Aug 2022 10:20:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id a70-20020a621a49000000b0052e6c073a3csm9020956pfa.142.2022.08.16.10.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:20:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 07:20:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 3/3] cgroup/cpuset: Keep user set cpus affinity
Message-ID: <YvvR2Sa6LxZLwXsJ@slm.duckdns.org>
References: <20220816151119.29534-1-longman@redhat.com>
 <20220816151119.29534-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816151119.29534-4-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

So, overall I think this is the right direction.

> +static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
> +				       const struct cpumask *mask)
> +{
> +	if (p->user_cpus_ptr) {
> +		cpumask_var_t new_mask;
> +
> +		if (alloc_cpumask_var(&new_mask, GFP_KERNEL) &&
> +		    copy_user_cpus_mask(p, new_mask) &&
> +		    cpumask_and(new_mask, new_mask, mask)) {
> +			int ret = set_cpus_allowed_ptr(p, new_mask);
> +
> +			free_cpumask_var(new_mask);
> +			return ret;
> +		}
> +		free_cpumask_var(new_mask);
> +	}
> +
> +	return set_cpus_allowed_ptr(p, mask);
> +}

But this seems racy to me. Let's say attach and setaffinity race. The
expectation should be that we'd end up with the same eventual mask no matter
what the operation order may be. The above code wouldn't do that, right?
There's nothing synchronizing the two and if setaffinity takes place between
the user_cpus_ptr test and set_cpus_allowed_ptr(), it'd get ignored.

This gotta be more integrated. There is what the user requested and there
are restrictions from CPU hotplug state and cpuset. All three should be
synchronized so that there is one synchronzied way to obtain and apply the
current effective mask.

Thanks.

-- 
tejun
