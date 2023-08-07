Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2E772E0E
	for <lists+cgroups@lfdr.de>; Mon,  7 Aug 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjHGSmF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Aug 2023 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHGSmE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Aug 2023 14:42:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566D171A;
        Mon,  7 Aug 2023 11:42:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb84194bf3so31963115ad.3;
        Mon, 07 Aug 2023 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691433723; x=1692038523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjR5pXl0UuinG01FbgVJViJLXMyiirXmYlC8ixIZaWI=;
        b=LBJ/vxIxnRKTm7zQ76pErn2jwczKbYDq41bpll/TUjJBnW7H/rQJVuz1tyUkGcB6oM
         sV67vRXYiyxhwWeEsQLiJ0ID04XmOSbbo3N1w86bLzq6xWRNq49SI9OPgbvf4/AyPxLs
         qL4112juNxcf595WcqGthvXUXZhQWF/PBxa+jZ+4C7rjwk36arxNV9yw3hoY7vf+XO1r
         0TxQ8G0HUw0gsWJjOTe85l556gc0VS5FHct7gGGq0LhfJcw8uIHOTS6oK6fTMFklJiHn
         Yey8etyXTAmszbJjWEEybEs45+iZ77ajyB36HpRv1hA6Fqc7E+0qtnvqqxBV2B9+Qy4k
         XBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433723; x=1692038523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjR5pXl0UuinG01FbgVJViJLXMyiirXmYlC8ixIZaWI=;
        b=T4JMuAtyEWFhbRVXbEXVzL56fxogEzKJDXFv1Ln6FqQk76R3KfQ7Z2GWoSRRQRz8Qo
         n5DOcchAHgVJddukewY37OI5bDZoOQh8tUamfjn2GYg7Y0fMdNywpGLXOtLLN+5ahNym
         x+8YthwicJHe572/TeaJxabLnwcYjis/FFFv6Q07Er8rQWIIlG33il6eQwnZvCyyHHOu
         kM8MTH2ECA8WcMapcQHFQLxN9PX+uo6lS5dM0O/fdiUEcSze/aw6Rl+LEx2NJpDhymlT
         Om3q9s/fyiIi+3sXL/vMPbiH1I5FePZr+XpozEbwTFiK+IN7Wh/Y61Pb91RydtqLFNmm
         oSvg==
X-Gm-Message-State: AOJu0YzFe7Y14MMJTIQzmZmrWD58pgnluejCqoINflcpPGZiRwVi6qE6
        ct92VRfsibKwrgygwdZTKkI=
X-Google-Smtp-Source: AGHT+IF5OMe5bFNGQysrQDFaEvUlHdMMAhUHimv4sE0RqHepvqKXiKrN6ts3bZVslLjBfXo6BT8gew==
X-Received: by 2002:a17:903:1cb:b0:1bc:5bdd:1f38 with SMTP id e11-20020a17090301cb00b001bc5bdd1f38mr7575761plh.3.1691433723515;
        Mon, 07 Aug 2023 11:42:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001b801044466sm7240525plg.114.2023.08.07.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:42:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 08:42:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        songmuchun@bytedance.com, muchun.song@linux.dev,
        wuyun.abel@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/rstat: Record the cumulative per-cpu time of
 cgroup and its descendants
Message-ID: <ZNE6-U5zwKUguRJE@slm.duckdns.org>
References: <20230807032930.87785-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807032930.87785-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 07, 2023 at 11:29:30AM +0800, Hao Jia wrote:
> The member variable bstat of the structure cgroup_rstat_cpu
> records the per-cpu time of the cgroup itself, but does not
> include the per-cpu time of its descendants. The per-cpu time
> including descendants is very useful for calculating the
> per-cpu usage of cgroups.
> 
> Although we can indirectly obtain the total per-cpu time
> of the cgroup and its descendants by accumulating the per-cpu
> bstat of each descendant of the cgroup. But after a child cgroup
> is removed, we will lose its bstat information. This will cause
> the cumulative value to be non-monotonic, thus affecting
> the accuracy of cgroup per-cpu usage.
> 
> So we add the subtree_bstat variable to record the total
> per-cpu time of this cgroup and its descendants, which is
> similar to "cpuacct.usage*" in cgroup v1. And this is
> also helpful for the migration from cgroup v1 to cgroup v2.
> After adding this variable, we can obtain the per-cpu time of
> cgroup and its descendants in user mode through eBPF/drgn, etc.
> And we are still trying to determine how to expose it in the
> cgroupfs interface.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
