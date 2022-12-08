Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85221647546
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLHSDo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 13:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiLHSDa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 13:03:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B72AD33C;
        Thu,  8 Dec 2022 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670522609; x=1702058609;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=a5QVaJCW+1KfH+RIxcXb6CC8DOjg9E8IGIEr6DurHN4=;
  b=GZuGOMlkP+zF9wHo7SHVTokw/nl48YpRT0CYYAXRoIrdfryA9SkNIcX6
   kpiwtN+tR82YC6fGzonfqI081wmtM2D4i6lIxKyxi7eh79gH1Pw7Uqdwm
   dp96rdTbLgAxN18Dx3xYpD29uc5C2sH03I8lLNAfD2tp4e0jNfH851NXk
   BA2Ls5d8Nu5DMSeybuvpKFfWlVPnp56giV1T17hFcoGN5XE4SZsjnCBcP
   gWPEA1kqBrjwJnAuMMjwRog7UHvimecZBHcK7/7Qs16QYWi9d0l31bCgQ
   imqijagBcvfKFLmeaiBGQudyLz44uZNd+EUasJdv0nKe0cqxlizaDiiT0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="319116038"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="319116038"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 10:03:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="640720980"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="640720980"
Received: from nmanikan-mobl1.amr.corp.intel.com (HELO [10.251.3.168]) ([10.251.3.168])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 10:03:05 -0800
Message-ID: <08a420401b2fb539f37cbf21a0ded6bf8c68c72b.camel@linux.intel.com>
Subject: Re: [PATCH v2 03/18] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Date:   Thu, 08 Dec 2022 10:03:04 -0800
In-Reply-To: <Y5IDXF+6GmURxbYF@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
         <20221202183655.3767674-4-kristen@linux.intel.com>
         <Y5IDXF+6GmURxbYF@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2022-12-08 at 15:31 +0000, Jarkko Sakkinen wrote:
> On Fri, Dec 02, 2022 at 10:36:39AM -0800, Kristen Carlson Accardi
> wrote:
> > Introduce a data structure to wrap the existing reclaimable list
> > and its spinlock in a struct to minimize the code changes needed
> > to handle multiple LRUs as well as reclaimable and non-reclaimable
> > lists, both of which will be introduced and used by SGX EPC
> > cgroups.
> >=20
> > Signed-off-by: Sean Christopherson
> > <sean.j.christopherson@intel.com>
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > ---
> > =C2=A0arch/x86/kernel/cpu/sgx/sgx.h | 65
> > +++++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 65 insertions(+)
> >=20
> > diff --git a/arch/x86/kernel/cpu/sgx/sgx.h
> > b/arch/x86/kernel/cpu/sgx/sgx.h
> > index 39cb15a8abcb..5e6d88438fae 100644
> > --- a/arch/x86/kernel/cpu/sgx/sgx.h
> > +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> > @@ -90,6 +90,71 @@ static inline void *sgx_get_epc_virt_addr(struct
> > sgx_epc_page *page)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return section->virt_ad=
dr + index * PAGE_SIZE;
> > =C2=A0}
> > =C2=A0
> > +/*
> > + * This data structure wraps a list of reclaimable EPC pages, and
> > a list of
> > + * non-reclaimable EPC pages and is used to implement a LRU policy
> > during
> > + * reclamation.
> > + */
> > +struct sgx_epc_lru_lists {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spinlock_t lock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head reclaimable=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head unreclaimab=
le;
> > +};
> =C2=A0
> Why this is named like this, and not sgx_epc_global_rcu? Are there
> any other use cases?
>=20
> BR, Jarkko

Yes, there are other use cases that are introduced in the other
patches. This structure is used to in the cgroup struct to hold cgroup
specific LRUs.

