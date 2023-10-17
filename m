Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81107CCB4A
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjJQSyw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQSyv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 14:54:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC8C6;
        Tue, 17 Oct 2023 11:54:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0881421CFC;
        Tue, 17 Oct 2023 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697568888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WV8+QfL+W0GjUUx4DVAHsFccb/fwVlTGl0IqfxdfoSI=;
        b=hLnG6JFP3CdGIUwngJLGTg1Pjd+QkNnRPjs0lMTnDR4yiNmTTwaFJrGgiaiyQNDd+27Qk1
        MhoccU3MgS2tABD7xx+ADwcnn25XXp4MRS5pptOW6luVxMfvx8ob50SVQHOaiM0KDb1r2b
        qhTrQ9Kg8OlKfpwVZg9X2sGHNiJfg9M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB4C913584;
        Tue, 17 Oct 2023 18:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lHYZKXfYLmWmIgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 17 Oct 2023 18:54:47 +0000
Date:   Tue, 17 Oct 2023 20:54:46 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     "Christopherson,, Sean" <seanjc@google.com>,
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
Message-ID: <6lrq4xmk42zteq6thpyah7jy25rmvkp7mqxtll6sl7z62m7n4m@vrbbedtgxeq4>
References: <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
 <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
 <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2qvdlt5oh6ne5ty"
Content-Disposition: inline
In-Reply-To: <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -12.70
X-Spamd-Result: default: False [-12.70 / 50.00];
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
         RCPT_COUNT_TWELVE(0.00)[21];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--d2qvdlt5oh6ne5ty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Haitao.

On Tue, Oct 17, 2023 at 07:58:02AM -0500, Haitao Huang <haitao.huang@linux.intel.com> wrote:
> AFAIK, before we introducing max_write() callback in this series, no misc
> controller would possibly enforce the limit when misc.max is reduced. e.g. I
> don't think CVMs be killed when ASID limit is reduced and the cgroup was
> full before limit is reduced.

Yes, misccontroller was meant to be simple, current >= max serves to
prevent new allocations.

FTR, at some point in time memory.max was considered for reclaim control
of regular pages but it turned out to be too coarse (and OOM killing
processes if amount was not sensed correctly) and this eventually
evolved into specific mechanism of memory.reclaim.
So I'm mentioning this should that be an interface with better semantic
for your use case (and misc.max writes can remain non-preemptive).

One more note -- I was quite confused when I read in the rest of the
series about OOM and _kill_ing but then I found no such measure in the
code implementation. So I would suggest two terminological changes:

- the basic premise of the series (00/18) is that EPC pages are a
  different resource than memory, hence choose a better suiting name
  than OOM (out of memory) condition,
- killing -- (unless you have an intention to implement process
  termination later) My current interpretation that it is rather some
  aggressive unmapping within address space, so less confusing name for
  that would be "reclaim".


> I think EPC pages to VMs could have the same behavior, once they are given
> to a guest, never taken back by the host. For enclaves on host side, pages
> are reclaimable, that allows us to enforce in a similar way to memcg.

Is this distinction between preemptability of EPC pages mandated by the
HW implementation? (host/"process" enclaves vs VM enclaves) Or do have
users an option to lock certain pages in memory that yields this
difference?

Regards,
Michal

--d2qvdlt5oh6ne5ty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZS7YdAAKCRAGvrMr/1gc
jpc5AP9tTv+0BiQvCbDojRuouQdurDiPml67Obr1FdJ6Jqfb1AEAvxfWBD/03b86
jE2isDspp+sfjhBkmc8tAl7umLlKJwc=
=3VCm
-----END PGP SIGNATURE-----

--d2qvdlt5oh6ne5ty--
