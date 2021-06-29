Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B702E3B7098
	for <lists+cgroups@lfdr.de>; Tue, 29 Jun 2021 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhF2K2v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Jun 2021 06:28:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60660 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhF2K2v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Jun 2021 06:28:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F0B9203CD;
        Tue, 29 Jun 2021 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624962382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4nnJd/WQSpUTtWERcTYMKjk7Xm3bTS7VSG5SjPdv9Bc=;
        b=SIOiyfS7XfAvoPmQiyHYe5i2CqhxV09toMQQiEzN+oosnPqqz8XsULnowsgVFUZwJqTTwP
        GUzX0vNQaS1ETRJIiLWMUmwhOELlrPWsRhQL2Zvfmw1QaOY5z3ckCm/xaKpIfv9AaWwOgM
        LUKvYk0acBAFboy9Nt9XSeD/pPvh0Qk=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5572711906;
        Tue, 29 Jun 2021 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624962382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4nnJd/WQSpUTtWERcTYMKjk7Xm3bTS7VSG5SjPdv9Bc=;
        b=SIOiyfS7XfAvoPmQiyHYe5i2CqhxV09toMQQiEzN+oosnPqqz8XsULnowsgVFUZwJqTTwP
        GUzX0vNQaS1ETRJIiLWMUmwhOELlrPWsRhQL2Zvfmw1QaOY5z3ckCm/xaKpIfv9AaWwOgM
        LUKvYk0acBAFboy9Nt9XSeD/pPvh0Qk=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id G6qnE0712mDMAwAALh3uQQ
        (envelope-from <mkoutny@suse.com>); Tue, 29 Jun 2021 10:26:22 +0000
Date:   Tue, 29 Jun 2021 12:26:21 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <YNr1TYfBwR/tEpEJ@blackbook>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
 <20210610173944.1203706-4-schatzberg.dan@gmail.com>
 <YNXvr81YFzbaTxCb@blackbook>
 <YNnZ7hIRIk9dJDry@dschatzberg-fedora-PC0Y6AEN>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8xak29pAuRs/xS4S"
Content-Disposition: inline
In-Reply-To: <YNnZ7hIRIk9dJDry@dschatzberg-fedora-PC0Y6AEN>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--8xak29pAuRs/xS4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 28, 2021 at 10:17:18AM -0400, Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> Agreed that exporting int_active_memcg is an implementation detail,
> but would this prevent set_active_memcg from being inlined?

Non-inlining in the loop module doesn't seem like a big trouble. OTOH,
other callers may be more sensitive and would need to rely on inlining.
I can't currently think of a nice way to have both the exported and the
exlicitly inlined variant at once. It seems it's either API or perf
craft in the end but both are uncertain, so I guess the current approach
is fine in the end.

> Yes it is intentional. All requests (not just aio) go through the loop
> worker which grabs the blkcg reference in loop_queue_work() on
> construction. So I believe grabbing a reference per request is
> unnecessary.

Isn't there a window without the reference between loop_queue_rq and
loop_queue_work? I don't know, you seem to know better, so I'd suggest
dropping a comment line into the code explaining this.

Thanks,
Michal

--8xak29pAuRs/xS4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmDa9UkACgkQia1+riC5
qShOvQ/+IAbayEL5mDzde7avlf2IctIAGpgzfJMiT0f2HjZlZvc+wZyRZtbY48+f
qQvyKrqzoa8urrykaJOPImzej1n5/+LPnxg/EdPXMLf3GP69aeRWx/UFSkiPpCeJ
jw5r2FbQE29yfQYAtuHbL6IPnfa1JDkQXroHwN+MIsNqayGiz2FbE4fxPJxR8hkt
xCYjCyNMzBEw1b334gUvj8XrFRbzfgIJokZ3UNVIrRcv/rbYKs4LplelQ5dGEjpp
uzFAC5QDabn78+SJ6c7h5ReTx4zdPC+9A3FlZXBWxkpSPiPEPO6b0Qdo86p4v4eA
MGT8fNcfyvjQZdzckZ1oHylUCBbDhCIons6PmEqpEDd5ZFA5taD9G6YRGyH1G7Kb
EieXPoCynJWRCdHat3PeqTpnf9oYPsaiBXozn2UXdK2Rvv2+g9A5am/AKN+I2Y+J
xgzp9FPA5nRx5Z8oIAl9iqvb8mfrlYPn0CsNnzo+eHE13Zh7nxlFQrrqJsnjaQ2J
45wPm24rg9XrKoTIpLs0O1INWqNjkweqPRLs5I/ClXRWkqXkfJ5cUchEjsLqksVJ
SunkIX+LxIWE/Fb23d2jio51pC26W4gcAtOTTe6MZ/Iqq7LI7cpKX9bGW1dkrKgB
nWkJth7TDCL8bIeOjDMMsNVW05el1qQcPei4GZ4sfBjJu6FlikM=
=q9SM
-----END PGP SIGNATURE-----

--8xak29pAuRs/xS4S--
