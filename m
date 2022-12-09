Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C0648673
	for <lists+cgroups@lfdr.de>; Fri,  9 Dec 2022 17:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLIQWi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Dec 2022 11:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIQWh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Dec 2022 11:22:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BF41C0;
        Fri,  9 Dec 2022 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670602952; x=1702138952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iQwVqHB9rC9aTwo4Z445IcUifA5rNpwqLqEuyYsANns=;
  b=MfIU6d/730wqghMxeJTBwiLhdIjCe5UmOtnoB/UBGfO495Qhq43G57BE
   sys8Se8M3EZhhpM2tFvIh8rQrp0pqqNDl7tVM+zZM4BoUFSpuFG/Tp2qW
   FV9jRZz6RPphCtmmAs0ElwXm8Mvz2XppoWQAhsTSeS48z+LRmYMgNqGwI
   w6QuBTbswIoKRaA0hI8g7je/ahzE5s/YENCu+gInTBxOUjrZUjIolzHwv
   ygt18rXP/zSFAQM3M9PlNWhOYIbI8/unPJfwl3MjMq1djjaYpHQhbdTPl
   C73oMeJ40V6NAJ1EmSh7cebeU87cTnuYk/brfHsMFucHGwt5f9eotfGUn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="315129265"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="315129265"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:22:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="754083892"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="754083892"
Received: from hoonpark-desk15.amr.corp.intel.com (HELO [10.209.54.118]) ([10.209.54.118])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:22:27 -0800
Message-ID: <e5aff02b-713c-ccd8-7211-d07ff6d7adb2@intel.com>
Date:   Fri, 9 Dec 2022 08:22:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 14/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-15-kristen@linux.intel.com>
 <Y5IBCOuF8X7jEK3+@kernel.org>
 <cb5abce531c1b14118de419ba68c2a501b016873.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cb5abce531c1b14118de419ba68c2a501b016873.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/9/22 08:05, Kristen Carlson Accardi wrote:
> Aside from that though, I don't think that killing enclaves makes sense
> outside the context of cgroup limits. 

I think it makes a lot of sense in theory.  Whatever situation we get
into with a cgroup's EPC we can also get into with the whole system's EPC.

*But*, it's orders of magnitude harder to hit on the whole system.
Basically, it has to be at a point where all of the EPC is consumed in
non-SGX-swappable page types like SECS or VEPC pages.  That's
_possible_, of course, but it's really hard to create because one VEPC
page can hold the info of several (32??) swapped-out EPC pages.

So, you'd need roughly 4GB of swapped-out normal enclave memory to
exhaust a system with 128MB of total enclave memory.

OOM handling *much* necessary in practice if you have a cgroup with some
modestly sized enclaves and a very tiny EPC limit.  If someone wants to
extend this OOM support to system-wide EPC later, then go ahead.  But, I
don't think it makes a lot of sense to invert this series for it.
