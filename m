Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B600EEF1BA
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfKEAPI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 19:15:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42370 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfKEAPI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 19:15:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id t20so11158138qtn.9
        for <cgroups@vger.kernel.org>; Mon, 04 Nov 2019 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhaR1pzpDhD8Oj3r3+6NDw11m3VI6XnZi9HpX8QpwHA=;
        b=LXCqzYpjO+5foQaI1XMgpMH6xWSPtZXtDolI8drNQXSmzupY2nc7zpsFcu8eon4tPe
         ok5vdlJd0lhZsBx+sG/iEuHWS1e98sf1Sk2SW2Fxu62UULw5yguNpAovUqYDLxQUvoZo
         Ik2HQk2BIFR7JlDnJcQjV5ZvnRo30KN7Bpn2yENPHfMbX32DtoyixXL5BSuCWLUyHFpd
         DcWjEF77eeZp6urqdvt3aDTl1XUa6Zc64ve/56/8mWkAfxSP3e28hsV9LWATFSVTVoZV
         WR9vQgG8Fq2fLhRCx5IqbWoIgmcMd8LImFD1IdooKcHvYCGihLssYULD9hkns+RWy1hY
         uIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhaR1pzpDhD8Oj3r3+6NDw11m3VI6XnZi9HpX8QpwHA=;
        b=IenvLZ/fTHv1ws2EjV/TEGldVMyFUlTHrNw5rXa/jDnqZuzKMsxvOiB911housB0ZP
         BJ9lBg8Qoptt+CFDvbPdEbGzAlib8BOJISk5babRDLE9VvTkutmFpaNdLpM4YqND25ye
         N6OtowSVqV/Ycv1Bt9IF9gbfAqMQupbtoqTDv/7u1bWtM79c2tcfI565dCeaBHYa3NGh
         tiqBa4GnaFX72+XV5MbOeepxLA4xEWM7cL7pgpGpr0RmVwpfZRhGB2mLQgtefQfbICS3
         4ah4Oz9qTIi0EMKPNi9O4vxXsVavTjvSZg5BELBgq9ozFfDHnEFZ3HYIi2c2ARDV73Yx
         RLHQ==
X-Gm-Message-State: APjAAAWd2X6FZ7q8wL/ZqEnXB3OYaH7xm5v+C54q0myuMiKf9VW4eODL
        7Fi+HilcP1EehpngXUmyZWU=
X-Google-Smtp-Source: APXvYqwH7VS2MjwpNjwcYETIPSxzZVeB9EKxaiZzQwpcyEfRW3GbbAvWA8ohLUEp0gqrzep911LCjQ==
X-Received: by 2002:ac8:5350:: with SMTP id d16mr15380877qto.319.1572912907385;
        Mon, 04 Nov 2019 16:15:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id q17sm14324139qtq.58.2019.11.04.16.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:15:06 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:15:05 -0800
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
Message-ID: <20191105001505.GR3622521@devbig004.ftw2.facebook.com>
References: <20191104220847.23283-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104220847.23283-1-brian.welty@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 04, 2019 at 05:08:47PM -0500, Brian Welty wrote:
> +  gpuset.units
> +  gpuset.units.effective
> +  gpuset.units.partition
> +
> +  gpuset.mems
> +  gpuset.mems.effective
> +  gpuset.mems.partition
> +
> +  sched.max
> +  sched.stats
> +  sched.weight
> +  sched.weight.nice
> +
> +  memory.current
> +  memory.events
> +  memory.high
> +  memory.low
> +  memory.max
> +  memory.min
> +  memory.stat
> +  memory.swap.current
> +  memory.swap.max

I don't understand why it needs to replicate essentially *all* the
interfaces that system resources are implementing from the get-go.
Some of the above have intersecting functionalities and exist more for
historical reasons and I fail to see how distinctions like min vs. low
and high vs. max would make sense for gpus.  Also, why would it have a
separate swap limit of its own?

Please start with something small and intuitive.  I'm gonna nack
anything which sprawls out like this.  Most likely, there's still a
ton you guys need to work through to reach the resource model which is
actually useful and trying to define a comprehensive interface upfront
like this is gonna look really silly and will become an ugly drag by
the time the problem space is actually understood.

It doesn't seem like this is coming through but can you please start
with a simple weight knob?

Thanks.

-- 
tejun
