Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6262DF71
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 16:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiKQPSE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 10:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiKQPRt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 10:17:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ABE64546
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 07:12:23 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id jr19so1226336qtb.7
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb4RJ2noO6I+KBBEP872ofv51+cSy/3xrWUOMQWU1g4=;
        b=unvKwDbp6LIvRE1YZzhs+MLHGUogLNHOaJtbDbivWS5s44b5nd/+fzpFFuHNOngT5A
         4frV5x8oF3oEG+aSh2cr/LvyIvOLohkDasFZmTzDykSqt6JO/eI9HIhqoG9pCQzMorp7
         cxFJ8gX3Cl/eHNc3HKfulahIoglZ7NtSKddroAvfL0pkYFpiFZm0sWerGkyOm4Y6sFnE
         H/LiloikMwsXjYmWX95A7aWP4f6s8o+oHlLLspaKrBitIaNF0zrDvHaSBhtzn+7uevhb
         J3+xquR69zS5ohA1ttWbfAKezUsgPpzc0+yy75yslYQD/tEZUBYp0hgJ8Sz8+ASq2vX3
         w0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb4RJ2noO6I+KBBEP872ofv51+cSy/3xrWUOMQWU1g4=;
        b=G3wCSO+XE+Np6JmdFd/jx0I2HrlTi4jOW8D1SNaihnZDCYexj32b0jgmrcEZhs2X7a
         r0NV4VUiMqKKO6zLi9qy4JqYnekPhAcNYDxR1s66IfaVw5elmbS2nYaW1KvF1KJaeRwe
         NDGAqloEQLguLYKAZNTG1+b846TsukPQSD2l1H2Qby8bal/VCfwd/ifcqpPOF0ZnJyyN
         qJhJ2iFBP05hPI99KBPgF9FYPWy4FD66p9s6ZsHnQLXIWJzj/BRjxcIXvDjTvK8r7MoY
         xxGqvfNiBcBrYaQcko7amPTySTYWPZWjtuGWcQF+91waLlbRrN78OD9WVcSXPssNxcuY
         Xr4g==
X-Gm-Message-State: ANoB5pmFrBXmumRaQqNSsoJGqbhWOWvWLUg+c554cw/iDmrMxMJ9o5CO
        mjvyjtE4TEZeqn0S3q4fXuVzaw==
X-Google-Smtp-Source: AA0mqf6db36HEcuGPTsX5mFnx6+PAMiVxBZOXmOKzqIIc4IWHOrqiX1PGXdOEJM6QU27gkNBb9gQuw==
X-Received: by 2002:ac8:741a:0:b0:3a5:2932:3a77 with SMTP id p26-20020ac8741a000000b003a529323a77mr2534247qtq.591.1668697936744;
        Thu, 17 Nov 2022 07:12:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a248f00b006fa9d101775sm618553qkn.33.2022.11.17.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:12:16 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:12:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org
Subject: Re: cgroup v1 and balance_dirty_pages
Message-ID: <Y3ZPZyaX1WN3tad4@cmpxchg.org>
References: <87wn7uf4ve.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn7uf4ve.fsf@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Aneesh,

On Thu, Nov 17, 2022 at 12:24:13PM +0530, Aneesh Kumar K.V wrote:
> Currently, we don't pause in balance_dirty_pages with cgroup v1 when we
> have task dirtying too many pages w.r.t to memory limit in the memcg.
> This is because with cgroup v1 all the limits are checked against global
> available resources. So on a system with a large amount of memory, a
> cgroup with a smaller limit can easily hit OOM if the task within the
> cgroup continuously dirty pages.

Page reclaim has special writeback throttling for cgroup1, see the
folio_wait_writeback() in shrink_folio_list(). It's not as smooth as
proper dirty throttling, but it should prevent OOMs.

Is this not working anymore?

> Shouldn't we throttle the task based on the memcg limits in this case?
> commit 9badce000e2c ("cgroup, writeback: don't enable cgroup writeback
> on traditional hierarchies") indicates we run into issues with enabling
> cgroup writeback with v1. But we still can keep the global writeback
> domain, but check the throtling needs against memcg limits in
> balance_dirty_pages()?

Deciding when to throttle is only one side of the coin, though.

The other side is selective flushing in the IO context of whoever
generated the dirty data, and matching the rate of dirtying to the
rate of writeback. This isn't really possible in cgroup1, as the
domains for memory and IO control could be disjunct.

For example, if a fast-IO cgroup shares memory with a slow-IO cgroup,
what's the IO context for flushing the shared dirty data? What's the
throttling rate you apply to dirtiers?
