Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78437BBDAE
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjJFRZd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjJFRZc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 13:25:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C153C5;
        Fri,  6 Oct 2023 10:25:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2706BC433C7;
        Fri,  6 Oct 2023 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696613129;
        bh=wLse5zDSVS+RScsM3WAUWNwpS7JJkCOs2oALrayhWiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A46/ZRdq/OPLaN3/gIS7spr9LUntOhdg9WjT9s6w9Saef20MdhSUEFefsQqPGOpLg
         VcCuB0KD+kdRv0yhLGDG3d2ZKSyz2UkPLj7zIZbz9vSXVw9VhgJuBMaCHHovpS6eOk
         Xemx64JC2pa8zy/JhD/xOn/6TMqzXTzA8grVHCko=
Date:   Fri, 6 Oct 2023 10:25:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller (fix)
Message-Id: <20231006102523.cc8ea46aeda6ef0a03ae22a2@linux-foundation.org>
In-Reply-To: <20231004194506.946908-1-nphamcs@gmail.com>
References: <20231003001828.2554080-3-nphamcs@gmail.com>
        <20231004194506.946908-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed,  4 Oct 2023 12:45:06 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> Ensure hugetlb folio migration also transfers the memcg metadata.
> 
> This fixlet should be squashed to the following patch:
> https://lore.kernel.org/lkml/20231003001828.2554080-3-nphamcs@gmail.com/
> hugetlb: memcg: account hugetlb-backed memory in memory controller
> 

I've rather lost track of what's going on here.  I'll drop the series
"hugetlb memcg accounting" v3.  Please resend everything and let's try
again.

