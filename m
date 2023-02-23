Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD96A127A
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 23:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBWWAQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 17:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBWWAP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 17:00:15 -0500
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [IPv6:2001:41d0:203:375::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D40452DD2
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 14:00:13 -0800 (PST)
Date:   Thu, 23 Feb 2023 14:00:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677189611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d26wBxNftgvIEigvlBues+H50f7ZSE9Q9ePe8CXNvAs=;
        b=hy1GOCctAm2u9Q/WJ7L7i8MHDrWDIM/OZ/LaaCUIlYO4NsaGcXONCLopBdR4rwr7VnKtOG
        kEU4fg/XS5dDhRvUcB3YGSEgEtiJmdnDYBkH7Kt/hwVXa+rSdfjo4GDKrlOZWuLKOz6aw2
        R1thl8eJaTOT74Ik2v5yhyn4k7IbbkY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Matthew Chae <Matthew.Chae@axis.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel <kernel@axis.com>,
        Christopher Wong <Christopher.Wong@axis.com>,
        Muchun Song <muchun.song@linux.dev>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcontrol: add memory.peak in cgroup root
Message-ID: <Y/fh5sQEcM9hPt4Z@P9FQF9L96D.corp.robot.car>
References: <AM5PR0202MB25167BFBBE892630A2EE3B7DE1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
 <Y/eizTVo8LM70flh@P9FQF9L96D.corp.robot.car>
 <AM5PR0202MB2516BD45CFBC033F9EA3B0A4E1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0202MB2516BD45CFBC033F9EA3B0A4E1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 07:00:57PM +0000, Matthew Chae wrote:
> Hi Roman,
> 
> I'd like to get the peak memory usage recorded overall time, rather than at a certain time.
> Plus, I expect that the systematical way might have better performance compared to userspace sampling.

I'm not necessarily saying to do this in userspace, you can try add a new system-wide counter
(new /proc/vmstat entry). Obviously, it might be easier to do this in userspace.
My point is to do it on system level rather than cgroup level and record a bottom of free
memory rather than the peak of used memory.

> If I understand correctly, recording the bottom of available free memory might not be helpful for this.
> Am I missing something?

Why?
