Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4B42C83B
	for <lists+cgroups@lfdr.de>; Wed, 13 Oct 2021 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJMSD2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 14:03:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSD2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 14:03:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9520E219C7;
        Wed, 13 Oct 2021 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634148083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NE66Dj/QGO/V+dUIB7Cr5kb37zCYA6r5tio5RjzNII=;
        b=B5V05/9o7Qyc+X/mDJCKHrJHU6FQg67zI22a1OGNF5iATFfW4V+ZU+C3WOUGmUajfs4qXT
        b99ySrjT5mzdxKSCuG0VXQ051wZ81Y+pAXYTdRsnw0QOlXMlLv1cVG9822BZobjv//KMc6
        y/fzTXdhw/CXtYD2grraAEdVjDxI85s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BE8813D10;
        Wed, 13 Oct 2021 18:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PX2IHfMeZ2G2PQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 13 Oct 2021 18:01:23 +0000
Date:   Wed, 13 Oct 2021 20:01:22 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] memcg: unify memcg stat flushing
Message-ID: <20211013180122.GA1007@blackbody.suse.cz>
References: <20211001190040.48086-1-shakeelb@google.com>
 <20211001190040.48086-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001190040.48086-2-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Shakeel.

(Sorry for taking so long getting down to this.)

On Fri, Oct 01, 2021 at 12:00:40PM -0700, Shakeel Butt <shakeelb@google.com> wrote:
> There is no need for that.  We just need one flusher and everyone else
> can benefit.

I imagine a cgroup with an intricate deep hiearchy with many updates and
a separate (simpler) sibling/independent cgroup that would need to pay
the costs of the first hierarchy updates [1] when it asks just for its
own stats (bound by the amount that's leftover from the periodic
updates).

The stats files (or wb stats) are likely not that time sensitive and the
reclaim (that can be local only but is slow path anyway) already uses
the global flushing.

I wonder whether the bigger benefit would be to retain the global
stats_flush_threshold counter but flush only local subtree.

Thanks,
Michal

[1] At first I thought non-memcg updates would interfere too via rstat
tree but I see it's actually filtered with the stats_flush_threshold so
only foreign memcg updates are relevant.
