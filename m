Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0485124C482
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgHTR2w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbgHTR2o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 13:28:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E564C061385
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 10:28:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so1749224qtn.7
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGSTy2S11pQaFof1yGnLyVAv1YOvYkkwg2xvJjtqeUQ=;
        b=B0zXn8r/1mchT7VpWpZ+mN4JB+LQTOAcThKwvNYAguEIUDOZHwwTrdR6gzmQZ5tubZ
         nadwJJP0FhhTUc6qtozlaIcQuD/FFdRoOqCSSFPC20808u50MokVC+zzcj74bSNK3564
         K2rPaPV6/LqFSt2EYvyidWPeBNnkH5k+UUHnDDp7LsHM+QUZl4RIfl0sMDasq2fgoDTh
         aEiFbkQ9IhmoLjkYAaQc2VPQYaxtLY7ONExn+cDWgW0LH7qwa/cgM2WtSkYRhS29jGEn
         +HZQ+jI+GqR+PBIfIjicJ0wnOj2ML6oSYHPVNMYabbRVYTlqLboSPlY8YiNQkmtdg/2E
         7wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGSTy2S11pQaFof1yGnLyVAv1YOvYkkwg2xvJjtqeUQ=;
        b=TyTAAtkEDEleANbXuxhj1fm/KQIvjAgcGDSwPOek2vviQKpX4Hf0K2OY21GtNgQyn5
         PH877+/Xw1KRJ0ziFSYqFbvaBl7tu1dOnsBLD/FN5DMYUZlH/WUYYKCIUtHJpIptX1Gr
         wuWx66F8sxY12VRIvqee7TReRAbvVl1ztqAkQ3Lu58DLyAaLvOEp/W6hfEfRTbVHIU+j
         KvzMQ0La8VWl2eu/dG8mzaI9W6XfFyOW5dxzAhBmDj6oEJUUMGXX8NKGAczAUg3jNY6j
         hI5LkWfzeiCTt08G5twOb7nXdm9NZUlxzSgl45qDfsvmHASpaPPbOr4DaDLkeNY9PmNc
         Vebg==
X-Gm-Message-State: AOAM532RqRuPWnhA4Uy51nqCThkd9l7agODCD9MIN6vCb0TCWqJSwve3
        oBrm6uFzxNcW0qnsqD0XE+nGPw==
X-Google-Smtp-Source: ABdhPJzxECzP6spyILQOPgtHzJiSltg/hxxoXq1qcxUwEjRfqOCr081RyncGF5PD5joh3rhL7RCH+w==
X-Received: by 2002:ac8:7c87:: with SMTP id y7mr3692080qtv.375.1597944521618;
        Thu, 20 Aug 2020 10:28:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3cdd])
        by smtp.gmail.com with ESMTPSA id r188sm2708541qkb.122.2020.08.20.10.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:28:40 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:27:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/3] mm/memcg: Clean up obsolete enum charge_type
Message-ID: <20200820172726.GA912520@cmpxchg.org>
References: <20200820130350.3211-1-longman@redhat.com>
 <20200820130350.3211-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820130350.3211-2-longman@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 09:03:48AM -0400, Waiman Long wrote:
> Since commit 0a31bc97c80c ("mm: memcontrol: rewrite uncharge API") and
> commit 00501b531c47 ("mm: memcontrol: rewrite charge API") in v3.17, the
> enum charge_type was no longer used anywhere. However, the enum itself
> was not removed at that time. Remove the obsolete enum charge_type now.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
