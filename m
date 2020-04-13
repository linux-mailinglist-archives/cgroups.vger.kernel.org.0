Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859BA1A6E82
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbgDMVkq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 17:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388138AbgDMVkq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 17:40:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF501C0A3BDC
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 14:40:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d77so10777046wmd.3
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3TzEoMtIfUdNB8j5+48orQwp7L+4a4BtPUMG6Pa9Qs=;
        b=JJPXaMUMVrsrFSqVXlhblXhpVdyvyU1hImwu8WoU8B2TfGosdDZS3BTkSPdwtBM3aW
         YKmrxwFbUw9GDetYjYLgNvG3ssHyU7RxH9cLyKRMfyXowPCRYtusXu/fS3S6XhCizpF2
         Uojh6woCNv7Q/tz6Z0gTY+LbuIAN45HA8KGXBCpJBhAUTr9JdEtY5V0yoO9DpWXkuVt0
         r+E/qJVorbUAwxCz3D9gYe4ZrXP2G72jPanfh6r7R1UsmxWDRL5b065ilJyDREYQj2aG
         u3t+f91ZDlqBbA1t1sd7y5uaOpjCSurFyTCr0NhvXqLd+BFTjyN5fdA/Hza/FDYtnxqB
         rpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3TzEoMtIfUdNB8j5+48orQwp7L+4a4BtPUMG6Pa9Qs=;
        b=gOPKbGmtciG9IAnIyK6odNelpzJvyUxaOXWCr6iRZV6qmR+N9m40XQiNn2OOYpYaap
         teHCDsiz4PVgHko4zOq/7v3+Z+0Op6DCMOYRwzhGNpMwuuxI0u9vc65UvfhaIlufrLCL
         e1cAm6s/AodqwTSMFQIWsHrjFEsBSdxZ4mi0TzZbQmk0z9qTHiuXzBp77/PrxDY4a9RR
         Iol0oC3dJ9TVrYSFh/1AJJfmLiSrWzPD7eMeiaaaCGmDqEvJd10x+Q+Pl7RRuH3WyOIp
         eXCA3YcOC/j4Mw8h/98PJdkUpB8/w7kHzgHb06L5F1dgE0FpJs9KefcZVwPj0Xbp5L+A
         rrdg==
X-Gm-Message-State: AGi0PuZXr0ehzoyOIHJWVzAv9WwNYJb/2Gw1ct4oE5q2ntEIcpgDyrmZ
        ivuWIkJ/yQLbsKbFN5/Dbtuk03V0XrnAInIpHxI=
X-Google-Smtp-Source: APiQypJmnmVsSa7P0w3YlJaIQlNVKj0BXQzYdCbxJ0pspOdO6devQKrfwNYWhioym4arvY5qHfuSaRUNuaj1xhhrKS4=
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr20023708wmf.23.1586814044460;
 Mon, 13 Apr 2020 14:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org> <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org> <CAOWid-dM=38faGOF9=-Pq=sxssaL+gm2umctyGVQWVx2etShyQ@mail.gmail.com>
 <20200413205436.GM60335@mtj.duckdns.org>
In-Reply-To: <20200413205436.GM60335@mtj.duckdns.org>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Mon, 13 Apr 2020 17:40:32 -0400
Message-ID: <CAOWid-fvmxSXtGUtQSZ4Ow1fK+wR8hbnUe5PcsM56EZMOMwb6g@mail.gmail.com>
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

Hi,

On Mon, Apr 13, 2020 at 4:54 PM Tejun Heo <tj@kernel.org> wrote:
>
> Allocations definitely are acceptable and it's not a pre-requisite to have
> work-conserving control first either. Here, given the lack of consensus in
> terms of what even constitute resource units, I don't think it'd be a good
> idea to commit to the proposed interface and believe it'd be beneficial to
> work on interface-wise simpler work conserving controls.
>
...
> I hope the rationales are clear now. What I'm objecting is inclusion of
> premature interface, which is a lot easier and more tempting to do for
> hardware-specific limits and the proposals up until now have been showing
> ample signs of that. I don't think my position has changed much since the
> beginning - do the difficult-to-implement but easy-to-use weights first and
> then you and everyone would have a better idea of what hard-limit or
> allocation interfaces and mechanisms should look like, or even whether they're
> needed.

By lack of consense, do you mean Intel's assertion that a standard is
not a standard until Intel implements it? (That was in the context of
OpenCL language standard with the concept of SubDevice.)  I thought
the discussion so far has established that the concept of a compute
unit, while named differently (AMD's CUs, ARM's SCs, Intel's EUs,
Nvidia's SMs, Qualcomm's SPs), is cross vendor.  While an AMD CU is
not the same as an Intel EU or Nvidia SM, the same can be said for CPU
cores.  If cpuset is acceptable for a diversity of CPU core designs
and arrangements, I don't understand why an interface derived from GPU
SubDevice is considered premature.

If a decade-old language standard is not considered a consenses, can
you elaborate on what might consitute a consenses?

Regards,
Kenny
