Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438D27CE1B4
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjJRPw3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjJRPw3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 11:52:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0F89F;
        Wed, 18 Oct 2023 08:52:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7106821855;
        Wed, 18 Oct 2023 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697644345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3Va38a8sZL3iVjAWsTHHzZGt8WWZ+pcUoedGjqgQR0=;
        b=g9UH8xytD9YucQsxopJFs9GuKq5iUz2a8QIb7sS/H33jKkzP3mmDW2TKVBZrgGO6yfOudr
        sKHARkYPO34cJIoI6JqjFrRFRM0YTg5yQTMJOZ1vyW4tqcR2BJ+4biBpXzPQlUEzbtihgu
        9AJEbM9oDqICRMHlLXdW26ErRDoS4fY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CC6213915;
        Wed, 18 Oct 2023 15:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dSRSBjn/L2X7BgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 Oct 2023 15:52:25 +0000
Date:   Wed, 18 Oct 2023 17:52:23 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Message-ID: <yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3>
References: <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
 <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
 <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6lrq4xmk42zteq6thpyah7jy25rmvkp7mqxtll6sl7z62m7n4m@vrbbedtgxeq4>
 <op.2cztslnpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <11413ca0-a8a9-4f73-8006-2e1231dbb390@intel.com>
 <op.2c0nt109wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfycubn7gx2ldoil"
Content-Disposition: inline
In-Reply-To: <7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -12.53
X-Spamd-Result: default: False [-12.53 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[22];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.83)[99.27%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--sfycubn7gx2ldoil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 08:37:25AM -0700, Dave Hansen <dave.hansen@intel.co=
m> wrote:
> 1. Admin sets a limit
> 2. Enclave is created
> 3. Enclave hits limit, allocation fails

I was actually about to suggest reorganizing the series to a part
implementing this simple limiting and a subsequent part with the reclaim
stuff for easier digestability.=20

> Nothing else matters.

If the latter part is an unncessary overkill, it's even better.

Thanks,
Michal

--sfycubn7gx2ldoil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZS//NQAKCRAGvrMr/1gc
jjuFAQD2xyk+E8YDQEiLZRkzZgLNNa9uj65olyt01GBofYgW0wD/WHDRxDomdgb3
KyYKGF1P6hM7GDWbgwRHcCg5PSgE/gE=
=+mep
-----END PGP SIGNATURE-----

--sfycubn7gx2ldoil--
