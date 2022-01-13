Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7CD48DA02
	for <lists+cgroups@lfdr.de>; Thu, 13 Jan 2022 15:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiAMOsI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 09:48:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40600 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiAMOsF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jan 2022 09:48:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7ADFC1F387;
        Thu, 13 Jan 2022 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642085284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/KiLmbu2FzwjS6g8oZPwe01R3SCJm9aWDvcjh1V1oQ=;
        b=UzapisG0u9pfLMsgBm15bvLIVl8KzGhzBfs+l22qSgE6/NiXDdINQLc9ShJjoGYF6NyL9D
        N0xgRz4dE6ou/b3G6Wy9yCq0nhAhI9RuklR4BmHJ3fpvuILBLV8j0uSQ+Fxm90ImIleIm8
        CxA7xma/OBgwkBbt+v3yd6LtJRSqOe8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A35B13DD1;
        Thu, 13 Jan 2022 14:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vVhwFaQ74GGRBgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 13 Jan 2022 14:48:04 +0000
Date:   Thu, 13 Jan 2022 15:48:03 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/3] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT
Message-ID: <20220113144803.GB28468@blackbody.suse.cz>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-2-bigeasy@linutronix.de>
 <20220105141653.GA6464@blackbody.suse.cz>
 <YeAkOm0YsAe5jFRb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeAkOm0YsAe5jFRb@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 13, 2022 at 02:08:10PM +0100, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> I added a preempt-disable() section restricted to RT to
> mem_cgroup_event_ratelimit().

Oh, I missed that one.

(Than the decoupling of such mem_cgroup_event_ratelimit() also makes
some more sense.)
> That would mean that mem_cgroup_event_ratelimit() needs a
> local_irq_save(). If that is okay then sure I can move it that way.

Whatever avoids the twisted code :-)

---

> I remember Michal (Hocko) suggested excluding/ rejecting soft limit but
> I didn't know where exactly and its implications. In this block here I
> just followed the replacement of irq-off with preempt-off for RT.

Both soft limit and (these) event notifications are v1 features. Soft
limit itself is rather considered even misfeature. I guess the
implications would not be many since PREEMPT_RT+memcg users would be
new(?) so should rather start with v2 anyway.

One way to disable it would be to reject writes into
memory.soft_limit_in_bytes or cgroup.event_control + documentation of
that.

Michal
