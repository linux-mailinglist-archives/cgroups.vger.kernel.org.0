Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794523EF289
	for <lists+cgroups@lfdr.de>; Tue, 17 Aug 2021 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhHQTOo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Aug 2021 15:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhHQTOo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 17 Aug 2021 15:14:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5FEB60EBD;
        Tue, 17 Aug 2021 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629227650;
        bh=e7J/njEnxcO8SaLkLK/P3EfzspDwSQw73D4u4l2pHCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s0/KRm5RBJw6o+Xc0boKgzneAED+creTvrWPnBOqIx0TwvgWd0l+LP3GRh2oQHcNb
         mjDmgI7oKJ41dOQgHIQVrVVweEXEjG8cZh6ct0U7Epi40o2jTBoYphIau66HX7aDP2
         X/EwSWdyxxu9nO8r0Alq+Z4TKy2mASx81P3bHFCA=
Date:   Tue, 17 Aug 2021 12:14:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-Id: <20210817121408.47be5d9a11baf5bba44da9a1@linux-foundation.org>
In-Reply-To: <20210817180506.220056-1-hannes@cmpxchg.org>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 17 Aug 2021 14:05:06 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> We've noticed occasional OOM killing when memory.low settings are in
> effect for cgroups. This is unexpected and undesirable as memory.low
> is supposed to express non-OOMing memory priorities between cgroups.
> 
> The reason for this is proportional memory.low reclaim. When cgroups
> are below their memory.low threshold, reclaim passes them over in the
> first round, and then retries if it couldn't find pages anywhere else.
> But when cgroups are slighly above their memory.low setting, page scan
> force is scaled down and diminished in proportion to the overage, to
> the point where it can cause reclaim to fail as well - only in that
> case we currently don't retry, and instead trigger OOM.
> 
> To fix this, hook proportional reclaim into the same retry logic we
> have in place for when cgroups are skipped entirely. This way if
> reclaim fails and some cgroups were scanned with dimished pressure,
> we'll try another full-force cycle before giving up and OOMing.

Which kernel version(s) do you think need this?
