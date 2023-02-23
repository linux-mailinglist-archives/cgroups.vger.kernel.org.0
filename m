Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9B6A0EBB
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBWRbD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 12:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBWRbC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 12:31:02 -0500
X-Greylist: delayed 149559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 09:31:00 PST
Received: from out-35.mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E4A567B7
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 09:31:00 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:30:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677173458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1WZIJ8pUmzgqf8s+eBJbOZDw0S7cY6i0ZgBo0K3FG/Q=;
        b=pioTvFJu7T1+T4/dTxeZZqfGM2/TWjnxl4BbSskW/8iJMEnf3xGmnYpO2bJERJoSDtrpit
        0eku3xR9czaZIWNvA8YRjTXPDh9dCUtqB9XDSEDs0pibvBl25q+K8xrv85ULglmXpU5SYL
        spx63rP8+9iIRtqUhMP6lWjWqydHSU0=
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
Message-ID: <Y/eizTVo8LM70flh@P9FQF9L96D.corp.robot.car>
References: <AM5PR0202MB25167BFBBE892630A2EE3B7DE1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0202MB25167BFBBE892630A2EE3B7DE1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 04:22:33PM +0000, Matthew Chae wrote:
> Hi Michal,
> 
> First off, thank you for sharing your opinion.
> I'd like to monitor the peak memory usage recorded of overall system or at least cgroup accounted memory through memory.peak.
> But it looks like this is not relevant to what I wanted.
> It might be good to have some proper way for checking the system's peak memory usage recorded.

I guess you might want to do the opposite: instead of tracking the peak usage,
you can record the bottom of available free memory.

Thanks!
