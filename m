Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB016CB00E
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 22:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjC0Ukl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Mar 2023 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0Ukk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Mar 2023 16:40:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485F1719;
        Mon, 27 Mar 2023 13:40:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE16C1FE22;
        Mon, 27 Mar 2023 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679949637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgIrKz0UNBCn4PDiHW0xzrI6MTRBYSXxkJu/zMHUvKg=;
        b=aTyTas8xnndKQ+7rRpt7+uxegjLQTBesNPvbKnCfTN5qLbE6ycmNqY7poDyjI3gNMFpEEc
        q9Tr3ZJm7OP//76yYW4qy6Urq56r/oM+X/rPvVywvwdlCrSja9e+wB0YDmj0DVFfr2QMqj
        TEEofls4ExVM5wz3WIr2NkNvgkrZNJI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C06BA13482;
        Mon, 27 Mar 2023 20:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PIgTLEX/IWSFNAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 27 Mar 2023 20:40:37 +0000
Date:   Mon, 27 Mar 2023 22:40:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Florian Schmidt <flosch@nutanix.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] memcg v1: provide read access to memory.pressure_level
Message-ID: <ZCH/RVlh1M6DRXaU@dhcp22.suse.cz>
References: <20230322142525.162469-1-flosch@nutanix.com>
 <20230324150350.fu7itbqqvtjmyf3s@blackpad>
 <6f4420d0-2f86-7294-01e1-6806ef7e4686@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f4420d0-2f86-7294-01e1-6806ef7e4686@nutanix.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 27-03-23 14:59:37, Florian Schmidt wrote:
> Hi Michal,
> 
> On 24/03/2023 15:03, Michal Koutný wrote:
> > On Wed, Mar 22, 2023 at 02:25:25PM +0000, Florian Schmidt <flosch@nutanix.com> wrote:
[...]
> > > (b) would you be interested to take this patch, or is it too niche a fix
> > >      for a legacy subsystem?
> > 
> > I'd rather not extend this "unique way" with additionally unique dummy
> > helpers.
> 
> I understand that this is all code that has no modern user any more, which
> is why I tried to keep the fix as self-contained as possible.
> Another option would be to have a special handler in cgroup_file_mode(), but
> that feels a lot klunkier to me, and leaks a v1-specific behaviour into the
> shared cgroup code.

Yes, this is effectivelly a deprecated interface but I do agree that we
shouldn't really make life of users more complicated than necessary. If
the simplest solution to address this is to provide an empty callback
then be it. I am not sure but I do not think there are other cgroup
interfaces to warrant a more generic solution.

-- 
Michal Hocko
SUSE Labs
