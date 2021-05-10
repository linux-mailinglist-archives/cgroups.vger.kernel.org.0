Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF1B37973E
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhEJSzk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhEJSzj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 May 2021 14:55:39 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E490C061574;
        Mon, 10 May 2021 11:54:34 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u1so8880417qvg.11;
        Mon, 10 May 2021 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhr+PGYEagAJ8E92KKnVFnuFMoTrCUOtPClJNlbWd8c=;
        b=XDAkuaG3qMxQY7dLWJcvjZbjFutrp6S4uxZbqDVUVlsSSlv67pOxqGEMAsZEbwqLpm
         pCRp4m2d8A0+I0Gkk2olVBRLnUZBEc5ttuj8I2oy5s0FzSAP2wVS4GyJwoadxXHVgqqn
         Pgqw1/hbpWDzLZSrL+Hxdj+7XFk1z5MBMATmjmZZ+lDD/kYWKSA7GWeNbQqJrLn4rhgd
         PlkdwnMbSwf4IK3m3EHT7PmAHSlE9iO13AOyBBWG9En1y+48k1Rn91QsOu2Y/wUAdv5A
         +7m3+AVAd4dngN6iUbJCOV5dWMVYZ7gqt96zpShP50K+Rq5F5CaCkrv/58L02mrQ/qwd
         IbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qhr+PGYEagAJ8E92KKnVFnuFMoTrCUOtPClJNlbWd8c=;
        b=UDoA6DmFy6kPsOPmivff1oFAc8GLtiiRDn4ZNC1R5T2WXz9hgWU14FdcJNiaXqFIRe
         30uDQyBGAK+E2QqNvysffcrNTpgYpiRIlnl5pU40BqOSeLSLBuG0m73nRwkf465z+IoI
         Q2e082ArkR36yS4hfVSjyzyLgXh8Oiaz1tnoendSu2ZbSFWdalIj2IIo9wwJChXyuC4G
         bTbdjd+bvnz9uE5ULnQADvQuHGytAt+CF1Y/NQ8V4imri3r6zUhXhb2v1LQheYLgUIAf
         PhEUjXENQlaSByB4LfJC6uU2B+TS4l+mJfA88M6QTvxTERzODFvoNzwrn1Fp50VQMYiB
         6vJQ==
X-Gm-Message-State: AOAM5304GfugstN8t2IN3iY+izf/4rX4c32KirdeP9RrCDGGLHxN23cg
        lk9eqfYkme6EK6I0/TKFk+I=
X-Google-Smtp-Source: ABdhPJw3s2AkqIcMWXHkWTsqrEyOhMr5GtcB1ncNGdBNXL5aYyoVUxITeMVEUvwMToB8FG6z/IN86w==
X-Received: by 2002:ad4:4523:: with SMTP id l3mr13886384qvu.45.1620672873193;
        Mon, 10 May 2021 11:54:33 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id w7sm11934620qtn.91.2021.05.10.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 11:54:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 May 2021 14:54:31 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: inline cgroup_task_freeze()
Message-ID: <YJmBZ3IVCiAK7WF+@slm.duckdns.org>
References: <20210510184556.946798-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510184556.946798-1-guro@fb.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 10, 2021 at 11:45:56AM -0700, Roman Gushchin wrote:
> After the introduction of the cgroup.kill there is only one call site
> of cgroup_task_freeze() left: cgroup_exit(). cgroup_task_freeze() is
> currently taking rcu_read_lock() to read task's cgroup flags, but
> because it's always called with css_set_lock locked, the rcu protection
> is excessive.
> 
> Simplify the code by inlining cgroup_task_freeze().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Applied to cgroup/for-5.14.

Thanks.

-- 
tejun
