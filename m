Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F0A75D750
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGUWSO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 18:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGUWSN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 18:18:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4C62D7C;
        Fri, 21 Jul 2023 15:17:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad8383faso17678695ad.0;
        Fri, 21 Jul 2023 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689977875; x=1690582675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjm6i6VGWK46ksrSf/WO54+zzsF5ULR5YF0/kPA+stI=;
        b=sIusdMkhzyYYzt7HTZ12ouC1zo0sibV8H/PYeYkaLxSBDEhc0NmcBhK/VXQFLOMD8W
         yS7JEFFOviSYIfM0AUhzG9IhwX1q9peWhyLEwZo1fi1Ei5S7h1BqDE1g6Of2+nZ7PTpx
         Q+UOBogLu+QuJl125anoYUSX9LRIuAPBV+8p+ObtmgkGeVXFhpawz5krJvA98tTOB6Ra
         lnn6h/GpqJu3CRz4orpNv/dF77t7/T6j5np29gkpvd7deyLug5Qg9GNsgFdanYl8stF4
         TYc5U1LqMLuLF3QdZikaEvERFBL7v8REuiNxCz5F8AxJJI9Sl1vfdhCDfmupGEmdv0d9
         iQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689977875; x=1690582675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cjm6i6VGWK46ksrSf/WO54+zzsF5ULR5YF0/kPA+stI=;
        b=D1wNs4Y/uPVWUhpC5qT7XcImfXGnQd8SfM8nSSXRzseo+AqL0iFOniHo+TBVhW96mI
         mjCrZddYEUNOhQ86iLdM1TQM2nqufNq/NIiW61b+mA6CRtDuF0QaqrgwzRQCte3J/hww
         2qzqjilBQsXqUgyZzZlnkkI4+dLQnbNAY9c4IfLedNKWdgWtkjqtFvOzfmmP2i/0PL36
         gWtx+0Jv7kR1OMPXmZArT/nN9tFKZ2DXMJaGCr4U8WB6TM7/06NWDpu5AJqSKsJfQsIl
         /yoXRbrk04MQlRI65wGm5YLLe/80BeJbCR3vXHImjQuF4TD/FSwqZ1uLnnkBYaV97xBl
         pOkA==
X-Gm-Message-State: ABy/qLZPvrO5RgpovNXC0roK/tjnfcIqe+2R/jY7ehp9kXhG40JIYFsv
        HVXsirI5w83MtJd44IiZ47s=
X-Google-Smtp-Source: APBJJlFHfb0jG/WWODgMdRojw07Pd0F9ziQEPHIpWaqHWQMOzDHQ9v53Ib02LKyBkAYUj3LalcPxeA==
X-Received: by 2002:a17:903:2304:b0:1bb:4861:d39e with SMTP id d4-20020a170903230400b001bb4861d39emr2970299plh.12.1689977874650;
        Fri, 21 Jul 2023 15:17:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902a5cb00b001b9dab0397bsm2339866plq.29.2023.07.21.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:17:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 12:17:53 -1000
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
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 12/17] cgroup/drm: Introduce weight based drm cgroup
 control
Message-ID: <ZLsEEYDFlJZwrJiV@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-13-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712114605.519432-13-tvrtko.ursulin@linux.intel.com>
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

On Wed, Jul 12, 2023 at 12:46:00PM +0100, Tvrtko Ursulin wrote:
> +DRM scheduling soft limits
> +~~~~~~~~~~~~~~~~~~~~~~~~~~

Please don't say soft limits for this. It means something different for
memcg, so it gets really confusing. Call it "weight based CPU time control"
and maybe call the triggering points as thresholds.

Thanks.

-- 
tejun
