Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCE63E651
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 01:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLAARQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 19:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiLAAQ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 19:16:58 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9CE8EE7D
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 16:13:37 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d8so65032qki.13
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 16:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHV8O4q/YJYqi3y8OK2heA1MTuVYBE9Z71+HHXjgjL4=;
        b=IdVVPMRbeJD3ERLIYatf7Qhl7gSloz9FAjQA5VPxurI7mOMGOlRe1SmMkxP8nXen+h
         ctCSsHsndDMVyouwDaQm0v7TXfHq0aby4aifQ/E+OXRoPNWWRgh40xnSMefoKPKxsmiQ
         ZtIHvUylWyyCoco0II+oxM9XH6gfMt1tybat6VJivkyIA44CQk1UoG15QByOzCWQKUUR
         2w4ENrKjCgXgpRcCgsQFoYOFzLSHwZSBMSIxZC5+Qjkn+HaH+uJfn1bOX7w8JWghI2MW
         3oH9d2vIdfEElOxXDK/quYJ7tUiZOVe1aS7CsaLh9UpRs/BE+dX7qVyUmLRqtQSSj0EE
         N5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHV8O4q/YJYqi3y8OK2heA1MTuVYBE9Z71+HHXjgjL4=;
        b=HyzTSWIGuSt8IHJOR6FoR7wHz/3TOz/NOLgWC5dA1k+BaBfIoccO15wwv3GqMkS7Oi
         Jmaj/7PHXptNgqhuil7I8aiLQbctLC5KKOn5Y3FpXCR0ydr7f+r3LJINjMmKBcZ1KaM5
         UeZwOWDn+ol3EldedgEIpIPobHQp3Bz5ejB4U1dPGvGyACJ5DofaYMLf4Tj0etwCDn9c
         m5TpZ825Ng0qLRYxnScTgHzuA1ZgoI2wsNPknXHt2dMN/i43adxIumVUmBgjZC2rE3hn
         WsAfBTkr4UYvWipy2UNn1h0q70PBB4coRGh1xTniRkaj3DpvQHT0yFAvYGAQOZWCLKQE
         CfqA==
X-Gm-Message-State: ANoB5plwwKOyy9iaf4vTT/dfE8YXMTBEC3WVwAW2R7BBsN76kttyLfKi
        ohlEXUcwbe2Ztv0PQPkvF3fkOQ==
X-Google-Smtp-Source: AA0mqf6TePEUGMD3StSeLumfJ10Eo16EklOUBHLtB4+ZnlRfBXSytT3eYYPo1hFoETQOHA+hUimEow==
X-Received: by 2002:a37:34f:0:b0:6fc:a68e:43ec with SMTP id 76-20020a37034f000000b006fca68e43ecmr185704qkd.436.1669853616057;
        Wed, 30 Nov 2022 16:13:36 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a0bcc00b006ee7e223bb8sm2328277qki.39.2022.11.30.16.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 16:13:35 -0800 (PST)
Date:   Wed, 30 Nov 2022 16:13:23 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
In-Reply-To: <Y4fZbFNVckh1g4WO@cmpxchg.org>
Message-ID: <33f2f836-98a0-b593-1d43-b289d645db5@google.com>
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com> <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org> <3659bbe0-ccf2-7feb-5465-b287593aa421@google.com> <CALvZod7_FjO-CjzHUpQTsCTm4-68a1eKi_qY=4XdF+g7yMLd4Q@mail.gmail.com>
 <e0918c92-90cd-e3ed-f4e6-92d02062c252@google.com> <Y4fZbFNVckh1g4WO@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 30 Nov 2022, Johannes Weiner wrote:
> 
> Hm, I think the below should work for swap pages. Do you see anything
> obviously wrong with it, or scenarios I haven't considered?
> 

I think you're overcomplicating it, with the __swap_count(ent) business,
and consequent unnecessarily detailed comments on the serialization.

Page/folio lock prevents a !page_mapped(page) becoming a page_mapped(page),
whether it's in swap cache or in file cache; it does not stop the sharing
count going further up, or down even to 0, but we just don't need to worry
about that sharing count - the MC_TARGET_PAGE case does not reject pages
with mapcount > 1, so why complicate the swap or file case in that way?

(Yes, it can be argued that all such sharing should be rejected; but we
didn't come here to argue improvements to memcg charge moving semantics:
just to minimize its effect on rmap, before it is fully deprecated.)

Or am I missing the point of why you add that complication?

> @@ -5637,6 +5645,46 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,

Don't forget to trylock the page in the device_private case before this.

>          * we call find_get_page() with swapper_space directly.
>          */
>         page = find_get_page(swap_address_space(ent), swp_offset(ent));
> +
> +       /*
> +        * Don't move shared charges. This isn't just for saner move
> +        * semantics, it also ensures that page_mapped() is stable for
> +        * the accounting in mem_cgroup_mapcount().

mem_cgroup_mapcount()??

> +        *
> +        * We have to serialize against the following paths: fork
> +        * (which may copy a page map or a swap pte), fault (which may
> +        * change a swap pte into a page map), unmap (which may cause
> +        * a page map or a swap pte to disappear), and reclaim (which
> +        * may change a page map into a swap pte).
> +        *
> +        * - Without swapcache, we only want to move the charge if
> +        *   there are no other swap ptes. With the pte lock, the
> +        *   swapcount is stable against all of the above scenarios
> +        *   when it's 1 (our pte), which is the case we care about.
> +        *
> +        * - When there is a page in swapcache, we only want to move
> +        *   charges when neither the page nor the swap entry are
> +        *   mapped elsewhere. The pte lock prevents our pte from
> +        *   being forked or unmapped. The page lock will stop faults
> +        *   against, and reclaim of, the swapcache page. So if the
> +        *   page isn't mapped, and the swap count is 1 (our pte), the
> +        *   test results are stable and the charge is exclusive.
> +        */
> +       if (!page && __swap_count(ent) != 1)
> +               return NULL;
> +
> +       if (page) {
> +               if (!trylock_page(page)) {
> +                       put_page(page);
> +                       return NULL;
> +               }
> +               if (page_mapped(page) || __swap_count(ent) != 1) {
> +                       unlock_page(page);
> +                       put_page(page);
> +                       return NULL;
> +               }
> +       }
> +
>         entry->val = ent.val;
>  
>         return page;

Looks right, without the __swap_count() additions and swap count comments.

And similar code in mc_handle_file_pte() - or are you saying that only
swap should be handled this way?  I would disagree.

And matching trylock in mc_handle_present_pte() (and get_mctgt_type_thp()),
instead of in mem_cgroup_move_account().

I haven't checked to see where the page then needs to be unlocked,
probably some new places.

And I don't know what will be best for the preliminary precharge pass:
doesn't really want the page lock at all, but it may be unnecessary
complication to avoid taking it then unlocking it in that pass.

Hugh
