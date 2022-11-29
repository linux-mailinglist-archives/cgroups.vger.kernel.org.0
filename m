Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C7963C7CA
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 20:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiK2TIj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 14:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiK2TIi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 14:08:38 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E0E30556
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 11:08:36 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id c14so6420620qvq.0
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmXXccF6gcyyJcn8xYpOax7l00RlE3WtMYxosINrpmo=;
        b=1kG96GwDm4z4tl5X58tMTSiaw3DnpfdCF/rv7UlXbsY8+W8PnZuGywUo6KHIprE3/m
         C3/GaQpilxnGQceURvNXTO1ziGUJq4Vc2aq7zP10STkI1U+qpHo7fv8DPSjq5nmE6ZDr
         C650xqNqffQvPC+Elo1PQXQrtus8NaS/ki4zN58D+ZaxSNRC+Vtxehlx8iQIVmXaEnyn
         dXr1dJoOKIVqUhDcSoGHaKX3y65ZqZegji+EglMCsAv+k1m5HXwK3Hflzhq4HrxtID2A
         PruXnlCS3Ni2PLeN/PPbY1Pqv87aHsLGz+Av6nyMfMl+F8m8jTAKXsXDZ+jBt1Cs+Aaf
         UU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmXXccF6gcyyJcn8xYpOax7l00RlE3WtMYxosINrpmo=;
        b=ywNazNBWbHcmK72R1NgDV0ckyyI00+BfEG+5a/niTT9fCltjtH4LibJjcOfNll5QKq
         Fz7F0AJ/jzFkBDHmWl+vCktnmy5uRqWk/cPnU9LWpplgh9UxZyX4wA2gH1l5XCuuiYrs
         5BWV3ZsiA+nUhAXo1ef2vpCbmTSp0CfKWY5II+QECmj0aIeFBD0vQggCXvsmkjsxobBm
         ORV9Sd83nZBXQQYR/BKBLNDFSj4amBhFzYrpfhH471bAl7ADLa8OhqPTtORjEehsCBlS
         i4990nEDwlCDuhLjmT52YiFdwlosDViLkfUhC2GCmdsCP44TCDqK8ZTnaVjfqvGAEXr2
         zZpQ==
X-Gm-Message-State: ANoB5pmgGrehu+HUEZ2cgVUB4kyTWIWfAShhQru6djvPvu0POxNH+p90
        uaOIlN2jUDIRDjovg9bJqRiD6Q==
X-Google-Smtp-Source: AA0mqf7kOv2D0QHrH528Onq6INt8AdhEMV1yVr/SaOZ92ayirYrrlPL0UhZs4UZIEVoDmDOXy1GqwA==
X-Received: by 2002:a05:6214:3612:b0:4c6:e2b4:8c6c with SMTP id nv18-20020a056214361200b004c6e2b48c6cmr22819440qvb.13.1669748915997;
        Tue, 29 Nov 2022 11:08:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ea9a])
        by smtp.gmail.com with ESMTPSA id w23-20020ae9e517000000b006f9f3c0c63csm10841129qkf.32.2022.11.29.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:08:35 -0800 (PST)
Date:   Tue, 29 Nov 2022 14:08:34 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
Message-ID: <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
References: <20221123181838.1373440-1-hannes@cmpxchg.org>
 <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4TpCJ+5uCvWE6co@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 28, 2022 at 11:59:53AM -0500, Johannes Weiner wrote:
> On Wed, Nov 23, 2022 at 10:03:00PM -0800, Hugh Dickins wrote:
> The swapcache/pagecache bit was a brainfart. We acquire the folio lock
> in move_account(), which would lock out concurrent faults. If it's not
> mapped, I don't see how it could become mapped behind our backs. But
> we do need to be prepared for it to be unmapped.

Welp, that doesn't protect us from the inverse, where the page is
mapped elsewhere and the other ptes are going away. So this won't be
enough, unfortunately.

> > Does that mean that we just have to reinstate the folio_mapped() checks
> > in mm/memcontrol.c i.e. revert all mm/memcontrol.c changes from the
> > commit?  Or does it invalidate the whole project to remove
> > lock_page_memcg() from mm/rmap.c?

Short of further restricting the pages that can be moved, I don't see
how we can get rid of the cgroup locks in rmap after all. :(

We can try limiting move candidates to present ptes. But maybe it's
indeed time to deprecate the legacy charge moving altogether, and get
rid of the entire complication.

Hugh, Shakeel, Michal, what do you think?
