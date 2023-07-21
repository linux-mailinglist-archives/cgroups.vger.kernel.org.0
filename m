Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1C75D755
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 00:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGUWTg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGUWTf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 18:19:35 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1E26BF;
        Fri, 21 Jul 2023 15:19:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b9aadde448so1990288a34.0;
        Fri, 21 Jul 2023 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689977974; x=1690582774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsrbrVHFxjwjByjc6/UZrNrL/NPET1Wevp1mB/G/Lmc=;
        b=D6dXczY+0qF8EjPi28ps6MVuYsmGnnl07dBtmDJMYl7vBhxNbiI46WCsnYerS3mdC1
         KJe0HOBXRp4SjPvPuqJThZbDALy0UO3m+BCzAkLWsKYZok+M09tI1Ijg6hiHp0FjDR2g
         Wfe3Md02hxCbKwHsJLZNfRvIrRMW2zZr9NZneiEEC96Gb7gHmArpMdUNDYUP+EfOvpHM
         b7FbtaG8csDOKZ4KQlozssqHNZVcuBMG/+KXvbQME5X35/ARjyJ22OOe/U9bFIwvi1GD
         ttfxFjpx6YWTM60Q/ICBRYeD67D4yI0TYfK7ByJPBQzZ/NAyniSv3hzNsiZk7+SnT9z2
         wiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689977974; x=1690582774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsrbrVHFxjwjByjc6/UZrNrL/NPET1Wevp1mB/G/Lmc=;
        b=UjSr1Tf4wvVo9yAyCM1AKhY5BxF55miBXMiHcQMCJzONZ8i+bKeqaUliovePDzaK65
         Da+5/OFsXSxZjPUfK52Q8SCa1AQevRvF8wx2CsDDWlY2HYctBqBOz7GhYPewSiUogmp5
         gqfos78U7Gs60YO9ifjC679mPukENl9DghUVGD1zclxhIM8eOIzA/gXWac+ca9xy7knE
         DU/Ow8xYcd5XjpznTB2q1Eof2u92Z3DC/Ro8EKwxE+Oz81M+H8KSRbCij/vZEwNoRBRb
         vgRW8kkwkkbNUkl9Kr8720MKRBhEdSkOmmUwztMWSW+uW26sAfWBWobWs7nJK9a/XmLm
         o2/Q==
X-Gm-Message-State: ABy/qLZeqIVFqE2ObpO6BkKlqvpiaBF2IBtvozsMhr9NxjsTRkqjUDhD
        R8FIRtge7W727E+ZzUBSw14=
X-Google-Smtp-Source: APBJJlH2AWrT2kqCjorNC+sDLF7zmPAxqztrnNl7fRba70OrDYiKI8GCFkEYX+RQpDKzKy/qNRlpbA==
X-Received: by 2002:a05:6358:949a:b0:135:73b0:cc6c with SMTP id i26-20020a056358949a00b0013573b0cc6cmr1255798rwb.28.1689977973850;
        Fri, 21 Jul 2023 15:19:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id e23-20020a633717000000b0056368adf5e2sm3582208pga.87.2023.07.21.15.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:19:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 12:19:32 -1000
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
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 15/17] cgroup/drm: Expose GPU utilisation
Message-ID: <ZLsEdJeEAPYWFunT@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-16-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712114605.519432-16-tvrtko.ursulin@linux.intel.com>
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

On Wed, Jul 12, 2023 at 12:46:03PM +0100, Tvrtko Ursulin wrote:
> +  drm.active_us
> +	GPU time used by the group recursively including all child groups.

Maybe instead add drm.stat and have "usage_usec" inside? That'd be more
consistent with cpu side.

Thanks.

-- 
tejun
