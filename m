Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526214F399B
	for <lists+cgroups@lfdr.de>; Tue,  5 Apr 2022 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiDELgO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Apr 2022 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356861AbiDEKZA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Apr 2022 06:25:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA89C12EB;
        Tue,  5 Apr 2022 03:09:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B8321F745;
        Tue,  5 Apr 2022 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649153348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2JAhA7wRXjstDGSBxsda1XlMcvrnOLvDvnRGSGBhWQ=;
        b=VUzkhbo1IP8rBXBSTb+xi5+IO+JKiwE8GKiq1RV8GvLLp621TtLgWINmac+lMjA3AxHC7/
        U+KDroTz7bzqhgUsS1Gvm4ACqI7ELwJOUTcIP0zkEutls9EakN7ohOic0E9tlWNymY7qr2
        xEeaJnx+CzP6OJK8UrMwCtA0b8swnf8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0023613A04;
        Tue,  5 Apr 2022 10:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bx79OkMVTGI0SQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 05 Apr 2022 10:09:07 +0000
Date:   Tue, 5 Apr 2022 12:09:06 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <20220405100906.GB13806@blackbody.suse.cz>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
 <YkcYq8F6MYlMi+yS@cmpxchg.org>
 <CAAPL-u-za-TTyyC5uMVev9eQyhxZS7q3pVqaUxCFjqk+Sv9+ig@mail.gmail.com>
 <CALvZod4-fKfv6vbZPZ3nCE=Bue4FUnC+9t27wsznmyd+JKgDbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4-fKfv6vbZPZ3nCE=Bue4FUnC+9t27wsznmyd+JKgDbg@mail.gmail.com>
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

On Mon, Apr 04, 2022 at 10:08:43AM -0700, Shakeel Butt <shakeelb@google.com> wrote:
> What would be the challenge on returning the number of bytes reclaimed
> through cgroup interface?

You'd need an object that represents the write size:

> bfd = open("/sys/kernel/mm/reclaim/balloon", O_RDWR);
> dprintf(bfd, "type=file nodemask=1-2 timeout=30\n")
> 
> fd = open("/sys/kernel/fs/cgroup/foo/memory.reclaim", O_WRONLY);
> reclaimed = splice(bfd, NULL, fd, NULL, reclaim_size);

(I'm joking with this API but it is a resembling concept.)

Michal
