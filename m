Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D558A2FF38B
	for <lists+cgroups@lfdr.de>; Thu, 21 Jan 2021 19:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbhAUStC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jan 2021 13:49:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:35618 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbhAUSnc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 21 Jan 2021 13:43:32 -0500
X-Greylist: delayed 89984 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 13:43:31 EST
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 96974615D;
        Thu, 21 Jan 2021 18:42:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 96974615D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611254569; bh=KxfdKf8J8tSGmZBq7yUG1lQFeXM6uq332DkLkZd7fX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RiCC6D6hJcmhA73DYZ9EDpdyYi7l9DJ+s/6X+ShfHRxUdJ0YlVFWKaYHLmwvVmgbT
         w4Zz225icshrnee3FBiQ60Mlud887sRzamj0xhfGjEXRMGUMU76VfKvkyPHwtA8a1M
         V2N0Xo2kPQeej5Bf849DoW6Q1P7lVEQWmXGfZkk7o4g7Dne0uYsRNiprEi/I/KA2EY
         h+8J0F98aqslMz1BGRVUl5d/PYhFY2xhVoeCcSlqmIqxQcUhm1Pj4B0GYzfMndKrk/
         IPaPJwZSJL5Avg6PrhyKkAK9s2bhWynEmOPuZldsLbgPpFvOTZJrO2D7DTjjJ7HJnj
         k+zC1l/gXD3Iw==
Date:   Thu, 21 Jan 2021 11:42:48 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Kir Kolyshkin <kolyshkin@gmail.com>, linux-doc@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 00/10] docs: cgroup nits and fixes
Message-ID: <20210121114248.1c60c394@lwn.net>
In-Reply-To: <YAhdwtMS98iPma+S@mtj.duckdns.org>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
        <YAhdwtMS98iPma+S@mtj.duckdns.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 20 Jan 2021 11:43:46 -0500
Tejun Heo <tj@kernel.org> wrote:

> For the series,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> I suppose it'd be best to route this through the doc tree?

Works for me.

I've applied the set with the exception of #4, which still seems
unnecessary to me; Kir, I can reconsider that if you want to argue the
case.

Thanks,

jon
