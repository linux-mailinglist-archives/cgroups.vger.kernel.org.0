Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387C51A7B1F
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 14:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502173AbgDNMr3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729462AbgDNMrP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 08:47:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F665C061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 05:47:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d77so12822269wmd.3
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRyhuD/q/qOwlm0kCGXzYUfBwRXX/YNDPiZm8kxyWfw=;
        b=eZ75jlgV8S/ZzIaX7d0n1GVxx+e+nNLM0JeqIjKIZL5R2fXELL1gLdVc1A3L+2/Ymk
         WhbIpajbhckGLvguf9NIaCUzUBncvsNIXltfNiXd3Ef92Bq+2BvGDzIw4apEYExuCyvr
         tuPpAk1sZehGNF9Au+LL0+d3FJHVDBAKvMcXizZnjJRTCKpxbByjs2PFw48Mwvf9RfE+
         dN4m865SUI20bTA/onU+ZeDVQjWvQ/d7AX9ZQbukAkSuKxVdf3+CNP61K82+/vm/zMM8
         5BQzHCVquADazudWyZozQ5Hg8yTweCsWYsmgLtrL4umj5RV73+3ND4P6uTEYnAHLu8ON
         jdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRyhuD/q/qOwlm0kCGXzYUfBwRXX/YNDPiZm8kxyWfw=;
        b=nU8UremFS8QVIW0ikrGS8NFTeuYcggytiikPUjesVvPDi3Fi29mS7OkP9shZCWbBGs
         79B4fUwipdklBgZHQINnfzD52Wh45DYDdboUzKJ1YgV5Z5e0RQWqvEZFQWTTqXCxeQZf
         USwOUpY7iayXrrPVjnXCsfA+0btvCxdGXk017fJx/Cza1LxvQVPSbPIJ/kQN/dPBBWzL
         jmNvjpwaQZNlLCkd/Q0t/ctbE6z59pGw4W4REoML3v5fcl6gk7q7k+tqL/GHxHBeaUap
         bqfsg9eLNp2Xa85pz+XQpzaX+jA7PMo86/NC5gjwUjGypJSj60ulEOTCfrBesJ1DXxJX
         88eA==
X-Gm-Message-State: AGi0PuZ6kszHVlDYfKqqji97pPhAscQ5+OnwLYKi2oD4YpWar0EWHSSq
        4DY+L13+9ddMwvRreqEsMlwraTSCkeT9AQSz1FTiA+8khhFUfew6
X-Google-Smtp-Source: APiQypLuNpCYZZTsMPtx87wYh1wg4P8bZcbB42r/ns9R/dVzYhHCFhPBA8qsVSDfNoiLwGFYJ61nieSa+Sgja1Sn1Y0=
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr23047307wmf.23.1586868432709;
 Tue, 14 Apr 2020 05:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org> <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org> <20200414122015.GR3456981@phenom.ffwll.local>
In-Reply-To: <20200414122015.GR3456981@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 14 Apr 2020 08:47:01 -0400
Message-ID: <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Tejun Heo <tj@kernel.org>, Kenny Ho <Kenny.Ho@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, jsparks@cray.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Daniel,

On Tue, Apr 14, 2020 at 8:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> My understanding from talking with a few other folks is that
> the cpumask-style CU-weight thing is not something any other gpu can
> reasonably support (and we have about 6+ of those in-tree)

How does Intel plan to support the SubDevice API as described in your
own spec here:
https://spec.oneapi.com/versions/0.7/oneL0/core/INTRO.html#subdevice-support

Regards,
Kenny
