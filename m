Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B03511B4A
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiD0OMn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiD0OMn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 10:12:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD534EF58;
        Wed, 27 Apr 2022 07:09:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA6CE1F37B;
        Wed, 27 Apr 2022 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651068569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qG8YIn3JE35g9Ne+urDhvDL4HbkCFi0xkUxB0TL6o3I=;
        b=FagGEF9266faGYZUHMQ7LBbOYJ6Buy1ny6xrAtyvD5345V/OyTl5AOYA8+hHWKvYXPZLMK
        rm8B6wrD7trua5Vddbu7bWthowMxia9peAgV7nb6c44uDpqNIvs26PjxF7HLsaI5dPeQW6
        fItKqnIsFzukl0ZnrGQUDIED8UGpC6c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D37C13A39;
        Wed, 27 Apr 2022 14:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sNVVJZlOaWLLbQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 27 Apr 2022 14:09:29 +0000
Date:   Wed, 27 Apr 2022 16:09:28 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <20220427140928.GD9823@blackbody.suse.cz>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423155619.3669555-3-void@manifault.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello David.

On Sat, Apr 23, 2022 at 08:56:19AM -0700, David Vernet <void@manifault.com> wrote:
> This unfortunately broke the memcg tests, which asserts that a sibling
> that experienced reclaim but had a memory.low value of 0, would not
> observe any memory.low events. This patch updates test_memcg_low() to
> account for the new behavior introduced by memory_recursiveprot.

I think the test is correct, there should be no (not even recursive)
protection in this particular case (when the remaining siblings consume
all of parental protection).

This should be fixed in the kernel (see also [1], no updates from me yet
:-/)

Michal

[1] https://lore.kernel.org/lkml/20220322182248.29121-1-mkoutny@suse.com/
