Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE36877A0
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 09:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBBIfz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 03:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjBBIfs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 03:35:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC410273;
        Thu,  2 Feb 2023 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYRHjdpFC8rwNVpnVUsVW62VMDGH/LfAMOltBaeapz8=; b=hbB48Di5yNViLQvKyzXJLd2eO+
        dY/VBrumUuxNjXWoyQkTykoHyZoNnMSLuTw3cTyDWiloSvSn1AyO8KfJXUeVYyuL/myc88zdKxhbn
        WyRJQnnT/hDfTw1lRxGRbnOLb7RfS8OWzVamBHJ0f2R4kSvCUi087q81qMgHV0f/ibr91K8L3lM33
        QlLcpYH1mYfoWwMWVUjHw4KOZcT+1/ZiazZ1ag6wQVFG2bvzVg8oHWx1U/JQ3Xh0LkjtGMpHlYSwU
        r8MNKzvtULpetEvfvA4w3Dw60F/q5lqAtubxEeGXx2tmGgMUQbIiN7Qtq6XuKe/HR+odRhS5+85+g
        K59hmjBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNV3a-00DEC1-DB; Thu, 02 Feb 2023 08:34:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6AE73001E5;
        Thu,  2 Feb 2023 09:34:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C39C020A3B6EA; Thu,  2 Feb 2023 09:34:56 +0100 (CET)
Date:   Thu, 2 Feb 2023 09:34:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 11:14:27PM -0500, Waiman Long wrote:

> A major concern I have is the overhead of creating a poor man version of v2
> cpus_allowed. This issue can be worked around even for cpuset v1 if it is
> mounted with the cpuset_v2_mode option to behave more like v2 in its cpumask
> handling. Alternatively we may be able to provide a config option to make
> this the default for v1 without the special mount option, if necessary.

It is equally broken for v2, it masks against effective_cpus. Not to
mention it explicitly starts with cpu_online_mask.
