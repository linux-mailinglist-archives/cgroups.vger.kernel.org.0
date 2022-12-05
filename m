Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB24643064
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 19:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiLESa0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 13:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiLESaJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 13:30:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D462124A;
        Mon,  5 Dec 2022 10:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670264771; x=1701800771;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6Ibb9FHX6sDZCVR/tQ45ZXWV1fgsrR8xYe8426ATKDs=;
  b=HVMyzuTQbjCHl37OyUHWo8Au1jNGjK6PCJu/rEwXb5T1I+vX6zUg1SeL
   AiIZkD6DjHACUvWoTkHXmlo86d+mcTrMou7nbbggUZA4d08ulznikMv5p
   Cowst5sCHeBKcseF/aBKwiY9did2pruwWU6m24z9kOSza6JHGRwdcc1fr
   ej5YZUT4tMsJhWY+dRXZ7ugMxcMaJM71JIRhSrHB69exUOONwTU88eR3n
   nK3YBtYuXQ1i4xSUhvHb7Tmz0n0ECDgd3QhVdVW5ap7c4naHa/3yvVkjs
   bRmpycocOsyPv7lF6W/1sguczneZRphn6gVy0eeueos+lSrNWNRhUsL+S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317570171"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="317570171"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 10:25:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="752302027"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="752302027"
Received: from almamunm-mobl.amr.corp.intel.com (HELO [10.209.53.139]) ([10.209.53.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 10:25:57 -0800
Message-ID: <7017151a739c42516ace0de439679b37016b031c.camel@linux.intel.com>
Subject: Re: [PATCH v2 07/18] x86/sgx: Use a list to track to-be-reclaimed
 pages during reclaim
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Date:   Mon, 05 Dec 2022 10:25:56 -0800
In-Reply-To: <6668e428-8e4a-0a44-d77c-a540c04d72ed@intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
         <20221202183655.3767674-8-kristen@linux.intel.com>
         <0646275c-0ab9-2fad-8db1-7098656d6e1d@intel.com>
         <931e48dc399eddf8ad9f9dec8783f57df776daa9.camel@linux.intel.com>
         <6668e428-8e4a-0a44-d77c-a540c04d72ed@intel.com>
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

On Mon, 2022-12-05 at 09:03 -0800, Dave Hansen wrote:
> On 12/5/22 08:33, Kristen Carlson Accardi wrote:
> > The helpers were added because Jarrko requested a queue abstraction
> > for
> > the sgx_epc_lru_lists data structure in the first round of reviews.
> > the
> > simple one line inlines are effectively just renaming to make the
> > queue
> > abstraction more obvious to the reader.
>=20
> Jarkko,
>=20
> Do you have any issues with zapping these helpers?=C2=A0 I really don't
> think
> they add to readability.=C2=A0 The "reclaimable" versus "unreclaimable"
> naming is patently obvious from the structure member names.=C2=A0 I'm not
> sure what value it adds to have them in the function names too.
>=20
>=20


Well, there's sort of 2 things I would want clarity on before my next
revision. One is obviously deleting the wrappers for unreclaimable and
reclaimable pushes etc. The other is deleting the wrappers for the list
operations (the push/pop/peek queue abstractions) and whether those are
desired.

