Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304B75EAFEC
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIZSbM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIZSbK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 14:31:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5AE4F181;
        Mon, 26 Sep 2022 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664217065; x=1695753065;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bYxR8XqfZF9gxiYvUcSZcCJ2VTxb74tRDtYgU4TZI4Y=;
  b=QcYu8sB5yJJtuM3Q9Myf+sehUruV2bnc+6S/mMaKH4a20anB0SoPaeHm
   akbOZu2qqgQiKaJi9QO86SIeWqzgRm7UfJ+tCUTNqdU3zU0Kfg7HkhDDI
   8PEwPK2qKjJkcOu8e0JqkE/MWala6/T153BK1Pxc1yd9zBH3hvZP73pQz
   5HIYB0f+iV722nZeyqWRcMxvNeEg5T6KG9CcBpQwyZ3HzQkmbXB+6W9CV
   MrkG5gky7wtCtwSum25w3TChvcJNbrR8xlBqwANFtSrC+yN67LBvzjKLf
   wFWFpxstUBRCX9bLFMIj3lAoh1mhybdzNALLbEmzrygwAr71lu02Fz7iQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="284227637"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="284227637"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 11:30:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683643885"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683643885"
Received: from andrewjy-mobl.amr.corp.intel.com (HELO [10.212.166.96]) ([10.212.166.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 11:30:40 -0700
Message-ID: <4898ee6cd2b6c6dc1e89890c4b26c5c80b4d9496.camel@linux.intel.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 26 Sep 2022 11:30:39 -0700
In-Reply-To: <Yy5KwnRTbFjmKE9X@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
         <YyyeSVSk/lWdo/W4@slm.duckdns.org>
         <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
         <YyyykUJQtYbPVctn@slm.duckdns.org>
         <7ff6d114-a6cc-e3c5-5edb-8ac0e527d8a9@intel.com>
         <Yy5KwnRTbFjmKE9X@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.module_f36+15386+a24ad1a3) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-09-23 at 14:09 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Sep 22, 2022 at 02:03:52PM -0700, Dave Hansen wrote:
> > On 9/22/22 12:08, Tejun Heo wrote:
> > > Can you please give more concrete examples? I'd love to hear how
> > > the SGX EPC
> > > memory is typically used in what amounts and what's the
> > > performance
> > > implications when they get reclaimed and so on. ie. Please
> > > describe a
> > > realistic usage scenario of contention with sufficient details on
> > > how the
> > > system is set up, what the applications are using the SGX EPC
> > > memory for and
> > > how much, how the contention on memory affects the users and so
> > > on.
> >=20
> > One wrinkle is that the apps that use SGX EPC memory are *normal*
> > apps.
> > =C2=A0There are frameworks that some folks are very excited about that
> > allow
> > you to run mostly unmodified app stacks inside SGX.=C2=A0 For example:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://github.com/gram=
ineproject/graphene
> >=20
> > In fact, Gramine users are the troublesome ones for overcommit.=C2=A0
> > Most
> > explicitly-written SGX applications are quite austere in their SGX
> > memory use; they're probably never going to see overcommit.=C2=A0 These
> > Gramine-wrapped apps are (relative) pigs.=C2=A0 They've been the ones
> > finding
> > bugs in the existing SGX overcommit code.
> >=20
> > So, where does all the SGX memory go?=C2=A0 It's the usual suspects:
> > memcached and redis. ;)
>=20
> Hey, so, I'm a bit weary that this doesn't seem to have a strong
> demand at
> this point. When there's clear shared demand, I usually hear from
> multiple
> parties about their use cases and the practical problems they're
> trying to
> solve and so on. This, at least to me, seems primarily driven by
> producers
> than consumers.
>=20
> There's nothing wrong with projecting future usages and jumping ahead
> the
> curve but there's a balance to hit, and going full-on memcg-style
> controller
> with three control knobs seems to be jumping the gun and may create
> commitments which we end up looking back on with a bit of regret.
>=20
> Given that, how about this? We can easily add the functionality of
> .max
> through the misc controller. Add a new key there, trycharge when
> allocating
> new memory, if fails, try reclaim and then fail allocation if reclaim
> fails
> hard enough. I belive that should give at least a reasonable place to
> start
> especially given that memcg only had limits with similar semantics
> for quite
> a while at the beginning.
>=20
> That way, we avoid creating a big interface commitments while
> providing a
> feature which should be able to serve and test out the immediate
> usecases.
> If, for some reason, many of us end up running hefty applications in
> SGX, we
> can revisit the issue and build up something more complete with
> provisions
> for backward compatibility.
>=20
> Thanks.
>=20

Hi Tejun,

thanks for your suggestion. Let me discuss this with customers who
requested this feature (not all customers like to respond publically)
and see if it will meet needs. If there is an issue, I'll respond back
with concerns.

Thanks,
Kristen

