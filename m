Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7503E7CCB54
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjJQSzK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbjJQSzH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 14:55:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C18F5;
        Tue, 17 Oct 2023 11:55:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F31EA1F8BA;
        Tue, 17 Oct 2023 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697568904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uLnZcT7m+cR+ihtjfCvEhepXOzUUYRn52NrGv1VdUws=;
        b=meIVwqTadDKAQhLi24bvP59mxV0LhjzH3G5WlmQV3YNY1/6YBi1D/D3bFWofMsuMxG9FoB
        maWj+eH9qeSQNFgUH1+rO4jn9v1r41gRjlmP1YayH2fzln+iUGaCiu3Ojsa1D0SvxcJpli
        5I+MMZyv9W3FOYI3kM7hSWGo0Rpj1qA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A316413584;
        Tue, 17 Oct 2023 18:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qH8QJ4fYLmXGIgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 17 Oct 2023 18:55:03 +0000
Date:   Tue, 17 Oct 2023 20:55:02 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
        yangjie@microsoft.com
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
Message-ID: <k4hvow3juyelizqrlwdjmuu57kscvcwanu3xhpeuqnppynzrdu@hmxuvgefqpo5>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="do7f6ref46fav4tn"
Content-Disposition: inline
In-Reply-To: <20230923030657.16148-2-haitao.huang@linux.intel.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.66
X-Spamd-Result: default: False [-8.66 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[20];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.96)[99.83%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--do7f6ref46fav4tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 08:06:40PM -0700, Haitao Huang <haitao.huang@linux.=
intel.com> wrote:
> @@ -276,10 +276,13 @@ static ssize_t misc_cg_max_write(struct kernfs_open=
_file *of, char *buf,
> =20
>  	cg =3D css_misc(of_css(of));
> =20
> -	if (READ_ONCE(misc_res_capacity[type]))
> +	if (READ_ONCE(misc_res_capacity[type])) {
>  		WRITE_ONCE(cg->res[type].max, max);
> -	else
> +		if (cg->res[type].max_write)
> +			cg->res[type].max_write(cg);
> +	} else {
>  		ret =3D -EINVAL;
>
> +	}

Is it time for a misc_cg_mutex? This given no synchronization guarantees
to implementors of max_write. (Alternatively, document it that the
callback must implement own synchronization.)


Thanks,
Michal

--do7f6ref46fav4tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZS7YhAAKCRAGvrMr/1gc
jtZGAP9yG0GJSSTgY45EqfHcfkzqyBg2KvAFA7gx5WotIRHTkwD+Mo6bB7HpvmUH
8ZJECbI9T8hXKU0Ff2O/oEC4KwR3Mw8=
=5qrs
-----END PGP SIGNATURE-----

--do7f6ref46fav4tn--
