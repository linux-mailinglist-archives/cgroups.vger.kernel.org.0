Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B349C88F
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 12:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiAZLY2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 06:24:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiAZLY1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 06:24:27 -0500
Date:   Wed, 26 Jan 2022 12:24:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643196266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22UvY86Kfs4AbFGAcdoC8Kdx7cTmd+khf9zUEu3+8JU=;
        b=Y7kQkiCmXIll4GHMf/OXPjc7GbWHeMX4BK6a60kJv+OtHkOlHBIWzwoVlUecRRVSGLleqq
        xN0exkry7H3DhKWYBAycSgPYGE2nREK85PvJSSZxiqEwLbP6yfMYNXD5gZ55/XBHzBmUs4
        P5epcx+y7dqy9Xh40pdCjwKrEjd2oIik+PPGmirzfJptqanxbweSltevfnCAEPTRKX1SQS
        +rCwDQj4W6YDWwWg/dIVUcbg93Z+K6M+K1jYKCoApUGInNkLU3HyDMlZTwmgYAD0CJ9I1W
        WbI5qs2CetZVCe6yGPVfH8hNPVtZ9r/MWOdLmkXCfF47Y5uXtGvABUB4uvnOrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643196266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22UvY86Kfs4AbFGAcdoC8Kdx7cTmd+khf9zUEu3+8JU=;
        b=igt4CRlkzJpPqZFeay9GJE8KSEMkn9bNkM5J8GrPivTBxt7zcI40CakmKrJraSCsziuMtB
        dBEtsKhIHBrZkxCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/4] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YfEvaeCXoL+I3z05@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-3-bigeasy@linutronix.de>
 <86eeed07-b7dc-b387-ea4d-1a4a41334fe3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86eeed07-b7dc-b387-ea4d-1a4a41334fe3@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-26 11:06:40 [+0100], Vlastimil Babka wrote:
> So it's like c68ed7945701 ("mm/vmstat: protect per cpu variables with
> preempt disable on RT") but we still don't want a wrapper of those
> constructs so they don't spread further, right :)

Right. We only have them because of assumption based on spin_lock_irq()
which are not true on PREEMPT_RT. Having a generic one might let people
to use them for the wrong reasons.
The commit you mentioned changed all users while here I only changed
those which missed it. Also I wasn't sure if preemption should be
disabled or interrupts (to align with the other local_irq_save()).

> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thank you.

Sebastian
