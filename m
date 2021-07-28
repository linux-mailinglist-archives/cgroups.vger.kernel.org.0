Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765A13D9623
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhG1Tnb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Jul 2021 15:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhG1Tna (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Jul 2021 15:43:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 928FE61040;
        Wed, 28 Jul 2021 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627501407;
        bh=TgcJqwLoPTRv4fk6gzrVlBugar75L/QJwtcHNSkMUJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjfRiQvZF1G/igSUwx43shhbBOQEqN091BYafBeKw7pF2opxclayI80Sqozlu7XJb
         UM7ImzliQbGmesD9ts7CZU10l7Nn6pEJOV9FBYgw6A/Lzk08zEQTwsWjvYFs/umYny
         HW8XEHdL8aHqj7IE3AUFQcUDSI9vBDL3mUC8rPRo=
Date:   Wed, 28 Jul 2021 12:43:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: cleanup racy sum avoidance code
Message-Id: <20210728124326.a3e6cc29f670062185fb57d7@linux-foundation.org>
In-Reply-To: <20210728012243.3369123-1-shakeelb@google.com>
References: <20210728012243.3369123-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 27 Jul 2021 18:22:43 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> We used to have per-cpu memcg and lruvec stats and the readers have to
> traverse and sum the stats from each cpu. This summing was racy and may
> expose transient negative values. So, an explicit check was added to
> avoid such scenarios. Now these stats are moved to rstat infrastructure
> and are no more per-cpu, so we can remove the fixup for transient
> negative values.

We can't do anything about the same code in lruvec_page_state_local()?
