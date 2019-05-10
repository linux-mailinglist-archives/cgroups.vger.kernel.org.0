Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34641A465
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 23:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfEJVRB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 17:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfEJVRB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 10 May 2019 17:17:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9735520896;
        Fri, 10 May 2019 21:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557523020;
        bh=WrSi5jHV6SOltHTRjAOARni7OmFLSEe0K6ep9p6h53s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YNxRIaYgHUo1dWlD85ZFCIL5YSk3Cha+eYCoGs5AgoCUDVCBzesDOqhW3oY60AP1O
         ARNXJwykVG2EbSSoceQDX3qlwp0wm3LhS+fgUA3xdDskZL1P1OY/wToCjOfz7XYwk9
         n4L/v528+OlY1WjeYvlQLjXiYKlFWEp6Kr2gzaJs=
Date:   Fri, 10 May 2019 14:16:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH] psi: Expose pressure metrics on root cgroup
Message-Id: <20190510141659.08f58679c2eb3d321092dc23@linux-foundation.org>
In-Reply-To: <20190510174938.3361741-1-dschatzberg@fb.com>
References: <20190510174938.3361741-1-dschatzberg@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 10 May 2019 10:49:34 -0700 Dan Schatzberg <dschatzberg@fb.com> wrote:

> Pressure metrics are already recorded and exposed in procfs for the
> entire system, but any tool which monitors cgroup pressure has to
> special case the root cgroup to read from procfs. This patch exposes
> the already recorded pressure metrics on the root cgroup.
> 

Documentation/admin-guide/cgroup-v2.rst says "A read-only nested-key
file which exists on non-root cgroups". 
Documentation/accounting/psi.txt could do woth some clarification as
well.

