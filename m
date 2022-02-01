Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322914A5BF3
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 13:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiBAMMB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 07:12:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38772 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbiBAMMA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 07:12:00 -0500
Date:   Tue, 1 Feb 2022 13:11:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643717518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoYCT5Ajw3bvng7Y4v2BWHQ3eOLblDeukkE/DZmvkTc=;
        b=ULdyc7e2K4mDRfFRC/wPnIuJWqhuADYbGF82VNM4OASlv5mQp9QltsJfg6H7UVgXz6gMlw
        OK3g28o76gTy6Qe4bFW9dGRm7o9M//x6Gh/tsJbg6xbc5dfJ8aPmYGUKAH59p40tBdiWSG
        tXA6+J9jdWVkP6l1s9PZiPmvdPBZw2/d4+zRsxg7UpnUSNJQSCCv5Sx3yJrlcfY7dVIpXx
        yR1FNennWfC+woRakMP2pGOYhvxGHcwNar3PBMNAfE+ZlMNBN9WeoRtbO7zRedjyUzkZDs
        Nth/nyGEwJ7iOAteCtO2L40vxcHrvU2tZ1qgyV0GkmLaQ35bu1GoWo1MVZ876w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643717518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoYCT5Ajw3bvng7Y4v2BWHQ3eOLblDeukkE/DZmvkTc=;
        b=lkslniCrb4ene2lnwMn/UypCh2//CunFtxqS6YCOcN8cOXDluoDaUYgpxmTsU5WTjgwj3L
        YIU5GTSHFG6HU0Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <Yfkjjamj09lZn4sA@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <YfFmxH1IXeegNOa9@dhcp22.suse.cz>
 <YfKHxKda7bGJmrLJ@linutronix.de>
 <YfkhsiWHzsyQSBfl@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfkhsiWHzsyQSBfl@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-01 13:04:02 [+0100], Michal Hocko wrote:
> 
> Thanks! This gives us some picture from the microbenchmark POV. I was
> more interested in some real life representative benchmarks. In other
> words does the optimization from Weiman make any visible difference for
> any real life workload?

my understanding is that this was micro-benchmark driven.

> Sorry, I know that this all is not really related to your work but if
> the original optimization is solely based on artificial benchmarks then
> I would rather drop it and also make your RT patchset easier.

Do you have any real-world benchmark in mind? Like something that is
already used for testing/ benchmarking and would fit here?

Sebastian
