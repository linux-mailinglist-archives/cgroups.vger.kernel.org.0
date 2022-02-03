Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00E44A82F0
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 12:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbiBCLJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 06:09:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52446 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiBCLJU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 06:09:20 -0500
Date:   Thu, 3 Feb 2022 12:09:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643886559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9dLipNCWTDLjIRcvw1w4KRMkmUCKyaDC+LsdcGILXU=;
        b=QDRNCbwJulSq9t5Xh04HOv8ePTtDVfMuQTt034qeBLsgpE80y7cSOplg5bJpS4uJZGhtw+
        wc6UOjq9UPSmDE+YXuNGXbMmKbJTJIZ9XjsxFEwJm+6NqD5o0M+efshiP1Ly/7Um07CnOP
        15pzvzuzjhWRNVTdsHEzGEMQfBpENqgwsGzg+mdCV1jF0C8x4l+qUyYITGj82dfL7uoEGW
        xfZ9x5TOmiH/abavhKVmtWfn4+B7Uc9qnvFSrDhNeWKzHBYG2/KPfTL7u1V2qrj0egy8M/
        ZAINbkF5Iyf55flNQmaaGlemu8KmMQR92BnxP6cqvFuGHFeRmQ3Jzfdp95Ew7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643886559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9dLipNCWTDLjIRcvw1w4KRMkmUCKyaDC+LsdcGILXU=;
        b=lwUjPEVsfXIfH935kV3JAUFh5s5hYmrfTNIqfAtlPw/iNkPURp5YZyrDHhydvyywD+rzqM
        kvt2dX0TvgEVtmCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <Yfu33qrQTLTn5X/G@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <YfFmxH1IXeegNOa9@dhcp22.suse.cz>
 <YfKHxKda7bGJmrLJ@linutronix.de>
 <YfkhsiWHzsyQSBfl@dhcp22.suse.cz>
 <Yfkjjamj09lZn4sA@linutronix.de>
 <YflR3/RuGjYuQZPH@dhcp22.suse.cz>
 <YfumP3u1VCjKHE3b@linutronix.de>
 <Yfup9THPcSIPDSoH@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yfup9THPcSIPDSoH@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-03 11:09:57 [+0100], Michal Hocko wrote:
> Thanks for this test. I do assume that both have been run inside a
> non-root memcg.

I did run after a regular login on a Debian unstable installation. I did
confirm via trace_printk() that get_obj_stock() was invoked from process
and interrupt context and the caller was cc1 and so on.

> Weiman, what was the original motivation for 559271146efc0? Because as
> this RT patch shows it makes future changes much more complex and I
> would prefer a simpler and easier to maintain code than some micro
> optimizations that do not have any visible effect on real workloads.

Sebastian
