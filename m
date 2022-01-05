Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E0485430
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 15:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiAEOQ6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 09:16:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43848 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbiAEOQ4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 09:16:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C52D2210E7;
        Wed,  5 Jan 2022 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641392214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+WLxA9/1x+7qLb1Bx+bH8yfotWhgKxpBD6Y91WrBPbQ=;
        b=PAV1YMrbk39la/pf4jUdMUxaJx7luCh/1FN7SIUMJSyUYitC0PrA9E1VgkCh4UraOVmpCW
        +8BmyHXXMxdMUUZt92yHwdC6UfUeiVDIiLcYDZZKA7x/dKlQYzcwlFtdozw5tMUSedbc0s
        dEWuIryro2F81voSW5mEdShvjMtk74A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E0D513BE3;
        Wed,  5 Jan 2022 14:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id is55JVao1WHESwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 05 Jan 2022 14:16:54 +0000
Date:   Wed, 5 Jan 2022 15:16:53 +0100
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
Message-ID: <20220105141653.GA6464@blackbody.suse.cz>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222114111.2206248-2-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 22, 2021 at 12:41:09PM +0100, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> The sections with disabled preemption must exclude
> memcg_check_events() so that spinlock_t locks can still be acquired
> (for instance in eventfd_signal()).

The resulting construct in uncharge_batch() raises eybrows. If you can decouple
per-cpu updates from memcg_check_events() on PREEMPT_RT, why not tackle
it the same way on !PREEMPT_RT too (and have just one variant of the
block)?

(Actually, it doesn't seem to me that memcg_check_events() can be
extracted like this from the preempt disabled block since
mem_cgroup_event_ratelimit() relies on similar RMW pattern.
Things would be simpler if PREEMPT_RT didn't allow the threshold event
handlers (akin to Michal Hocko's suggestion of rejecting soft limit).)

Thanks,
Michal
