Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45E53662F
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbiE0Qyf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 May 2022 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiE0Qye (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 May 2022 12:54:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E9DED70C;
        Fri, 27 May 2022 09:54:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFCCA21ADA;
        Fri, 27 May 2022 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653670470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+u8JHoqLLvsvRVRBUuvCk5vOU0EPwCFY9Y54KiKuKVk=;
        b=hsMieLInNRiAFgba/ZyPJYd4fTnZWpaKHkD81x/3sHXl8J57s/mbfM10cJZ/tgrYCx4GU3
        E4pweojjXyzWX8ILfLZZqX2DYyZNLolbQgy+7oLilvuFWqBXX/VnIgybG3/7ew2v/tY2c2
        LC18jfjBjXvsIReeB0Qutu1x07qBcYw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A639813A84;
        Fri, 27 May 2022 16:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ldeHJ0YCkWL1KAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 27 May 2022 16:54:30 +0000
Date:   Fri, 27 May 2022 18:54:29 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <20220527165429.GJ11007@blackbody.suse.cz>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <904ef8af-13a5-e566-b760-74519f70fa62@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <904ef8af-13a5-e566-b760-74519f70fa62@linaro.org>
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

Hello Tadeusz.

On Fri, May 27, 2022 at 09:39:20AM -0700, Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
> As far as I can see we are trying to test the same thing suggested by Tejun.
> I just sent a test request to try this:
> https://github.com/tstruk/linux/commit/master

Yup, I've added few more prints to get more fine-grained resolution.
Also, I decided to use ftrace printk not to interfere with timing too
much (due to the original race hypothesis).

> Let me know if you have any more tests to run and I will hold off until
> you are done.

My latest attempt is [1] (tip 5500e05d82fd5b5db2203eedb3f786857d3ccbea).

So far, I'm not convinced, I extract the complete ftrace buffer from the
syzbot runs, so I'm not drawing any conclusions from the traces I've
got. I'm not going to continue today. You may have more luck with your
plain printk (if it's just imbalance and it avoids printk locking
sensitive paths).

HTH,
Michal

[1] https://github.com/Werkov/linux/tree/cgroup-ml/css-lifecycle-b2
