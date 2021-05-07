Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE53E376778
	for <lists+cgroups@lfdr.de>; Fri,  7 May 2021 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhEGPEV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 11:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234872AbhEGPEU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 May 2021 11:04:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6E9561006;
        Fri,  7 May 2021 15:03:15 +0000 (UTC)
Date:   Fri, 7 May 2021 17:03:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/16] memcg: enable accounting for new namesapces and
 struct nsproxy
Message-ID: <20210507150312.pb4wnxyfw3nwl4yi@wittgenstein>
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
 <fcec18da-0e46-a29e-0a67-26bd024146b1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcec18da-0e46-a29e-0a67-26bd024146b1@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28, 2021 at 09:52:43AM +0300, Vasily Averin wrote:
> Container admin can create new namespaces and force kernel to allocate
> up to several pages of memory for the namespaces and its associated
> structures.
> Net and uts namespaces have enabled accounting for such allocations.
> It makes sense to account for rest ones to restrict the host's memory
> consumption from inside the memcg-limited container.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---

Serge's ack reminded me of this. Looks good if the mm folks are fine
with this too,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
