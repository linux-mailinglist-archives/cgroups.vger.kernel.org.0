Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579336A7BFC
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 08:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCBHp7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 02:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCBHp6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 02:45:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B928216
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 23:45:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDF1221AF6;
        Thu,  2 Mar 2023 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677743155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SZzZlo51hCIHj63LTnZFCuHCo+OU2sc9qkPk8oTs2I=;
        b=PoUWiCcNQHCkdj583LO/FEOzanT+eGRGNnnMQXkh+OfyWi2LsHSbfwSozqB15GQI/8Ri8X
        P1l5KOj4fAx4C4zxe/Ae5eUXN4hUaYsonTKFaVqDtPYn9rtvdPEnvrE9IC+m2V3QvabOV9
        NI7eTsquRnQMQeYbffgmB0EYO7eD2Yo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F81013A7D;
        Thu,  2 Mar 2023 07:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3Lm5JDNUAGS7CAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 02 Mar 2023 07:45:55 +0000
Date:   Thu, 2 Mar 2023 08:45:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v5 2/6] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <ZABUMit05SZBDXRQ@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-3-bigeasy@linutronix.de>
 <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 01-03-23 18:23:19, Valentin Schneider wrote:
> On 26/02/22 21:41, Sebastian Andrzej Siewior wrote:
> > During the integration of PREEMPT_RT support, the code flow around
> > memcg_check_events() resulted in `twisted code'. Moving the code around
> > and avoiding then would then lead to an additional local-irq-save
> > section within memcg_check_events(). While looking better, it adds a
> > local-irq-save section to code flow which is usually within an
> > local-irq-off block on non-PREEMPT_RT configurations.
> >
> 
> Hey, sorry for necro'ing a year-old thread - would you happen to remember
> what the issues were with memcg_check_events()? I ran tests against
> cgroupv1 using an eventfd on OOM with the usual debug arsenal and didn't
> detect anything, I'm guessing it has to do with the IRQ-off region
> memcg_check_events() is called from?

I would have to look into details but IIRC the resulting code to make
the code RT safe was dreaded and hard to maintain as a result. As we
didn't really have any real life usecase, disabling the code was an
easier way to go forward. So it is not the code would be impossible to
be enabled for RT it just doeasn't seam to be worth all the complexity.

> I want cgroupv1 to die as much as the next person, but in that specific
> situation I kinda need cgroupv1 to behave somewhat sanely on RT with
> threshold events :/

Could you expand on the usecase?

-- 
Michal Hocko
SUSE Labs
