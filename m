Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6525BEB
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2019 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfEVCXw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 22:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfEVCXw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 May 2019 22:23:52 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50F72173C;
        Wed, 22 May 2019 02:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558491832;
        bh=wUT9Oh+IJNtkbs2q1QgrEx8t9Q4hOJE0j84LxGl06Ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rrMba+ZX8lAWROnAkoY5D87S9fOHTRdkoZESFNef+egifs+9lW5INd3V34LCpOvOW
         ep7TPyh1yBfU7lTlu2c/pnv0E+itIOFlpZ0CBGnpLSdfWnHistSsaGwGjpZ44icvk7
         UFRqgijB26uTYluj1BTcuo9Hh9ACLE+qIkeUJN3I=
Date:   Tue, 21 May 2019 19:23:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, mm-commits@vger.kernel.org,
        tj@kernel.org, guro@fb.com, dennis@kernel.org,
        chris@chrisdown.name,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-Id: <20190521192351.4d3fd16c6f0e6a0b088779a6@linux-foundation.org>
In-Reply-To: <20190518013348.GA6655@cmpxchg.org>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
        <20190213124729.GI4525@dhcp22.suse.cz>
        <20190516175655.GA25818@cmpxchg.org>
        <20190516180932.GA13208@dhcp22.suse.cz>
        <20190516193943.GA26439@cmpxchg.org>
        <20190517123310.GI6836@dhcp22.suse.cz>
        <20190518013348.GA6655@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 17 May 2019 21:33:48 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> - Adoption data suggests that cgroup2 isn't really used yet. RHEL8 was
>   just released with cgroup1 per default. Fedora is currently debating
>   a switch. None of the other distros default to cgroup2. There is an
>   article on the lwn frontpage *right now* about Docker planning on
>   switching to cgroup2 in the near future. Kubernetes is on
>   cgroup1. Android is on cgroup1. Shakeel agrees that Facebook is
>   probably the only serious user of cgroup2 right now. The cloud and
>   all mainstream container software is still on cgroup1.

I'm thinking we need a cc:stable so these forthcoming distros are more
likely to pick up the new behaviour?

Generally, your arguments sound good to me - I don't see evidence that
anyone is using cgroup2 in a manner which is serious enough to be
seriously affected by this change.

