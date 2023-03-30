Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70896CFE90
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjC3IjM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 04:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjC3IjI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 04:39:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1746582;
        Thu, 30 Mar 2023 01:39:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AB851FE3F;
        Thu, 30 Mar 2023 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680165546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l77j8HdtGUHY1DMGytaSmxCL2KwdNyQtcXi/v8k1LPw=;
        b=ZgNg5GontEAiDlgn92dJ6MtfZud/Zqf+VjcX9eEi4gTi2tHmEQ33ugODl7Ly+X0ZWtEsA+
        p3AZ19J4aHB5KoT4BR/c1glf2Ls0e6ZF0/gGE1sQoKTvQeCB+cmYH2J59mXyjUNEtHGGaB
        aZDvQcyHUI3flpOOeXADbKoneVeUCeA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC0D1138FF;
        Thu, 30 Mar 2023 08:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6e0lN6lKJWRCHQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 30 Mar 2023 08:39:05 +0000
Date:   Thu, 30 Mar 2023 10:39:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
Message-ID: <ZCVKqN2nDkkQFvO0@dhcp22.suse.cz>
References: <20230328221644.803272-5-yosryahmed@google.com>
 <ZCQfZJFufkJ10o01@dhcp22.suse.cz>
 <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com>
 <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
 <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
 <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz>
 <CAJD7tkaKd9Bcb2-e83Q-kzF7G+crr1U+7uqUPBARXWq-LpyKvw@mail.gmail.com>
 <ZCVFA78lDj2/Uy0C@dhcp22.suse.cz>
 <CAJD7tkbjmBaXghQ+14Hy28r2LoWSim+LEjOPxaamYeA_kr2uVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbjmBaXghQ+14Hy28r2LoWSim+LEjOPxaamYeA_kr2uVw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 30-03-23 01:19:29, Yosry Ahmed wrote:
> On Thu, Mar 30, 2023 at 1:15 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 30-03-23 01:06:26, Yosry Ahmed wrote:
> > [...]
> > > If we achieve that, do you think it makes sense to add
> > > WARN_ON_ONCE(irqs_disabled()) instead to prevent future users from
> > > flushing while disabling irqs or in irq context?
> >
> > WARN_ON (similar to BUG_ON) will not prevent anybody from doing bad
> > things. We already have means to shout about sleepable code being
> > invoked from an atomic context and there is no reason to duplicate that.
> > As I've said earlier WARN_ON might panic the system in some
> > configurations (and yes they are used also in production systems - do
> > not ask me why...). So please be careful about that and use that only
> > when something really bad (yet recoverable) is going on.
> 
> Thanks for the information (I was about to ask why about production
> systems, but okay..). I will avoid WARN_ON completely. For the
> purposes of this series I will drop this patch anyway.

Thanks! People do strange things sometimes...

> Any idea how to shout about "hey this may take too long, why are you
> doing it with irqs disabled?!"?

Well we have a hard lockup detector. It hits at a much higher stall by
default but if you care about IRQ latencies in general then you likely
want to lower. Another thing would be IRQ tracing. In any case this code
path shouldn't be any special. Sure it can take long on large systems
but I bet there are more of those.
-- 
Michal Hocko
SUSE Labs
