Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC875812B
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjGRPlh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGRPlg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 11:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA114B0;
        Tue, 18 Jul 2023 08:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E04A61636;
        Tue, 18 Jul 2023 15:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6087CC433C7;
        Tue, 18 Jul 2023 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689694894;
        bh=2z4VemvJVhwmItrQCFbXp9Jgb8x1GmS7nNXmRAUmxe4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=b7YN7txj1on5brdZbnALpUA94GYmyReQ+rClZl8Mz2bWYBYwgmIEkm8pdca4djZv/
         M0/ca7LkPW9RLp4P5PxIhT4+N4GIFM0+SDwh848mHn+4gCX/qzKQDzYdF/H9OdGwA2
         LqF+D+CokWv5RrrXVPnDyJ80a2/otiTTB4iz9ik+d0/+wa7T3aHw7GUMCpflWkoxJ5
         8ocmj/cGk3YWBFL0Cbe1589RT4WHM40Sbl5wCDRS9LLcaY1bliMbadfrb/dDmlHV8e
         2s0h4K2G6ILAYhmyVG/Wf6mi64APUa8G9zu3M2+1psXxsFLMceexRWUl36HHyJU2ym
         IVDuIGvKOZKBw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 18:41:27 +0300
Message-Id: <CU5EUJDXM616.SQKBEGB2RLHL@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-sgx@vger.kernel.org>, <cgroups@vger.kernel.org>,
        "Zefan Li" <lizefan.x@bytedance.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>, <vipinsh@google.com>,
        <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>
Subject: Re: [PATCH] cgroup/misc: Fix an overflow
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tejun Heo" <tj@kernel.org>,
        "Haitao Huang" <haitao.huang@linux.intel.com>
X-Mailer: aerc 0.14.0
References: <20230717184719.85523-1-haitao.huang@linux.intel.com>
 <CU4OCLEHU1S5.359W394902648@seitikki> <ZLWPN_xyGFrqqJkV@slm.duckdns.org>
 <op.178pr1qewjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <op.178te0tbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
In-Reply-To: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon Jul 17, 2023 at 11:37 PM EEST, Tejun Heo wrote:
> Hello,
>
> On Mon, Jul 17, 2023 at 03:19:38PM -0500, Haitao Huang wrote:
> > Actually, we are using atomic_long_t for 'current' which is the same wi=
dth
> > as long defined by arch/compiler. So new_usage should be long to be
> > consistent?
>
> We can use atomic64_t, right? It's slower on 32bit machines but I think i=
t'd
> be better to guarantee resource counter range than micro-optimizing charg=
e
> operations. None of the current users are hot enough for this to matter a=
nd
> if somebody becomes that hot, the difference between atomic_t and atomic6=
4_t
> isn't gonna matter that much. We'd need to batch allocations per-cpu and =
so
> on.

In our context, the microcode of SGX could support 32-bit but by design
we only support 64-bit. So at least with the current implementation this
would not be an issue for SGX.

BR, Jarkko


