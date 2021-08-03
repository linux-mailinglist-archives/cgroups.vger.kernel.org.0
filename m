Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF953DF65B
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHCU0J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 16:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhHCU0I (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 3 Aug 2021 16:26:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 199996056B;
        Tue,  3 Aug 2021 20:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628022356;
        bh=4UYyWRfegSMj4Y3aIRE3t+wlvCWreIb2YkpXno8GWJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NpkXsJyLuV8Rto+fPBp/xHoG9B7ruK6eYb8Z7oC7u8GRdLsJ8QBsTlea5Zu7XVjQm
         3pQLDu6NvFJw5H/xSqZhv9tZxnC1zJjfwMf+lA5rOsFGOpIjr6s79ctI9TkBeCcLMW
         U29HEHnj0fUYAJCegoW4d70q9xfFl6TPyJZ8fn1I=
Date:   Tue, 3 Aug 2021 13:25:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: Set the correct memcg swappiness
 restriction
Message-Id: <20210803132555.51b95495b453180060526cab@linux-foundation.org>
In-Reply-To: <02826fde-43a8-e20d-37f5-55416ba0c773@linux.alibaba.com>
References: <d77469b90c45c49953ccbc51e54a1d465bc18f70.1627626255.git.baolin.wang@linux.alibaba.com>
        <YQOekWWgtZUfim4M@dhcp22.suse.cz>
        <6e6570d2-44a2-1da1-6c2a-38766786c40c@suse.cz>
        <02826fde-43a8-e20d-37f5-55416ba0c773@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 3 Aug 2021 23:45:20 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> > So, also Fixes: c843966c556d ("mm: allow swappiness that prefers reclaiming anon
> > over the file workingset")
> > ?
> 
> Sure. Andrew, do I need resend it with adding fixes tag, or you can help 
> to add it? Thanks.

I added the Fixes tag, thanks.
