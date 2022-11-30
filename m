Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8263E376
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 23:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiK3W3b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 17:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiK3W3b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 17:29:31 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FD1880C4
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 14:29:29 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z1so13430285qkl.9
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 14:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YE7jXxz564+ij1F7ID7Smaf8XdVIpgEM18wsOYbg3aI=;
        b=m4nPay6NFvD+wrygzHoAAEj6bi16gjB6pd//RmTxx/BSfRxwShWVVNlw2v++ANe9sC
         IfryetzxwhkZR4y+YcM+nho/ywaN12FyGbqz00aSeE69Sm94NnBMjbg+iSGXMmd/i6B9
         +PA2NPIgAWqWYUcNRsnA9K7ZNvIBJzU7jjWh1cS7HlyHHGKBA91lnGA0Jjro5TDAjbTy
         DWXahcLLhg2Rh+MyDQ67llbSkztb1Gvq9AXWdjovY2IYRqGtWG38x5CDLtPgw2LHWRPx
         chO/8kccdpcFYRKhW97nNYycTog1y1uUq4x9LPJ5ol8ZdyP5TM4ABChtFHbMVgrG293S
         /SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE7jXxz564+ij1F7ID7Smaf8XdVIpgEM18wsOYbg3aI=;
        b=lnoz3azdS+Zm0rB8Vbr1iMMawXOAda+e2tNT8wLPfHPpa5y8XKhIclHifycSG8dwWK
         YpG1IXC9+uFhscSS8+mpmQOgnuO7QWJukyEfDPQ+ZWRtF9lazG0FCNvTWUTRUyoF1mdJ
         c/6x4ZtnwLst1IBsPooZhHnpxhJ/+BKtP8RupSDsB/2ZSh/YKI2Miao7lPUy30B08/BZ
         R1atRSWBQfp1vtXEYgSX30UEvM9FUN7KYc1cnl2YSMYFLROJlz/B+G4GwF/ia1tyNp39
         +SkePyErKhaTqjq5Uv2MoQGNX6x2O0n7kVO/6YMJby4sPOqGNCPgEqkfsAMjiFr5WfWL
         LAqw==
X-Gm-Message-State: ANoB5pnTDIMLMf7yQ4/Sdt8gx5Ov+1tQLsnAMmgZH/7L9zZnl5HGtq7R
        PWbcVZbwLVzwvoLOl75S6zOuY6T9Lu5dvg==
X-Google-Smtp-Source: AA0mqf48/BylUaxIj4WH2dz8ry96OogTB1MtBq+CkHBcaLTJBXHoRydAVkZXv1VOBCNu+Y0AeP0qNQ==
X-Received: by 2002:a05:620a:2f2:b0:6f9:9833:1e21 with SMTP id a18-20020a05620a02f200b006f998331e21mr56039127qko.715.1669847368847;
        Wed, 30 Nov 2022 14:29:28 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-3663-3884-f85a-44bb.res6.spectrum.com. [2603:7000:c01:2716:3663:3884:f85a:44bb])
        by smtp.gmail.com with ESMTPSA id j10-20020ac806ca000000b003a4f22c6507sm1519610qth.48.2022.11.30.14.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 14:29:28 -0800 (PST)
Date:   Wed, 30 Nov 2022 17:30:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
Message-ID: <Y4fZbFNVckh1g4WO@cmpxchg.org>
References: <20221123181838.1373440-1-hannes@cmpxchg.org>
 <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org>
 <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
 <3659bbe0-ccf2-7feb-5465-b287593aa421@google.com>
 <CALvZod7_FjO-CjzHUpQTsCTm4-68a1eKi_qY=4XdF+g7yMLd4Q@mail.gmail.com>
 <e0918c92-90cd-e3ed-f4e6-92d02062c252@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0918c92-90cd-e3ed-f4e6-92d02062c252@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:36:15AM -0800, Hugh Dickins wrote:
> On Wed, 30 Nov 2022, Shakeel Butt wrote:
> > 
> > 2. For 6.2 (or 6.3), remove the non-present pte migration with some
> > additional text in the warning and do the rmap cleanup.
> 
> I just had an idea for softening the impact of that change: a moment's
> more thought may prove it's a terrible idea, but right now I like it.
> 
> What if we keep the non-present pte migration throughout the deprecation
> period, but with a change to the where the folio_trylock() is done, and
> a refusal to move the charge on the page of a non-present pte, if that
> page/folio is currently mapped anywhere else - the folio lock preventing
> it from then becoming mapped while in mem_cgroup_move_account().

I would like that better too. Charge moving has always been lossy
(because of trylocking the page, and having to isolate it), but
categorically leaving private swap pages behind seems like a bit much
to sneak in quietly.

> There's an argument that that's a better implementation anyway: that
> we should not interfere with others' pages; but perhaps it would turn
> out to be unimplementable, or would make for less predictable behaviour.

Hm, I think the below should work for swap pages. Do you see anything
obviously wrong with it, or scenarios I haven't considered?

@@ -5637,6 +5645,46 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
         * we call find_get_page() with swapper_space directly.
         */
        page = find_get_page(swap_address_space(ent), swp_offset(ent));
+
+       /*
+        * Don't move shared charges. This isn't just for saner move
+        * semantics, it also ensures that page_mapped() is stable for
+        * the accounting in mem_cgroup_mapcount().
+        *
+        * We have to serialize against the following paths: fork
+        * (which may copy a page map or a swap pte), fault (which may
+        * change a swap pte into a page map), unmap (which may cause
+        * a page map or a swap pte to disappear), and reclaim (which
+        * may change a page map into a swap pte).
+        *
+        * - Without swapcache, we only want to move the charge if
+        *   there are no other swap ptes. With the pte lock, the
+        *   swapcount is stable against all of the above scenarios
+        *   when it's 1 (our pte), which is the case we care about.
+        *
+        * - When there is a page in swapcache, we only want to move
+        *   charges when neither the page nor the swap entry are
+        *   mapped elsewhere. The pte lock prevents our pte from
+        *   being forked or unmapped. The page lock will stop faults
+        *   against, and reclaim of, the swapcache page. So if the
+        *   page isn't mapped, and the swap count is 1 (our pte), the
+        *   test results are stable and the charge is exclusive.
+        */
+       if (!page && __swap_count(ent) != 1)
+               return NULL;
+
+       if (page) {
+               if (!trylock_page(page)) {
+                       put_page(page);
+                       return NULL;
+               }
+               if (page_mapped(page) || __swap_count(ent) != 1) {
+                       unlock_page(page);
+                       put_page(page);
+                       return NULL;
+               }
+       }
+
        entry->val = ent.val;
 
        return page;
