Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1E611492
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ1OaU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 10:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJ1OaT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 10:30:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C036F551;
        Fri, 28 Oct 2022 07:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DB7CB82A89;
        Fri, 28 Oct 2022 14:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CFAC433C1;
        Fri, 28 Oct 2022 14:30:12 +0000 (UTC)
Date:   Fri, 28 Oct 2022 10:30:28 -0400
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
Message-ID: <20221028103028.636072e3@gandalf.local.home>
In-Reply-To: <9bb423f8-5910-494d-2522-2fcf8e41c2e4@kernel.dk>
References: <20221027150525.753064657@goodmis.org>
        <20221027150925.819019339@goodmis.org>
        <20221027111944.39b3a80c@gandalf.local.home>
        <Y1uSG/7VXWLNlxlt@infradead.org>
        <20221028062414.7859f787@gandalf.local.home>
        <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
        <20221028100656.00a4d537@gandalf.local.home>
        <9bb423f8-5910-494d-2522-2fcf8e41c2e4@kernel.dk>
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

On Fri, 28 Oct 2022 08:11:27 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> This is pretty common for tree wide changes. The relevant lists need
> to see the full context, patch 4/31 by itself is useless and may as well
> not be sent at this point then.

Ah, I didn't think about just including the mailing lists. The Cc lists
were auto-generated, and I didn't think about just taking out the lists.

Will do that for v2.

Thanks,

-- Steve
