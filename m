Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955A57562F4
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGQMmU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGQMl7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 08:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7CE7F;
        Mon, 17 Jul 2023 05:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5EE61050;
        Mon, 17 Jul 2023 12:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC57C433CB;
        Mon, 17 Jul 2023 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689597713;
        bh=m/DOGC6VOPi4p/KkmSKEwPEhmwK+Sh1kqIBGMvhMij8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Xt29kgKbOvs8kiul6RR8/AjHsVnpp2Vc9cPd3+e2BVZ69ih3Mh8Ry3SQx1pJ8I19y
         EFWrSVAMcHAsUcM6/8DHpDu/5JS/+ugvBS59Gb6oidoSHaSPrlQ83S1sGgq//QtvCw
         vYK/DHgSRdjO6eaweTtJarG1JY7DqbkfeJ/1REY1AoStCNHbhhX0/55egaxODMWZGT
         OYHRy3uYXfyle2IC4SxQ/W4zn3tzfXef3yzJWWUgYNmOuC/M7kDlKYmsIOkSA2xx6E
         gDjXmRA04k9xTnPeRhWv55jSj7XDPy8NtNnZTnoL08RUhozWl+0pUYqRp/EIUDJKXe
         bYmJmJc3NuiFQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 12:41:47 +0000
Message-Id: <CU4GEFJ8R4US.227AN2H482Q4G@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>
Subject: Re: [PATCH v3 02/28] x86/sgx: Add EPC page flags to identify owner
 type
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-3-haitao.huang@linux.intel.com>
In-Reply-To: <20230712230202.47929-3-haitao.huang@linux.intel.com>
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
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Two types of owners, 'sgx_encl' for VA pages and 'sgx_encl_page' for othe=
r,
> can be stored in the union field in sgx_epc_page struct introduced in the
> previous patch.

This would be easier to follow:

"Two types of owners of struct_epc_page, 'sgx_encl' for VA pages and
'sgx_encl_page' can be stored in the previously introduced union field."

> When cgroup OOM support is added in a later patch, the owning enclave of =
a
> page will need to be identified. Retrieving the sgx_encl struct from a
> sgx_epc_page will be different if the page is a VA page vs. other enclave
> pages.
>
> Add 2 flags which will identify the type of the owner and apply them
> accordingly to newly allocated pages.

This would be easier to follow:

"OOM support for cgroups requires that the owner needs to be identified
when selecting pages from the unreclaimable list. Address this by adding
flags for identifying the owner type."

It is better to carry the story a little bit forward than say that a
subsequent patch will require this :-) I.e. enough to get at least a
rough idea what is going on.

R, Jarkko
