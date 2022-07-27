Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A42582310
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiG0J1e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiG0J1U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 05:27:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49D47B89;
        Wed, 27 Jul 2022 02:27:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C59A720603;
        Wed, 27 Jul 2022 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658914036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anqnE2KfGtEVOPeKnZ+sVTbUC4usJ64Dv0txy9AxFfA=;
        b=uD35DKCURHlRIeXliZPxVGX4Y/Z6a5x/Vgou/m87fXh1CMhyJePsMik/zc2Sr1ocVRvviC
        S6y/HKcJCUM7rvIrjV4zE7FmLlq9YJisl5zB1wltvJbZumHGP5r1BwfyDXLWvgrszCjy3e
        tB2ROOFWjOPeSrcVzcYJPrHQSccQqZ4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A16B413A8E;
        Wed, 27 Jul 2022 09:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kfSZJvQE4WIjSwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 27 Jul 2022 09:27:16 +0000
Date:   Wed, 27 Jul 2022 11:27:15 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH cgroup/for-5.20] cgroup: remove "no" prefixed mount
 options options
Message-ID: <20220727092715.GA1569@blackbody.suse.cz>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <20220726143246.GA23794@blackbody.suse.cz>
 <YuBIACfZDk72yjI3@slm.duckdns.org>
 <YuB5ICv3bXsy5Xuh@slm.duckdns.org>
 <YuB9QXapVUy1t8TZ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuB9QXapVUy1t8TZ@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 26, 2022 at 01:48:17PM -1000, Tejun Heo <tj@kernel.org> wrote:
Thanks.

> While a bit confusing, given that there is a way to turn off the options,
> there's no reason to have the explicit "no" prefixed options. Let's remove
> them.

This is sensible...

>  Documentation/admin-guide/cgroup-v2.rst |    8 ++++----
>  kernel/cgroup/cgroup.c                  |   24 ++++--------------------
>  2 files changed, 8 insertions(+), 24 deletions(-)

...and cleaner.

Michal
