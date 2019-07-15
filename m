Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E3269EFB
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2019 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfGOWf3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Jul 2019 18:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730912AbfGOWf3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Jul 2019 18:35:29 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77DC2086C;
        Mon, 15 Jul 2019 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563230128;
        bh=Dhp2+rAmaJRqgQ4W9zWGRLoTJ1hk6O5nwAes/tP0jXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OYNxeNqlSp4DM+68xBXNHVmmuaMCEc7vAD+ioCjOMRuJnlCWj5Z4QFMkH+09l0tju
         vVg15F6qj1fwZhkSrafpF5PiJWeixRExiJuHx8RGfkobzmc90Tff/7ld+JpcFve56S
         li8bTQVcIwkIthO4FJwMEpLAxdLXovL3EGbCQ+3w=
Date:   Mon, 15 Jul 2019 15:35:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: Proportional memory.{low,min} reclaim
Message-Id: <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
In-Reply-To: <20190128215230.GA32069@castle.DHCP.thefacebook.com>
References: <20190124014455.GA6396@chrisdown.name>
        <20190128210031.GA31446@castle.DHCP.thefacebook.com>
        <20190128214213.GB15349@chrisdown.name>
        <20190128215230.GA32069@castle.DHCP.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 28 Jan 2019 21:52:40 +0000 Roman Gushchin <guro@fb.com> wrote:

> > Hmm, this isn't really a common situation that I'd thought about, but it
> > seems reasonable to make the boundaries when in low reclaim to be between
> > min and low, rather than 0 and low. I'll add another patch with that. Thanks
>
> It's not a stopper, so I'm perfectly fine with a follow-up patch.

Did this happen?


I'm still trying to get this five month old patchset unstuck :(.  The
review status is: 

[1/3] mm, memcg: proportional memory.{low,min} reclaim
Acked-by: Johannes
Reviewed-by: Roman

[2/3] mm, memcg: make memory.emin the baseline for utilisation determination
Acked-by: Johannes

[3/3] mm, memcg: make scan aggression always exclude protection
Reviewed-by: Roman


I do have a note here that mhocko intended to take a closer look but I
don't recall whether that happened.

I could

a) say what the hell and merge them or
b) sit on them for another cycle or
c) drop them and ask Chris for a resend so we can start again.
