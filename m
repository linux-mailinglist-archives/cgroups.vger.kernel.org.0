Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB94768C8DB
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 22:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBFVmR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 16:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjBFVmQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 16:42:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8626CD6
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 13:42:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bx22so10044832pjb.3
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 13:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RM0dHQibFaaOeas3cj3XA1NvkGxIpzMBa9fsiolqgCo=;
        b=RvOFv3Z31Yj5mmSTDwcykYqpK+nXUuKDHwTIRjp7IlTJ49/4jCZPgRtgPHfcF5QfcI
         rxlVQ8AP6+WBj28k4Mv1D4kChHfjw+mulKOnfkWe0+iCfeb/Pkv7m8/XJxV1VKT6yj6b
         ebi3BnWJhBWgQNCmRmJgpYKlaDFQqVo6KLyp0FVnBO9utT1McPcXlu5LI0mK5ca9zYQN
         xuxvMVycIxexW3iDVbESeTs4nQKBV+vyZGCJAdDPnJJs+owngKh3K+WL7coj3sWZ+UTN
         ngLxlh2RIgPVxtj05gKjqH6JU5hmhJV3Li1Djo/eL8ygqZUWOffb17T9TfYl1BHBWhlo
         e/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RM0dHQibFaaOeas3cj3XA1NvkGxIpzMBa9fsiolqgCo=;
        b=0/67I7/w+BtJQzoRwokMwk+9RQu10o0bi7zYew7tRkEwE9mjiJKGBaOqBfsx3j1Bg9
         Rb50OMpslgHA7Vnm6vNxNRdU9TIMhjO0OgOaCgGugjaJDcvkWkGFj2E9dQRWYGlcJ4YG
         6uXtbZZUGFfL+dL/oMCUHCYDdNtZ8gGKVoT1XfHDYjVArluB8/D05YfVC94CutS4aEj/
         TdQfzVjGFM+WlR6igo+Xd1dIkLafDUfsq624i008HQSdsNA5jmltK68zO5AEHNBSBsrq
         V1rlKGNBO4aWhZbV3zvAbfDORFU6weizkq6JPIyJCdQ62iJNO2q7UNZmHB+/lI5w1mya
         wy+w==
X-Gm-Message-State: AO0yUKV6t8mVKYYQ8egz0JwkRcceRcJ3rxXEPAvHpcb7FRMFzyJPmQUa
        owtezlAdSSm5FhIekcCz++g=
X-Google-Smtp-Source: AK7set8Tr4CgHVK86qLV6YZy8KqYloc6RDa1SQPDfWIfe4TQzXo0LIIGjIGOQbjFt9T9R6tXOQ63+A==
X-Received: by 2002:a17:902:dac8:b0:198:f1d0:f9f2 with SMTP id q8-20020a170902dac800b00198f1d0f9f2mr409303plx.61.1675719734191;
        Mon, 06 Feb 2023 13:42:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b00188c9c11559sm7032014plr.1.2023.02.06.13.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:42:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 11:42:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: Using cgroup membership for resource access control?
Message-ID: <Y+F0NA9iI0zlONz7@slm.duckdns.org>
References: <Y+FvQbfTdcTe9GVu@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+FvQbfTdcTe9GVu@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Feb 06, 2023 at 01:21:05PM -0800, Tony Luck wrote:
...
> I'm thinking along these lines:
> 
> 1) Sysadmin creates a cgroup for a "job". Initializes the limits on
> how many of these virtual windows can be used (h/w has a fixed number).
> Assigns tasks in the job to this cgroup.
> 
> 2) Tasks in the job that want to offer virtual windows call into the
> driver to allocate and partially set up windows tagged with "available
> to any other process in my cgroup".
> 
> 3) Other tasks in the group ask the driver to complete the h/w
> initialization by adding them (their PASID) to the access list
> for each window.
> 
> My questions:
> 
> 1) Is this horrible - have I misunderstood cgroups?
> 	1a) If this is horrible, can it be rescued?

I'm not sure whether I fully understand what the virtual windows are but
assuming that it's a hardware resource that's limited in number and if
you're okay with tying it to cgroup hierarchy, I think it can just be one of
the resources that are managed by the misc controller.

The tying access domain to the cgroup part is likely the challenging part.
cgroup hierarchy is primarily composed according to the innate usage
hierarchy of the system and this might not match what you need. I can't
tell.

> 2) Will it work - is "membership in a cgroup" a valid security mechanism?

Again, I can't tell without knowing about the specifics but it gets used
that way in some cases - e.g. devcg in cgroup1 or the BPF counterpart in
ecgroup2 are used to enforce raw device access restrictions based on cgroup
membership.

> 3) Has someone done something similar before (so I can learn from their code)?

For limiting the number available to a part of a system, the misc controller
- kernel/cgroup/misc.c.

> 4) Is there an existing exported API to help. I see task_cgroup_path()
> which looks generally helpful (though I'd prefer a task_cgroup() that
> just takes a task and gives me the cgroup to which it belongs.)

task_dfl_cgroup(). However, please note that everything in cgroup is
supposed to be hierarchical, so that's something to keep on mind when
defining an external security mechanism based on cgroup membership.

The flip side is that on vast majority of configurations, cgroup hierarchy
more or less coincides with process tree which has the benefit of being
available regardless of cgroups, so in a lot of cases, it can be better to
just go the traditional way and tie these things to the process tree.

Thanks.

-- 
tejun
