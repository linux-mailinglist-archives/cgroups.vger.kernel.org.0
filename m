Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C3F330A
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 16:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfKGP3T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 10:29:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32870 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388539AbfKGP3S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 10:29:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id y39so2839085qty.0
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2019 07:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kj+RMnwa9bAM6y6Y3sVjyaJSaw0mEdf8JHAxyNOdU+I=;
        b=U090f3nYuGHfqONSML4lw2ShHwu1EhvZQFByH/J0b/yoysoNRMzQ/7710BtLuraRo6
         z39Z9ZyUrWnIP79yLiCn+kPEyKD0a+ZPpVbwDtHM/4VJcvgkG2pQswD5oTx7GwKvh/hE
         BZEpuBQBJB3UurrSHyU1/Rk6FCcFeLFn+TSD7uaKwrETX9IfH+vW+IQwpfnqWnEYLsmm
         HRu0PB3Adlm6JnThxhWpLqeSUzZ4X9JV++c4ZOL1lY1oAhgv7s53zhvKQly0HaoXYMzl
         4NRiPNrbjdzzMnNvnxAtMXe4xpk/8EZR2g9MWdewoQYDgXrAuc8DLOQ4iiF3mDxhikg7
         T/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kj+RMnwa9bAM6y6Y3sVjyaJSaw0mEdf8JHAxyNOdU+I=;
        b=ELGJXmamcUvZL8Qt0RmBCKi/ACQfumimyTob0/Z72dbz1qylGwlFDtUgeUTadUedfz
         A2KjYWDavi4EKo11/xnqNYa/i4ch7dt17jJeXJRdf+8f9c0H0wq7dJUaO7DT48NKeSRi
         lQ6DdA4m09Fcw8vZnUqrT0mHO/S6CqaF8TJp6LKfiZIt7FxdieBC4YfafCVUUhzkQmLk
         2zMHhf9X1Ocj20aNB+D4Su+rgJ0E+627UqIcDy5OBMagZ3Dt9J8XC395te4TRA5X/g11
         KDNUZ90TnojP51UwagmVvxQ/D9WvzT6WhCHvWmyjlzVBn6vOC6uSUehArlHFBuOyCK9X
         e5CQ==
X-Gm-Message-State: APjAAAU4NaVglVYAWaLeTc70ShoTVciCV2jBK0mo2tQT6ocQjfvrbKXY
        7hhq/hLIVcsSXyiHVmAzKBE=
X-Google-Smtp-Source: APXvYqz/xJmeYKPcsq77wNyL9N551x2ABFW1E4nOUvPNyDlyubWRQS0kwJ1fbQsbiDRp97AFQ+Zohw==
X-Received: by 2002:aed:3b6c:: with SMTP id q41mr4358043qte.11.1573140557672;
        Thu, 07 Nov 2019 07:29:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id b13sm1095706qtj.64.2019.11.07.07.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 07:29:16 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:29:14 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Brian Welty <brian.welty@intel.com>
Cc:     cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH] cgroup: Document interface files and rationale for
 DRM controller
Message-ID: <20191107152914.GU3622521@devbig004.ftw2.facebook.com>
References: <20191104220847.23283-1-brian.welty@intel.com>
 <20191105001505.GR3622521@devbig004.ftw2.facebook.com>
 <d565fc2c-0bd0-a85a-c7ce-12ee5393154d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d565fc2c-0bd0-a85a-c7ce-12ee5393154d@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Nov 05, 2019 at 04:08:22PM -0800, Brian Welty wrote:
> I was more interested in hearing your thoughts on whether you like
> the approach to have a set of controls that are consistent with 
> some subset of the existing CPU/MEM ones.  Any feedback on this?
> Didn't really mean to suggest that all of these would be included
> from the start.

I don't see why they should be synchronized.  If it ends up being
about the same anyway, there's no reason to not sync them but that
doesn't seem very likely to me and trying to sync sounds like adding
an unnecessary constraint.  One side of the ballot is possibly missing
on aesthetics a bit while the other side is constraining interface
design even before understanding the design space, so...

> Would you agree that this reduced set is a reasonable starting point?
> +  sched.weight
> +  memory.current
> +  memory.max
> 
> Thoughts on whether this should be very GPU-specific cgroups controller
> or should be more forward thinking to be useful for other 'accelerator'
> type devices as well?

My preference is starting small and focused.  GPU by itself is already
a big enough problem and the progress upto this point evidently
indicates even that alone is poorly mapped out.  Please start with the
smallest and most common (tied to usage, not hardware) interface
that's viable.

Thanks.

-- 
tejun
