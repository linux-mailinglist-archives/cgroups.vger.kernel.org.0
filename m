Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D22756C82
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGQSwU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjGQSwU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A191;
        Mon, 17 Jul 2023 11:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E28611FB;
        Mon, 17 Jul 2023 18:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C662C433C8;
        Mon, 17 Jul 2023 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689619938;
        bh=P87FuhTc8IahWEgTuqdfWe67jrGdK6SDRTgOReZthFE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=qlnofnqnii1cMegZYZVF2HqyH5omZ2b7OXOzmWHw5owzA1KLmpBqePrWEhzN9hyCR
         EgR9GGacPYBjYMMZQa98po56ewrU0hMXaaaBFhZemBR39eJ2uX89yeX+VEdPYKCpzh
         tUligDoFnNONCEqCbtyjpccJwznUBXbrwaULtWW8E2fMJTAEE2T54XqBqPX4dOooa8
         ANYFBYQ4kdLadlWlMLKbMr7bBU5dX3bjyEfnBkRBeBIXkYIl8lhjDERZycLmNwGERo
         /wm5YTgYyujAZtS4ESNh74V6tGcAXY2BCvK2/cxVYCl9Z5FM9PbeBdBS1Knz5Z+Bc2
         JmMSrfHkPFtvA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 18:52:13 +0000
Message-Id: <CU4OA1SYEUA9.1HXBD5E4PKRZ4@seitikki>
Subject: Re: [PATCH v3 17/28] x86/sgx: fix a NULL pointer
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-18-haitao.huang@linux.intel.com>
 <CU4GJG1NRTUD.275UVHM8W2VED@seitikki>
 <ffe26e8b-9f2a-4f06-aadf-9dfb1421be76@intel.com>
In-Reply-To: <ffe26e8b-9f2a-4f06-aadf-9dfb1421be76@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon Jul 17, 2023 at 3:49 PM UTC, Dave Hansen wrote:
> On 7/17/23 05:48, Jarkko Sakkinen wrote:
> > On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> >> Under heavy load, the SGX EPC reclaimers (ksgxd or future EPC cgroup
> >> worker) may reclaim SECS EPC page for an enclave and set
> >> encl->secs.epc_page to NULL. But the SECS EPC page is required for EAU=
G
> >> in #PF handler and is used without checking for NULL and reloading.
> >>
> >> Fix this by checking if SECS is loaded before EAUG and load it if it w=
as
> >> reclaimed.
> >>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > A bug fix should be 1/*.
>
> No, bug fixes should not even be _part_ of another series.  Send bug
> fixes separately, please.

Yes, that would be of course a better option.

BR, Jarkko
