Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A35F7BA8
	for <lists+cgroups@lfdr.de>; Fri,  7 Oct 2022 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJGQkU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Oct 2022 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJGQkO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Oct 2022 12:40:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C14599D;
        Fri,  7 Oct 2022 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665160801; x=1696696801;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:mime-version:date;
  bh=9Nj9pblwvx5r7sXSpQ1XOTFiHv2HjukhpuHauwYQ3cI=;
  b=KDNtvTXtg4kosGKpubx3/KNE6IlK8oIdAGxIR+igo9iHXm7u+AxG25wN
   3rK3YCmtozvNHkWP/eOmbZeTAYndh8ZSQxjHog4i+tgMEsfy+4Lwjcp+n
   mOZW7AvTt1qva1YC6nkPpe4gUYi6Hhzb4eUwl/+fqBxStPUPpZcuwFVct
   +QaS6tjQixZ0fUAq6g6I36URSWLa2LAAtKbhE7hCWsifO/zE1gcfdLEcz
   oU9FsppMCTd70mjYZpJ1A1sabQvupvR3pivsqu00YxgA8qJRbatLgjaRk
   V7LEme1AfLPaQqPf6JNKtTATKdDL7NposjlKYyYy4SmdWSCye0gnV0hEJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="367907702"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="367907702"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 09:40:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="687960909"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="687960909"
Received: from ccwistar-mobl.amr.corp.intel.com (HELO [10.212.129.146]) ([10.212.129.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 09:39:58 -0700
Message-ID: <0f42e11434b264e555559cab626c1828a9eae09f.camel@linux.intel.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
In-Reply-To: <Yy5KwnRTbFjmKE9X@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
         <YyyeSVSk/lWdo/W4@slm.duckdns.org>
         <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
         <YyyykUJQtYbPVctn@slm.duckdns.org>
         <7ff6d114-a6cc-e3c5-5edb-8ac0e527d8a9@intel.com>
         <Yy5KwnRTbFjmKE9X@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Fri, 07 Oct 2022 09:39:40 -0700
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-09-23 at 14:09 -1000, Tejun Heo wrote:
<snip>

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

Hi Tejun,
I'm playing with the misc controller to see if I can make it do what I
need to do, and I had a question for you. Is there a way to easily get
notified when there are writes to the "max" file? For example, in my
full controller implementation, if a max value is written, the current
epc usage for that cgroup is immediately examined. If that usage is
over the new value of max, then the reclaimer will reclaim from that
particular cgroup to get it under the max. If it is not possible to
reclaim enough to get it under the max, enclaves will be killed so that
all the epc pages can be released and then get under the max value.
With the misc controller, i haven't been able to find a way to easily
react to a change in the max value. Am I missing something?

Thanks,
Kristen

