Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836034CBB14
	for <lists+cgroups@lfdr.de>; Thu,  3 Mar 2022 11:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiCCKOz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Mar 2022 05:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiCCKOy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Mar 2022 05:14:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C93179A05
        for <cgroups@vger.kernel.org>; Thu,  3 Mar 2022 02:14:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 243DF21107;
        Thu,  3 Mar 2022 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646302448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8hn+K1tGTvyF5f1kaIIx3YbkP2Kix2PLC93JbSkSwA=;
        b=iYFyvIhFWJzafeqkx9+fNKRZuKDSbPBEA/i0TMOKUK1aPllk0+d7K8Tfl+D3iwm8/e5BW4
        RgBKDKqBztOkqfV8lO1BPFfeF47Qwzp8Lc9UfhVyePkFd6hXmcyyU+In0Fyd230h+Nhqk2
        rvm1rmfx4/FU10+Oytt9coDRtbl+cVk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F33CD13AB4;
        Thu,  3 Mar 2022 10:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ckHSOu+UIGLBewAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 03 Mar 2022 10:14:07 +0000
Date:   Thu, 3 Mar 2022 11:14:06 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-mm@kvack.org, Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memcontrol: return 1 from cgroup.memory __setup()
 handler
Message-ID: <20220303101406.GE10867@blackbody.suse.cz>
References: <20220222005811.10672-1-rdunlap@infradead.org>
 <20220302185300.GA19699@blackbody.suse.cz>
 <9f8d4ddb-81ce-738a-d1f7-346ff9bf8ebd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f8d4ddb-81ce-738a-d1f7-346ff9bf8ebd@infradead.org>
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

On Wed, Mar 02, 2022 at 04:53:19PM -0800, Randy Dunlap <rdunlap@infradead.org> wrote:
> I don't think those strings (even with invalid option values) should be
> added to init's environment.

Isn't mere presence of the handler sufficient to filter those out? [1]

(Counter-example would be 'foo=1 foo=2' where 1 is accepted value by the
handler, 2 is unrecognized and should be passed to init. Is this a real
use case?)

> I'm willing to add a pr_warn() or pr_notice() for any unrecognized
> option value, but it should still return 1 IMO.

Regardless of the handler existence check, I see returning 1 would be
consistent with the majority of other memcg handlers.

For the uniformity,
Reviewed-by: Michal Koutný <mkoutny@suse.com>

(Richer reporting or -EINVAL is by my understanding now a different
problem.)

Thanks,
Michal

