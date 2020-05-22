Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D044B1DECC4
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2020 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEVQG3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 May 2020 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbgEVQG3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 May 2020 12:06:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D230FC061A0E
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 09:06:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h4so9111501wmb.4
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtbmX0dyqTdFrd4tlTLyqr9RkMznchbfW/cN9uktbsE=;
        b=ah7RmwWxN9q7dxKf+gAuYNWjx6K6QPOaXvntt2YUcRn9h4NJFUGvkk1Ac/sTaqPucC
         brS1J2kyueAkaOOEsl7Jt5j1lSuy9e7MxolKLydJzGOCfm7pV2Itel7DowMiX6eBqwaW
         P6lIrkxT5Q6m19lxPitR+Wqn0NwtVXgOXDtfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtbmX0dyqTdFrd4tlTLyqr9RkMznchbfW/cN9uktbsE=;
        b=CtUbNewtLE0wLdd+b4JUJ7Os1caMd1wXXr2yIS44RGBm6zQx1Vl9YvWTqW5kmx0g9W
         3LivNb5wktSwF1zEjuIyeGgCHABdpd7+pzGT+oUvbxs7MqEcTdmG+tsgiz5ERk0p6Zfu
         ZO2nCYwPrZO7Zq7u110pSNGymDFglZagUJ+FBYYbz6MfqNd9W1Vz4d8VCM63W8zw1GtN
         lhvH9eZyIieh+O/NIp7WH1F2pcm52ybZdwacavBXTiB1BLWOZVlL3P6rRvPGUFeSSzOw
         0yxQEGswwssWp46sA+u0QzmxFoaHU3i3tOPulMnKoqF1WAXYlKaTAiTwWwJ8+LcojuSG
         hY+A==
X-Gm-Message-State: AOAM531VY0POBTlkZbs+6wU0cuocGQYcllEu7Sba5MUdCVdtpZt/vQKN
        chdeOGo+3NCwE4v4j7AnOOyQug==
X-Google-Smtp-Source: ABdhPJygEawD/lJudaTltpgXyXjT5L0fi1Rd5uEVjbbJe1bbL0UYGwlL+SuYBnoIwxkETsDzoBuWtg==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr14490673wma.170.1590163587553;
        Fri, 22 May 2020 09:06:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id n9sm9514256wrv.43.2020.05.22.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:06:26 -0700 (PDT)
Date:   Fri, 22 May 2020 17:06:26 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
Message-ID: <20200522160626.GB1112005@chrisdown.name>
References: <20200505084127.12923-1-laoar.shao@gmail.com>
 <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
 <CALOAHbBTt1pMo0kwheWqPfU7RTXcDHWJ-x8=5mpw327uiy2qzA@mail.gmail.com>
 <CA+G9fYtmpjunUetTmf2yquB1rwZA+nnWOiueWbAMx483c0wUvQ@mail.gmail.com>
 <CALOAHbCdXrU1AeLd4pWubutuG6HP4xKvxRkXeOv=sd_MMW58rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbCdXrU1AeLd4pWubutuG6HP4xKvxRkXeOv=sd_MMW58rg@mail.gmail.com>
User-Agent: Mutt/1.14.1 (2020-05-03)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yafang Shao writes:
>I will do it.
>If no one has objection to my proposal, I will send it tomorrow.

If the fixup patch works, just send that. Otherwise, sure.
