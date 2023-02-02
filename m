Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64D86887E8
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBBUAT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 15:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBBUAR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 15:00:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02BD75190;
        Thu,  2 Feb 2023 12:00:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l4-20020a17090a850400b0023013402671so6669491pjn.5;
        Thu, 02 Feb 2023 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTEXTLdEtQvrB7aVFpBYAbH4Vf/ihPabgDflRw+s72o=;
        b=CuJhJ9UTVuPY/jraolwLg+hw6h/pKxRy1SLRd/hEO8GnE3cDoiPidADrjRGw4Tat7E
         jsPj+B5/JWPEzkR1ov2cP4QLjkGjelgudaCyhdc4WTw+8Tb5Oonu+M6rmd85VoAp+09n
         p29yqXXOCqF9Y85uU7Om7KJ2ttMYgVWNGXZB9YxNzDvxDzbpksNHc1G+p86CxKdlN0Ty
         +rwXXExzAQPU5AL4D29Etk7FWGP466Or/Daf4dCE9QSEqudpR8qq8SpggqjYy48/R5Nd
         XYVHbi+FsHBVz+Wv+DIRXgY0DRGWK3xQsCPpOzfidwB7nrd2hKVFHAH562MKRavuNJmY
         xtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTEXTLdEtQvrB7aVFpBYAbH4Vf/ihPabgDflRw+s72o=;
        b=vtd4FKduuXJGgzVL1qvaa0spsjrfNLAc4k4gHSW6qy0v/sEL6ZdhfriGCUDj3xOqDn
         hPN1nwtQlq2pR/IGXMPnSD1/1koWMvtHCOrdnuB8hFwJMlrlZ9r+6t8+rp1uC5jeXDBl
         0YIyL3PsCUFZ7fA3XfsYEAaU9Flho4jsSKB1TtfbNWBW7ZZNgDj8kzXoyKak0J8kYgGw
         vUVgMTsgX4938hCyFW2fraSx6Evsd5yMfHLBLXebBmf8VzwlsSeSrumTKBtr2c/OZNIu
         kgQ0e3oUDhO41BT45j7D/kPUUuQ8j+xkCLK3jtUkX6INJvWlPs6nOCZwyFsWbggnGWQc
         +83g==
X-Gm-Message-State: AO0yUKVxZV5IHCvHh5RWcBom9QW+Qa5/dVAkWKbOld9PTdmsF7jY321G
        tXf7ouxaWITGpoED3yHHSiY=
X-Google-Smtp-Source: AK7set8Q9bsQxt4cyQu1ye65OLJScIues9R6Sdz55WQAGcTEZjBv9qXC8qRJpwpjQ6p92muQd2Vhww==
X-Received: by 2002:a17:903:1111:b0:196:6ec4:52db with SMTP id n17-20020a170903111100b001966ec452dbmr8506618plh.51.1675368016015;
        Thu, 02 Feb 2023 12:00:16 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001933b4b1a49sm53850plj.183.2023.02.02.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:00:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 10:00:14 -1000
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
Message-ID: <Y9wWTspETnYYodDc@slm.duckdns.org>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
 <Y9R2N8sl+7f8Zacv@slm.duckdns.org>
 <27b7882e-1201-b173-6f56-9ececb5780e8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b7882e-1201-b173-6f56-9ececb5780e8@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Feb 02, 2023 at 02:26:06PM +0000, Tvrtko Ursulin wrote:
> When you say active/inactive - to what you are referring in the cgroup
> world? Offline/online? For those my understanding was offline was a
> temporary state while css is getting destroyed.

Oh, it's just based on activity. So, for example, iocost puts a cgroup on
its active list which is canned periodically when an IO is issued from an
inactive cgroup. If an active cgroup doesn't have any activity between two
scans, it becomes inactive and dropped from the list. drm can prolly use the
same approach?

> Also, I am really postponing implementing those changes until I hear at
> least something from the DRM community.

Yeah, that sounds like a good idea.

Thanks.

-- 
tejun
