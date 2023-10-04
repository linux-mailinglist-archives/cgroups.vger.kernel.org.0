Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713567B7AF8
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbjJDJCS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJDJCR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 05:02:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2DCA6;
        Wed,  4 Oct 2023 02:02:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EC6821845;
        Wed,  4 Oct 2023 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696410133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fknh9pTwUeNKMs0LwnDupSYiQbG9mDB9y4OA1iLV+0=;
        b=tBwWk0kxxXHNsUHhG94DTvVeKkk9ha3EVwnEwDaUmOnwerKy83pzDptPvxHpBTPIx0S+I0
        Wy4iTgY0F1eLpdhYgs11fOK9T1+SPm3NsL6Kn2BxxCAD57VHZcgCrPIh2MlfwmnDODpR1m
        HI/lWm22+g4ED1aR2FZDZnUcf/efX4I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D940C139F9;
        Wed,  4 Oct 2023 09:02:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zCY1NBQqHWVPNQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 Oct 2023 09:02:12 +0000
Date:   Wed, 4 Oct 2023 11:02:11 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
Message-ID: <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com>
 <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
 <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrmj7bntvvlwev3j"
Content-Disposition: inline
In-Reply-To: <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--jrmj7bntvvlwev3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 03, 2023 at 12:47:25PM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> Those constants are shared with code outside of memcg, namely enum
> node_stat_item and enum vm_event_item, and IIUC they are used
> differently outside of memcg. Did I miss something?

The difference is not big, e.g.
  mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
could be
  __count_memcg_events(
    container_of(lruvec, struct mem_cgroup_per_node, lruvec)->memcg,
    WORKINGSET_ACTIVATE_BASE + type, delta
  );

Yes, it would mean transferring WORKINGSET_* items from enum
node_stat_item to enum vm_event_item.
IOW, I don't know what is the effective difference between
mod_memcg_lruvec_state() and count_memcg_events().
Is it per-memcg vs per-memcg-per-node resolution?
(Is _that_ read by workingset mechanism?)

Thanks,
Michal

--jrmj7bntvvlwev3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZR0qEAAKCRAGvrMr/1gc
jslxAQCM0oIUUE2njzgV3hSlbhBKS89fDJ5yV5qkor2tfY81OQEA21DKpM1O90/m
0H9Byin50ep97S6iK3v4kyckR54LzQ0=
=TnaG
-----END PGP SIGNATURE-----

--jrmj7bntvvlwev3j--
