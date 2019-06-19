Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474CA4C3F1
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2019 01:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSXEn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jun 2019 19:04:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42201 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfFSXEl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jun 2019 19:04:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id s5so307860ywd.9
        for <cgroups@vger.kernel.org>; Wed, 19 Jun 2019 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbzMOyrZckNlP/Lcg+Lm/vM3zrC2t8DPpb83xlh9FiI=;
        b=t5CyOJNfaac+Q7sPzpACyPTDx6EHsMBAXAnNFHc1O5tDZWecDaCzf1vYTuyz7Zjf/e
         67AVLo3wFwFhYh4mwpzgD+9UNuTSphgseGd0AVOtn7iOtYOElLcQ3s+WX4gwDSQUJSAG
         kHzUBPWbM3Dmo4KyNNeKLuRTTau5zxBm1pYUE8IUgg96i3/B0ojjp1aZCvK8b5YvIrRq
         3y/D3kCzgimUMVAjolJtiirGA8S5lSRCCmJdB1ggTynoPqquMl1gDOrFf2Hao69SK3nD
         qqRIODa4r7NbdVpNTrP+mSFxZxA2I3Lap/PkRe7pPMQAA9C50Yxp8L3JthprklpEeTg/
         Qmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbzMOyrZckNlP/Lcg+Lm/vM3zrC2t8DPpb83xlh9FiI=;
        b=rNuNnShwRVqIan5jRuH4MTSZMQHwSsyKPPo8vRRUvavoXHNHdbg0Ot4mbqAlSHeRqa
         81fluVyrOcIBM30pYFcL3prmbN6UvLbOrNXSgJRMMTo2+CHlWMyK1VP4fed9FTNHu6kw
         dCVQFPhluhydNSJa9jaDryKkRgiGAY1yHKwSKrn8Iw3g6dY+O8pyG75mb/p9okmWd6eA
         OHjcFummjGZ1+Y9iuR+DHZ1Nv5UJtcbUs1m+wBUPxDJ0Rhpe6kHw+K9wBRjd6xrP7J73
         HJCgnXMUv4vE2ZCQqkhV/sMkwglmW1/xtCZG8TfNS/KQh7EOg06JT+oUWHmj5Eamy0s5
         Drfg==
X-Gm-Message-State: APjAAAWwRsNiDUBUU5nFtFc9neemRPgRB7ni8zkS8nuWxioCFP7XdUP3
        RlSM8SqozLb6f7+bNFtEuDeNIshrbt6pNDLjyUdlng==
X-Google-Smtp-Source: APXvYqwwLc9GbuN1yski600QDsOdlXMt97I/+eg7SO2Z7GQo/t8DI3dWtHIREvPeuOmKIK1eoWONOQDWPdZIfMaHZBs=
X-Received: by 2002:a81:a55:: with SMTP id 82mr37722007ywk.205.1560985479831;
 Wed, 19 Jun 2019 16:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <e5cfe17c-a59f-b1d1-19ce-590245106068@intel.com>
In-Reply-To: <e5cfe17c-a59f-b1d1-19ce-590245106068@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 19 Jun 2019 16:04:28 -0700
Message-ID: <CALvZod6Bfbi57mRmbYetO+R=gB07kkewo=F9sTyMdWpDXGgwDg@mail.gmail.com>
Subject: Re: memcg/kmem panics
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 19, 2019 at 3:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> I have a bit of a grievance to file.  :)
>
> I'm seeing "Cannot create slab..." panic()s coming from
> kmem_cache_open() when trying to create memory cgroups on a Fedora
> system running 5.2-rc's.  The panic()s happen when failing to create
> memcg-specific slabs because the memcg code passes through the
> root_cache->flags, which can include SLAB_PANIC.
>
> I haven't tracked down the root cause yet, or where this behavior
> started.  But, the end-user experience is that systemd tries to create a
> cgroup and ends up with a kernel panic.  That's rather sad, especially
> for the poor sod that's trying to debug it.
>
> Should memcg_create_kmem_cache() be, perhaps filtering out SLAB_PANIC
> from root_cache->flags, for instance?  That might make the system a bit
> less likely to turn into a doorstop if and when something goes mildly
> wrong.  I've hacked out the panic()s and the system actually seems to
> boot OK.

You must be using CONFIG_SLUB and I see that in kmem_cache_open() in
SLUB doing a SLAB_PANIC check. I think we should remove that
altogether from SLUB as SLAB does not do this and failure in memcg
kmem cache creation can and should be handled gracefully. I can send a
patch to remove that check.

Shakeel
