Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8370074DA8D
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjGJPyw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjGJPwn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 11:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE105E50;
        Mon, 10 Jul 2023 08:52:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 937A41FEB0;
        Mon, 10 Jul 2023 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689004285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3Yl6KJ5iaf9hnfCzXQRl84Iaqux0AkHxDIFY4RqjNw=;
        b=RZVYDWZ3/urg8+OJrIGYGpUrF751dlFkNaykpkxGQn+RqXVDGewk43zN/vQ2i0TKnuoxE/
        s7uQLUU69qyMXv11RQzR4bprnARgyqFrYmMNWSbM1NRZ3Q442UZgzD6NFe5dgPpxB63CnK
        wdVjoFlpxkXACX6TRNmKaO0oBArtHfg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 646901361C;
        Mon, 10 Jul 2023 15:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SBCfF/0orGQjbQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 10 Jul 2023 15:51:25 +0000
Date:   Mon, 10 Jul 2023 17:51:24 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
Message-ID: <ag6ed2ebb3azrienshnvn775ejp6jsftx66we7mwcavv74q4s7@xm5djhor7bjl>
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <fbabnjfly5w6fxrhe3eu6ebspngz2hd3tqs6rrbropcdvylnhs@ayjdpq73kwui>
 <74f1906e-fe58-c745-a851-b160374f7acf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktauyloq4o6i5icy"
Content-Disposition: inline
In-Reply-To: <74f1906e-fe58-c745-a851-b160374f7acf@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ktauyloq4o6i5icy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 11:40:36AM -0400, Waiman Long <longman@redhat.com> wrote:
> I believe the primary reason is because update_parent_subparts_cpumask() can
> potential run for quite a while. So we don't want to hold the rcu_read_lock
> for too long.

But holding cpuset_mutex is even worse than rcu_read_lock()? IOW is the
relieve with this reason worth it?

> There may also be a potential that schedule() may be called.

Do you mean the spinlocks with PREEMPT_RT or anything else? (That seems
like the actual reason IIUC.)

Thanks,
Michal

--ktauyloq4o6i5icy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZKwo+gAKCRAGvrMr/1gc
jvoTAQDxUP5rRDvddw1/LeVeB6ciZXYjqioRtToDzNWdWiOIFAEAi10plOPMMm5q
0JhePeVrhp89P6ZsW9Vqi4y25ZY1mA4=
=qaQM
-----END PGP SIGNATURE-----

--ktauyloq4o6i5icy--
