Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEEF39FCAA
	for <lists+cgroups@lfdr.de>; Tue,  8 Jun 2021 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhFHQlj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Jun 2021 12:41:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59622 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhFHQlj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Jun 2021 12:41:39 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B247E219C0;
        Tue,  8 Jun 2021 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623170384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YkYqz+ZtymbOhQ5LKg4OZB2IErjraWsnNuYIpmXMpw=;
        b=U3kPBWzMvHzcsRUkRNyGFPLYEbf9J+yR7Chy7YTtDt1Ai5jy+UVmpK0Kt2pQ6mIMMLOi2w
        xceE13H0dnINmYtKvu3REgUm050s8k21StvXeKmIrIiG6PaoEDzvW365NdYbmzdhHwxDG1
        y6Mnee6w26nNnjZ3wkZLth9j9x7thVM=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4A4E2118DD;
        Tue,  8 Jun 2021 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623170384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YkYqz+ZtymbOhQ5LKg4OZB2IErjraWsnNuYIpmXMpw=;
        b=U3kPBWzMvHzcsRUkRNyGFPLYEbf9J+yR7Chy7YTtDt1Ai5jy+UVmpK0Kt2pQ6mIMMLOi2w
        xceE13H0dnINmYtKvu3REgUm050s8k21StvXeKmIrIiG6PaoEDzvW365NdYbmzdhHwxDG1
        y6Mnee6w26nNnjZ3wkZLth9j9x7thVM=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id haZ9EFCdv2BjWgAALh3uQQ
        (envelope-from <mkoutny@suse.com>); Tue, 08 Jun 2021 16:39:44 +0000
Date:   Tue, 8 Jun 2021 18:39:42 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH v4] sched/fair: Correctly insert cfs_rq's to list on
 unthrottle
Message-ID: <YL+dTtsCtZjMeZWn@blackbook>
References: <20210604102314.697749-1-odin@uged.al>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bjCpVaBEdcHpnVsT"
Content-Disposition: inline
In-Reply-To: <20210604102314.697749-1-odin@uged.al>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--bjCpVaBEdcHpnVsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Jun 04, 2021 at 12:23:14PM +0200, Odin Ugedal <odin@uged.al> wrote:

> @@ -4719,8 +4738,8 @@ static int tg_unthrottle_up(struct task_group *tg, =
void *data)
>  		cfs_rq->throttled_clock_task_time +=3D rq_clock_task(rq) -
>  					     cfs_rq->throttled_clock_task;
> =20
> -		/* Add cfs_rq with already running entity in the list */
> -		if (cfs_rq->nr_running >=3D 1)
> +		/* Add cfs_rq with load or one or more already running entities to the=
 list */
> +		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
>  			list_add_leaf_cfs_rq(cfs_rq);
>  	}

Can there be a decayed cfs_rq with positive nr_running?
I.e. can the condition be simplified to just the decayed check?

(I'm looking at account_entity_enqueue() but I don't know if an entity's
weight can be zero in some singular cases.)

Thanks,
Michal

--bjCpVaBEdcHpnVsT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmC/nUgACgkQia1+riC5
qSj6Zw/9GyYrkFQquKqXjlrp3PwkSq9ciNFqX2R3JUduT4zfQDhXHZSv7tJrn3mD
jFv22NWGZZj1m72YBIFBu5+vYqATnsErIB4XPoDfpHFjlwcazPFcFcObhdaUHLPC
ic4KMGpVnUF08qBwjVcDlLvUcGbj/GElzjt0PSVSGXRByNAF7JV1PE6n3kH5VApC
5MOhWRELjS2I3dRuzQI9/oPJ+T3e6SDX+s9Op7SKKTbN2joIbSnRFxwbgNTgVtf/
4uhmTM7oVLN4DptYIJnIIX5P8CpsqcrgICXyH5bAAs6UTHfdeSCwH8ns5IL8IWgC
7qCjxEo7TMZL2tOhYxqi9NqAxP8ogqOV425LMEVkg67cii4RAaOBPwdDDKFa70Ep
M9IelfmsXerwWrfJzbZlHedfIQm30ZJYi57KtshWB+OtxNMkqKi9XHoDsx1FQ2YG
W4S1hhZn2vbZcmQv13TpMkIyjEeIVXbFxEElfRj9yO7440rYp0wBZBPmS9wS1WEG
nQjmpZTsvtrAEMWXVAPNU7LG7rqEWHsI0KTkou5o4mmVVYt83lTzDxLVW3pgh2Tm
IF0ulw6OesHvaDmUW4GO239112ZTtnpl0e+JXWpZq3Aw1ub0fojSBVZffCjGD14C
O4Mo0z+I/eQe14D9Zmgxll4ltTeZJvg1EJWWEC3TiZnWJFJQ/Mc=
=CXYl
-----END PGP SIGNATURE-----

--bjCpVaBEdcHpnVsT--
