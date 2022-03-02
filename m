Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6F4CADF0
	for <lists+cgroups@lfdr.de>; Wed,  2 Mar 2022 19:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiCBSxs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Mar 2022 13:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiCBSxr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Mar 2022 13:53:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7F50473
        for <cgroups@vger.kernel.org>; Wed,  2 Mar 2022 10:53:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 964661F383;
        Wed,  2 Mar 2022 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646247182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETq8HlggMKKBEmSfyL4EONAS/CABlZuOFa+QsLe+Wf0=;
        b=c7wRWHji8ylj9sHDg9NDHuzDIlBJ16wywrGqA7MV3iPFIDOmbyfk2fp5AfxGW2aRW4qEQO
        Xl1GPMbT8oIlcw28I2y0Sjf2Vr1YKp8p2ytZDrEbez1r9eZUQArwjQkLuriRYD5lZIswfa
        F52D6RLBu3hZ1GVDeyanclxKTsFDny4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E12A13A9F;
        Wed,  2 Mar 2022 18:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H46WGQ69H2JVaAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 02 Mar 2022 18:53:02 +0000
Date:   Wed, 2 Mar 2022 19:53:00 +0100
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
Message-ID: <20220302185300.GA19699@blackbody.suse.cz>
References: <20220222005811.10672-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222005811.10672-1-rdunlap@infradead.org>
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

On Mon, Feb 21, 2022 at 04:58:11PM -0800, Randy Dunlap <rdunlap@infradead.org> wrote:
> __setup() handlers should return 1 if the command line option is handled
> and 0 if not (or maybe never return 0; it just pollutes init's environment).

Interesting.

> Instead of relying on this '.' quirk, just return 1 to indicate that
> the boot option has been handled.

But your patch would return 1 even when no accepted value was passed,
i.e. is the command line option considered handled in that case?

Did you want to return 1 only when the cgroup.memory= value is
recognized?

Thanks,
Michal
