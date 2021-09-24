Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15C3416F06
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbhIXJgA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 05:36:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41628 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhIXJf7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 05:35:59 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id F2AAF1FFE0;
        Fri, 24 Sep 2021 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632476066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDntLQNLN6lkb4wP0qiiEY2Cp52Cp3JUhnteHpFO/Oo=;
        b=hNW9wJaJWv3vsI422axK/4ZwmDP3wpH8/RQnB9Yq6SGYmh8OUSzBAbB5534mN0ZXJv3PRQ
        /cQflQkkGM4y1nnJkC01BciIs/ASV5wqN2Y4u1Y6HXnQ5CpCKjEiF5yD5gNoX++lxniizk
        byWh4W+84H0up/qePINIqRBtPHfXhqA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id DC11E25D3E;
        Fri, 24 Sep 2021 09:34:25 +0000 (UTC)
Date:   Fri, 24 Sep 2021 11:34:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] mem_cgroup: optimize the atomic count of
 wb_completion
Message-ID: <YU2boTZhfbo0h/Xi@dhcp22.suse.cz>
References: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 24-09-21 14:46:22, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> In order to track inflight foreign writeback, we init
> wb_completion.cnt to 1. For normal writeback, this cause
> wb_wait_for_completion() to perform meaningless atomic
> operations. Since foreign writebacks rarely occur in most
> scenarios, we can init wb_completion.cnt to 0 and set
> frn.done.cnt to 1. In this way we can avoid unnecessary
> atomic operations.

Does this lead to any measurable differences?
-- 
Michal Hocko
SUSE Labs
