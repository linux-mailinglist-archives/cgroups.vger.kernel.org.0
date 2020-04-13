Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4B1A6D1A
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgDMUR1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388265AbgDMUR1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 16:17:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087EC0A3BDC
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 13:17:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a81so11337367wmf.5
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD5YUEDwlW8icDI+F/y9bZzsHxv/M2KUcD6dDQ+9NEo=;
        b=aNP6WsOcy9oz2oIOPIazkJvo8godHmXtmr1TwE8JPmYx+cwAVWXPfV6tSX5Lgfey/B
         3dXc7YsM8r6adTCmRF/bA55Ip/VGpC/QouxCgsQDUpe81/U9Fg7B4wijrK6SEei3kqkC
         ckFdpb5ffuQhmtYRxoPwQSvKez4TVEY/lFeJKCGRQKZmdMr2cji+OnaFGXEd0FDSvNJn
         ah9styOQohwsf/lT2taKcFugIxEvavHdQFOqN5eEXFGvhCRerpBZtJMXtQ8WAqk+o+8W
         kfwKC0+fOvq4LnzI7HYDNDHI9Ae9Lj/D123X3Ussr43iDtHsF6WcqZhku2VK0AvP2KfL
         8raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD5YUEDwlW8icDI+F/y9bZzsHxv/M2KUcD6dDQ+9NEo=;
        b=hjExfEiJGMks5ODvVektgVzo5Cg89sXk0VxLLjM0yrPYZg68PamuCgVZoaOiQYPpj+
         y8w6f9xgf+GKokpqcktWp1dh7QwIsUi4y4Vj6olGMBftkrzJbxNK8dKlTOlffjy8Tzs/
         B/t6Qt9yfJampPw41KZ0fHBDWdG4syHlxEsJYI/X5TUfF/o+giOH8VW9SfRPKeHG7TZY
         trVaPehXh61wziG51fvGmXio9eFXdthS0dJKK95KHhalxzxAjagu9qfBlbiQ+J3IUs//
         a8kx/JE6EeEKSg55hWE0YSmUyxjHUOv174BcGsZGHTFkeoTx8+has6dj1PGEjAbsdUWj
         viXw==
X-Gm-Message-State: AGi0PuZ34fvsStixfd1XDAG9fpQ7Txh5lZtbEJ5hRwcrmCaAB1uEAIZe
        v6Uduaos5qv8h3u6++qrfW/rpmzGFZFabZl1t2I=
X-Google-Smtp-Source: APiQypKh7TZRCn8Mhrn8z14C0rhM0q0qetKx76lJiDA3Dok2HjocICF1CUGJ/iiEyAWJJZ3sG3pmNUO8e2TieXeSgbU=
X-Received: by 2002:a1c:a4c2:: with SMTP id n185mr21099181wme.104.1586809045201;
 Mon, 13 Apr 2020 13:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org> <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org>
In-Reply-To: <20200413191136.GI60335@mtj.duckdns.org>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Mon, 13 Apr 2020 16:17:14 -0400
Message-ID: <CAOWid-dM=38faGOF9=-Pq=sxssaL+gm2umctyGVQWVx2etShyQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To:     Tejun Heo <tj@kernel.org>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(replying again in plain-text)

Hi Tejun,

Thanks for taking the time to reply.

Perhaps we can even narrow things down to just
gpu.weight/gpu.compute.weight as a start?  In this aspect, is the key
objection to the current implementation of gpu.compute.weight the
work-conserving bit?  This work-conserving requirement is probably
what I have missed for the last two years (and hence going in circle.)

If this is the case, can you clarify/confirm the followings?

1) Is resource scheduling goal of cgroup purely for the purpose of
throughput?  (at the expense of other scheduling goals such as
latency.)
2) If 1) is true, under what circumstances will the "Allocations"
resource distribution model (as defined in the cgroup-v2) be
acceptable?
3) If 1) is true, are things like cpuset from cgroup v1 no longer
acceptable going forward?

To be clear, while some have framed this (time sharing vs spatial
sharing) as a partisan issue, it is in fact a technical one.  I have
implemented the gpu cgroup support this way because we have a class of
users that value low latency/low jitter/predictability/synchronicity.
For example, they would like 4 tasks to share a GPU and they would
like the tasks to start and finish at the same time.

What is the rationale behind picking the Weight model over Allocations
as the first acceptable implementation?  Can't we have both
work-conserving and non-work-conserving ways of distributing GPU
resources?  If we can, why not allow non-work-conserving
implementation first, especially when we have users asking for such
functionality?

Regards,
Kenny

On Mon, Apr 13, 2020 at 3:11 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Kenny.
>
> On Tue, Mar 24, 2020 at 02:49:27PM -0400, Kenny Ho wrote:
> > Can you elaborate more on what are the missing pieces?
>
> Sorry about the long delay, but I think we've been going in circles for quite
> a while now. Let's try to make it really simple as the first step. How about
> something like the following?
>
> * gpu.weight (should it be gpu.compute.weight? idk) - A single number
>   per-device weight similar to io.weight, which distributes computation
>   resources in work-conserving way.
>
> * gpu.memory.high - A single number per-device on-device memory limit.
>
> The above two, if works well, should already be plenty useful. And my guess is
> that getting the above working well will be plenty challenging already even
> though it's already excluding work-conserving memory distribution. So, let's
> please do that as the first step and see what more would be needed from there.
>
> Thanks.
>
> --
> tejun
