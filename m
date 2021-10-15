Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6742FD7E
	for <lists+cgroups@lfdr.de>; Fri, 15 Oct 2021 23:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbhJOVgP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Oct 2021 17:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243079AbhJOVgP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 Oct 2021 17:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A42DB60EE2;
        Fri, 15 Oct 2021 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634333648;
        bh=2tyMLoz7LKioqYzGr2VimJ9SCcxFOLwmrLyZHfNoTNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lZ8cYv7MXOGE5rKlvl0Do+7ZT7bSOjmWHroiiJBLfDCL6UeFaGIzT70s7XAJH5fks
         +8JKp9BXhuxBMHZZHmwEfGqkAdlB7NSmh88Rr/Vf++ZVs7WjILD8ypwD2bPFaita53
         mqQ+VLZNgENPu9qhJneMQi8dw6fXy4mtb9+AzkoQ=
Date:   Fri, 15 Oct 2021 14:34:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm v5] memcg: enable memory accounting in
 __alloc_pages_bulk
Message-Id: <20211015143405.b7d54e4afa4ca7b2d57b6140@linux-foundation.org>
In-Reply-To: <65c1afaf-7947-ce28-55b7-06bde7aeb278@virtuozzo.com>
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
        <65c1afaf-7947-ce28-55b7-06bde7aeb278@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 14 Oct 2021 11:02:57 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:

> Bulk page allocator is used in vmalloc where it can be called
> with __GFP_ACCOUNT and must charge allocated pages into memory cgroup.

Is this problem serious enough to justify -stable backporting?  Some
words which explaining reasoning for the backport would be helpful.

This patch makes Shakeel's "memcg: page_alloc: skip bulk allocator for
__GFP_ACCOUNT" unnecessary.  Which should we use?
