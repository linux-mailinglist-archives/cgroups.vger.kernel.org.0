Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7717669A
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 23:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCBWME (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 17:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBWMD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 2 Mar 2020 17:12:03 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33FD421739;
        Mon,  2 Mar 2020 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583187123;
        bh=u00owx5AeCvb4Q/OakL2XqFZQBlbOD3X9KlvMyZ6N/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/RKQreadIbBaR77IOPoErtcimfL0iyJfsZUocHcMLCEY4S5MOvpM6dIKJ8P5bcJc
         LueHo/4by5fhWowdKPvagGgYH/8DV3KR6B9Nr0oVZf8sHcKAbyInhLkyD7bswHtkGk
         7Hgt9ic26m0ALwoXf49r1dkSLRGJyBUY5dAZTR5k=
Date:   Mon, 2 Mar 2020 14:12:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com
Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg
Message-Id: <20200302141202.91d88e8b730b194a8bd8fa7d@linux-foundation.org>
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon,  2 Mar 2020 19:00:10 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Hi all,
> 
> This patchset mainly includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation.
> 2, use TestCleanPageLRU as page isolation's precondition
> 3, replace per node lru_lock with per memcg per node lru_lock
> 
> The keypoint of this patchset is moving lru_lock into lruvec, give a 
> lru_lock for each of lruvec, thus bring a lru_lock for each of memcg 
> per node. So on a large node machine, each of memcg don't suffer from
> per node pgdat->lru_lock waiting. They could go fast with their self
> lru_lock now.
> 
> Since lruvec belongs to each memcg, the critical point is to keep
> page's memcg stable, so we take PageLRU as its isolation's precondition.
> Thanks for Johannes Weiner help and suggestion!
> 
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
>   https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> 
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang.

I'm not seeing a lot of evidence of review and test activity yet.  But
I think I'll grab patches 01-06 as they look like fairly
straightforward improvements.
