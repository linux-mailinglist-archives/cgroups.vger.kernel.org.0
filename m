Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA07751502
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 02:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjGMALG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 20:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGMALE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 20:11:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B431FC8;
        Wed, 12 Jul 2023 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9qXn+we4vl/6E7qv05qrX8iXxtrz7OQ9ZzhJSvff8Kc=; b=qhJaU/WRyim+49/LxqT2+QEPc+
        pCd0GD9P1nk1zlaAiGQIJdpmTWnqLS6JONTSdB6dS0VfDtPp9k5BaINzFVn8l193BbZJJatf3CctK
        KtZdXK1UTgSdb3wvBtOzsUxCTP3ahqdZgcD4e0fsxMCwgfT91fQwh/NoQyXqDhwS7orJ9iVSBOywH
        i3oBsOjj87EMmIJKNrgplqkzn6zD6n1dgRID1iZUBuxH80nDjTIsEhZO2LUqCO4bnK/CSABkoRB7C
        tWq6Fxs3SMzzS/6X1CiroYvdabqNUux+ko99Pmu41c16vF0w9row/RLtadTFNHAcA4LUriAKL3tas
        COEHZi+g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJjvB-001YA3-0E;
        Thu, 13 Jul 2023 00:11:01 +0000
Message-ID: <f0dddc1a-6070-7e11-0458-b0db1f5ea671@infradead.org>
Date:   Wed, 12 Jul 2023 17:10:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 22/28] Docs/x86/sgx: Add description for cgroup support
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        zhiquan1.li@intel.com, seanjc@google.com, bagasdotme@gmail.com,
        linux-doc@vger.kernel.org, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-23-haitao.huang@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712230202.47929-23-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 7/12/23 16:01, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> Add initial documentation of how to regulate the distribution of
> SGX Enclave Page Cache (EPC) memory via the Miscellaneous cgroup
> controller.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/arch/x86/sgx.rst | 77 ++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/Documentation/arch/x86/sgx.rst b/Documentation/arch/x86/sgx.rst
> index 2bcbffacbed5..f6ca5594dcf2 100644
> --- a/Documentation/arch/x86/sgx.rst
> +++ b/Documentation/arch/x86/sgx.rst
> @@ -300,3 +300,80 @@ to expected failures and handle them as follows:
>     first call.  It indicates a bug in the kernel or the userspace client
>     if any of the second round of ``SGX_IOC_VEPC_REMOVE_ALL`` calls has
>     a return code other than 0.
> +
> +
> +Cgroup Support
> +==============
> +
> +The "sgx_epc" resource within the Miscellaneous cgroup controller regulates
> +distribution of SGX EPC memory, which is a subset of system RAM that
> +is used to provide SGX-enabled applications with protected memory,
> +and is otherwise inaccessible, i.e. shows up as reserved in
> +/proc/iomem and cannot be read/written outside of an SGX enclave.
> +
> +Although current systems implement EPC by stealing memory from RAM,
> +for all intents and purposes the EPC is independent from normal system
> +memory, e.g. must be reserved at boot from RAM and cannot be converted
> +between EPC and normal memory while the system is running.  The EPC is
> +managed by the SGX subsystem and is not accounted by the memory
> +controller.  Note that this is true only for EPC memory itself, i.e.
> +normal memory allocations related to SGX and EPC memory, e.g. the
> +backing memory for evicted EPC pages, are accounted, limited and
> +protected by the memory controller.
> +
> +Much like normal system memory, EPC memory can be overcommitted via
> +virtual memory techniques and pages can be swapped out of the EPC
> +to their backing store (normal system memory allocated via shmem).
> +The SGX EPC subsystem is analogous to the memory subsytem, and
> +it implements limit and protection models for EPC memory.
> +
> +SGX EPC Interface Files
> +-----------------------
> +
> +For a generic description of the Miscellaneous controller interface
> +files, please see Documentation/admin-guide/cgroup-v2.rst
> +
> +All SGX EPC memory amounts are in bytes unless explicitly stated
> +otherwise.  If a value which is not PAGE_SIZE aligned is written,
> +the actual value used by the controller will be rounded down to
> +the closest PAGE_SIZE multiple.
> +
> +  misc.capacity
> +        A read-only flat-keyed file shown only in the root cgroup.
> +        The sgx_epc resource will show the total amount of EPC
> +        memory available on the platform.
> +
> +  misc.current
> +        A read-only flat-keyed file shown in the non-root cgroups.
> +        The sgx_epc resource will show the current active EPC memory
> +        usage of the cgroup and its descendants. EPC pages that are
> +        swapped out to backing RAM are not included in the current count.
> +
> +  misc.max
> +        A read-write single value file which exists on non-root
> +        cgroups. The sgx_epc resource will show the EPC usage
> +        hard limit. The default is "max".
> +
> +        If a cgroup's EPC usage reaches this limit, EPC allocations,
> +        e.g. for page fault handling, will be blocked until EPC can
> +        be reclaimed from the cgroup.  If EPC cannot be reclaimed in
> +        a timely manner, reclaim will be forced, e.g. by ignoring LRU.
> +
> +  misc.events
> +	A read-write flat-keyed file which exists on non-root cgroups.
> +	Writes to the file reset the event counters to zero.  A value
> +	change in this file generates a file modified event.
> +
> +	  max
> +		The number of times the cgroup has triggered a reclaim
> +		due to its EPC usage approaching (or exceeding) its max
> +		EPC boundary.

The indentation here (above) is a little confusing.
Is this formatted the way that is intended?

> +
> +Migration
> +---------
> +
> +Once an EPC page is charged to a cgroup (during allocation), it
> +remains charged to the original cgroup until the page is released
> +or reclaimed.  Migrating a process to a different cgroup doesn't
> +move the EPC charges that it incurred while in the previous cgroup
> +to its new cgroup.

-- 
~Randy
