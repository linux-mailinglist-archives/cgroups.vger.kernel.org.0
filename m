Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BDF4B5BDB
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 22:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiBNU6K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 15:58:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiBNU6E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 15:58:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E1911EF08;
        Mon, 14 Feb 2022 12:57:27 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g1so11521631pfv.1;
        Mon, 14 Feb 2022 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8eI79aPTVtqYQhM0bTcpnqJ4UdG4+AWyiT8hNcdyv7Q=;
        b=ZSV4ZqXKji33uFcHmgvE05zjLOm9kEVHG6oWJ7eZKZPZ4kZ2nggGrMqLqKlPL34Ek1
         /u/NM4futt7QdWUDzgYKzfBFqB3ZZBZkwOMzOMhGC7cko+Qztmw8XHcfcb0gNwQq8MkU
         7507ocXVBAmsp48WPhA5XpPf/bn2aWqzt0WtH8bdY9cWxbZexhWBaUs3sZd0U5bp1e3T
         ruHrM+VNwVpvBmLdyRZvIgDd/7i3XcHwZsLkaOtpINL3arjnaQdH3B8XpxaFk+Fyctd1
         shUZRC0TnpWCQftQMjh+GxGmupgih3F576KJYbNUbrq4yUWvlv3OvixikVZXYjiUMish
         slvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8eI79aPTVtqYQhM0bTcpnqJ4UdG4+AWyiT8hNcdyv7Q=;
        b=o3eE+CYEMxE67VxanFZkAPqsQZg+QwdShIlzmrMsDPTDscgsb+V1JTgAu2XeRlGiQo
         FyH4zrAW9ChQ5sJDpeVuTw+km3LV3olOdpHgBVnDIu1n2O0nIId7XDCtW61bJpQdaLLG
         P02SmNdoee0lNRVmA6IjkiCjTZFSpV7yS9x5sdcDwkLcyYk8C577LFWcbsnIsnjs4eE3
         FMLEYCdvq7VmLFJ6sfYidkyC6c1b7ooNl3UqE4WcFTPoviC9o/Cer5so+I7k4QyEZYMD
         LP1hTjDWH1Tv3KiHEP2RPu9D8Pq/yC+lQtm/9UOlKR1laqkwBpSISYtI+PxJIuFIoldT
         Iw/w==
X-Gm-Message-State: AOAM533ABcdnkONUWee9QGL7nG2NFhRkd61eYyqQGxOuRso8THXsMiYb
        1Rp7oBCuFiaZK4v0qnvNWbRLUMxMr0s=
X-Google-Smtp-Source: ABdhPJyUfTPTFZc8hUeHI+dD4bfFcL0x2ysfp78YkPhpEXIAqKojYn5U65C+/pWyd/cczefXz/Cd4w==
X-Received: by 2002:a63:68c1:: with SMTP id d184mr494872pgc.405.1644868241417;
        Mon, 14 Feb 2022 11:50:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q94sm3968073pja.27.2022.02.14.11.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:50:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 09:50:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, matthltc@us.ibm.com,
        bblum@google.com, menage@google.com, akpm@linux-foundation.org,
        longman@redhat.com, mkoutny@suse.com, zhaogongyi@huawei.com
Subject: Re: [PATCH] cgroup/cpuset: Fix a race between cpuset_attach() and
 cpu hotplug
Message-ID: <Ygqyj7nns+mxH81t@slm.duckdns.org>
References: <20220121101210.84926-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121101210.84926-1-zhangqiao22@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 21, 2022 at 06:12:10PM +0800, Zhang Qiao wrote:
> As previously discussed(https://lkml.org/lkml/2022/1/20/51),
> cpuset_attach() is affected with similar cpu hotplug race,
> as follow scenario:
> 
>      cpuset_attach()				cpu hotplug
>     ---------------------------            ----------------------
>     down_write(cpuset_rwsem)
>     guarantee_online_cpus() // (load cpus_attach)
> 					sched_cpu_deactivate
> 					  set_cpu_active()
> 					  // will change cpu_active_mask
>     set_cpus_allowed_ptr(cpus_attach)
>       __set_cpus_allowed_ptr_locked()
>        // (if the intersection of cpus_attach and
>          cpu_active_mask is empty, will return -EINVAL)
>     up_write(cpuset_rwsem)
> 
> To avoid races such as described above, protect cpuset_attach() call
> with cpu_hotplug_lock.
> 
> Fixes: be367d099270 ("cgroups: let ss->can_attach and ss->attach do whole threadgroups at a time")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Applied to cgroup/for-5.17-fixes w/ stable cc'd.

Thanks and sorry about the delay.

-- 
tejun
