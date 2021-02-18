Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7996131EF1B
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 20:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhBRTAg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 14:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhBRRH2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Feb 2021 12:07:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE49C061786
        for <cgroups@vger.kernel.org>; Thu, 18 Feb 2021 09:06:45 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id w19so2727841qki.13
        for <cgroups@vger.kernel.org>; Thu, 18 Feb 2021 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zVENMey1EdFzZhk4Yon7dEXfrybku0MTAsUKJNMONig=;
        b=Y1SWeFTKNyObDh6T0tVdAgoEZMOAylAVj0RaiIh4kAxsIwLKcsBRG7tkJfxs3cHEKu
         NOWc39l8M1vBqjKsIMnc+AtNj0YWSFBUUDAUFpgpXHuzPzLnk3MRbun/IK0sJH9iZqCi
         RdKo6WX4ySkyoeKwlC94IFZsf1Ggdowq/47IJqc+GCWUnkGbAfJudf0kZ1qCFSoUNHHv
         dY/nu1cl5r8HS/JXRG7goGXAtXL1RrdpPQrPCdy4hfiG1WW/Jl8mkMBXUYgonM//jEni
         tEXmFMLO5cKxRzFHrI9OfkDp/+N6LspjAeUDpjjPIkd3xT5lsvZV4/93GtGUolxXXHfH
         c9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zVENMey1EdFzZhk4Yon7dEXfrybku0MTAsUKJNMONig=;
        b=gnRKMajKkgBa77CyzsdSIoZe509GYRJBLbdtrzfZYdv0MyPcu4bIWiAdCmYvyOCKpF
         Y4+TqPBQW5JgU9hPblxotCDrMti9lxQDU0t3EOeMCLW80kOSLw3ZF85X7z8HXNCo1KEu
         SNYq80dVDhrmSTsFbrgMzguZalLi61LDFwO7WfKSmN9e64iyGgXu4Q01DopHxHyzO33y
         tdeH0n3LTQS3NDLQAeZ6sI97v0o7Pm04lsbVc/54voWyVphIBhcsKdnBaEeM0psdhV1i
         0kOqrxkZ7zxPU+xZwWMM2Foq7lBOctU4Qcc07hMLjOaqI4aPB2472PZQuH4KUrWnOutw
         XM0w==
X-Gm-Message-State: AOAM5330Kz9sQ8bd7QT1SHHGfUZlBfAFDbZtjrxW0CjkQ3BPRyIf/Sel
        u7C247VoJHFPPpmUOSDmzdMQ9A==
X-Google-Smtp-Source: ABdhPJx9iIU6TFeUSb0A5vm+Lg9Nywr+deM4uatCuWy5lkLBvlxLa/67dT0NGQDC3PG+xNOK/X/C/Q==
X-Received: by 2002:ae9:f309:: with SMTP id p9mr5127370qkg.111.1613668004287;
        Thu, 18 Feb 2021 09:06:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b3a9])
        by smtp.gmail.com with ESMTPSA id b9sm890037qkj.90.2021.02.18.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 09:06:43 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:06:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 4/8] cgroup: rstat: support cgroup1
Message-ID: <YC6eojaku6oaOqA2@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-5-hannes@cmpxchg.org>
 <20210217174232.GA19239@blackbody.suse.cz>
 <YC2CKyaeF2bqvpMk@cmpxchg.org>
 <YC6Lh8BRfMA2Ppdk@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YC6Lh8BRfMA2Ppdk@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 18, 2021 at 04:45:11PM +0100, Michal Koutný wrote:
> On Wed, Feb 17, 2021 at 03:52:59PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > In this case, we're talking about a relatively small data structure
> > and the overhead is per mountpoint.
> IIUC, it is per each mountpoint's number of cgroups. But I still accept
> the argument above. Furthermore, this can be changed later.

Oops, you're right of course.

> > The default root group has statically preallocated percpu data before
> > and after this patch. See cgroup.c:
> I stand corrected, the comment is still valid.
> 
> Therefore,
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Thanks for your reviews, Michal!
