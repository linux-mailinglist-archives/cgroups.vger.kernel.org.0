Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7463CFBC
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 08:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiK3Hd1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 02:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiK3Hd1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 02:33:27 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6335ADCC
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 23:33:24 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so10676292otl.7
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 23:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AgzOj8U3caSyuY1WKQWxWsXylIKB3XS8A98MNnMeTI=;
        b=lq99lhtWYhivFicKBQg0Prv5DJ+v/2lt7NSJFbq3rAUCzXgv+KNkTw/xhiyUZyKfqu
         uMf2C6OYW5swfdUEuSNfmToqqQCvapyvBEvoLa9I53Ndv6qYYJWQY1NpXdK/DMep/mGR
         7L8Hl0Jzaihv1Ny3msUYGt7QI5CzigbfwEtDso150EN9K4k5WTZ9i+5r39ViwHjdPomi
         1qHBXQNIab2fmYZH+82qfFqdeSinNLbxsAAnnMs/3YJ53sHZ4wwReZDqH1eYS1Phyuy+
         zs+pAc+bZtQT8h0FP0tZDi452jQmcPX/LjIw/UdtMpkH4O4GqO+i6KRtz8XtJ1Ob46e0
         h35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AgzOj8U3caSyuY1WKQWxWsXylIKB3XS8A98MNnMeTI=;
        b=kRTFbyRt/Cjna6WMKmRGQSiNylpU5+/K0qMzJ2C9GgnRk6pw3XU5iGFBZDLGh5eECL
         SJuUoRi/EMHY0N1sDGSFxM0OZFsC5C+2ImVvQm+REav1ajArMsguL6m5r/NpFsf+oYrc
         MVOA8JhwRKQ1q607FmMqKIdI2vs3iXh71UO8zQcGveryLysS+cR1eeg6yrhYmS7j4EII
         ekF6I3mkb4CXhfTLvr2J1R9dVopydWkD2f+F9lR7kcwjObCFRICNa2abRlYEUhhQ9V71
         9JvDHynNiwWJBRFFHY2K9fPvEA8jcj5rbcorlMl51ffszCo6ecg5lLP/Br0bwUINqK7L
         Odmw==
X-Gm-Message-State: ANoB5pm9symDRQk+f9MRk521NNaDl0tKTlxy8MInKZ93BPmJtFtQ7NVn
        L0k6Glqs+g7f3u6qxrzljwgzKA==
X-Google-Smtp-Source: AA0mqf7Ar78OhaEBLN7YckBESZzpsqFWLuBSeZKsK4PXb8O5CbfqMvcL19+oWPd9nNge0Q37MA+YaQ==
X-Received: by 2002:a9d:6294:0:b0:66c:5ad5:325e with SMTP id x20-20020a9d6294000000b0066c5ad5325emr21143324otk.116.1669793604101;
        Tue, 29 Nov 2022 23:33:24 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m1-20020a4ae3c1000000b004a002884426sm451137oov.18.2022.11.29.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 23:33:23 -0800 (PST)
Date:   Tue, 29 Nov 2022 23:33:14 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
In-Reply-To: <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
Message-ID: <3659bbe0-ccf2-7feb-5465-b287593aa421@google.com>
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com> <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 29 Nov 2022, Johannes Weiner wrote:
> On Mon, Nov 28, 2022 at 11:59:53AM -0500, Johannes Weiner wrote:
> > On Wed, Nov 23, 2022 at 10:03:00PM -0800, Hugh Dickins wrote:
> > The swapcache/pagecache bit was a brainfart. We acquire the folio lock
> > in move_account(), which would lock out concurrent faults. If it's not
> > mapped, I don't see how it could become mapped behind our backs. But
> > we do need to be prepared for it to be unmapped.
> 
> Welp, that doesn't protect us from the inverse, where the page is
> mapped elsewhere and the other ptes are going away. So this won't be
> enough, unfortunately.
> 
> > > Does that mean that we just have to reinstate the folio_mapped() checks
> > > in mm/memcontrol.c i.e. revert all mm/memcontrol.c changes from the
> > > commit?  Or does it invalidate the whole project to remove
> > > lock_page_memcg() from mm/rmap.c?
> 
> Short of further restricting the pages that can be moved, I don't see
> how we can get rid of the cgroup locks in rmap after all. :(
> 
> We can try limiting move candidates to present ptes. But maybe it's
> indeed time to deprecate the legacy charge moving altogether, and get
> rid of the entire complication.
> 
> Hugh, Shakeel, Michal, what do you think?

I'm certainly not against deprecating it - it's a largish body of odd
code, which poses signficant problems, yet is very seldom used; but I
feel that we'd all like to see it gone from rmap quicker that it can
be fully deprecated out of existence.

I do wonder if any user would notice, if we quietly removed its
operation on non-present ptes; certainly there *might* be users
relying on that behaviour, but I doubt that many would.

Alternatively (although I think Linus's objection to it in rmap is on
both aesthetic and performance grounds, and retaining any trace of it
in rmap.c still fails the aesthetic), can there be some static-keying
done, to eliminate (un)lock_page_memcg() overhead for all but those few
who actually indulge in moving memcg charge at immigrate?  (But I think
you would have already done that if it were possible.)

Hugh
