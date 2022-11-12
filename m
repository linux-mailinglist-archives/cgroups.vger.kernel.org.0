Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6569A62687F
	for <lists+cgroups@lfdr.de>; Sat, 12 Nov 2022 10:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiKLJ2m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Nov 2022 04:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKLJ2m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Nov 2022 04:28:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8AE60C5;
        Sat, 12 Nov 2022 01:28:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9683938pjs.4;
        Sat, 12 Nov 2022 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJeFW65Bs1DVHRXTMJLugWLkr26agWIWDiv+B9kQhY0=;
        b=i6t0sbED3vCuLXbeckNyt0yQ3yo89h0/60hntRMuTjX5XFkC2DzgYHt2wbQg6++DwR
         x/lmGizsTDx8mXeMfovOJLT+q4JvrhZEAlUx+O6nT2me32pvKja086rdXUlht0Ce/Fu4
         Iq2OZ1e5XY17odzvHseT0OEZfmtSarAkx+UDODhWs+AcRc2A+0zznbCnCw1waLligL+P
         CgYpb6B4SyDXzHb+Sws0nmQYt63JiFlDbUMbN+r1+ZX4QAYJc9kSQYtCusE1l4ss1SHE
         rhbqDrIZqEkkWzaCYtIZ80ZH3rbOExy4xkBJLQTzh1PnTLtMS8O/XN/Pq7O6aX0PE3TE
         Y/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJeFW65Bs1DVHRXTMJLugWLkr26agWIWDiv+B9kQhY0=;
        b=JW89pBCsXWTf0CIPgWBs8izN434N3hW7zH2B7d/WmzqgEEVQovQtnCHKmaitatuSHf
         AgsdEBG11V/ZoD58wPh1zyQN8LD8bC477OgjBjGxrCdhfeetp0OPAHJhq6LKvIVZihiq
         Y0rLWq2VG56dtLbb0IAMDWnDjfY2L1yBCO7uTcyv+fvsDTuB/+URklqBQEF/zvMw/jxO
         1zpM1TqXN86DEeTbWNc44pLsAnaC4aSOt5/GdopDaMf6pNkNdqlNo6yVN5AM0JPvdwHp
         MZShd0edsJIXJ6wHRHBTwXWlLUpgXw0XQcaMyvMbO+JYYSXvAQrxGFo5GmSuxP9FYSMf
         3eig==
X-Gm-Message-State: ANoB5plkL2WJRuftzmT1JKctyBH2vYZPpfhwtXrQLYg7cgfgeP8g3zqe
        7iFwKAPqTWeJTnkFUrTTV+TdZZLxFh2DOg==
X-Google-Smtp-Source: AA0mqf7DHt1Vrc/2pssK58dV/Ij0FyxahAA6sgZS0j6yMU7uVxY3ViHIcfbsYjvK35lktSbfZEZxwQ==
X-Received: by 2002:a17:902:f384:b0:188:b8cf:83f with SMTP id f4-20020a170902f38400b00188b8cf083fmr837631ple.134.1668245318870;
        Sat, 12 Nov 2022 01:28:38 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090a13cb00b002071ee97923sm6081582pjf.53.2022.11.12.01.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 01:28:38 -0800 (PST)
Message-ID: <483efb64-4c8f-7b0e-059c-b2421a9e33b5@gmail.com>
Date:   Sat, 12 Nov 2022 16:28:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 26/26] Docs/x86/sgx: Add description for cgroup support
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>,
        linux-doc@vger.kernel.org
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-27-kristen@linux.intel.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221111183532.3676646-27-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/12/22 01:35, Kristen Carlson Accardi wrote:
> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
> index 2bcbffacbed5..f6ca5594dcf2 100644
> --- a/Documentation/x86/sgx.rst
> +++ b/Documentation/x86/sgx.rst
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
> +
> +Migration
> +---------
> +
> +Once an EPC page is charged to a cgroup (during allocation), it
> +remains charged to the original cgroup until the page is released
> +or reclaimed.  Migrating a process to a different cgroup doesn't
> +move the EPC charges that it incurred while in the previous cgroup
> +to its new cgroup.

The doc LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

