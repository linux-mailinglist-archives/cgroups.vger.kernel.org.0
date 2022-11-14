Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8709E628D41
	for <lists+cgroups@lfdr.de>; Tue, 15 Nov 2022 00:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiKNXRi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 18:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKNXRh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 18:17:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0397613F1E;
        Mon, 14 Nov 2022 15:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668467857; x=1700003857;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BJtuGQcejdW0AaDzJi8BImdXcSYnmn5KFjXEYF0+NuY=;
  b=NZwEMtKY5sd9W1hHNCFAjEJaLhtoBbpLFdFJDbEkh3XSBk3W9FAwyLHQ
   zQbSgkBIRu7SpO6CE4EHMm5V2upKqvWXrQZq9E81ffsfKZXlvTB/4+5Sm
   oux6vzzpXtr6Rlp2PfRwPEXKVqXmrbWrggIkcjWXH0LIFn+zfBDoFGCFm
   x/7RjDHGUw10gN7zD9TL6jsMUHDabjBs3jG73xWGo0hu3nhltA0ZJwdDv
   IPekmxM0mHKJJqroRV1vsJVWoWRwDwWzhzyVHPDp3qMsXO5xPttlb2hQ7
   kriGut5HnZZPcUef19+mx47H5d/Prd8t34plCQndMFbKZm+tH5VBe19XA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310816045"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310816045"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:17:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="744344646"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="744344646"
Received: from tmacfarl-mobl1.amr.corp.intel.com (HELO [10.209.82.47]) ([10.209.82.47])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:17:35 -0800
Message-ID: <f7d63c6ea33b8aacf1e5f1ede91636f397e1b770.camel@linux.intel.com>
Subject: Re: [PATCH 17/26] cgroup/misc: Add notifier block list support for
 css events
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Date:   Mon, 14 Nov 2022 15:17:34 -0800
In-Reply-To: <Y3LLJypIUOSGKujT@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
         <20221111183532.3676646-18-kristen@linux.intel.com>
         <Y3LES3rUIZ/PtwzV@slm.duckdns.org>
         <6f7afaa6811cbda30d12c38d73d4b261ab733a9f.camel@linux.intel.com>
         <Y3LLJypIUOSGKujT@slm.duckdns.org>
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

On Mon, 2022-11-14 at 13:11 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Mon, Nov 14, 2022 at 03:10:05PM -0800, Kristen Carlson Accardi
> wrote:
> > Makes no difference to me TBH - I believe they will be functionally
> > equivalent and from a downstream user perspective equally as easy
> > to
> > use, so whatever you think is easiest for you to maintain.
>=20
> Yeah, functionally they should be equivalent. Hmm... Let's go with
> the ops
> table so that it's more explicit.
>=20
> Thanks.
>=20

OK, in the next version I will make this change, consolidate everything
for the misc controller into 1 or 2 patches as you requested, and also
get rid of the helpers and just access the struct directly. Thanks for
your review.

Kristen

