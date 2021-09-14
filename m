Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF01640B081
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhINOYi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 10:24:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36372 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhINOYh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 10:24:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A5261FDFC;
        Tue, 14 Sep 2021 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631629398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPLjlxNiMy8SE7UjNTK8tngq7pn7HiFIBgi/dU4IiY4=;
        b=RHBOwzDGUJPzZPe5F1N+ijWFfwWf18Vb1viFqcFbzGn1pNyswLU9xhfJWkC3kfqxfT3cQK
        ASD9bWHOnAZDFsQpQ1ynhod/htXkglaRNsUdBxKpn7/nI/xk19+CoO4aINaWO4k22bBslH
        d1n25oTi+dd0w5BtyfqC7w+1HHmLwYM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BD9513B8A;
        Tue, 14 Sep 2021 14:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OaVTEVawQGGacAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Sep 2021 14:23:18 +0000
Date:   Tue, 14 Sep 2021 16:23:16 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH] ipc: remove memcg accounting for sops objects in
 do_semtimedop()
Message-ID: <20210914142316.GA23024@blackbody.suse.cz>
References: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
 <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
 <CALvZod7Y4pC4XvqVp+tJ==CnS5Ay8YPqrxeUzA8tMLu+0U3hjQ@mail.gmail.com>
 <YUBLrJOL6DGxmira@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUBLrJOL6DGxmira@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 14, 2021 at 09:13:48AM +0200, Michal Hocko <mhocko@suse.com> wrote:
> "
> This object can consume up to 2 pages, syscall is sleeping one,
> size and duration can be controlled by user, and this allocation
> can be repeated by many thread at the same time.
> "
> 
> It sounds like a problem, except it is not because? A worst case
> scenario evaluation would be beneficial for example

AFAICS, the offending allocation is in place only during the duration of
the syscall. So it's basically O(#tasks).
Considering at least 2 pages for task_struct + 2 pages for kernel stack,
back of the envelope calculation gives me the footprint amplification is
<1.5.
The factor would IMO be interesting if it was >> 2 (from the PoV of
excessive (ab)use, fine-grained accounting seems to be currently
unfeasible due to performance impact).

The commit message can be more explicit about this but to the patch
Reviewed-by: Michal Koutný <mkoutny@suse.com>
