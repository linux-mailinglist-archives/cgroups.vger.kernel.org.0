Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34555610E5D
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ1KYF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJ1KYE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 06:24:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F3B1CB534;
        Fri, 28 Oct 2022 03:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EFE3B80188;
        Fri, 28 Oct 2022 10:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423D9C433C1;
        Fri, 28 Oct 2022 10:23:59 +0000 (UTC)
Date:   Fri, 28 Oct 2022 06:24:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221028062414.7859f787@gandalf.local.home>
In-Reply-To: <Y1uSG/7VXWLNlxlt@infradead.org>
References: <20221027150525.753064657@goodmis.org>
        <20221027150925.819019339@goodmis.org>
        <20221027111944.39b3a80c@gandalf.local.home>
        <Y1uSG/7VXWLNlxlt@infradead.org>
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

On Fri, 28 Oct 2022 01:26:03 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> This is just a single patch out of apparently 31, which claims that
> something that doesn't even exist in mainline must be used without any
> explanation.  How do you expect anyone to be able to review it?

  https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/

Only the first patch is relevant to you. I guess the Cc list would have
been too big to Cc everyone that was Cc'd in the series.

It not being in mainline is the reason I marked it RFC. As it's more of an
FYI than a pull it in request.

-- Steve
