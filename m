Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0A784172
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbjHVNBG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjHVNBG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 09:01:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D75CC7;
        Tue, 22 Aug 2023 06:01:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F13022C28;
        Tue, 22 Aug 2023 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692709263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPC9oXTPWIOvWWqbloyF9hpx3Cia2d5N+O5LkxGdFhc=;
        b=BSDgSSZyu2C+dtWRJVdM6RBEYpTsn5ecB93MOzrEO0y4G8bQ1lk/06vcv0UhQeGeSwo6ph
        AhtGAT4BNUtYS1CUT/E1rW1SiHS4RgTgDxzcU5pLf/jq337dypvzCNbK8Xe4QWXlzqDXSg
        SNyg4lfKK56Xuo6ORmPYg3KFZA3BxsY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D363132B9;
        Tue, 22 Aug 2023 13:01:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ydRgBo+x5GQqdQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 22 Aug 2023 13:01:03 +0000
Date:   Tue, 22 Aug 2023 15:01:01 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: memcg: add a helper for non-unified stats
 flushing
Message-ID: <y7vvyndehadwy5ouounm5oyo52bqhsysiizuphzki2h3bwpdpc@3hvaq6sp6f4k>
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nkqic6iypcnygsam"
Content-Disposition: inline
In-Reply-To: <20230821205458.1764662-3-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--nkqic6iypcnygsam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 08:54:57PM +0000, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> +static void do_stats_flush(struct mem_cgroup *memcg)
> +{
> +	cgroup_rstat_flush(memcg->css.cgroup);
	if(memcg =3D=3D root_mem_cgroup)
		atomic_set(&stats_flush_threshold, 0);
> +}
> +
>  /*
>   * do_unified_stats_flush - do a unified flush of memory cgroup statisti=
cs
>   *
> @@ -656,7 +667,7 @@ static void do_unified_stats_flush(void)
> =20
>  	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> =20
> -	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> +	do_stats_flush(root_mem_cgroup);
> =20
  -	atomic_set(&stats_flush_threshold, 0);
>  	atomic_set(&stats_flush_ongoing, 0);

You may reset stats_flush_threshold to save the unified flushers some
work.

Michal


--nkqic6iypcnygsam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZOSxiwAKCRAGvrMr/1gc
jm71AQCt7WNfujH/Pjh8YjVKcytjG329tBz6ofp30cTENZIrxQD7BQe9CMXaQ46H
Ryr2cNLw9Zi0Z5DRW4nF1r5TaJyJ3Ac=
=k+uV
-----END PGP SIGNATURE-----

--nkqic6iypcnygsam--
