Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B728648630
	for <lists+cgroups@lfdr.de>; Fri,  9 Dec 2022 17:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLIQHZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Dec 2022 11:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLIQHE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Dec 2022 11:07:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F45A384A;
        Fri,  9 Dec 2022 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670601959; x=1702137959;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XWRLIvNaPSbx3qgHOle8bZTzrcu0wd+pVGPi5uuTaLg=;
  b=Dx9A1LP4Rj3v31a86MkFcPaEXndEZ3bJeuWd/xZMw8foA+g2pK5lyz5p
   3b3qtM5ZMPz8j4I4cqo5O2xKt4cQclKM8vcfnFgvr9xwM3Ak3OrBbbtD/
   fBJpLEFmWsQ1YqrQ5B6AzrS6ekOI1XPU8/X+7bQ8qTYQxLIjnh+Y31502
   RGIqHNxUFjDmndfbdOn58pD8ZpjR064rV3nVNYb/bucsLE3YpBvMJWhwx
   KV9F5aBPxE1RSh4o4S6Py4ZBqhuzo37dJmtkmbJ+MnpqY30aE9/Roz0Zq
   6Xf58jz4dLmH5QQGrZW1lSj1vzgCdkvSt0p78jxwQqeMPNeEiQWknyxdu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="316194344"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="316194344"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:05:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="976319943"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="976319943"
Received: from pphiri-mobl1.amr.corp.intel.com (HELO [10.212.198.173]) ([10.212.198.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:05:57 -0800
Message-ID: <cb5abce531c1b14118de419ba68c2a501b016873.camel@linux.intel.com>
Subject: Re: [PATCH v2 14/18] x86/sgx: Add EPC OOM path to forcefully
 reclaim EPC
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Date:   Fri, 09 Dec 2022 08:05:56 -0800
In-Reply-To: <Y5IBCOuF8X7jEK3+@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
         <20221202183655.3767674-15-kristen@linux.intel.com>
         <Y5IBCOuF8X7jEK3+@kernel.org>
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

On Thu, 2022-12-08 at 15:21 +0000, Jarkko Sakkinen wrote:
> On Fri, Dec 02, 2022 at 10:36:50AM -0800, Kristen Carlson Accardi
> wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >=20
> > Introduce the OOM path for killing an enclave with the reclaimer
> > is no longer able to reclaim enough EPC pages. Find a victim
> > enclave,
> > which will be an enclave with EPC pages remaining that are not
> > accessible to the reclaimer ("unreclaimable"). Once a victim is
> > identified, mark the enclave as OOM and zap the enclaves entire
> > page range. Release all the enclaves resources except for the
> > struct sgx_encl memory itself.
> >=20
> > Signed-off-by: Sean Christopherson
> > <sean.j.christopherson@intel.com>
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Cc: Sean Christopherson <seanjc@google.com>
>=20
> Why this patch is dependent of all 13 patches before it?
>=20
> Looks like something that is orthogonal to cgroups and could be
> live by its own. At least it probably does not require all of
> those patches, or does it?
>=20
> Even without cgroups it would make sense to killing enclaves if
> reclaimer gets stuck.
>=20
> BR, Jarkko

It is dependent first of all of having the LRU struct with the
unreclaimable/reclaimable lists. Which means it requires storing the
enclave pointer in the page as well. It's dependent on knowing how many
pages are available, being able to ignore the age of a page etc. Right
now, without cgroups, sgx will be unable to allocate memory when an
enclave is created if it cannot reclaim enough memory from the existing
in use enclaves.

Aside from that though, I don't think that killing enclaves makes sense
outside the context of cgroup limits. Without cgroup limits, you have a
max number of EPC pages that you can have active at any one time. If an
enclave attempts to allocate a new page and the reclaimer can't free up
any, how would you decide whether it's ok to kill an entire enclave in
order to grant this other enclave the higher priority for getting a
page? With a cgroup limit, the system owner explicitly can decide what
the limits on usage will be, but without that, you'd have a situation
where one new enclave could kill others I would think. Better to just
have it the way it is - new page allocations fail if there are not free
pages, but you don't kill enclaves that already exist.

