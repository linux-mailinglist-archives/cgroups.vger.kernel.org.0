Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D96689E41
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBCP1M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjBCP05 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:26:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8349D8F25C;
        Fri,  3 Feb 2023 07:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lu9oAwbuGqgDnRk3vRAVJgv15QaK9kCnbeHbuhe5rA0=; b=EhPD/CV7Oko1TZWYSADXXYt/PG
        uzsAuah2fSS0d/3HtoipFVQbZThMDP1SWU4zX1HT+rMfviXg+CcgLJpkK2jf2ltOd/1roCgYA5TrN
        KO10wtlhuAkl61snmCxBejQ6AsB04IeqEFc98wGUvmfdfnyEyQ2XJz8q/sxBgsRJkj+zLD2/CARNZ
        spwWDcJ4A1H7P4g/XaxYH7SU3u8Sr3cjHa9KTtteLvXfXwp5QqEnV/Z7Jtm8Urs4j+0PrmZm+GQXt
        SZIuV4kyQKQNhUAzXAuBDMn+Hr0Ua0buCV/N4teDGZsmai6FZpSKA/EH9p/0djo/hJDDRaqayQk3x
        XcAMnqiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxxI-00EPQd-LZ; Fri, 03 Feb 2023 15:26:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D85BC30012F;
        Fri,  3 Feb 2023 16:26:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEAF42C14E63E; Fri,  3 Feb 2023 16:26:23 +0100 (CET)
Date:   Fri, 3 Feb 2023 16:26:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <Y90nn9NVkEhcZ6nq@hirez.programming.kicks-ass.net>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
 <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
 <Y9rVVldS19oyIZ+g@hirez.programming.kicks-ass.net>
 <773e2f22-211e-163f-64bb-15ae29ad161b@redhat.com>
 <20230203115045.GB5927@willie-the-truck>
 <d626998b-4cb0-dd8f-fd97-21715bf2eb0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d626998b-4cb0-dd8f-fd97-21715bf2eb0b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 10:13:10AM -0500, Waiman Long wrote:

> I think I know where the problem is. It is due to the fact the cpuset
> hotplug code doesn't update cpumasks of the tasks in the top cpuset (root)
> at all when there is a cpu offline or online event. It is probably because
> for some of the tasks in the top cpuset, especially the percpu kthread,
> changing their cpumasks can be catastrophic. The hotplug code does update
> the cpumasks of the tasks that are not in the top cpuset. This problem is
> irrespective of whether v1 or v2 is in use.

I've been saying this exact thing for how many mails now?
