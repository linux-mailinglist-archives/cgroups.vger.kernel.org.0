Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7243375614D
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGQLPE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGQLPD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 07:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E91B9;
        Mon, 17 Jul 2023 04:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E7461014;
        Mon, 17 Jul 2023 11:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ED9C433C7;
        Mon, 17 Jul 2023 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689592501;
        bh=jQaqrSCg/yz5THxsM9cGnoZroPykdynjBcPlSG9vNuk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=biVF7s9jcxMdUb2BNF9qZV5HtosaQalGOMAHtL4rHUPEpnq91DGXn039B5C6Cnk4D
         ZDGEtBMAhLOQRwl6lIW+Zv6UhejI96Lz8bLsEjJiBaiIu2HLW+yFSrgtZdjXy+wXRV
         vwMyz9EawHrE40q6tPROYq5yMLOKotg0Um/vk16UgL/Rdt/uP9kMiImhKhngT/mcCc
         XwEQOxPLuR/eKw4HzDcXIWJbf+a1irlyFJM1wAtOHCJ/CWHxeAcbWlt55tVxcbu534
         j9zH0Ggcj/mIULA/QUqd5AsxHezqVSOVMIs9NJUIe+JPVKyxbnhBP0c/SbXTdozyZr
         LfPjYFzHfuLtQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 11:14:56 +0000
Message-Id: <CU4EJXH6STEZ.20R6EOX7V3XGD@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>
Subject: Re: [PATCH v3 01/28] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-2-haitao.huang@linux.intel.com>
In-Reply-To: <20230712230202.47929-2-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> In a later patch, when a cgroup has exceeded the max capacity for EPC pag=
es
> and there are no more Enclave EPC pages associated with the cgroup that c=
an
> be reclaimed, the only pages still associated with an enclave will be the
> unreclaimable Version Array (VA) pages or SECS pages, and the entire
> enclave will need to be killed to free up those pages.
>
> Currently, given an enclave pointer it is easy to find the associated VA
> pages and free them, however, OOM killing an enclave based on cgroup limi=
ts
> will require examining a cgroup's unreclaimable page list, and finding an
> enclave given a SECS page or a VA page. This will require a backpointer
> from a page to an enclave, including for VA pages.
>
> When allocating new Version Array (VA) pages, pass the struct sgx_encl of
> the enclave that is allocating the page. sgx_alloc_epc_page() will store
> this value in the owner field of the struct sgx_epc_page.  In a later
> patch, VA pages will be placed in an unreclaimable queue, and then when t=
he
> cgroup max limit is reached and there are no more reclaimable pages and t=
he
> enclave must be OOM killed, all the VA pages associated with that enclave
> can be uncharged and freed.
>
> To avoid casting needed to access the two types of owners: sgx_encl for V=
A
> pages, sgx_encl_page for other pages, replace 'owner' field in sgx_epc_pa=
ge
> with a union of the two types.

I think the action taken is correct but the reasoning is a bit
convoluted.

Why not instead put something like:

"Because struct sgx_epc_page instances of VA pages are not owned by an
sgx_encl_page instance in the first place, mark their owner as sgx_encl,
in order to make it reachable from the unreclaimable list."

The code change itself, and rest of the paragraphs do look reasonable.

BR, Jarkko
