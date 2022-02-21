Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A64BE55E
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358837AbiBUNS5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 08:18:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358825AbiBUNSw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 08:18:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070001EED9
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 05:18:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8854C210F0;
        Mon, 21 Feb 2022 13:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645449507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aRXcFsOUSSMa2BGcwAaU3jThpHs0aCs0hHkKe3j5Nk0=;
        b=iSPAuStelADUpXCvEe6gFVGnj6K+QDQusZ4BDFfdwORGpDkOAjfsZiTn85OAbt4uLT9ihu
        5K++/pWtAOqwrTi2yYTl10O9i9URTzTtP5pb8q964FMvvCAgqmMRi+3wEmzFgFtfeRhbWQ
        y0ie2MMVgIl2g2HE25jHlMCQrk115Ng=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 623C613AF2;
        Mon, 21 Feb 2022 13:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ybd6FyORE2KdfwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 21 Feb 2022 13:18:27 +0000
Date:   Mon, 21 Feb 2022 14:18:25 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <20220221131825.GA7534@blackbody.suse.cz>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-4-bigeasy@linutronix.de>
 <CALvZod4eZWVfibhxu0P0ZQ35cB=vDbde=VNeXiBZfED=k3YPOQ@mail.gmail.com>
 <YhN4BSQ1RLomLoyl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhN4BSQ1RLomLoyl@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 21, 2022 at 12:31:17PM +0100, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> What about memcg_rstat_updated()? It does:
> 
> |         x = __this_cpu_add_return(stats_updates, abs(val));
> |         if (x > MEMCG_CHARGE_BATCH) {
> |                 atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
> |                 __this_cpu_write(stats_updates, 0);
> |         }
> 
> The writes to stats_updates can happen from IRQ-context and with
> disabled preemption only. So this is not good, right?

These counters serve as a hint for aggregating per-cpu per-cgroup stats.
If they were systematically mis-updated, it could manifest by
missing "refresh signal" from the given CPU. OTOH, this lagging is also
meant to by limited by elapsed time thanks to periodic flushing.

This could affect freshness of the stats not their accuracy though.


HTH,
Michal

