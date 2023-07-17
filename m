Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFE756319
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGQMth (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 08:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjGQMtg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 08:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD3E49;
        Mon, 17 Jul 2023 05:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F876103B;
        Mon, 17 Jul 2023 12:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843F0C433C8;
        Mon, 17 Jul 2023 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689598172;
        bh=FzCc29B7tSBEcJAG9hiePGHLv8t23C1X2FNVDh8fwck=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=GPIVtST5cI3Gk0QPUa/Vbf3KaCgRK+8E/5AZn3ng7ExtBCSEECQ21eAdMLEnfzciB
         RZDaAthD+8xP0Oi4jsDR+YVstLZXpK3qNn6q3QFaGgT2c1XLBNiCh6eCco8/GTJ+DE
         ni8P9WBy+ZBfLOlOUjMcwfW9K0um6mIzLetwb5tAiYTqBtO7gH0umKu0+SE5kT7mUB
         nyOfw9TfxanSw0qk//eQ6hZ85Up/UFJos2Ak7OZS8x3nFOpjgV/41zWhUPkxE47YWO
         ddOXNGK9BhJJvjnHX6oeFKhtd7ToS8W9dw1iPtf/MwKgiyJwhczpsa+npFovhmT1LL
         whEntvnwlujoQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 12:49:27 +0000
Message-Id: <CU4GKARPLGU5.1CVBNY9N4K28F@seitikki>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>
Subject: Re: [PATCH v3 17/28] x86/sgx: fix a NULL pointer
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-18-haitao.huang@linux.intel.com>
 <CU4GJG1NRTUD.275UVHM8W2VED@seitikki>
In-Reply-To: <CU4GJG1NRTUD.275UVHM8W2VED@seitikki>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon Jul 17, 2023 at 12:48 PM UTC, Jarkko Sakkinen wrote:
> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> > Under heavy load, the SGX EPC reclaimers (ksgxd or future EPC cgroup
> > worker) may reclaim SECS EPC page for an enclave and set
> > encl->secs.epc_page to NULL. But the SECS EPC page is required for EAUG
> > in #PF handler and is used without checking for NULL and reloading.
> >
> > Fix this by checking if SECS is loaded before EAUG and load it if it wa=
s
> > reclaimed.
> >
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>
> A bug fix should be 1/*.

And a fixes tag.

Or is there a bug that is momentized by the earlier patches? This patch
feels confusing to say the least.

BR, Jarkko
