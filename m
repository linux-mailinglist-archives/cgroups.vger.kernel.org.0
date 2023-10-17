Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB77CCB4D
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjJQSy7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjJQSy7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 14:54:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BEF5;
        Tue, 17 Oct 2023 11:54:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF4371F8B5;
        Tue, 17 Oct 2023 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697568895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wQOh3FH9b2rnyijAjQaLtuaZg6t2cVu7jm6tXATJYw=;
        b=bupwfa13hhgne16QMB8JCzQVS/2H7SV0HOqyzL0hemmXj+KZaUOhwdGuTvyJI1MRzrjSn5
        zKQktwiIgjjGdUPwynyoJyC/pcS4fDQpiZaVbXOzeqtrjR2X0zZegVAz82C5zuxCKBABRn
        kUrimFf5KOWe5U0Y4QlkWKy1nlncKjQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 803C713584;
        Tue, 17 Oct 2023 18:54:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id crmSHn/YLmWzIgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 17 Oct 2023 18:54:55 +0000
Date:   Tue, 17 Oct 2023 20:54:54 +0200
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
Subject: Re: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Message-ID: <mc3js6ye7sw2z4gyppqwld7lepke5swqlfbx4mchqwxbwgwts3@c5vzusgelgyc>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-17-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="edw5ydf5cclnwdcr"
Content-Disposition: inline
In-Reply-To: <20230923030657.16148-17-haitao.huang@linux.intel.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.86
X-Spamd-Result: default: False [-7.86 / 50.00];
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
         BAYES_HAM(-2.16)[95.97%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--edw5ydf5cclnwdcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2023 at 08:06:55PM -0700, Haitao Huang <haitao.huang@linux.intel.com> wrote:
> +static void sgx_epc_cgroup_free(struct misc_cg *cg)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg = sgx_epc_cgroup_from_misc_cg(cg);

It should check for !epc_cg since the misc controller implementation
in misc_cg_alloc() would roll back even on non-allocated resources.

> +	cancel_work_sync(&epc_cg->reclaim_work);
> +	kfree(epc_cg);
> +}
> +
> +static void sgx_epc_cgroup_max_write(struct misc_cg *cg)
> +{
> +	struct sgx_epc_reclaim_control rc;
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg = sgx_epc_cgroup_from_misc_cg(cg);
> +
> +	sgx_epc_reclaim_control_init(&rc, epc_cg);
> +	/* Let the reclaimer to do the work so user is not blocked */
> +	queue_work(sgx_epc_cg_wq, &rc.epc_cg->reclaim_work);

This is weird. The writer will never learn about the result of the
operation.

Thanks,
Michal

--edw5ydf5cclnwdcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZS7YfAAKCRAGvrMr/1gc
jiXBAQCjRWtn93e1A3lqtdgEQbgCQbqbDof6U4NlLFxKtLfdygD9HjQFcAbLr/8e
MoCT1oqhzmRq++UsUrnxa/WIAnreTwI=
=CV66
-----END PGP SIGNATURE-----

--edw5ydf5cclnwdcr--
