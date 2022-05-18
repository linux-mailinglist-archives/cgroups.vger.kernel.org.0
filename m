Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8152B4C1
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiERIXb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiERIXa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 04:23:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35910788A;
        Wed, 18 May 2022 01:23:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 944491F9AF;
        Wed, 18 May 2022 08:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652862207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FJND1+favEk/cOgY0turwQ+6cBnWq+nsb19SAKTVPUA=;
        b=t/o5epZYvxiBIQDzueYrPOwwiW1warWt2xq1/43b4Mj1nJfRwe5l+xKZd0iZfTWfO74CG4
        7P318fbQMXRSCtWT9vlEpfhiCbavhA1HuRdRPC5UIYPhedEviCDhQ6jGCzMuYHoBDrdKt5
        No7H2oBTBt/Q01S/kFrhKyw7lnHceNo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60317133F5;
        Wed, 18 May 2022 08:23:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7MepFv+shGK4aQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 08:23:27 +0000
Date:   Wed, 18 May 2022 10:23:26 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-ID: <20220518082326.GH17557@blackbody.suse.cz>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
 <20220511173218.GB31592@blackbody.suse.cz>
 <YnwJUL90fuoHs3YW@cmpxchg.org>
 <20220513151426.GC16096@blackbody.suse.cz>
 <Yn6QfdouzkcrygTR@cmpxchg.org>
 <20220516143459.GA17557@blackbody.suse.cz>
 <YoKtgaxOAMBVKiCf@cmpxchg.org>
 <20220517165216.7acd8434f8b25606836e21e6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517165216.7acd8434f8b25606836e21e6@linux-foundation.org>
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

On Tue, May 17, 2022 at 04:52:16PM -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 16 May 2022 16:01:05 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Thanks for your thoughts, Michal.

You're welcome. The change is well-reasoned...

> I think everything is settled here so I plan to import this series into
> mm-stable in a couple of days.

...and makes sense with the listed fixups.

Michal
