Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD0641033
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiLBVvQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLBVvP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:51:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4B1CB23D;
        Fri,  2 Dec 2022 13:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017874; x=1701553874;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9f5KbostxEAV+RFNf4XG1ooSo6jjgGnVqXRgip8PujU=;
  b=cowQvwtRqxGF4Xhh04eCkEpfUl6emsRYD7OiGf1GWdJnyp+qwN+87jIs
   dRu6S418crjqxm1hVaAnPMgZK2LzfZWTs6RjqL0RXhJmmIl2X8fb5cUzU
   I+LC0Wk3HO0I5evZqkZ66EBl3iUiNwRIagKZ7UAbNCVSvJe5ByeA5DLEv
   ylKhZ97LRPjtKFJhc9GR/+tIJBFMzg5xmGd3b2QF07jHpDAQf038rLBuh
   77XC5/4PsYFYAte+z5+EftrvJ/Ivi6PmyRsJzelwPNQlcUc6klWSguR8K
   JnYET/eJfAbe9QSeNX+7QT1AXol199Jc88f7v/76loR37YIiA610ztbJ9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317199289"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="317199289"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:51:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787440141"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787440141"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO [10.251.1.207]) ([10.251.1.207])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:51:12 -0800
Message-ID: <d17c270bcbf631736d52b762dad8a6758d7dc951.camel@linux.intel.com>
Subject: Re: [PATCH v2 04/18] x86/sgx: Use sgx_epc_lru_lists for existing
 active page list
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Date:   Fri, 02 Dec 2022 13:51:10 -0800
In-Reply-To: <ad1bcb0f-661d-a701-2175-c8750d8af8d8@intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
         <20221202183655.3767674-5-kristen@linux.intel.com>
         <ad1bcb0f-661d-a701-2175-c8750d8af8d8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-12-02 at 13:43 -0800, Dave Hansen wrote:
> On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&sgx_global_lru.lo=
ck);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < SGX_N=
R_TO_SCAN; i++) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (list_empty(&sgx_active_page_list))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0epc_page =3D
> > sgx_epc_pop_reclaimable(&sgx_global_lru);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!epc_page)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
>=20
> One other nit about the structure of the patches: This introduced
> *both*
> reclaimable and unreclaimable list_heads.=C2=A0 But, it has zero use for
> the
> unreclaimable ones during the refactoring here.=C2=A0 I probably would
> have
> left out the 'unreclaimable' bits for now.

I know - and originally the addition of unreclaimable was added later,
but when I posted the RFC I felt there was some misunderstanding about
what this data structure was and how it would be used because the
addition of the unreclaimable bits came later. So I stuck both lists in
one so it'd be a better view of what the data structure would look
like.

>=20
> BTW, this is a nice sign:
>=20
> > =C2=A0arch/x86/kernel/cpu/sgx/main.c | 39 +++++++++++++++++------------=
-
> > ----
> > =C2=A01 file changed, 19 insertions(+), 20 deletions(-)
>=20
>=20

