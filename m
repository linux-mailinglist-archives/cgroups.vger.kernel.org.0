Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B49611402
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 16:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJ1OGq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJ1OGp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 10:06:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC895B125;
        Fri, 28 Oct 2022 07:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61CF4B82A31;
        Fri, 28 Oct 2022 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76D2C433D6;
        Fri, 28 Oct 2022 14:06:40 +0000 (UTC)
Date:   Fri, 28 Oct 2022 10:06:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph =?UTF-8?B?QsO2aG13YWxk?= =?UTF-8?B?ZXI=?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221028100656.00a4d537@gandalf.local.home>
In-Reply-To: <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
References: <20221027150525.753064657@goodmis.org>
        <20221027150925.819019339@goodmis.org>
        <20221027111944.39b3a80c@gandalf.local.home>
        <Y1uSG/7VXWLNlxlt@infradead.org>
        <20221028062414.7859f787@gandalf.local.home>
        <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 28 Oct 2022 07:56:50 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 10/28/22 4:24 AM, Steven Rostedt wrote:
> > On Fri, 28 Oct 2022 01:26:03 -0700
> > Christoph Hellwig <hch@infradead.org> wrote:
> >   
> >> This is just a single patch out of apparently 31, which claims that
> >> something that doesn't even exist in mainline must be used without any
> >> explanation.  How do you expect anyone to be able to review it?  
> > 
> >   https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/
> > 
> > Only the first patch is relevant to you. I guess the Cc list would have
> > been too big to Cc everyone that was Cc'd in the series.  
> 
> No it's not, because how on earth would anyone know what the change does
> if you only see the simple s/name/newname change? The patch is useless
> by itself.
> 

I meant this as the first patch:

  https://lore.kernel.org/all/20221027150925.248421571@goodmis.org/

Which was what the link above was suppose to point to.

It's the only patch relevant to the rest of the series, as the rest is just
converting over to the shutdown API, and the last patch changes
DEBUG_OBJECTS_TIMERS to catch if this was done properly.

That is, patch 01/31 and the patch you were Cc'd on is relevant, and for
those that want to look deeper, see patch 31 as well.

But if I included the Cc list for patch 01 for all those Cc'd in the
entire series, it would be a huge Cc list, so I avoided doing so.

Also, this is still RFC as the changes may still change. That is, this
patch set is a heads up to what is to come. Ideally, I'd like to get just
the API possibly in the kernel before the merge window without anyone using
it. Then I can ask all the sub systems to pull in these individual patches
as well.

-- Steve
