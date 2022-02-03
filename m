Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827094A883A
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiBCQBn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 11:01:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52210 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiBCQBm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 11:01:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE49A1F399;
        Thu,  3 Feb 2022 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643904101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkyve6YcfYvGoM0nU3VYewppp11fiRG9LkTkuMwauMI=;
        b=FHyKvmx3QstWqcUImKdWd4sJfM9FGttwlG+410KA6OlHVip0mKpK/55iqOol1glyN//zCq
        kNQzvJsYTVs6ufm+Rmh8IoWujFNwXDAdOJZ+dk7m7Ce0/TN89Q5EF6izsvwQGUD2dCEvrM
        0i6GW8kVUejQ6AayNO+MbdRwM3gMEiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643904101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkyve6YcfYvGoM0nU3VYewppp11fiRG9LkTkuMwauMI=;
        b=H+z2nD8gV+ElRoKfGli7lMY82/X8MDAMdH2GYdBVOTFNncWMjmS/2qGsFI7F6ZIWYeQTrw
        f5dGAvscI7QpEYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C27E813C7C;
        Thu,  3 Feb 2022 16:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q/HALmX8+2HNFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Feb 2022 16:01:41 +0000
Message-ID: <e068646f-c7f2-5876-8577-6ddf93df07d0@suse.cz>
Date:   Thu, 3 Feb 2022 17:01:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <7f4928b8-16e2-88b3-2688-1519a19653a9@suse.cz>
 <Yff69slA4UTz5Q1Y@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
In-Reply-To: <Yff69slA4UTz5Q1Y@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/22 16:06, Sebastian Andrzej Siewior wrote:
>> > - drain_all_stock() disables preemption via get_cpu() and then invokes
>> >   drain_local_stock() if it is the local CPU to avoid scheduling a worker
>> >   (which invokes the same function). Disabling preemption here is
>> >   problematic due to the sleeping locks in drain_local_stock().
>> >   This can be avoided by always scheduling a worker, even for the local
>> >   CPU. Using cpus_read_lock() stabilizes cpu_online_mask which ensures
>> >   that no worker is scheduled for an offline CPU. Since there is no
>> >   flush_work(), it is still possible that a worker is invoked on the wrong
>> >   CPU but it is okay since it operates always on the local-CPU data.
>> > 
>> > - drain_local_stock() is always invoked as a worker so it can be optimized
>> >   by removing in_task() (it is always true) and avoiding the "irq_save"
>> >   variant because interrupts are always enabled here. Operating on
>> >   task_obj first allows to acquire the lock_lock_t without lockdep
>> >   complains.
>> > 
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> 
>> The problem is that this pattern where get_obj_stock() sets a
>> stock_lock_acquried bool and this is passed down and acted upon elsewhere,
>> is a well known massive red flag for Linus :/
>> Maybe we should indeed just revert 559271146efc, as Michal noted there were
>> no hard numbers to justify it, and in previous discussion it seemed to
>> surface that the costs of irq disable/enable are not that bad on recent cpus
>> as assumed?
> 
> I added some number, fell free re-run.
> Let me know if a revert is preferred or you want to keep that so that I

I see that's discussed in the subthread with Michal Hocko, so I would be
also leaning towards revert unless convincing numbers are provided.

> can prepare the patches accordingly before posting.

An acceptable form of this would have to basically replace the bool
stock_lock_acquried with two variants of the code paths that rely on it,
feel free to read though the previous occurence :)
https://lore.kernel.org/all/CAHk-=wiJLqL2cUhJbvpyPQpkbVOu1rVSzgO2=S2jC55hneLtfQ@mail.gmail.com/

>> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> > --- a/mm/memcontrol.c
>> > +++ b/mm/memcontrol.c
>> > @@ -260,8 +260,10 @@ bool mem_cgroup_kmem_disabled(void)
>> >  	return cgroup_memory_nokmem;
>> >  }
>> >  
>> > +struct memcg_stock_pcp;
>> 
>> Seems this forward declaration is unused.
> you, thanks.
> 
> Sebastian
> 

