Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3793F4E06
	for <lists+cgroups@lfdr.de>; Mon, 23 Aug 2021 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhHWQKS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Aug 2021 12:10:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41470 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQKO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Aug 2021 12:10:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF3AF1FFCA;
        Mon, 23 Aug 2021 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629734970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4eFiPUzslOJAtwIAy5T1boXHUjZS+B3BFncyco1H9t0=;
        b=NquIf+8HHYFommojg9qouyGn7kgUzV1xmNACFJshhh9se3FdrIE5O4RaqMolDjBC5qJXP+
        RdQ/9+JCgPxmJgZPlLeOLSnW5XB1Au8FPrJdcsY8lpb+3zyuNQQ2LIHB36CbjdSeGkwG8F
        6qgCzo2IBMVEZ4s1MHEi8GO28hWMb9k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9577E13BE6;
        Mon, 23 Aug 2021 16:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G048IzrII2HvUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 23 Aug 2021 16:09:30 +0000
Date:   Mon, 23 Aug 2021 18:09:29 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YSPIOZOVG2qplLIW@blackbook>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817180506.220056-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello

(and sorry for a belated reply).

On Tue, Aug 17, 2021 at 02:05:06PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> @@ -2576,6 +2578,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> [...]
> +			/* memory.low scaling, make sure we retry before OOM */
> +			if (!sc->memcg_low_reclaim && low > min) {
> +				protection = low;
> +				sc->memcg_low_skipped = 1;

IIUC, this won't result in memory.events:low increment although the
effect is similar (breaching (partial) memory.low protection) and signal
to the user is comparable (overcommited memory.low).

Admittedly, this patch's behavior adheres to the current documentation
(Documentation/admin-guide/cgroup-v2.rst):

> The number of times the cgroup is reclaimed due to high memory
> pressure even though its usage is under the low boundary,

however, that definition might not be what the useful indicator would
be now.
Is it worth including these partial breaches into memory.events:low?

Regards,
Michal
