Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E976B8F20
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 11:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCNKA7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 06:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNKA6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 06:00:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE77B9B1
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 03:00:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1AF1F894;
        Tue, 14 Mar 2023 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678788051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrFNQAV0l1CaW8TiDEGT9ogtnBdqHaF4d1lnbt/UKwY=;
        b=l+Fl+tiItkB9IMHG6s9GklHI70NVKfCAJfb6sfkphrk2E7mPyQOCeEiWSD8eyevzEzkdqn
        2VRh7BF+1HEEd8eBMot1x1G2D63yCHyVb2N06OPgbH2WYNjRhEw8pzpVBhbaTzsJ7ctXn9
        XM7+9tyRhSczLagEMuGgH8UPKCwP72o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07F7113A26;
        Tue, 14 Mar 2023 10:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N9IUAdNFEGRxfQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Mar 2023 10:00:51 +0000
Date:   Tue, 14 Mar 2023 11:00:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Message-ID: <ZBBF0oHa0eArw9kb@dhcp22.suse.cz>
References: <20230313083452.1319968-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313083452.1319968-1-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-03-23 08:34:52, Yosry Ahmed wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
> observed a warning from page_cgroup_ino() when reading
> /proc/kpagecgroup. This warning was added to catch fragile reads of
> a page memcg. Make page_cgroup_ino() get memcg from compound_head(page):
> that gives it the correct memcg for each subpage of a compound page,
> so is the right fix.
> 
> I dithered between the right fix and the safer "fix": it's unlikely but
> conceivable that some userspace has learnt that /proc/kpagecgroup gives
> no memcg on tail pages, and compensates for that in some (racy) way: so
> continuing to give no memcg on tails, without warning, might be safer.
> 
> But hwpoison_filter_task(), the only other user of page_cgroup_ino(),
> persuaded me.  It looks as if it currently leaves out tail pages of the
> selected memcg, by mistake: whereas hwpoison_inject() uses compound_head()
> and expects the tails to be included.  So hwpoison testing coverage has
> probably been restricted by the wrong output from page_cgroup_ino() (if
> that memcg filter is used at all): in the short term, it might be safer
> not to enable wider coverage there, but long term we would regret that.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
> (Yosry: Alternatively, we could modify page_memcg_check() to do
>  page_folio() like its sibling page_memcg(), as page_cgroup_ino() is the
>  only remaining caller other than print_page_owner_memcg(); and it already
>  excludes pages that have page->memcg_data = 0)
> 
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..e3a55295725e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -395,7 +395,7 @@ ino_t page_cgroup_ino(struct page *page)
>  	unsigned long ino = 0;
>  
>  	rcu_read_lock();
> -	memcg = page_memcg_check(page);
> +	memcg = page_memcg_check(compound_head(page));
>  
>  	while (memcg && !(memcg->css.flags & CSS_ONLINE))
>  		memcg = parent_mem_cgroup(memcg);
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog

-- 
Michal Hocko
SUSE Labs
