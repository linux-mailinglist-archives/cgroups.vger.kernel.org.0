Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E247ADD7B
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjIYQ5b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 12:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjIYQ5a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 12:57:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139110D;
        Mon, 25 Sep 2023 09:57:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA55C433C7;
        Mon, 25 Sep 2023 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695661043;
        bh=/TClsZXVGXCV9uINJx9IgXVRoHxhac9DAEBNZbscd1w=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=WBNUXt/WPWhBOc7FN29nn/y8nh1h4+x9bTO6ai3NHcfLzlWG/RF6iEYi1pEp1HTh8
         4LwFwL0c28Mm3QpAWj77WQVmkvBNkEA5CR6+zaET2Tlk2gaYI/0IrX/HOpkMeoOXyb
         cPRErNZxEP2NLg9LCXSqWIwcIYiputLZ3MLdTsN12Q68acODnioW443+WPg+HKIizl
         Nd/Z1N48K4NZ1DXFnadVJkdgIPRFCwXvnphpYImcEgrmtpxS/DHAc9lqiYJIEazOF2
         8r33lZHLd77+B7WO3wIROGBDbMbJwg0Yueyzyb71wNWRiLWJ6wUFrQTOGAvx3S6DS/
         40ITz+rb7puIw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 19:57:17 +0300
Message-Id: <CVS5O6QV7OWF.UBP59U46WUBX@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 01/18] cgroup/misc: Add per resource callbacks for
 CSS events
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-2-haitao.huang@linux.intel.com>
 <CVHOU5G1SCUT.RCBVZ3W8G2NJ@suppilovahvero>
 <op.2bci9anpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2bci9anpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat Sep 16, 2023 at 7:11 AM EEST, Haitao Huang wrote:
> Hi Jarkko
>
> On Wed, 13 Sep 2023 04:39:06 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>
> >> Consumers of the misc cgroup controller might need to perform separate
> >> actions for Cgroups Subsystem State(CSS) events: cgroup alloc and free=
.
> >
> > nit: s/State(CSS)/State (CSS)/
> >
> > "cgroup alloc" and "cgroup free" mean absolutely nothing.
> >
> >
> >> In addition, writes to the max value may also need separate action. Ad=
d
> >
> > What "the max value"?
> >
> >> the ability to allow downstream users to setup callbacks for these
> >> operations, and call the corresponding per-resource-type callback when
> >> appropriate.
> >
> > Who are "the downstream users" and what sort of callbacks they setup?
>
> How about this?
>
> The misc cgroup controller (subsystem) currently does not perform resourc=
e =20
> type specific action for Cgroups Subsystem State (CSS) events: the =20
> 'css_alloc' event when a cgroup is created and the 'css_free' event when =
a =20
> cgroup is destroyed, or in event of user writing the max value to the =20
> misc.max file to set the consumption limit of a specific resource =20
> [admin-guide/cgroup-v2.rst, 5-9. Misc].
>
> Define callbacks for those events and allow resource providers to registe=
r =20
> the callbacks per resource type as needed. This will be utilized later by=
 =20
> the EPC misc cgroup support implemented in the SGX driver:
> - On cgroup alloc, allocate and initialize necessary structures for EPC =
=20
> reclaiming, e.g., LRU list, work queue, etc.
> - On cgroup free, cleanup and free those structures created in alloc.
> - On max write, trigger EPC reclaiming if the new limit is at or below =
=20
> current consumption.

Yeah, this is much better (I was on holiday, thus the delay on
response).

> Thanks
> Haitao

BR, Jarkko
