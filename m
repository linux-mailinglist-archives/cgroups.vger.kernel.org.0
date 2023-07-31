Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8296769445
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 13:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGaLLD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGaLLD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 07:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763A1BF;
        Mon, 31 Jul 2023 04:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C59C76105A;
        Mon, 31 Jul 2023 11:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B06C433C8;
        Mon, 31 Jul 2023 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690801861;
        bh=GQE4ikJOGvMhp7gKtfrRyBB/OigQHtCUYCx9FoUAlLg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=c+5iI4lBI1Xr9Q6XgHXyYMgH7oUBx77jiwy8HUfsDonzUm3db0QulCo65lQZsc8z+
         nboML0pAKixv0122Jd994M03a17edVOcADc4PO1XrXlJYoyeBaXt2NUKWDSrDau2Zn
         GezQAPLMzstIeqp0hm4UIGUVXM2XVVmXCZhehBnHVDFOKZkWhZXhl8XPtxsgQ6v+fe
         Ma/G2MSniOQNEY7Mst43pQWrr5k4qTh2GlNuOAGS4WIx7+UPem1oqBmX08c4lckeOp
         osm1Rug37jBNdHdOpauhHvqBBvA0t4gFQYQYQeE04fG2cETavr1hxmQ6YVutpXFH39
         xxqsBqNSBtCxw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 Jul 2023 11:10:55 +0000
Message-Id: <CUGB8HJ4IYB9.1VVYV9GK75UYX@seitikki>
Cc:     <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>
Subject: Re: [PATCH v3 11/28] x85/sgx: Return the number of EPC pages that
 were successfully reclaimed
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Pavel Machek" <pavel@ucw.cz>,
        "Haitao Huang" <haitao.huang@linux.intel.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-12-haitao.huang@linux.intel.com>
 <ZMUKd7KY6Kquubjf@duo.ucw.cz>
In-Reply-To: <ZMUKd7KY6Kquubjf@duo.ucw.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat Jul 29, 2023 at 12:47 PM UTC, Pavel Machek wrote:
> Hi!
>
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >=20
> > Return the number of reclaimed pages from sgx_reclaim_pages(), the EPC
> > cgroup will use the result to track the success rate of its reclaim
> > calls, e.g. to escalate to a more forceful reclaiming mode if
> > necessary.
>
> Subject says x85. While some would love to see support of Linux on
> Intel 8085, I guess it should be x86.

hmm... that could potentially be also a step towards also to zilog z80
compatibility :-)

BR, Jarkko
