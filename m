Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835E952699C
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383411AbiEMSyh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383405AbiEMSyf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 14:54:35 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B146B7DD;
        Fri, 13 May 2022 11:54:34 -0700 (PDT)
Date:   Fri, 13 May 2022 11:54:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652468073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WunYiDoozFlJnA00AKYmdrxduHSk2KR4s1IxWu01ZWc=;
        b=AkUGvY90Jenytj6a63yYuxluujbvSqSww8LlEQcAyTtBtRbjxIIxf66PW9Ho/kLc5jtzJt
        drtj2VBNrmFmOyBVoOFl14yrxxxMFOjvCF+s0/THk6f1LHXt5FgsMgN79qfdYRcsU380PR
        kUR0n2FgMwIWI+167bKGI6XfkBdyL0I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     void@manifault.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 2/4] selftests: memcg: Expect no low events in
 unprotected sibling
Message-ID: <Yn6pWPodGPlz+D8G@carbon>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513171811.730-3-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 07:18:09PM +0200, Michal Koutny wrote:
> This is effectively a revert of commit cdc69458a5f3 ("cgroup: account
> for memory_recursiveprot in test_memcg_low()"). The case test_memcg_low
> will fail with memory_recursiveprot until resolved in reclaim
> code.

Hm, what are our plans here? Are we going to fix it soon-ish, or there
is still no agreement on how to proceed?
