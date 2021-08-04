Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65723DFC34
	for <lists+cgroups@lfdr.de>; Wed,  4 Aug 2021 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhHDHjh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Aug 2021 03:39:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49034 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhHDHjg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Aug 2021 03:39:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4D9C22193;
        Wed,  4 Aug 2021 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628062763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvd9pPr9EanKWBW5cDt9Sg5pvM2uTEKHOrqxlKqLhuE=;
        b=UzHHJ65hvzZkwrhUytOaNbHvEDJs+m6w9AqJrpSN6Eu7Fk+tWYzFaysfAMgWLxPAXRKsK5
        WgC5cerdwOJLCAD+Yad0uXurjc6hwK/zhAl5uAC5zbuB/OBcUpIK7RFkkHtnosVMYVepM2
        V7ivdH+N7LSHpj0BA9Q4M6aMZRESDds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628062763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvd9pPr9EanKWBW5cDt9Sg5pvM2uTEKHOrqxlKqLhuE=;
        b=l4IOXECy3nbKl00pW05d5t9CIG9R796gBwYSXRuZBE5IUbxcGEybBzu45/vZBwug9NuH04
        XOt3qwD29AbYVVDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 97E8B13768;
        Wed,  4 Aug 2021 07:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id AunDIytECmHVSwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 04 Aug 2021 07:39:23 +0000
Subject: Re: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
To:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210803175519.22298-1-longman@redhat.com> <87h7g62jxm.ffs@tglx>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <93dfe0d4-c687-93f8-da75-c5d3c9bd0ac7@suse.cz>
Date:   Wed, 4 Aug 2021 09:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87h7g62jxm.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/4/21 1:21 AM, Thomas Gleixner wrote:
> 	/*
> 	 * The only protection from memory hotplug vs. drain_stock races is
> 	 * that we always operate on local CPU stock here with IRQ disabled
> 	 */
> -	local_irq_save(flags);
> +	local_lock_irqsave(memcg_stock_lock, flags);
>         ...
> 	if (use_task_obj_stock())
>   		drain_obj_stock(&stock->task_obj);
> 
> which is incomprehensible garbage.
> 
> The comment above the existing local_irq_save() is garbage w/o any local
> lock conversion already today (and even before the commit which
> introduced stock::task_obj) simply because that comment does not explain
> the why.

Michal, this seems to be your comment from commit 72f0184c8a00 ("mm, memcg:
remove hotplug locking from try_charge"). Was "memory hotplug" a mistake,
because the rest of the commit is about cpu hotplug, and I don't really see a
memory hotplug connection there?
