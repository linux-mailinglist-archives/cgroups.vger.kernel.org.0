Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4D47284D
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 11:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhLMKKc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 05:10:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41512 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbhLMKIa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 05:08:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E7F6E2111A;
        Mon, 13 Dec 2021 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639390108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAlFWeBlMiXf+1RQBWZpSz97qKdbH168dZaJ4vBCj88=;
        b=rUPcmILWZKV8HVQCcAOG/7r1sDRrpwu3h02jFJQISqeJswZm+cmuKuPjTJzDAdK+xGFhdg
        OnM0Cae/CVt5zFQbjxQRDYh5WCHEo8C3zHEBNwB06Srz3YgrlHTotzrr02Zu1pi4Chq8Tq
        9WdcpaC89KsMkxK4es9O0AwrnBXd3NE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B620BA3B89;
        Mon, 13 Dec 2021 10:08:28 +0000 (UTC)
Date:   Mon, 13 Dec 2021 11:08:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <YbcbmvQk+Sgdsi9G@dhcp22.suse.cz>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
 <Ya+SCkLOLBVN/kiY@cmpxchg.org>
 <YbNwmUMPFM/MO0cX@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNwmUMPFM/MO0cX@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 10-12-21 16:22:01, Sebastian Andrzej Siewior wrote:
[...]
I am sorry but I didn't get to read and digest the rest of the message
yet. Let me just point out this

> The problematic part here is mem_cgroup_tree_per_node::lock which can
> not be acquired with disabled interrupts on PREEMPT_RT.  The "locking
> scope" is not always clear to me.  Also, if it is _just_ the counter,
> then we might solve this differently.

I do not think you should be losing sleep over soft limit reclaim. This
is certainly not something to be used for RT workloads and rather than
touching that code I think it makes some sense to simply disallow soft
limit with RT enabled (i.e. do not allow to set any soft limit).
-- 
Michal Hocko
SUSE Labs
