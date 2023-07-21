Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065B775D738
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 00:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGUWO7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 18:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUWO7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 18:14:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4452733;
        Fri, 21 Jul 2023 15:14:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66869feb7d1so1551393b3a.3;
        Fri, 21 Jul 2023 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689977692; x=1690582492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXrwI0f7BDKHLGwATVJjnhmJ48tgd3+2nr9dmXSF18o=;
        b=r3cG7lOFcoYQwf+fNGpD139Z1Covyp+2lo5zJD5XnTAf8/K2pT9/dUBD2deat8FKKY
         npfSKBeTWt4RQmlwADclDm3Xd4QSNgj7U/QuvE7Vkq1WJcsnq0VH2IZGR/0WuWD7+4su
         kiKtRxjosdCNcaRgSFvEgYafPhLPyLWkrbkuBDotW3bpA9q1EiSVmA2iZ4tTSqwy+x1V
         KiHpqELnKXUa/gYZKJKU3S/5o+DJixx9URsj4dgQ1EG8f6aW6uYrKfS/sYl7EHM94Nbo
         9uTZv8JxLxGV3Og6f1YzX10gR7qDoVLgNvBQMuU3LzHEcL3qr43+/kFZWh+cmYCbyOpe
         7O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689977692; x=1690582492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXrwI0f7BDKHLGwATVJjnhmJ48tgd3+2nr9dmXSF18o=;
        b=D/7tth+tmsD5JN1pZIcTyelmW+o+8VgwQkPGFa0paVZyiwyQHuE2kXPNzQhOmuHdGc
         KlwBq/w9OQfKdNmSLC7neaCcdWEl5wMVAcW6lmDzma5oKH5/yNvtqZiD2r8yXRqfglMW
         dSfp9x/c/xzOPOU4WCpXa7UTMTYx5ynioUlQi6HAYKGzh6f8r6Otz1hLUmrh8haaaRru
         oblvqijWF6HGXWKgTQIRWu3Tj8WmAintCWkEJ7nyTGY9OS1TAoiRAEToNHsSfUF4JyvD
         /Bzhar88YA3Mzs6cVb9RA3kdSZwv0FRmeteHVtdcupbXQt9TGmzh1teeYdUFq8IVY3LF
         mQFQ==
X-Gm-Message-State: ABy/qLZYrXHCxR4LuR4n0RbYyDunaWMto7QZ3MAm58YWR1HqB5cSD3d3
        negMAdVgHmqY+A8Qqm8qD7w=
X-Google-Smtp-Source: APBJJlHoNi2MjEt7qTibhO+ffZRb9Yn/LK9ofBG7ZxnPqOG9HkkZfu+1e7w3xEKaYag4IjlOOLyZaw==
X-Received: by 2002:a05:6a00:80e:b0:67a:31b7:456c with SMTP id m14-20020a056a00080e00b0067a31b7456cmr1390223pfk.9.1689977691056;
        Fri, 21 Jul 2023 15:14:51 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id d134-20020a63368c000000b0055be951145csm3613018pga.36.2023.07.21.15.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:14:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 12:14:49 -1000
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
Subject: Re: [PATCH 08/17] drm/cgroup: Track DRM clients per cgroup
Message-ID: <ZLsDWcwTL9aE0-5h@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-9-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712114605.519432-9-tvrtko.ursulin@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jul 12, 2023 at 12:45:56PM +0100, Tvrtko Ursulin wrote:
> +void drmcgroup_client_migrate(struct drm_file *file_priv)
> +{
> +	struct drm_cgroup_state *src, *dst;
> +	struct cgroup_subsys_state *old;
> +
> +	mutex_lock(&drmcg_mutex);
> +
> +	old = file_priv->__css;
> +	src = css_to_drmcs(old);
> +	dst = css_to_drmcs(task_get_css(current, drm_cgrp_id));
> +
> +	if (src != dst) {
> +		file_priv->__css = &dst->css; /* Keeps the reference. */
> +		list_move_tail(&file_priv->clink, &dst->clients);
> +	}
> +
> +	mutex_unlock(&drmcg_mutex);
> +
> +	css_put(old);
> +}
> +EXPORT_SYMBOL_GPL(drmcgroup_client_migrate);

So, you're implicitly migrating the fd to the latest ioctl user on the first
access. While this may work for state-less control like usage time. This
likely will cause problem if you later want to add stateful control for
memory consumption. e.g. What happens if the new destination doesn't have
enough budget to accommodate the fd's usage? Let's say we allow over-commit
with follow-up reclaim or oom kill actions, if so, can we guarantee that all
memory ownership for can always be updated? If not, what happens after
failure?

If DRM needs to transfer fd ownership with resources attached to it, it
likely would be a good idea to make that an explicit operation so that the
attempt can be verified and failed if necessary.

Thanks.

-- 
tejun
