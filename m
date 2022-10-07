Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525C5F7BC8
	for <lists+cgroups@lfdr.de>; Fri,  7 Oct 2022 18:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJGQrC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Oct 2022 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJGQrA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Oct 2022 12:47:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF08F243;
        Fri,  7 Oct 2022 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665161220; x=1696697220;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Hz4ZOFub5d7WZ52Ly6J+98gkWjEVO9LcXzV3oygGfnc=;
  b=gNbe1Sug3sQ4i17rYJk8myvRRyn/bYA9pKvE3qeGarfj9ylj+xhITv9O
   wG7xtdX3u4Mc6waCNUvCkLU05KwTeA1GRG2styj13c1dgh5o7k0rgZ7W4
   W0ORFzPQXP43uKjjuA0VXQkEFzdLXrm55UIoruHt8KUPCz/SEGGAbXutv
   q54n3QXuFfF4emz2H+VzPAHdzMjSspg8Qwo0XJ35oN5f9Jyxxij71jKP4
   fhsMeDGo8XEHjPq79GDXpGLlloiW+cdvRHxLpqKM2y4p0cHj+2/z+H/D6
   svn5YVj8qq3tqf66Vml2fuRix2PuXVmNJ2bUWgUaHtzgNN3kQJ2C/qurr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="305362205"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="305362205"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 09:46:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="954131112"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="954131112"
Received: from ccwistar-mobl.amr.corp.intel.com (HELO [10.212.129.146]) ([10.212.129.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 09:46:58 -0700
Message-ID: <228456112a91fb78a91fe217cd8e60ca2496aa6a.camel@linux.intel.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 07 Oct 2022 09:46:57 -0700
In-Reply-To: <Y0BW/GkfXG99+41O@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
         <YyyeSVSk/lWdo/W4@slm.duckdns.org>
         <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
         <YyyykUJQtYbPVctn@slm.duckdns.org>
         <7ff6d114-a6cc-e3c5-5edb-8ac0e527d8a9@intel.com>
         <Yy5KwnRTbFjmKE9X@slm.duckdns.org>
         <0f42e11434b264e555559cab626c1828a9eae09f.camel@linux.intel.com>
         <Y0BW/GkfXG99+41O@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-10-07 at 06:42 -1000, Tejun Heo wrote:
> Hello, Kristen.
>=20
> On Fri, Oct 07, 2022 at 09:39:40AM -0700, Kristen Carlson Accardi
> wrote:
> ...
> > With the misc controller, i haven't been able to find a way to
> > easily
> > react to a change in the max value. Am I missing something?
>=20
> There isn't currently but it should be possible to add per-key
> notifiers,
> right?
>=20
> Thanks.
>=20

OK - yes, I will include a modification to the misc controller for the
functionality I need in my patchset.

