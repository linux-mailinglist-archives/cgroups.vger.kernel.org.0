Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB655747C
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 09:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiFWHvK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 03:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFWHvI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 03:51:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99EE2CE0E;
        Thu, 23 Jun 2022 00:51:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66A2B1FD45;
        Thu, 23 Jun 2022 07:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655970664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/aCRSdhEB1a/0vv+am/2J2O6zh8qGqpd9QHXNhE6fQ=;
        b=uX9mixs8DaMWvUWkJIlE5hYrzddV835XJc/pbvqs6zdl2ElMIt6vkjYE976CR/AFb8xzm5
        AE+zJC+LE7CWeChJY9ZsZnarpVzWsKP9XyHYR6oZu4lbuY0C1Jif8xInDH2xQajcTkU+LH
        f+KGfRmCvrPYV5PW7x6Nq7DwZvzsuvw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 045BE133A6;
        Thu, 23 Jun 2022 07:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6/h0O2cbtGJubwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 23 Jun 2022 07:51:03 +0000
Date:   Thu, 23 Jun 2022 09:51:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     rdunlap@infradead.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] sched: RT bandwidth interface for
 cgroup unified hierarchy
Message-ID: <20220623075102.GJ27251@blackbody.suse.cz>
References: <20220622015557.7497-1-zhouchengming@bytedance.com>
 <20220622173929.GA669@blackbody.suse.cz>
 <888b6885-5380-e21f-260f-eb1bb89679c3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888b6885-5380-e21f-260f-eb1bb89679c3@bytedance.com>
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

On Thu, Jun 23, 2022 at 10:23:26AM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
> I don't know why v2 differ from v1 in the RT bandwidth control.. Is there
> some links of explanation? (CFS bandwidth control can work on v2 now.)

You can see some ideas in [1] (the v1 API allows configurations that are
not implemented).
And I'd also say more generally, that applying throttling to an RT task
is already a lost game (either it's a runaway meaning there's a bug
elsewhere or the RT task won't have sufficient runtime which defeats its
RTness).

> If the problem can't be solved, we have to unset CONFIG_RT_GROUP_SCHED.

AFAICT, this was enough so far (but RT group scheduling can still be
(re)worked).

HTH,
Michal

[1] https://www.kernel.org/doc/html/latest/scheduler/sched-rt-group.html
