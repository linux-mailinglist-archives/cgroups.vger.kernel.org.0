Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB95E6D8D
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiIVVED (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIVVD7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 17:03:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1210CA7C;
        Thu, 22 Sep 2022 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663880637; x=1695416637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5J/gUw0ozggdiEjT67Hv+Q1CO877q7WnX+QC9z+OreE=;
  b=cGQ3FhvmCEU1br1E/02+iXJWgWqgjpHiM7usoLkViCJf2toyn5wGQ0lM
   cB9bf8ZoQ3RbJYV1V4uTEpxLaL3kpdnGs75jXqD7J4sLS0Fb3RbYcluu4
   eUShQ4xROSserw5YPRhlCH04kULGlB1z81+3p9dzsFomQCYGs8eCn9Py+
   bS/ehEOKPfGP+h5MX8wXsAC+kccGePgmXeU9Hs+ySTR4Zys3J86fR8Cuc
   9qFmqDtGEwZU/3ylxF/bm6QjM8ZroTdK1n6C4GkUByo+dl6eZIZIhOuvE
   Yr15QatCUwEz7NBDpxOdEcTlqxRpIgtnRxUpBv0Ef39lulSw0wLBrQlT4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301870386"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301870386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:03:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="948770813"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO [10.209.58.200]) ([10.209.58.200])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:03:51 -0700
Message-ID: <7ff6d114-a6cc-e3c5-5edb-8ac0e527d8a9@intel.com>
Date:   Thu, 22 Sep 2022 14:03:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <YyyeSVSk/lWdo/W4@slm.duckdns.org>
 <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
 <YyyykUJQtYbPVctn@slm.duckdns.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YyyykUJQtYbPVctn@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/22/22 12:08, Tejun Heo wrote:
> Can you please give more concrete examples? I'd love to hear how the SGX EPC
> memory is typically used in what amounts and what's the performance
> implications when they get reclaimed and so on. ie. Please describe a
> realistic usage scenario of contention with sufficient details on how the
> system is set up, what the applications are using the SGX EPC memory for and
> how much, how the contention on memory affects the users and so on.

One wrinkle is that the apps that use SGX EPC memory are *normal* apps.
 There are frameworks that some folks are very excited about that allow
you to run mostly unmodified app stacks inside SGX.  For example:

	https://github.com/gramineproject/graphene

In fact, Gramine users are the troublesome ones for overcommit.  Most
explicitly-written SGX applications are quite austere in their SGX
memory use; they're probably never going to see overcommit.  These
Gramine-wrapped apps are (relative) pigs.  They've been the ones finding
bugs in the existing SGX overcommit code.

So, where does all the SGX memory go?  It's the usual suspects:
memcached and redis. ;)
