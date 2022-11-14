Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3735D628D31
	for <lists+cgroups@lfdr.de>; Tue, 15 Nov 2022 00:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKNXKR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 18:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiKNXKP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 18:10:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0B22C;
        Mon, 14 Nov 2022 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668467414; x=1700003414;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xegt7ptKTtdJNW416eZFU2xzyfbyFyg07lD2i0oq41Q=;
  b=bEarSPNZtvx1T83GZvW9m36KNUTrCZAKbbqhkMxfty356n6/Sl2glriy
   s8HHrq8+b31UNMmxw4/wMm8M7Q1mW5aT0BotXqqV8dv0Xz/+PBkVeKACy
   NnpgxT3rwFcOr/T1NYhWl6ePQZjtacz3YpzZltz/J+918Bs1jOQRGA8Xr
   42ZElt3RY0EUThXsa+Dv/dc9CSB5NLp0QdV8wmfL9RrT9cB5pXaw3K1EB
   s8H6X4Ue94zJJXjii4nuZwqv80PDCURgL2DYGKGQF4mdQU8lcYKTLLq/f
   yOKwTR4xf8tf+IYPhpYLZ+IneqxdAwx5Ved1ZI8wl56w2vGGwarnQZ8nR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="312109889"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="312109889"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:10:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702198648"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702198648"
Received: from tmacfarl-mobl1.amr.corp.intel.com (HELO [10.209.82.47]) ([10.209.82.47])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:10:13 -0800
Message-ID: <6f7afaa6811cbda30d12c38d73d4b261ab733a9f.camel@linux.intel.com>
Subject: Re: [PATCH 17/26] cgroup/misc: Add notifier block list support for
 css events
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Date:   Mon, 14 Nov 2022 15:10:05 -0800
In-Reply-To: <Y3LES3rUIZ/PtwzV@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
         <20221111183532.3676646-18-kristen@linux.intel.com>
         <Y3LES3rUIZ/PtwzV@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2022-11-14 at 12:42 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Fri, Nov 11, 2022 at 10:35:22AM -0800, Kristen Carlson Accardi
> wrote:
> > +/**
> > + * register_misc_cg_notifier() - Register for css callback events
> > + * @nb: notifier_block to register
> > + *
> > + * Context: Any context.
> > + */
> > +int register_misc_cg_notifier(struct notifier_block *nb)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return
> > blocking_notifier_chain_register(&misc_cg_notify_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(register_misc_cg_notifier);
> > +
> > +/**
> > + * unregister_misc_cg_notifier() - unregister for css callback
> > events
> > + * @nb: notifier_block to unregister
> > + *
> > + * Context: Any context.
> > + */
> > +int unregister_misc_cg_notifier(struct notifier_block *nb)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return
> > blocking_notifier_chain_unregister(&misc_cg_notify_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_misc_cg_notifier);
>=20
> So, I'm not necessarily against this but wonder whether it'd be more
> straightforward to add sth like struct misc_res_ops which contains
> the
> optional callbacks and then have an array of pointers to the structs
> which
> are initialized / registered somehow. What do you think?
>=20
> Thanks.
>=20

Makes no difference to me TBH - I believe they will be functionally
equivalent and from a downstream user perspective equally as easy to
use, so whatever you think is easiest for you to maintain.

