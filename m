Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091AC46C114
	for <lists+cgroups@lfdr.de>; Tue,  7 Dec 2021 17:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhLGQ7M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Dec 2021 11:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhLGQ7L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Dec 2021 11:59:11 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D0C061574
        for <cgroups@vger.kernel.org>; Tue,  7 Dec 2021 08:55:41 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id 8so14882742qtx.5
        for <cgroups@vger.kernel.org>; Tue, 07 Dec 2021 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jBIRb58Y6btL+TAXKBtqGWyLSLmb/GcxbXs8B9okoJI=;
        b=xVie4c8Jj9A8d6UbzG2D4i8Nvmdt8QlQvLgRCKAHD0yC9kTB2O9kIE+hhm7KY3Dm75
         ah5bV+hSCiX04qN/2IR96z3IsKqa4ziG2K1mYHVCveyzJZBvuwNBRm3DnF0g3d5emx1Z
         2yc9H4rHwU8lLtJs6wHrpSLCv9NY8zhv31ZF3/UhvqukVcCbjKD9+Eoeo50rxWwlVozJ
         h8uQAdPtl0qp4dmuVcV0ts5oYWQY7wusgeEbP9Y+6rt6pL5B4BHgvtiG5LIUqY31aof3
         pY0C8UK3RS5LBPrnCFuA9LMp8pIC4Tue6Jfz+oMmvliC3aAdw7AbunTRstt3Tnl8a1Ul
         5juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jBIRb58Y6btL+TAXKBtqGWyLSLmb/GcxbXs8B9okoJI=;
        b=tJYxqMs1otd9GQBBJyWvTcz4+ItH1Ninqa5JPcsSbVJwdNNotUNWtnyUIE/irC6ikO
         70n0dPQFfAVtzzrFwrs4R/7532EPT3jg9pMPDNP92I6GG1QKAdbVgl4lPcAl4x8dv6cw
         HiOkrsMEleuLtOy3gnZGbFYaFdZ4JWWAgXiskavde34cvM3fvymAai3XCx2Lc4gJZCoZ
         qna00hK5iJit28GcZJnt+lmcL1GOtvuaRNEJVcF8e6l/daQ7djvf73hNJJtFwcRQJMaA
         /Rncb0hb3zCuTyV5WwoboHMGjFBpflN0A8/2GlFcAhthsq7bnzPO6/hTfI46FLUJNvyt
         ZDEQ==
X-Gm-Message-State: AOAM530PfNdz4KNNOaN/UVavMdCWt6C2aHML0bB87I6YZ+vYnivVCnxE
        cvOVII4d1N3QpnF9uj8uc27MduumtsuKnA==
X-Google-Smtp-Source: ABdhPJy/3i1cZVARjSv2TVIsxsNN6teXBPNEZfAggRQROn5PaiSaIIl1mvr1Y0ltWE/bELIg+HhFpw==
X-Received: by 2002:a05:622a:43:: with SMTP id y3mr446251qtw.192.1638896140469;
        Tue, 07 Dec 2021 08:55:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6bda])
        by smtp.gmail.com with ESMTPSA id t9sm70832qkp.110.2021.12.07.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 08:55:39 -0800 (PST)
Date:   Tue, 7 Dec 2021 11:55:38 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <Ya+SCkLOLBVN/kiY@cmpxchg.org>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207155208.eyre5svucpg7krxe@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 07, 2021 at 04:52:08PM +0100, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> MEMCG has a few constructs which are not compatible with PREEMPT_RT's
> requirements. This includes:
> - relying on disabled interrupts from spin_lock_irqsave() locking for
>   something not related to lock itself (like the per-CPU counter).

If memory serves me right, this is the VM_BUG_ON() in workingset.c:

	VM_WARN_ON_ONCE(!irqs_disabled());  /* For __inc_lruvec_page_state */

This isn't memcg specific. This is the serialization model of the
generic MM page counters. They can be updated from process and irq
context, and need to avoid preemption (and corruption) during RMW.

!CONFIG_MEMCG:

static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
					 int val)
{
	struct page *page = virt_to_head_page(p);

	mod_node_page_state(page_pgdat(page), idx, val);
}

which does:

void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
					long delta)
{
	unsigned long flags;

	local_irq_save(flags);
	__mod_node_page_state(pgdat, item, delta);
	local_irq_restore(flags);
}

If this breaks PREEMPT_RT, it's broken without memcg too.

> - explicitly disabling interrupts and acquiring a spinlock_t based lock
>   like in memcg_check_events() -> eventfd_signal().

Similar problem to the above: we disable interrupts to protect RMW
sequences that can (on non-preemptrt) be initiated through process
context as well as irq context.

IIUC, the PREEMPT_RT construct for handling exactly that scenario is
the "local lock". Is that correct?

It appears Ingo has already fixed the LRU cache, which for non-rt also
relies on irq disabling:

commit b01b2141999936ac3e4746b7f76c0f204ae4b445
Author: Ingo Molnar <mingo@kernel.org>
Date:   Wed May 27 22:11:15 2020 +0200

    mm/swap: Use local_lock for protection

The memcg charge cache should be fixable the same way.

Likewise, if you fix the generic vmstat counters like this, the memcg
implementation can follow suit.
