Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5916465F4
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 01:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHAgx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 19:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLHAgw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 19:36:52 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4E08D67A
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 16:36:51 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3b10392c064so204889327b3.0
        for <cgroups@vger.kernel.org>; Wed, 07 Dec 2022 16:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qeBXIqzSfIuH6SAUQWNL+jPx2S1sL9td+8nqZ4xaU5o=;
        b=i8izx+NjrAcYy4Azi2gqPWXEKbDGdCxrPDPu+ynSN5Bk59ImL6T95Oo1WQs/o3O4Dv
         psw4F81s8kACsalYuCfa3YKVBUaWdt1dN1dLAoYO2bURSF/UvH71sAocuPgjbCHFDXAM
         /BfpE2un7nJiG6xpMzVfPOtcBBwkYXRlKNKXsR8yKpQI5Y5Asgu0Pbzs6N11XFobKotf
         IkSSSNBiGAgpC/2Dnet7amfL8e3kbgaIJuFInroYam92GkAtxrLFF98Ng380oqEdtEKn
         aDEn6p51I0QgovKxUPDyJugKpODyKOUt14FWakO7ddAbM+U7UBLTPVLiByTMRh8LYTJs
         2hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeBXIqzSfIuH6SAUQWNL+jPx2S1sL9td+8nqZ4xaU5o=;
        b=LuL823imMhBrGOKYyWkdynBo9KoVFQ3W4auLLwIwcXnw4K1HptqkHC9jgbqicAuCJQ
         /c8w0G/Ps4sTvltp+xLEwjtOh4vIHdigAx81WOcVJ42O59Mywnv8ilxTYHwCwLnFhrfb
         m6qlboe3/VxYj33aQDmdZT1g04e/c+EXZ24iemOh94KpvRVUobHQ3y2LcBKzlru5XB9L
         8ciw4Pg/k7ZZfbKSusK1XUBLROOppwmzMm2LKB3NffASGZzyTUBqP4xtPYjWYNmqE/PR
         VqOUH+dtHH185dqqsLiwllE+DG5fVb20Osw+N9JNeJweq9ODo2xMnIAmM41JJ5Bt+9Uo
         dBtg==
X-Gm-Message-State: ANoB5pklcs/gz0wcxjnqlbIeUXyh9O53F/wRbqHB1LnMsTKBn/jgCYH3
        /MSJAy6l3RufCpTXbxyFru3jTIQt+cUOBRRScIKbdQ==
X-Google-Smtp-Source: AA0mqf7PFHyJxnhF8UTAf6SKwPztX0jqaTFvncPAyztKcb/I1POSkrTKztXHbKBwNImmsTxtr74ZufQdHvhbUfFc0uI=
X-Received: by 2002:a0d:f645:0:b0:3ba:76ae:dade with SMTP id
 g66-20020a0df645000000b003ba76aedademr56402285ywf.93.1670459810480; Wed, 07
 Dec 2022 16:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20221206171340.139790-1-hannes@cmpxchg.org> <20221206171340.139790-3-hannes@cmpxchg.org>
In-Reply-To: <20221206171340.139790-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Dec 2022 16:36:39 -0800
Message-ID: <CALvZod7jy0gvXRHhsJ2aaj+rP=3if5c4+p+-kC-qo3WSU+tRqQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: rmap: remove lock_page_memcg()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 6, 2022 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The previous patch made sure charge moving only touches pages for
> which page_mapped() is stable. lock_page_memcg() is no longer needed.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
