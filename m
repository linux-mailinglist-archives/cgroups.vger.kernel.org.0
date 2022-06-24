Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8AA5599A3
	for <lists+cgroups@lfdr.de>; Fri, 24 Jun 2022 14:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiFXM0P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jun 2022 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFXM0O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jun 2022 08:26:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AAB47541;
        Fri, 24 Jun 2022 05:26:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCD8A1F8BE;
        Fri, 24 Jun 2022 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656073571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3cWh7Nkfv7QaM5e4ajRtU4xW3swpukjf7WrfRWPE6E=;
        b=mrYLsPoEEQjRnhUtwsgNCoXCtrKNyvFVbXRqAwPxnnjWRxGMXjfszLzHbhAFKwx+uBW8CZ
        yuxjkWUMBCdNt+cgyQoLNqirpOBMsxu9PydMYcuN5QwltNVl12wnAOqK/fInVpSJGV7Mty
        XPJvhw0hfSqQTdSlEe9+UkTfFT9IMi4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7309213ACA;
        Fri, 24 Jun 2022 12:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 197MGWOttWKZYgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Jun 2022 12:26:11 +0000
Date:   Fri, 24 Jun 2022 14:26:10 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        kernel@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Message-ID: <20220624122610.GG16004@blackbody.suse.cz>
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
 <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
 <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
 <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
 <0f8146e3-5865-b7e6-6728-5baada375cf2@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <0f8146e3-5865-b7e6-6728-5baada375cf2@openvz.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 24, 2022 at 01:40:14PM +0300, Vasily Averin <vvs@openvz.org> wrote:
> Btw could you please explain why memory cgroups have MEM_CGROUP_ID_MAX limit
> Why it is required at all and why it was set to USHRT_MAX? I believe that
> in the future it may be really reachable:

IIRC, one reason is 2B * nr_swap_pages of memory overhead (in
swap_cgroup_swapon()) that's ~0.05% of swap space occupied additionally
in RAM (fortunately swap needn't cover whole RAM).

HTH,
Michal

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYrWtXgAKCRAkDQmsBEOq
uTryAQCHh6ZZYDD+j5lciUOhDxLFMQ15T9S7Ty/OmIhNzCcXwwD/YhFGF7ylqaSv
BYyT9akQtqnK5O1l1tmp4Hp0oIkmMAs=
=mx99
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
