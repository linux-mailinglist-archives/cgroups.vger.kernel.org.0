Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33971B6A4D
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 02:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgDXAaB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 20:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAaB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 20:30:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493FC09B042;
        Thu, 23 Apr 2020 17:30:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n24so3077945plp.13;
        Thu, 23 Apr 2020 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VKBqm9dD1eT/9SukXzSTV56tiVVlcyEzdR7J/pmXPKk=;
        b=m89Egqb1/fpd9kMAnDYFVXpT/PykNFJynjooI9IkfNzptBO0nn6hRNuNFqW+S9/cQs
         I2G7BCUXvItMqimgVATxYqv+RILMmTTE4djYombXNLu7Z7n0bl+CqXPnvz16U6EO34Wm
         Cl2DFf5an4Lcfssj4J58eZqy/CAEkTbf154kGv5vfvMg/Ja8TA+7tat/vCLcw43k8XfA
         DepdD4VhfU78IPl278F8nFbHfOZ1CVrF/InsmkhRejTmrYOorm+sADgK48QqPxeygD27
         7nQGN83N0yfvNd32LTvpnEtyHVNpEDdIg/dI0uCv/eAo+I6Q5DjtOMEeNrU755zx2Olf
         j1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VKBqm9dD1eT/9SukXzSTV56tiVVlcyEzdR7J/pmXPKk=;
        b=cXylUdTRi8Xi4fRBfvBKP0KE68nROI4UYMKuBtLTwqpey79Iy0+ijMlfLzYVfyTrSt
         IvmS7dh4WPlkv25Et8krk1Nk3SgjbS6RDqkRMOLff0WCTsPf6OXyPrcu0Rr3eofecrKy
         oNECwla7RqiJzkQsGkOV2k17PCCeYtFojWtFa/e9i2V9CU5H8H2VeaC4s6d423M7Hn+M
         NC84SugB6iwFFFiAwGf91UrCaiW+BuoKcX0QeUN/QuEZs5PoWA7/QPd4fDOTLJTeKQui
         nmMiE1TFmNpRXI3hyEuXxefg4AVwJjOGFGABUkdnhvyC1m2TNMggRiVYOeiDe2to/wi2
         z/qw==
X-Gm-Message-State: AGi0PuZ9siDTaabgTJLPK8grHEy+m9DyhaFdW9T8gdVkkuTEooeg4LqK
        oYcIsnD+YgyN3PbjkEQJsoI=
X-Google-Smtp-Source: APiQypJT6Nadt5BNvAzYM+MkUKF7U+h/3uJB33B3PTb7LycB291fgvl92BjVgBvk/S9NyKHI021hmA==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr6200279plo.225.1587688199726;
        Thu, 23 Apr 2020 17:29:59 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id a136sm3891498pfa.99.2020.04.23.17.29.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:29:59 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:29:54 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 12/18] mm: memcontrol: convert anon and file-thp to new
 mem_cgroup_charge() API
Message-ID: <20200424002953.GB13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-13-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-13-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:20PM -0400, Johannes Weiner wrote:
> With the page->mapping requirement gone from memcg, we can charge anon
> and file-thp pages in one single step, right after they're allocated.
> 
> This removes two out of three API calls - especially the tricky commit
> step that needed to happen at just the right time between when the
> page is "set up" and when it's "published" - somewhat vague and fluid
> concepts that varied by page type. All we need is a freshly allocated
> page and a memcg context to charge.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
