Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77347358B30
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 19:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhDHRTR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhDHRTM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 13:19:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5948BC061760
        for <cgroups@vger.kernel.org>; Thu,  8 Apr 2021 10:19:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v140so5310096lfa.4
        for <cgroups@vger.kernel.org>; Thu, 08 Apr 2021 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gEpNulq0JouzND7X8G/z4bZ8lZh7ERFU8FSsc0Dzac=;
        b=noL0zUmUFj2zwRUlYv3RquGNc8nwvDeqlE7uolCFVwehPyaRUjY3VAKKdGmRjzbZLl
         fD/PB2RNqDPIm2ezoQBU50070lVbfVsBOPRUfF+ZdyFQ+u6wHf9KMr7fBrLDaTEI1FbC
         XnC8zE6YqHXvJ/ZndiMiAa/1OhHSxtZ5S2Qa5UuUIrwGZtS96hvH34Wr1Io9GkW4/YgG
         zP/vAfPyeqU0PLkig/L+1rfZZmne+DWF9FAvwzjvjDLs6bwdvCIEtJyrdhIzts+iS2OA
         TCT04r2xZHuzfYbs0VIAhgUPfg2fj8fWboitjtol+M2nlDBeCyOsQessN0yhxxmJ/rQH
         Ix3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gEpNulq0JouzND7X8G/z4bZ8lZh7ERFU8FSsc0Dzac=;
        b=cj+x4bBwYUcYlemCOkL2LXH3hiitBuN7CPMEs0MOeIlUNtHfQr9eLFqEdFZnjXFVPw
         HrfTlcaISA9JU0fYvkhkHWCy4tDmSeiJReNtutBNJrgc8VOJHiseaEkZcJG8iPkOLBzR
         Vr7+umajj315R/X6sKvPMbH40XWH45n0gzluKVokRuSGLcFMWfnhKkbwWXNEiieS0Iel
         s3PO2WLZCRptC4VTGcOJi0eFMKpDEqOTe/xx4G355f0mEq9bhh33cEXkoYqjc3lnzwMs
         LX547CeOS71LEcgEZwQzOHiddeyh7UVDAxPlkoxcHvLwAr/TNPKpwfm3rALLedyQ5DkJ
         Hf9A==
X-Gm-Message-State: AOAM533naEJAjY0Gf9V4Ve4NPThjuENc2hfoDlrH6iE3EsftPN3Qm9Kw
        uDvZ1c6tcO1oQ0sxMCcuCjaweUNGJBnphwsbm9A1Hw==
X-Google-Smtp-Source: ABdhPJxrQIVn50yQwVDP1KBGEaeW1VjAaTwKlqTcXbP8XbkcSZjoaC/A0UKnyxmh/feBPbCrnpCocgTLcYJ/w/IEW9M=
X-Received: by 2002:a05:6512:3703:: with SMTP id z3mr7163066lfr.358.1617902338550;
 Thu, 08 Apr 2021 10:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 10:18:47 -0700
Message-ID: <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tim,

On Mon, Apr 5, 2021 at 11:08 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> Traditionally, all memory is DRAM.  Some DRAM might be closer/faster than
> others NUMA wise, but a byte of media has about the same cost whether it
> is close or far.  But, with new memory tiers such as Persistent Memory
> (PMEM).  there is a choice between fast/expensive DRAM and slow/cheap
> PMEM.
>
> The fast/expensive memory lives in the top tier of the memory hierachy.
>
> Previously, the patchset
> [PATCH 00/10] [v7] Migrate Pages in lieu of discard
> https://lore.kernel.org/linux-mm/20210401183216.443C4443@viggo.jf.intel.com/
> provides a mechanism to demote cold pages from DRAM node into PMEM.
>
> And the patchset
> [PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system
> https://lore.kernel.org/linux-mm/20210311081821.138467-1-ying.huang@intel.com/
> provides a mechanism to promote hot pages in PMEM to the DRAM node
> leveraging autonuma.
>
> The two patchsets together keep the hot pages in DRAM and colder pages
> in PMEM.

Thanks for working on this as this is becoming more and more important
particularly in the data centers where memory is a big portion of the
cost.

I see you have responded to Michal and I will add my more specific
response there. Here I wanted to give my high level concern regarding
using v1's soft limit like semantics for top tier memory.

This patch series aims to distribute/partition top tier memory between
jobs of different priorities. We want high priority jobs to have
preferential access to the top tier memory and we don't want low
priority jobs to hog the top tier memory.

Using v1's soft limit like behavior can potentially cause high
priority jobs to stall to make enough space on top tier memory on
their allocation path and I think this patchset is aiming to reduce
that impact by making kswapd do that work. However I think the more
concerning issue is the low priority job hogging the top tier memory.

The possible ways the low priority job can hog the top tier memory are
by allocating non-movable memory or by mlocking the memory. (Oh there
is also pinning the memory but I don't know if there is a user api to
pin memory?) For the mlocked memory, you need to either modify the
reclaim code or use a different mechanism for demoting cold memory.

Basically I am saying we should put the upfront control (limit) on the
usage of top tier memory by the jobs.
