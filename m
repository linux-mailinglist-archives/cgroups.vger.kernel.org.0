Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB236DCA6
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhD1QFT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbhD1QFR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Apr 2021 12:05:17 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB20C061573
        for <cgroups@vger.kernel.org>; Wed, 28 Apr 2021 09:04:31 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v20so9180041qkv.5
        for <cgroups@vger.kernel.org>; Wed, 28 Apr 2021 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9HgqzHqJPJLGc6VWM3q5vYoH4SbYPkaPRyIzhlX9Bos=;
        b=Bht3BSV6WGP5XFX0RRKMCTKA/B8W9utzqx+JvWKtKweNfmYxP9lLsJTExmM+rLe+Yk
         bWElCmDPEv4UYdxf4dkn/cUUnQ3lMpDFXP1hisUfEk6H7+b8FCANGwD4WXdxFz04bAhy
         RCT2ibFZwBQT4h42o43U8lplF6THU3M11Hh2eK4HknO7MVZNyCrxOxlDTKV/HMcipXSu
         xy/JROxrhxrPqjz/RL5CdZGPvD7hSWv8JnZr7YTUlAoRes6REUry3V8V5t4TKOmXnMZX
         xnvfSJBr6WN6WJo8dDvxTeP5LmzsUnSVOduK9FxAcU22LReNmnWVRVrmjM4hR24SLJD0
         yMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9HgqzHqJPJLGc6VWM3q5vYoH4SbYPkaPRyIzhlX9Bos=;
        b=jT5bYkfVtcIaGlmSor7SsLDIcVPK2pu1gZvpPk+bF1AmVz/9FQBuX4ZbX8hKBkvS5M
         mPXhXzKoq1VziMyGxZxVaO0boZ2JErqKQ2Qx4liKlmDgkSsMkYAwlFV5yIDEtLSWoiE2
         7kJybmMZedFES3YoEF+ZD2IbSKj01Pq+Qqvg501KH30ToLmddUcS28vynP8+YPk6XoLH
         SF69usGLynVVT8pr19spk8qoeTJUkgywfYXD11/rSZlePkk8hmq4v0u+gG8R+Yc2/+2G
         QMSYI7oACTRMGzWYKPRkO3DKpW8msHUKC0/vVmqLobCU+967vzQKB02Qq5/J7EqLMAeg
         yZDA==
X-Gm-Message-State: AOAM530lzTJsOSlc5PtKtkFlbijXfdJ2t6+RsnVN16H85IZfTMjdXuUt
        hB04Yxh9THjiUt6iO+kt+D8=
X-Google-Smtp-Source: ABdhPJxL1Z4pJKu7UmxzP9lolD/R/uy477KCAQIiJWc1IiIEbIOIkzzZvCa9cCagbMVZvvRFRtO+qQ==
X-Received: by 2002:a37:a78d:: with SMTP id q135mr29037730qke.210.1619625870601;
        Wed, 28 Apr 2021 09:04:30 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id p186sm95099qka.66.2021.04.28.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:04:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 28 Apr 2021 12:04:28 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YImHjGGuIt0ebL0G@slm.duckdns.org>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIcOZEbvky7hGbR1@blackbook>
 <20210427093606.kygcgb74otakofes@wittgenstein>
 <YIgfrP5J3aXHfM1i@slm.duckdns.org>
 <20210428143746.p6tjwv6ywgpixnjy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428143746.p6tjwv6ywgpixnjy@wittgenstein>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Apr 28, 2021 at 04:37:46PM +0200, Christian Brauner wrote:
> > I'd align it with cgroup.procs. Killing is a process-level operation (unlike
> > arbitrary signal delivery which I think is another reason to confine this to
> > killing) and threaded cgroups should be invisible to process-level
> > operations.
> 
> Ok, so we make write to cgroup.kill in threaded cgroups EOPNOTSUPP which
> is equivalent what a read on cgroup.procs would yield.

Sounds good to me.

> Tejun, Roman, Michal, I've been thinking a bit about the escaping
> children during fork() when killing a cgroup and I would like to propose
> we simply take the write-side of threadgroup_rwsem during cgroup.kill.
> 
> This would give us robust protection against escaping children during
> fork() since fork()ing takes the read-side already in cgroup_can_fork().
> And cgroup.kill should be sufficiently rare that this isn't an
> additional burden.
> 
> Other ways seems more fragile where the child can potentially escape
> being killed. The most obvious case is when CLONE_INTO_CGROUP is not
> used. If a cgroup.kill is initiated after cgroup_can_fork() and after
> the parent's fatal_signal_pending() check we will wait for the parent to
> release the siglock in cgroup_kill(). Once it does we deliver the fatal
> signal to the parent. But if we haven't passed cgroup_post_fork() fast
> enough the child can be placed into that cgroup right after the kill.
> That's not super bad per se since the child isn't technically visible in
> the target cgroup anyway but it feels a bit cleaner if it would die
> right away. We could minimize the window by raising a flag say CGRP_KILL
> say:

So, yeah, I wouldn't worry about the case where migration is competing
against killing. The order of operations simply isn't defined and any
outcome is fine. As for the specific synchronization method to use, my gut
feeling is whatever which aligns better with the freezer implementation but
I don't have strong feelings otherwise. Roman, what do you think?

Thanks.

-- 
tejun
