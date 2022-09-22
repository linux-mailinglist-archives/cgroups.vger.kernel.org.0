Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968BD5E6CA5
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 22:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiIVUEi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 16:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiIVUEK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 16:04:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B4B61;
        Thu, 22 Sep 2022 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877049; x=1695413049;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=snMZXlvHgnKICyfiYSRp0+L0NsQopjCdJqHUvJECElM=;
  b=OhzPvIpT5wHKRKXAKyl96v8ABN6NTEQxwXxklkxeay6UEUXluO6k0SjB
   xGo28551Ni9gwkqZPnYqEjT1ibOKmBFc1Y12mzgkBcHjv5MvzLmmBEGeF
   8IFZm18l91EMW38Xhz3hXwy4EcEIUpayRSjVaHc5Z+1EGiNUB0wa0WJPW
   1jWVw7lD9Enc8RIuZRc7WhylGhXLMUzQgEI9rXTRvfCDlURDDXYD2G3ZF
   hdaMv/jbQOG3jlWe68w2yv9klpx8W79oq+cqgAuJUJuhQixBeXTHB4KBo
   +pf867bS3pJir3Xg/etJAzWNQZ/hA7hGh7nJoEsBvEjf9yCoBc949AOvy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280141801"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280141801"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:04:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="653129114"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO [10.212.165.187]) ([10.212.165.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:04:07 -0700
Message-ID: <f031ac1bd6b16509f1d714cd65e6b017f054940c.camel@linux.intel.com>
Subject: Re: [RFC PATCH 03/20] x86/sgx: Track owning enclave in VA EPC pages
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, cgroups@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Sean Christopherson <seanjc@google.com>
Date:   Thu, 22 Sep 2022 13:04:06 -0700
In-Reply-To: <1adb03c8-1274-3898-0677-03015a1f5a5d@intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
         <20220922171057.1236139-4-kristen@linux.intel.com>
         <1adb03c8-1274-3898-0677-03015a1f5a5d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2022-09-22 at 11:55 -0700, Dave Hansen wrote:
> On 9/22/22 10:10, Kristen Carlson Accardi wrote:
> > -struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
> > +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool
> > reclaim)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_epc_page *ep=
c_page;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > @@ -1218,6 +1219,8 @@ struct sgx_epc_page *sgx_alloc_va_page(bool
> > reclaim)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EFAULT);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0epc_page->owner =3D encl;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return epc_page;
> > =C2=A0}
>=20
> BTW, is there a flag or any other way to tell to what kind of object
> ->owner points?

The owner will only be an sgx_encl type if it is a va page, so to tell
what kind of object owner is, you look at the epc page flags - like
this:
        if (epc_page->flags & SGX_EPC_PAGE_ENCLAVE)
                encl =3D ((struct sgx_encl_page *)epc_page->owner)->encl;
        else if (epc_page->flags & SGX_EPC_PAGE_VERSION_ARRAY)
                encl =3D epc_page->owner;
...


