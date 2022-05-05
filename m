Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD151CD09
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 01:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387010AbiEFAAj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387011AbiEFAAi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 20:00:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D660DA1
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 16:56:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kq17so11552767ejb.4
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VvFMpzRd3f5HOLZivGIaiJD1ZP3hh+AxpWSTf89n1T0=;
        b=LHAmBR4rXfqs1vhxinJbl8NDwSEWy62HrFVgBmifLXL/yTuw5QPat09BJ4dMwG/1nA
         l5RVXL4eVFyjMEF5Iv1k8eKRoV5VclTCvRe84/b6anAg4r02lTrN5bdFEEhobKNRLth3
         nz986sSoAVJa+QzvEDKqNgydg6qsTqkENspWffK/bIqW5Xs3J8XozPTDh1CcKbhWKwRg
         LWcH9kSyH1gvn2q3yDFesk164XBtY3K+GNoi6iGClpA7ct3dDnH0L57fHaIdNulErE2j
         TVN1C+LkyHh48XJp1C/q7YVoZJkeAVXvVCU6D4W4x7GoBZxqB55ZcGff8i7OHIyMaqzU
         65fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VvFMpzRd3f5HOLZivGIaiJD1ZP3hh+AxpWSTf89n1T0=;
        b=6nQfuVKjXk9m3FLV6Sb5fqkMEhAeExaCHiXF0i3ezeohsYIH0jJPCjBak3CSyHxrrA
         yfvZr5cFZ1GYV24SxLoF/+8f/UzncxIoHOsSmu2FatVhuDZpq3HCMkPNPRgCJOaHcxm3
         A0fBcVOXvZ15IdcimQu0UgodjtA1LjUnX1f/J+b4BSHEMLXAgUs9qPmbNhX/3EFMe2RG
         xopRXjg95uQFLeoTtIP28Nu/jCIRwSFqk82VFYwrWGZt+hQES179fW3dZnNAXF0azvWw
         t1+OORjCTrKLcuVIzHC0YlAq8muY3ZmbInQVGFSAl9XIoTX57KJlctXaB3E8yviRF4k4
         2fgA==
X-Gm-Message-State: AOAM532ha1UYNsRUnE1GV1h/8LT4KTwuLJ3jnRtbQ0/i8cpfB5Utyp7W
        shELtKiP7/wcior/BNa33dUDI9ZNIJ/CFw7yG++66Q==
X-Google-Smtp-Source: ABdhPJw2x82fC2kWVYLDqjdzrSO+4kUjJWyKyLNfDkPRL2J42FmpMBGOtu9De+v1HCvfUYPgeLlWmn8nojS0FJjy2nI=
X-Received: by 2002:a17:907:16a2:b0:6f4:eeb1:f7de with SMTP id
 hc34-20020a17090716a200b006f4eeb1f7demr611227ejc.446.1651795016098; Thu, 05
 May 2022 16:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220502231944.3891435-1-tjmercier@google.com>
 <20220502231944.3891435-3-tjmercier@google.com> <20220504122558.GB24172@blackbody.suse.cz>
 <CABdmKX2DJy0i3XAP7xTduZ8KFVKtgto24w714YJNUb_=pfYiKw@mail.gmail.com> <20220505115015.GD10890@blackbody.suse.cz>
In-Reply-To: <20220505115015.GD10890@blackbody.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 5 May 2022 16:56:45 -0700
Message-ID: <CABdmKX2gaWn9X9V3sr9Oyqs3WRsCFr_GTx2A1ifS-cJxGg9RCQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        John Stultz <jstultz@google.com>,
        Todd Kjos <tkjos@android.com>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 5, 2022 at 4:50 AM 'Michal Koutn=C3=BD' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed, May 04, 2022 at 10:19:20AM -0700, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > Should I export these now for this series?
>
> Hehe, _I_ don't know.
> Depends on the likelihood this lands in and is built upon.
>
Ok, I'll leave these unexported for now unless I hear otherwise.

> > No, except maybe the gpucg_bucket name which I can add an accessor
> > function for. Won't this mean depending on LTO for potential inlining
> > of the functions currently implemented in the header?
>
> Yes.  Also depends how much inlining here would be performance relevant.
> I suggested this with an OS vendor hat on, i.e. the less such ABI, the
> simpler.
>
> > I'm happy to make this change, but I wonder why some parts of the
> > kernel take this approach and others do not.
>
> I think there is no convention (see also
> Documentation/process/stable-api-nonsense.rst ;-)).
>
Alright I'll queue this change up for the next rev.

> Regards,
> Michal

Thanks again!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
