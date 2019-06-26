Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63BF57443
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 00:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZWZz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 18:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZWZy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 18:25:54 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB52421738;
        Wed, 26 Jun 2019 22:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561587954;
        bh=dWrZzF/XhnDsjGoEGdLBbSVqFhzeMu0M8np8rL3DeVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mssNCvDXM3lIy9mHu47Fi5QIRccIP4NEIrmBc+mQHupnTW7+YYbhguOoXDqtvERvH
         REfZC+aT9ppRRnmbB7/H8Yp47SEvjMSnzviL8SITVJOqWUzWaWRjUa5YprDOQSdFxO
         pQ6Rdu5QWpA8GqFoZXwWmNRKk1ID+8M77YZ7zkKo=
Date:   Wed, 26 Jun 2019 15:25:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] memcg: Add kmem.slabinfo to v2 for debugging purpose
Message-Id: <20190626152553.6f9178a0361e699a5d53e360@linux-foundation.org>
In-Reply-To: <20190626165614.18586-1-longman@redhat.com>
References: <20190626165614.18586-1-longman@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 26 Jun 2019 12:56:14 -0400 Waiman Long <longman@redhat.com> wrote:

> With memory cgroup v1, there is a kmem.slabinfo file that can be
> used to view what slabs are allocated to the memory cgroup. There
> is currently no such equivalent in memory cgroup v2. This file can
> be useful for debugging purpose.
> 
> This patch adds an equivalent kmem.slabinfo to v2 with the caveat that
> this file will only show up as ".__DEBUG__.memory.kmem.slabinfo" when the
> "cgroup_debug" parameter is specified in the kernel boot command line.
> This is to avoid cluttering the cgroup v2 interface with files that
> are seldom used by end users.
>
> ...
>
> mm/memcontrol.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)

A change to the kernel's user interface triggers a change to the
kernel's user interface documentation.  This should be automatic by
now :(


