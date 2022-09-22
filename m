Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E15E6B5A
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIVS7W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiIVS7R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 14:59:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F329E7215;
        Thu, 22 Sep 2022 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663873156; x=1695409156;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nHUCn3fAp1cyQDcEoHfYvoWZgKU6VQGrac32k6xR4P0=;
  b=P3ln6hnc5jgZaQKAPiiI1e0ljLEJdeziQv1z5nniUHIzDRp2/USzbMUC
   qcSzJFDfipCO+HKs/2pylFlMEHMD9BY4oIXLtVQGbmjzmXAphXELSCT6q
   UZDKqIlnfKX0ELx/V1tb/uoLd7zCI16B7KzuvMAnCP4erefncTb/jlCfn
   HtYKUojpSEDh+jqmJxbUID9Z2XTF1zQZQF48/nTQfbm008XtO+GqUVtVA
   b7PBb3NhWX34WcYA7d/UtNZFztZjRxVS0Ya658MFxSWhSwTMMO3p5hVp6
   5R9+ckMoTI1A+UJcphyZ3JkV4pZ9tlDIVtbaqNlf3kduK+e3RxveRT79k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300385172"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300385172"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:59:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650656236"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO [10.212.165.187]) ([10.212.165.187])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:59:15 -0700
Message-ID: <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 22 Sep 2022 11:59:14 -0700
In-Reply-To: <YyyeSVSk/lWdo/W4@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
         <YyyeSVSk/lWdo/W4@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2022-09-22 at 07:41 -1000, Tejun Heo wrote:
> Hello,
>=20
> (cc'ing memcg folks)
>=20
> On Thu, Sep 22, 2022 at 10:10:37AM -0700, Kristen Carlson Accardi
> wrote:
> > Add a new cgroup controller to regulate the distribution of SGX EPC
> > memory,
> > which is a subset of system RAM that is used to provide SGX-enabled
> > applications with protected memory, and is otherwise inaccessible.
> >=20
> > SGX EPC memory allocations are separate from normal RAM
> > allocations,
> > and is managed solely by the SGX subsystem. The existing cgroup
> > memory
> > controller cannot be used to limit or account for SGX EPC memory.
> >=20
> > This patchset implements the sgx_epc cgroup controller, which will
> > provide
> > support for stats, events, and the following interface files:
> >=20
> > sgx_epc.current
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A read-only value which=
 represents the total amount of EPC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory currently being =
used on by the cgroup and its
> > descendents.
> >=20
> > sgx_epc.low
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A read-write value whic=
h is used to set best-effort
> > protection
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of EPC usage. If the EP=
C usage of a cgroup drops below this
> > value,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0then the cgroup's EPC m=
emory will not be reclaimed if
> > possible.
> >=20
> > sgx_epc.high
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A read-write value whic=
h is used to set a best-effort limit
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0on the amount of EPC us=
age a cgroup has. If a cgroup's
> > usage
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goes past the high valu=
e, the EPC memory of that cgroup
> > will
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0get reclaimed back unde=
r the high limit.
> >=20
> > sgx_epc.max
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A read-write value whic=
h is used to set a hard limit for
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cgroup EPC usage. If a =
cgroup's EPC usage reaches this
> > limit,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0allocations are blocked=
 until EPC memory can be reclaimed
> > from
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the cgroup.
>=20
> I don't know how SGX uses its memory but you said in the other
> message that
> it's usually a really small portion of the memory and glancing the
> code it
> looks like its own page aging and all. Can you give some concrete
> examples
> on how it's used and why we need cgroup support for it? Also, do you
> really
> need all three control knobs here? e.g. given that .high is only
> really
> useful in conjunction with memory pressure and oom handling from
> userspace,
> I don't see how this would actually be useful for something like
> this.
>=20
> Thanks.
>=20

Thanks for your question. The SGX EPC memory is a global shared
resource that can be over committed. The SGX EPC controller should be
used similarly to the normal memory controller. Normally when there is
pressure on EPC memory, the reclaimer thread will write out pages from
EPC memory to a backing RAM that is allocated per enclave. It is
possible currently for even a single enclave to force all the other
enclaves to have their epc pages written to backing RAM by allocating
all the available system EPC memory. This can cause performance issues
for the enclaves when they have to fault to load pages page in.

sgx_epc.high value will help control the EPC usage of the cgroup. The
sgx reclaimer will use this value to prevent the total EPC usage of a
cgroup from exceeding this value (best effort). This way, if a system
administrator would like to try to prevent single enclaves, or groups
of enclaves from allocating all of the EPC memory and causing
performance issues for the other enclaves on the system, they can set
this limit. sgx_epc.max can be used to set a hard limit, which will
cause an enclave to get all it's used pages zapped and it will
effectively be killed until it is rebuilt by the owning sgx
application. sgx_epc.low can be used to (best effort) try to ensure
that some minimum amount of EPC pages are protected for enclaves in a
particular cgroup. This can be useful for preventing evictions and thus
performance issues due to faults.

I hope this answers your question.

Thanks,
Kristen

