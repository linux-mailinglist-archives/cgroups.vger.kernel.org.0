Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7CB634948
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiKVV30 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 16:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiKVV3Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 16:29:25 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CD322529;
        Tue, 22 Nov 2022 13:29:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k7so14877286pll.6;
        Tue, 22 Nov 2022 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYbx+av6DBnORVcQ2ULxfCSTDy21R06QMcTObHYEV34=;
        b=YGgKFSzVDtg4WqE7blC+H6hUzPYoBzvcBGqcO8VWfLHbMTqWNn4bE7btkALc2ygD5T
         D2Xj8asn40IU8QFMvKIiMRt9BNe+DUkTI09kpbDa7g6S4DYFTI1rHz51KuXDTKNuj/Sh
         Njuax5n6GHUJW8GAskJ2gtcmll/eWEZMsPzskTGXNZq1xDdhzPToaaPHs1DMAxoR4CXC
         g4T4/4TWRfjOCE9jGNmZHF8RmxInIK24wUW/svb5XVdP3I4wtMt1v020nT6Bdw3YBKkC
         HS1n2b8c0YyB6P4nGoAjBTrENJqPW49nR/dgfsFdWHaBGUsSvvgdvsl3W2dE202ZTirX
         l7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYbx+av6DBnORVcQ2ULxfCSTDy21R06QMcTObHYEV34=;
        b=Z4qVrnG+f8eVTaMAD6HKNcG2lG/JqKDgsknZGsDf5iEOPG8WjcW5lZ5+qQlNqq2W4q
         HIF1vFvjdmCwzy+En5TV7ywd5pKQVr9yLDx6e9gMHT2nshQgPIo/UrPaoo1HIXnZO2nI
         5wX3fcZ1euBcvj72g+aoL2AGo8UL1l+XkF4jXjHPKmivI+fIR/BFlq7n7G6ATUXOkaka
         SZ+ppCEL2uau4Q4nkmkII+JSEEJ6mAeFgRuD8A6bSIatgwQHe8vOJZ0Q5u/+SG7Q1iu6
         EDgasuDmXdd3fQRWgEtIuHbjxFKSiffJMuSv7tBR+DbSKSlwOdJh9inJAIE8F2tup0ar
         dp+A==
X-Gm-Message-State: ANoB5pnv3f4K6FFt/Su6w1gueIlgrR4RciXU1KeFujBheSGtZvqzWqyD
        HnitSks1RqjXHZUmhiLNRS0=
X-Google-Smtp-Source: AA0mqf5KzdFRzATj/MphE9mRIT5fns0fCeoG8/eWEzDJc/WpbIxhsTPN2fpHhxYabp11HdHmpTseJw==
X-Received: by 2002:a17:903:2407:b0:17f:3da:f19d with SMTP id e7-20020a170903240700b0017f03daf19dmr8588893plo.147.1669152562517;
        Tue, 22 Nov 2022 13:29:22 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78ec8000000b005627ddbc7a4sm11086709pfr.191.2022.11.22.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:29:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 11:29:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC 11/13] cgroup/drm: Introduce weight based drm cgroup control
Message-ID: <Y30/MIsLmVAZ7pQi@slm.duckdns.org>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
 <20221109161141.2987173-12-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109161141.2987173-12-tvrtko.ursulin@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 09, 2022 at 04:11:39PM +0000, Tvrtko Ursulin wrote:
> +DRM scheduling soft limits
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Because of the heterogenous hardware and driver DRM capabilities, soft limits
> +are implemented as a loose co-operative (bi-directional) interface between the
> +controller and DRM core.
> +
> +The controller configures the GPU time allowed per group and periodically scans
> +the belonging tasks to detect the over budget condition, at which point it
> +invokes a callback notifying the DRM core of the condition.
> +
> +DRM core provides an API to query per process GPU utilization and 2nd API to
> +receive notification from the cgroup controller when the group enters or exits
> +the over budget condition.
> +
> +Individual DRM drivers which implement the interface are expected to act on this
> +in the best-effort manner only. There are no guarantees that the soft limits
> +will be respected.

Soft limits is a bit of misnomer and can be confused with best-effort limits
such as memory.high. Prolly best to not use the term.

> +static bool
> +__start_scanning(struct drm_cgroup_state *root, unsigned int period_us)
> +{
> +	struct cgroup_subsys_state *node;
> +	bool ok = false;
> +
> +	rcu_read_lock();
> +
> +	css_for_each_descendant_post(node, &root->css) {
> +		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
> +
> +		if (!css_tryget_online(node))
> +			goto out;
> +
> +		drmcs->active_us = 0;
> +		drmcs->sum_children_weights = 0;
> +
> +		if (node == &root->css)
> +			drmcs->per_s_budget_ns =
> +				DIV_ROUND_UP_ULL(NSEC_PER_SEC * period_us,
> +						 USEC_PER_SEC);
> +		else
> +			drmcs->per_s_budget_ns = 0;
> +
> +		css_put(node);
> +	}
> +
> +	css_for_each_descendant_post(node, &root->css) {
> +		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
> +		struct drm_cgroup_state *parent;
> +		u64 active;
> +
> +		if (!css_tryget_online(node))
> +			goto out;
> +		if (!node->parent) {
> +			css_put(node);
> +			continue;
> +		}
> +		if (!css_tryget_online(node->parent)) {
> +			css_put(node);
> +			goto out;
> +		}
> +		parent = css_to_drmcs(node->parent);
> +
> +		active = drmcs_get_active_time_us(drmcs);
> +		if (active > drmcs->prev_active_us)
> +			drmcs->active_us += active - drmcs->prev_active_us;
> +		drmcs->prev_active_us = active;
> +
> +		parent->active_us += drmcs->active_us;
> +		parent->sum_children_weights += drmcs->weight;
> +
> +		css_put(node);
> +		css_put(&parent->css);
> +	}
> +
> +	ok = true;
> +
> +out:
> +	rcu_read_unlock();
> +
> +	return ok;
> +}

A more conventional and scalable way to go about this would be using an
rbtree keyed by virtual time. Both CFS and blk-iocost are examples of this,
but I think for drm, it can be a lot simpler.

Thanks.

-- 
tejun
