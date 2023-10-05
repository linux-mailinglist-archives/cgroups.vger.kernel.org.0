Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C147BA6E6
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 18:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJEQnS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjJEQlg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 12:41:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A1B6700;
        Thu,  5 Oct 2023 09:30:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17A2A21891;
        Thu,  5 Oct 2023 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696523427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sL+tYRULSD7EToNAPlVDPfOq2xfKv5cMBZyMAxFpTd0=;
        b=UZZ53f4TXC5JQzxPTJ9sLJfQTWS3CHG7J8bELDoeC52FohqWngE6Go84OsbBcs18zx/tPg
        e5M/41FvvX8womtQdSKsxYi0bFAdB/t+eq3mRTBA07sUbO1T5qNkdIjQGpAjIo6t2LCVYz
        Oj/tDV+FGnqaWVHlB5JZXOiyCNYR0TM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB069139C2;
        Thu,  5 Oct 2023 16:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rTedNKLkHmU4dQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 Oct 2023 16:30:26 +0000
Date:   Thu, 5 Oct 2023 18:30:25 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
Message-ID: <4h5uae72ti6jyiibcyfg2bytooy6d6ggtkrgod5a6rmpateyra@4setu5jmd5kn>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com>
 <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
 <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
 <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
 <20231004183619.GB39112@cmpxchg.org>
 <542ggmgjc27yoosxg466c6n4mzcad2z63t3wdbzevzm43g7xlt@5l7qaepzbth6>
 <CAJD7tkbaTRu838U=e_A+89PY1t4K+t_G1qkYq84BSDO7wAEtEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpu3njifk2lp5cu6"
Content-Disposition: inline
In-Reply-To: <CAJD7tkbaTRu838U=e_A+89PY1t4K+t_G1qkYq84BSDO7wAEtEg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--tpu3njifk2lp5cu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 05, 2023 at 02:31:03AM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> I am not really sure what you mean here.

My "vision" is to treat WORKINGSET_ entries as events.
That would mean implementing per-node tracking for vm_event_item
(costlier?).
That would mean node_stat_item and vm_event_item being effectively
equal, so they could be merged in one.
That would be situation to come up with new classification based on use
cases (e.g. precision/timeliness requirements, state vs change
semantics).

(Do not take this as blocker of the patch 1/2, I rather used the
opportunity to discuss a greater possible cleanup.)

> We don't track things like OOM_KILL and DROP_PAGECACHE per memcg as
> far as I can tell.

Ah, good. (I forgot only subset of entries is relevant for memcgs.)

> This will mean that WORKINGSET_* state will become more stale. We will
> need 4096 as many updates as today to get a flush. These are used by
> internal flushers (reclaim), and are exposed to userspace. I am not
> sure we want to do that.

snapshot_refaults() doesn't seem to follow after flush
and
workigset_refault()'s flush doesn't seem to preceed readers

Is the flush misplaced or have I overlooked something?
(If the former, it seems to work good enough even with the current
flushing heuristics :-))


Michal

--tpu3njifk2lp5cu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZR7knwAKCRAGvrMr/1gc
jmuCAQDLOZF2u7hvOxa6XliRfkYY1Be/D0QEHOZynh1+OxsDKQD/aGTjJFAWvb5D
qEcqxkg0fd9+iYdI1PSQdU3ICEFERAs=
=t1Ez
-----END PGP SIGNATURE-----

--tpu3njifk2lp5cu6--
