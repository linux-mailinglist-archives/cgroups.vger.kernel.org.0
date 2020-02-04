Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF6E151A21
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2020 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBDLyC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Feb 2020 06:54:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgBDLyC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Feb 2020 06:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iUu18RYN80bzMMLTjBJu6yIsP2v0nDSnUCJt6N21n6A=; b=KVQzzxEwjH+T/QHWi2sBA9hSk6
        3YEa05Z7jzH6PZOqAtx4/80TcdwU6pRdSk3UvqNI1dESExgcgU2hjTDEsqQmuyiYsTDnja/tuV3st
        3RmlufXrmB7hhAKpM0FEgnpJygQRQYRvW4Q4ykMQulQ8ZYF48NxRwKxawmmhDojuEdD4JdRyIcj4N
        NTx9eVuWxbmDL2N5LFEycSeQT//85aGCNXPB+CK6skMQ9QS3TW3c0S9Rr/w1hATzWkrqaTKAt1dGm
        Qfa+g7v+keGDGVuq6+CWBBrBPkPQ6g6NLiIKKTPEAHnA3ueQON4a/Cc4uEPOJzhbBBzXoZ2h35PAX
        qEaDf1Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iywm9-00060d-Sw; Tue, 04 Feb 2020 11:53:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D983F30257C;
        Tue,  4 Feb 2020 12:52:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 483C720247145; Tue,  4 Feb 2020 12:53:51 +0100 (CET)
Date:   Tue, 4 Feb 2020 12:53:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/6] clone3: allow spawning processes into cgroups
Message-ID: <20200204115351.GD14879@hirez.programming.kicks-ass.net>
References: <20200121154844.411-1-christian.brauner@ubuntu.com>
 <20200121154844.411-6-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121154844.411-6-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 21, 2020 at 04:48:43PM +0100, Christian Brauner wrote:
> This adds support for creating a process in a different cgroup than its
> parent. Callers can limit and account processes and threads right from
> the moment they are spawned:
> - A service manager can directly spawn new services into dedicated
>   cgroups.
> - A process can be directly created in a frozen cgroup and will be
>   frozen as well.
> - The initial accounting jitter experienced by process supervisors and
>   daemons is eliminated with this.
> - Threaded applications or even thread implementations can choose to
>   create a specific cgroup layout where each thread is spawned
>   directly into a dedicated cgroup.
> 
> This feature is limited to the unified hierarchy. Callers need to pass
> an directory file descriptor for the target cgroup. The caller can
> choose to pass an O_PATH file descriptor. All usual migration
> restrictions apply, i.e. there can be no processes in inner nodes. In
> general, creating a process directly in a target cgroup adheres to all
> migration restrictions.

AFAICT, he *big* win here is avoiding the write side of the
cgroup_threadgroup_rwsem. Or am I mis-reading the patch?

That global lock is what makes moving tasks/threads around super
expensive, avoiding that by use of this clone() variant wins the day.
