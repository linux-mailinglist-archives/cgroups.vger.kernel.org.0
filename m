Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034A56B8F29
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 11:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCNKCJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCNKCH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 06:02:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F497943AE
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 03:02:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4812B1F88C;
        Tue, 14 Mar 2023 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678788121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3V9UlH+4QbXycfDs9XgBP/KFr5npe8+4wtZALH2Ryk=;
        b=B3TInlRa76gpBNGGVaMXKohYJ3fSl3MCkousy1D+tQbxukirNV4Sn+na4/YlHcdfuET39l
        +J2Kxha6ZHC3/F3y9wVKku3J7WyiMVU7becgzjmeWbg0VbPS5slkDvMbNuoQxvwaOBSHQE
        FKX3z3cGHStkhPxrMFv3tLHl+8KmSvw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 283D713A26;
        Tue, 14 Mar 2023 10:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eYKlCBlGEGQNfgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Mar 2023 10:02:01 +0000
Date:   Tue, 14 Mar 2023 11:02:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Message-ID: <ZBBGGFi0U8r67S5E@dhcp22.suse.cz>
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-03-23 14:08:53, Yosry Ahmed wrote:
> On Mon, Mar 13, 2023 at 12:44 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > From: Hugh Dickins <hughd@google.com>
> > >
> > > In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
> > > observed a warning from page_cgroup_ino() when reading
> > > /proc/kpagecgroup.
> >
> > If this is the only known situation in which page_memcg_check() is
> > passed a tail page, why does page_memcg_check() have
> >
> >         if (PageTail(page))
> >                 return NULL;
> >
> > ?  Can we remove this to simplify, streamline and clarify?
> 
> I guess it's a safety check so that we don't end up trying to cast a
> tail page to a folio. My opinion is to go one step further and change
> page_memcg_check() to do return the memcg of the head page, i.e:
> 
> static inline struct mem_cgroup *page_memcg_check(struct page *page)
> {
>     return folio_memcg_check(page_folio(page));
> }

I would just stick with the existing code and put a comment that this
function shouldn't be used in any new code and the folio counterpart
should be used instead.

-- 
Michal Hocko
SUSE Labs
