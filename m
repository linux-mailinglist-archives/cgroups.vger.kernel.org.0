Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8D3B8A74
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhF3Wdm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 18:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhF3Wdm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 18:33:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA9C0617AD
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 15:31:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so5493474wms.5
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GMyVPuFMxYNbLMHQBfZilBl/NBmnN5vmlOEDJDVgikA=;
        b=H6lxDxqfFalvZBt10BgprhpbLvdq+DLerLRsXowgxYS2LE3FLuoCBt5dBBadg0Xghf
         KNDj9akhByJUB+imIU+sZmgZhWGTlhLfIXeCi6ADK574Zg1+4THNfr254tFvYlWUE2m7
         g3kxUdJVWLcLarbekZcB5Ay6FOh7hXYRuMJZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GMyVPuFMxYNbLMHQBfZilBl/NBmnN5vmlOEDJDVgikA=;
        b=iIWnjq8hrHaNZ5+6GCGSj+QgC9GNlXlsAa+3A7xb5eWg+Zug9982+6fNZfRt7fyf5H
         LVYUmZ6iH1X4Np5Bm/atxZunNBIQM2jnfRv2GM723PoNOoe6ThLStz55JmhKIJ5htWP7
         99rS1aBociCJZKXp0y7SoLqKFNkDT8BWZBYu67lRS/HsWTCkvGBboVyNv+MLfm9BbM/H
         bXwfeRTxF5NrVaOn0PXDW2YTeL+dpv30wYLC/8JqC6ONJgeJPWrMmHXunBys9Wqq/Trx
         CxME7vqgbd8Pbigxsr2ioQD6NQNl5lVM77zuSO7hoRWC2JSX4AxBG54bS4vzPHk0hx+S
         eJjw==
X-Gm-Message-State: AOAM533DIB3soSdUgU/zMNZkNdrgdhtNw9oxw/BY3dEpb4Nfnpm5rSQR
        0tCWH86AV7UdhS8Gqm1DcAOBsg==
X-Google-Smtp-Source: ABdhPJy+CBMlPBMOCn9DqrFiuK/2gDYg8Q4k6hyOxw0ZdBbgaxtH1RipwSDFUB/kwHiOL8sYZTnBPw==
X-Received: by 2002:a7b:ce82:: with SMTP id q2mr6904410wmj.60.1625092269984;
        Wed, 30 Jun 2021 15:31:09 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a683:959f:4ccb:54d6? ([2001:8b0:aba:5f3c:a683:959f:4ccb:54d6])
        by smtp.gmail.com with ESMTPSA id t11sm23408362wrz.7.2021.06.30.15.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 15:31:09 -0700 (PDT)
Message-ID: <696dc58209707ce364616430673998d0124a9a31.camel@linuxfoundation.org>
Subject: Re: [PATCH] cgroup1: fix leaked context root causing sporadic NULL
 deref in LTP
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, stable@vger.kernel.org
Date:   Wed, 30 Jun 2021 23:31:06 +0100
In-Reply-To: <20210630161036.GA43693@sirena.org.uk>
References: <20210616125157.438837-1-paul.gortmaker@windriver.com>
         <YMoXdljfOFjoVO93@slm.duckdns.org> <20210630161036.GA43693@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 2021-06-30 at 17:10 +0100, Mark Brown wrote:
> On Wed, Jun 16, 2021 at 11:23:34AM -0400, Tejun Heo wrote:
> > On Wed, Jun 16, 2021 at 08:51:57AM -0400, Paul Gortmaker wrote:
> 
> > > A fix would be to not leave the stale reference in fc->root as follows:
> 
> > >    --------------
> > >                   dput(fc->root);
> > >   +               fc->root = NULL;
> > >                   deactivate_locked_super(sb);
> > >    --------------
> 
> > > ...but then we are just open-coding a duplicate of fc_drop_locked() so we
> > > simply use that instead.
> 
> > As this is unlikely to be a real-world problem both in probability and
> > circumstances, I'm applying this to cgroup/for-5.14 instead of
> > cgroup/for-5.13-fixes.
> 
> FWIW at Arm we've started seeing what appears to be this issue blow up
> very frequently in some of our internal LTP CI runs against -next, seems
> to be mostly on lower end platforms.  We seem to have started finding it
> at roughly the same time that the Yocto people did, I guess some other
> change made it more likely to trigger.  Not exactly real world usage
> obviously but it's creating quite a bit of noise in testing which is
> disruptive so it'd be good to get it into -next as a fix.

It is a horrible bug to debug as you end up with "random" failures on the 
systems which are hard to pin down. Along with the RCU stall hangs it
was all a bit of a nightmare.

Out of interest are you also seeing the proc01 test hang on a non-blocking
read of /proc/kmsg periodically?

https://bugzilla.yoctoproject.org/show_bug.cgi?id=14460

I've not figured out a way to reproduce it at will yet and it seems strace
was enough to unblock it. It seems arm specific.

Cheers,

Richard



