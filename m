Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C622DA50A
	for <lists+cgroups@lfdr.de>; Tue, 15 Dec 2020 01:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgLOAsF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Dec 2020 19:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgLOAsA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Dec 2020 19:48:00 -0500
Date:   Mon, 14 Dec 2020 16:47:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607993233;
        bh=1xpGGC/vHo/hofOltzktcDRnhP/LevhVE6j84KnfYPM=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=DNUlGdZNnHzOpluseVDsnuw0tRA/LEeJATl1J6XW/1EzTby2u4OOLs7ZskJbjv/i4
         5T3yERpzdqYlhctXUexMnhewwLhtswd3gY/k09z+D/4DibLsGxp/B3vVD6yj5EA8BU
         HUR/REfwotA7rhuleb+nw7YNFMM+pSM2k8vB7cAg=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v21 00/19] per memcg lru lock
Message-Id: <20201214164712.39da20f908c6199eb4cde961@linux-foundation.org>
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu,  5 Nov 2020 16:55:30 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> This version rebase on next/master 20201104, with much of Johannes's
> Acks and some changes according to Johannes comments. And add a new patch
> v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> v21-0007.

I assume the consensus on this series is 'not yet"?

Also, did
https://lkml.kernel.org/r/0000000000000340a105b49441d3@google.com get
resolved?

