Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6567F388
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 02:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjA1BLX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 20:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA1BLX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 20:11:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F68922010;
        Fri, 27 Jan 2023 17:11:22 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d3so6615807plr.10;
        Fri, 27 Jan 2023 17:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkIPhMBlAguq3FpLF2bZhv+JUE0U4Yd9XqKOrWVb86U=;
        b=T/yjCD7aAOS7VSevYpoV8uPNqOX9/HTALgteOMMYgpyI3MhRyAu+YD3dWSItr3uMKd
         3GxM6KwOplc8c6T2VCDElYplaPui6ZBpurwTBcTp/88En30KDkoRkhGQXY2kDyN56U16
         YDo679wn6KpfLCufDkgvlAzyD2zTsSicSs0GZMqfZcjwhFhfqpbM1JCdXS323w1NVpfQ
         xMSXjIqAhLoFdyE5ztg6T0XEIj2653LI/UHlea/dw8asYDJFXYjh3wkPSbrQ+8Mw7s0q
         +Oz7NwncqTLmicgOYmqhSzXhfUKVBCVVefB/BmtsjrJJV7AuzKO8JXM3EvSbWhGK7ir6
         9vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkIPhMBlAguq3FpLF2bZhv+JUE0U4Yd9XqKOrWVb86U=;
        b=6Hzj2igGBcvfhZ7WIi+rNS4nW1did+FVeWBnqdu+nuGdl3EvefgKVsooH9PqzclTxJ
         tzFzsQ91OYsSO9T0VLhxGRUMwHYxpb6WXTuUW9poUxoCaJHNI+IZ6/wJQiCvuEZVIUrJ
         0p0WL1M6aLPY/MakdZMTLG7lqcqQ9Ndy1kgyo7kD00qwO89PKOtqZEvBjM/SCChUP6y5
         xvI28J31zDWBX6feRZjpsGCxBtdaJM+xo9FUMGOCzEtF9CVtvHoVWhW9IcxVbnviRCM1
         1pasrnM6pEynrvJni9X4OrBPB934ZoH9LLdculXKIB2fY57/YtW/rQmU25F7dPhlxCdg
         xKDg==
X-Gm-Message-State: AO0yUKUoylp6UKm0EAPeCp3ylOnZiUnPJevdYyrA2cXvb1yMhlZjJ9Gh
        2sATFw3ZUQ7mmUsQsKyiwmo=
X-Google-Smtp-Source: AK7set9J1CD7FAmfqjLRocvv/S1+31usQXEqv6Nnbcx3pC8XJsLD4h2fRZMz2A/hmOdiPdbN4A3tgg==
X-Received: by 2002:a05:6a20:6991:b0:bb:bb46:bb9e with SMTP id t17-20020a056a20699100b000bbbb46bb9emr17951461pzk.39.1674868281358;
        Fri, 27 Jan 2023 17:11:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g27-20020aa796bb000000b0059242cd5469sm3355789pfk.13.2023.01.27.17.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 17:11:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 15:11:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC 10/12] cgroup/drm: Introduce weight based drm cgroup control
Message-ID: <Y9R2N8sl+7f8Zacv@slm.duckdns.org>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 12, 2023 at 04:56:07PM +0000, Tvrtko Ursulin wrote:
...
> +	/*
> +	 * 1st pass - reset working values and update hierarchical weights and
> +	 * GPU utilisation.
> +	 */
> +	if (!__start_scanning(root, period_us))
> +		goto out_retry; /*
> +				 * Always come back later if scanner races with
> +				 * core cgroup management. (Repeated pattern.)
> +				 */
> +
> +	css_for_each_descendant_pre(node, &root->css) {
> +		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
> +		struct cgroup_subsys_state *css;
> +		unsigned int over_weights = 0;
> +		u64 unused_us = 0;
> +
> +		if (!css_tryget_online(node))
> +			goto out_retry;
> +
> +		/*
> +		 * 2nd pass - calculate initial budgets, mark over budget
> +		 * siblings and add up unused budget for the group.
> +		 */
> +		css_for_each_child(css, &drmcs->css) {
> +			struct drm_cgroup_state *sibling = css_to_drmcs(css);
> +
> +			if (!css_tryget_online(css)) {
> +				css_put(node);
> +				goto out_retry;
> +			}
> +
> +			sibling->per_s_budget_us  =
> +				DIV_ROUND_UP_ULL(drmcs->per_s_budget_us *
> +						 sibling->weight,
> +						 drmcs->sum_children_weights);
> +
> +			sibling->over = sibling->active_us >
> +					sibling->per_s_budget_us;
> +			if (sibling->over)
> +				over_weights += sibling->weight;
> +			else
> +				unused_us += sibling->per_s_budget_us -
> +					     sibling->active_us;
> +
> +			css_put(css);
> +		}
> +
> +		/*
> +		 * 3rd pass - spread unused budget according to relative weights
> +		 * of over budget siblings.
> +		 */
> +		css_for_each_child(css, &drmcs->css) {
> +			struct drm_cgroup_state *sibling = css_to_drmcs(css);
> +
> +			if (!css_tryget_online(css)) {
> +				css_put(node);
> +				goto out_retry;
> +			}
> +
> +			if (sibling->over) {
> +				u64 budget_us =
> +					DIV_ROUND_UP_ULL(unused_us *
> +							 sibling->weight,
> +							 over_weights);
> +				sibling->per_s_budget_us += budget_us;
> +				sibling->over = sibling->active_us  >
> +						sibling->per_s_budget_us;
> +			}
> +
> +			css_put(css);
> +		}
> +
> +		css_put(node);
> +	}
> +
> +	/*
> +	 * 4th pass - send out over/under budget notifications.
> +	 */
> +	css_for_each_descendant_post(node, &root->css) {
> +		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
> +
> +		if (!css_tryget_online(node))
> +			goto out_retry;
> +
> +		if (drmcs->over || drmcs->over_budget)
> +			signal_drm_budget(drmcs,
> +					  drmcs->active_us,
> +					  drmcs->per_s_budget_us);
> +		drmcs->over_budget = drmcs->over;
> +
> +		css_put(node);
> +	}

It keeps bothering me that the distribution logic has no memory. Maybe this
is good enough for coarse control with long cycle durations but it likely
will get in trouble if pushed to finer grained control. State keeping
doesn't require a lot of complexity. The only state that needs tracking is
each cgroup's vtime and then the core should be able to tell specific
drivers how much each cgroup is over or under fairly accurately at any given
time.

That said, this isn't a blocker. What's implemented can work well enough
with coarse enough time grain and that might be enough for the time being
and we can get back to it later. I think Michal already mentioned it but it
might be a good idea to track active and inactive cgroups and build the
weight tree with only active ones. There are machines with a lot of mostly
idle cgroups (> tens of thousands) and tree wide scanning even at low
frequency can become a pretty bad bottleneck.

Thanks.

-- 
tejun
