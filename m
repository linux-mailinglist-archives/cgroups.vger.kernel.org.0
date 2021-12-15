Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A144751BF
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 05:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhLOEhJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 23:37:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36680 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbhLOEhJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 23:37:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B68D31F383;
        Wed, 15 Dec 2021 04:37:07 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9D73139CF;
        Wed, 15 Dec 2021 04:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHemJvBwuWF8aQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 15 Dec 2021 04:37:04 +0000
Date:   Tue, 14 Dec 2021 20:36:57 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH-next v3] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Message-ID: <20211215043657.ngmxlk6rgc2ysbmz@offworld>
Mail-Followup-To: Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211214144412.447035-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211214144412.447035-1-longman@redhat.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 Dec 2021, Waiman Long wrote:

>@@ -2189,7 +2194,7 @@ static void drain_local_stock(struct work_struct *dummy)
>	 * drain_stock races is that we always operate on local CPU stock
>	 * here with IRQ disabled
>	 */
>-	local_irq_save(flags);
>+	local_lock_irqsave(&memcg_stock.lock, flags);
>
>	stock = this_cpu_ptr(&memcg_stock);
>	drain_obj_stock(&stock->irq_obj);

So here there is still the problem that you can end up taking sleeping locks
with irqs disabled via obj_cgroup_put() >> obj_cgroup_release() - ie: the
percpu_ref_switch_lock and css_set_lock. It had occurred to me to promote
the former to a raw spinlock, but doubt we can get away with the latter.

Thanks,
Davidlohr
