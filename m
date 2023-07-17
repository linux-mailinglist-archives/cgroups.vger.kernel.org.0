Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B875667B
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjGQOe3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjGQOeQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 10:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A01BD8;
        Mon, 17 Jul 2023 07:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE37610AB;
        Mon, 17 Jul 2023 14:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CADC433C7;
        Mon, 17 Jul 2023 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689604431;
        bh=I21ZDliWD7GOdnTUiUm/tPH/YR8Nmd8AOMXf8/BsAhQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=IHUkmxqZ8XZmpa+aN5HU8DZORxXMoMRWO+WWbx47YVDPP8qvPcVzhLHh1XeIU1nv8
         QzuwK0t9DPm/8gU/fnssor4Fkmq/bB8XGYkbHHr7y4nEmeUstm1rRH2EwPj95Ker1K
         ndQjU7fQqZIg6zCAfCxTzu03K585baZEwR6GK48cFRJRo8r8l0MRQ4w+PA1hZNqEk2
         rosP4lYUR6++AlrfPC7kpK3RXNhNpJEOgiJy4QIqZNBgQEvsDCtykn/s6ikPHmljVM
         iwMAYqHp7lpN2ENeBAvgFFQ5uBO42xfrgNcJzvgxERPEFLRFCZbhD5sy8yNFfJ9l7k
         qM+Ktsgp12Txw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 14:33:46 +0000
Message-Id: <CU4IS5XRH3PK.M9DAVXJ7PSSE@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>
Subject: Re: [PATCH v3 17/28] x86/sgx: fix a NULL pointer
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-18-haitao.huang@linux.intel.com>
 <CU4GJG1NRTUD.275UVHM8W2VED@seitikki> <CU4GKARPLGU5.1CVBNY9N4K28F@seitikki>
 <op.1779qgkdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.1779qgkdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon Jul 17, 2023 at 1:14 PM UTC, Haitao Huang wrote:
> On Mon, 17 Jul 2023 07:49:27 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Mon Jul 17, 2023 at 12:48 PM UTC, Jarkko Sakkinen wrote:
> >> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> >> > Under heavy load, the SGX EPC reclaimers (ksgxd or future EPC cgroup
> >> > worker) may reclaim SECS EPC page for an enclave and set
> >> > encl->secs.epc_page to NULL. But the SECS EPC page is required for =
=20
> >> EAUG
> >> > in #PF handler and is used without checking for NULL and reloading.
> >> >
> >> > Fix this by checking if SECS is loaded before EAUG and load it if it=
 =20
> >> was
> >> > reclaimed.
> >> >
> >> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >>
> >> A bug fix should be 1/*.
> >
> > And a fixes tag.
> >
> > Or is there a bug that is momentized by the earlier patches? This patch
> > feels confusing to say the least.
> >
>
> It happens in heavy reclaiming cases, just extremely rare when EPC =20
> accounting is not partitioned into cgroups. Will add fix tag with the =20
> related EDMM patch. And move this as the first patch.

I understand, it is just a good practice to follow, i.e. have prelude
and then the "real" changes :-)

BR, Jarkko
