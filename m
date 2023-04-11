Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32B46DDF02
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjDKPJW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjDKPJP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 11:09:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED54C38;
        Tue, 11 Apr 2023 08:09:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6B31FD76;
        Tue, 11 Apr 2023 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681225739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3tjzrn9vgH+epgdD39dTRsPzv4bId3KCAVUvytIiC0=;
        b=dADxETCkidHbUpn4IIj2ICcPpxGDuHfrP1gXYRRsuLhYsQn0UbF6NbrWWLvT/GogGsLdCz
        W7K+vzc+gH1JJ8ijeimOIV2lWQUJf521g9BxSR7iztTsrCUCzEWDS3QL9Sj6XvKHaPRI+x
        Y3khDEDd5T3Z18BbBWw7pXFl/map7EE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C49F513638;
        Tue, 11 Apr 2023 15:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3rWbLgp4NWRVcgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 11 Apr 2023 15:08:58 +0000
Date:   Tue, 11 Apr 2023 17:08:57 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: oom: introduce cpuset oom
Message-ID: <wmy3re5x2olokij77xfleomlydc7p2zczas6dagtawrl2mvh5a@d3ipt4hgqgr2>
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
 <3myr57cw3qepul7igpifypxx4xd2buo2y453xlqhdw4xgjokc4@vi3odjfo3ahc>
 <aa3382b4-4046-988f-42ea-8812dba7882b@bytedance.com>
 <ZDVcwuiu3rWEFiTE@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5w72e4ixd2yvjwyd"
Content-Disposition: inline
In-Reply-To: <ZDVcwuiu3rWEFiTE@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--5w72e4ixd2yvjwyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 03:12:34PM +0200, Michal Hocko <mhocko@suse.com> wr=
ote:
> > Oh I see, you mean scanning all processes in all cpusets and scanning
> > all processes globally are equivalent.
>=20
> Why cannot you simple select a process from the cpuset the allocating
> process belongs to? I thought the whole idea was to handle well
> partitioned workloads.

Ah, I was confused by the top_cpuset implementation.

The iteration should then start in
	nearest_hardwall_ancestor(task_cs(current)).
(in the 1st approximation).

The nodes_intersect/nodes_subset/nodes_equal/whatnot heuristics is
secondary.

HTH,
Michal

--5w72e4ixd2yvjwyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZDV4BQAKCRAkDQmsBEOq
uWmbAP92Dw9zEkV1uoIFp/40jhHF8QWoTOvy5Wn27+Nam1QPeQD9Hd2xoA9doDrd
EPYy/DQpuuQ7H3ogRM84kLZtmuSC2Aw=
=MJ50
-----END PGP SIGNATURE-----

--5w72e4ixd2yvjwyd--
