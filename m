Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810053B91BB
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhGAMpz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhGAMpz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 08:45:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8148C0617A8
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 05:43:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r9-20020a7bc0890000b02901f347b31d55so3902283wmh.2
        for <cgroups@vger.kernel.org>; Thu, 01 Jul 2021 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mo6oA/XnbDUGfk8NTnLtsX2Oxt2DjcL5ZEyjcIbXJxE=;
        b=ZoT209PloXnbOEhL1QU7auZZ8wiKaoDhkCY5o/ymMMMc54wtJgZRSBBst/6uWhboWC
         HJUkHBzw6bANDxSgtGj3yL1oQE4Q6Lxw9ITAw68rg6FgsGIcy5ANlDp5PbqojKIES3/e
         ZlmYBBAluT51L1CqtjRWPvBnwPN/vR35iWVlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mo6oA/XnbDUGfk8NTnLtsX2Oxt2DjcL5ZEyjcIbXJxE=;
        b=EDdh3eKFs/EHlJZX0APCNCr6UlllLH8sHfnevKR0U6tsksI3CZQnm6XMJ77qRIM79U
         ShgbQza9ActLD1JBczfebj04osqK2AY4BUVsOAAezFwgHNOZhIVVFcsTsaIfIR5DAzCb
         4SgAbh3ebWzAj226Aho2Aznl0ACB9jKUE3TbtdIJmyv76lv8oERGYYjIBMOpJt+VLuCK
         uARnqUrcWHLUDfvKR+6BzUs+ggt8MGerkuA7iecg4NBlWOfX1Pi8t53mgkOJKLSR3MLP
         CY8eU+9GerhpUmvLcIJXAfsNNv7x8pD7i7F+QgDye4fBF8pqVicSW9kDO6E7KPLqXWMi
         LjkQ==
X-Gm-Message-State: AOAM531g4R9Ty1o4d6D/8ZTxtam1r6m88/GYgaN5xtWvUa0HF5jVNUqz
        x437sC+FMC1VWh5jzqQ1ms6lFg==
X-Google-Smtp-Source: ABdhPJzTAwPPPR6L6P6uS3+LRZi3ZK1wPBHWPVvFvkqIsj03BGz5+yt7Zwi0kIGdB+vlNRETEs5OjQ==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr42940651wmb.167.1625143402298;
        Thu, 01 Jul 2021 05:43:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a683:959f:4ccb:54d6? ([2001:8b0:aba:5f3c:a683:959f:4ccb:54d6])
        by smtp.gmail.com with ESMTPSA id f6sm8278917wrs.13.2021.07.01.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:43:21 -0700 (PDT)
Message-ID: <8f20f2edd60fbff426b086599ae943ff09195b9c.camel@linuxfoundation.org>
Subject: Re: [PATCH] cgroup1: fix leaked context root causing sporadic NULL
 deref in LTP
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, stable@vger.kernel.org
Date:   Thu, 01 Jul 2021 13:43:19 +0100
In-Reply-To: <20210701121133.GA4641@sirena.org.uk>
References: <20210616125157.438837-1-paul.gortmaker@windriver.com>
         <YMoXdljfOFjoVO93@slm.duckdns.org> <20210630161036.GA43693@sirena.org.uk>
         <696dc58209707ce364616430673998d0124a9a31.camel@linuxfoundation.org>
         <20210701121133.GA4641@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2021-07-01 at 13:11 +0100, Mark Brown wrote:
> On Wed, Jun 30, 2021 at 11:31:06PM +0100, Richard Purdie wrote:
> 
> > Out of interest are you also seeing the proc01 test hang on a non-blocking
> > read of /proc/kmsg periodically?
> 
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=14460
> 
> > I've not figured out a way to reproduce it at will yet and it seems strace
> 
> I've been talking to Ross, he mentioned it but no, rings no bells.
> 
> > was enough to unblock it. It seems arm specific.
> 
> If it's 32 bit I'm not really doing anything that looks at it.

Its aarch64 in qemu running on aarch64 hardware with KVM.

If you do happen to see anything let us know!

Cheers,

Richard


