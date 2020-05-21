Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1F1DC383
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 02:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgEUAWI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 20:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgEUAWI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 May 2020 20:22:08 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CD5205CB;
        Thu, 21 May 2020 00:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590020528;
        bh=VNT1XW0Hh5ozONz4ly7v1+37MuVVB4/dY6J8WDs59k8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fVcDR+ygrfYVVQ9LnCkI/9ox3ZHnXW8UYVQV3OFC9RZyQvgE2nFDnG1cxptt85e0X
         QjFs/LbptJMNlvxXW82HpSBAJVYCCHqH6VTjSFVMBxGE9mykhCIMrVG8s6utchYuun
         9GSOUw7zQAIvxKx11ame7WfNfMFykMArJ5iRrv4A=
Date:   Wed, 20 May 2020 17:22:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org
Subject: Re: [PATCH mm v5 0/4] memcg: Slow down swap allocation as the
 available space gets depleted
Message-ID: <20200520172206.4e55b66f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200521002010.3962544-1-kuba@kernel.org>
References: <20200521002010.3962544-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 20 May 2020 17:20:06 -0700 Jakub Kicinski wrote:
> Tejun describes the problem as follows:
> 
> When swap runs out, there's an abrupt change in system behavior -
> the anonymous memory suddenly becomes unmanageable which readily
> breaks any sort of memory isolation and can bring down the whole
> system. To avoid that, oomd [1] monitors free swap space and triggers
> kills when it drops below the specific threshold (e.g. 15%).
> 
> While this works, it's far from ideal:
>  - Depending on IO performance and total swap size, a given
>    headroom might not be enough or too much.
>  - oomd has to monitor swap depletion in addition to the usual
>    pressure metrics and it currently doesn't consider memory.swap.max.
> 
> Solve this by adapting parts of the approach that memory.high uses -
> slow down allocation as the resource gets depleted turning the
> depletion behavior from abrupt cliff one to gradual degradation
> observable through memory pressure metric.
> 
> [1] https://github.com/facebookincubator/oomd
> 
> v4: https://lore.kernel.org/linux-mm/20200519171938.3569605-1-kuba@kernel.org/
> v3: https://lore.kernel.org/linux-mm/20200515202027.3217470-1-kuba@kernel.org/
> v2: https://lore.kernel.org/linux-mm/20200511225516.2431921-1-kuba@kernel.org/
> v1: https://lore.kernel.org/linux-mm/20200417010617.927266-1-kuba@kernel.org/

Ah, damn, I forgot to add Shakeel's review tags, let me resend.
