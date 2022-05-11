Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED213522A07
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 04:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiEKCuu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 22:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiEKCuE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 22:50:04 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A542244F3D
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 19:48:15 -0700 (PDT)
Date:   Tue, 10 May 2022 19:48:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652237293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uCnHxA7VpNijHGZNPJZUZ6oyRd7F+wjYsYtPWkS284E=;
        b=YUkOxIn+iOIzqbWiDTczG6RZIgmXSq88F65gW7aErpPupXjtoxJkrn/v0BLLzbivYUF7ob
        UfVf95n+NEMD1wM3k2Cvk7UZIFviS7lowrLBFMWS978ZvlGZUp9mdxQ/aWfAHMAgZgNjPI
        ZQmZTRAjYwAh838fjKkYcv5z2fExAuc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
Message-ID: <Ynsj6cZa8hUVYmhu@carbon>
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 06, 2022 at 10:09:16PM -0700, Ganesan Rajagopal wrote:
> We run a lot of automated tests when building our software and run into
> OOM scenarios when the tests run unbounded. v1 memcg exports
> memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> metric to heuristically limit the number of tests that can run in
> parallel based on per test historical data.
> 
> This metric is currently not exported for v2 memcg and there is no
> other easy way of getting this information. getrusage() syscall returns
> "ru_maxrss" which can be used as an approximation but that's the max
> RSS of a single child process across all children instead of the
> aggregated max for all child processes. The only work around is to
> periodically poll "memory.current" but that's not practical for
> short-lived one-off cgroups.
> 
> Hence, expose memcg->watermark as "memory.peak" for v2 memcg.
> 
> Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

I've been asked a couple of times about this feature, so I think it's indeed
useful.

Thank you for adding it!
