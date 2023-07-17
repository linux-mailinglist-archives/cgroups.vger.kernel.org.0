Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48AC7562F9
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGQMn4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 08:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGQMni (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 08:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F7D91;
        Mon, 17 Jul 2023 05:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C55C61053;
        Mon, 17 Jul 2023 12:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BED3C433C8;
        Mon, 17 Jul 2023 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689597816;
        bh=7B2Pjw6NKXemEOfCP4Ct4UyD922UxZCxaO6K3gVi/7E=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=OBushMGAKDmd4+oHNO5CKO8iknCBEDcvl5hf2of5KPj1BfEJCq7TVDaEvrMjoqLlq
         2TqfkuZvscTEC5Uee8X00ZQcbtClJ7+r6x6S3ZGVP0L0sIZ7PsfDCks/N6OKw3eqzm
         jA3MFXDNom5FJzY8hIRJWWVwNBei9J3GWe9AE98TJQjtsnJjnNI1O7EIqtWP4Tmx4O
         gXsWE61LX8N0YPg4XtrwcGpf+BH8Cvy6NCkspYxBMv9opPOug/Ti0SowGR2IRRL3zo
         XpF9cJO8Zo4voPbDGC7qeGog8ml7AaCbUnZ6qppr6+xrJytDTObPsoqyRu+kUMZxZV
         S+3i9iULCfdpg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 12:43:31 +0000
Message-Id: <CU4GFR4WLMZP.3R9HJQFFG1JEK@seitikki>
Subject: Re: [PATCH v3 02/28] x86/sgx: Add EPC page flags to identify owner
 type
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-3-haitao.huang@linux.intel.com>
 <CU4GEFJ8R4US.227AN2H482Q4G@seitikki>
In-Reply-To: <CU4GEFJ8R4US.227AN2H482Q4G@seitikki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon Jul 17, 2023 at 12:41 PM UTC, Jarkko Sakkinen wrote:
> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >
> > Two types of owners, 'sgx_encl' for VA pages and 'sgx_encl_page' for ot=
her,
> > can be stored in the union field in sgx_epc_page struct introduced in t=
he
> > previous patch.
>
> This would be easier to follow:
>
> "Two types of owners of struct_epc_page, 'sgx_encl' for VA pages and
> 'sgx_encl_page' can be stored in the previously introduced union field."
>
> > When cgroup OOM support is added in a later patch, the owning enclave o=
f a
> > page will need to be identified. Retrieving the sgx_encl struct from a
> > sgx_epc_page will be different if the page is a VA page vs. other encla=
ve
> > pages.
> >
> > Add 2 flags which will identify the type of the owner and apply them
> > accordingly to newly allocated pages.
>
> This would be easier to follow:
>
> "OOM support for cgroups requires that the owner needs to be identified
> when selecting pages from the unreclaimable list. Address this by adding
> flags for identifying the owner type."
>
> It is better to carry the story a little bit forward than say that a
> subsequent patch will require this :-) I.e. enough to get at least a
> rough idea what is going on.

Oops, sent by mistake. I was going to say that the flag would be better
named simply as SGX_EPC_OWNER_PAGE instead of SGX_EPC_OWNER_ENCL_PAGE.

BR, Jarkko
