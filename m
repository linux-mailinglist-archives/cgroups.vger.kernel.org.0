Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF550C55E
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 02:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiDVXxd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 19:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiDVXx1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 19:53:27 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612521384AC;
        Fri, 22 Apr 2022 16:50:19 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:50:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650671417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMfzDL5JA0cUmzPiRnDBwSelMHWpmqS+/mHuZZauqFM=;
        b=a+wi3HYiqinXhmAX1F9VwZBpjFQJL0pEqfkuYWeOMEbit0scO0zBp35fOMYk8PD20VerZ5
        lumIWn3vCbVEP5N/z551GXFlgE+D5hka3VN93XUFQK1IT3xwVd6YYdtf7IuZbb095kD4Mu
        j4o406/OQtOcmMxu4SB1znE57WD+Apk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 4/5] cgroup: Removing racy check in test_memcg_sock()
Message-ID: <YmM/NCX9FwUY/GvB@carbon>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-5-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422155728.3055914-5-void@manifault.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 22, 2022 at 08:57:28AM -0700, David Vernet wrote:
> test_memcg_sock() in the cgroup memcg tests, verifies expected memory
> accounting for sockets. The test forks a process which functions as a TCP
> server, and sends large buffers back and forth between itself (as the TCP
> client) and the forked TCP server. While doing so, it verifies that
> memory.current and memory.stat.sock look correct.
> 
> There is currently a check in tcp_client() which asserts memory.current >=
> memory.stat.sock. This check is racy, as between memory.current and
> memory.stat.sock being queried, a packet could come in which causes
> mem_cgroup_charge_skmem() to be invoked. This could cause memory.stat.sock
> to exceed memory.current. Reversing the order of querying doesn't address
> the problem either, as memory may be reclaimed between the two calls.

But just curious, does it fix the flakiness (assuming there is no memory
pressure)?

> Instead, this patch just removes that assertion altogether, and instead
> relies on the values_close() check that follows to validate the expected
> accounting.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

