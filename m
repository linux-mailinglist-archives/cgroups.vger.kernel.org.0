Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF09610C21
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ1I0J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1I0I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 04:26:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B991C3E53;
        Fri, 28 Oct 2022 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NSFvNasYsfodbnQHojzQMqo+zVFJLt7KLaSOZRcfaUo=; b=bLdfCKmpWHGIaP8dtWXbmk1azY
        3V0CcnTEZ27fcVNfDAzAhxdGG6lCTYWqzDmOVPnITxvO0hCyl8rkNg9dxNDb6IONIHt9A+wKFX92j
        g0ATxvMYQFh+6Vok1Bf8jOatYALAROFElh6U0OgBkVX0ndqLN0OAinRgSP7pc7Lu0n6RVkFvVaJJd
        zkbjIteUfej7HyCW1IBZOHVxKQvszSJslt4MFRLD7jgRuAGPZNvE9pm28BdJErSjA0PFCf0YVWDJH
        aF2edsB8E5AgzWYZscjS97W5BB3RTGGW7Mg8S/IlAPTb/r+cyw6G2WJFKMWka94flyzU0aqCBS9Do
        4m3xz2cw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooKgl-00G8rL-Il; Fri, 28 Oct 2022 08:26:03 +0000
Date:   Fri, 28 Oct 2022 01:26:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Message-ID: <Y1uSG/7VXWLNlxlt@infradead.org>
References: <20221027150525.753064657@goodmis.org>
 <20221027150925.819019339@goodmis.org>
 <20221027111944.39b3a80c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027111944.39b3a80c@gandalf.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is just a single patch out of apparently 31, which claims that
something that doesn't even exist in mainline must be used without any
explanation.  How do you expect anyone to be able to review it?
