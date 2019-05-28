Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333822CDC0
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfE1RkF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:40:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37117 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1RkE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 13:40:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id h19so10135751ljj.4;
        Tue, 28 May 2019 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vrqv9/Iv3MI1xIjyN3OV08sjxDNX6ztkzOcRbglOqYU=;
        b=Jn3UOoYxRmXz0/8P3Xa1ogBoFdvfiEZw2RtmGsb44RMcX1DAy1oLZBJOdc0yUZWgsp
         7xDsDDfSRzse0HMpWGBh+B3/3KZdzQ4RtrR+ai9HHSTWdS3W/lOCz6XGCV5nioxnzy3g
         AwWANrslZw+zkzTcIFqpiBH42mm9qs6k6c4jUaNec5p3+Arjs9kmm3FEZBYRfWmeK26h
         6ejUGFeY6UP0HWbJH8dR+3FOeATW/2hzFzPARvfhKKOZJ6UoquVGdUZ3TROyy3I3JWb4
         3sNArYlNTwUNXs+RoRHymG/wz6N1UARoP5AZjl8pud20oUsrVARyF1KV3pz9bv2T89ep
         c0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vrqv9/Iv3MI1xIjyN3OV08sjxDNX6ztkzOcRbglOqYU=;
        b=Pwaibf2P0ZtfSRMQie3zAPIgWKkN+i4sjIhKzzuATd3tnup/lLSUgg66NkuAvnkN6w
         yPquGZHoosCG2M7+B6H+Z2Om5n8AF8UFJ1706d9FEGJIrVv2MWrqNrggePs3zD4WC/kh
         Xoh/fjvr3X7nsjICDpUvfp6cCm5c7oAxveb23rrb5WSs6N5f/JBKO5BBMh7Pcfc2FRr4
         B3Mkd19gwLL24LbugXMHq1+KOURZV3bSLZBtJ8DGbhM5R810gBmwzwmrWGWvsB4WoCkW
         F7IYU7hO96cXBG6pyIYSRsU2RABXYCSQIklOmHHfr938NglRT0BsxUFhay+mtV2Aqess
         A9EA==
X-Gm-Message-State: APjAAAXmJJClolc+Q45coW7xUjFzHKBHsksJN20pXr6rwMDcQewskMAJ
        ZkBgAZ7MvaMjjSrdsRYIJ88gOFrbluE=
X-Google-Smtp-Source: APXvYqwy0DxaU7TAPzZWannjuwTBDJOTg4m8sJCc5t6TldLIBR+KFV2pXC2+7AeA6vbnoN16p4wFfw==
X-Received: by 2002:a2e:129b:: with SMTP id 27mr34359558ljs.104.1559065202827;
        Tue, 28 May 2019 10:40:02 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id q124sm3003954ljq.75.2019.05.28.10.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:40:02 -0700 (PDT)
Date:   Tue, 28 May 2019 20:39:59 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/7] mm: rework non-root kmem_cache lifecycle
 management
Message-ID: <20190528173959.h4hq55b3ajlfpjrk@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-6-guro@fb.com>
 <20190528170828.zrkvcdsj3d3jzzzo@esperanza>
 <96b8a923-49e4-f13e-b1e3-3df4598d849e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b8a923-49e4-f13e-b1e3-3df4598d849e@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 01:37:50PM -0400, Waiman Long wrote:
> On 5/28/19 1:08 PM, Vladimir Davydov wrote:
> >>  static void flush_memcg_workqueue(struct kmem_cache *s)
> >>  {
> >> +	/*
> >> +	 * memcg_params.dying is synchronized using slab_mutex AND
> >> +	 * memcg_kmem_wq_lock spinlock, because it's not always
> >> +	 * possible to grab slab_mutex.
> >> +	 */
> >>  	mutex_lock(&slab_mutex);
> >> +	spin_lock(&memcg_kmem_wq_lock);
> >>  	s->memcg_params.dying = true;
> >> +	spin_unlock(&memcg_kmem_wq_lock);
> > I would completely switch from the mutex to the new spin lock -
> > acquiring them both looks weird.
> >
> >>  	mutex_unlock(&slab_mutex);
> >>  
> >>  	/*
> 
> There are places where the slab_mutex is held and sleeping functions
> like kvzalloc() are called. I understand that taking both mutex and
> spinlocks look ugly, but converting all the slab_mutex critical sections
> to spinlock critical sections will be a major undertaking by itself. So
> I would suggest leaving that for now.

I didn't mean that. I meant taking spin_lock wherever we need to access
the 'dying' flag, even if slab_mutex is held. So that we don't need to
take mutex_lock in flush_memcg_workqueue, where it's used solely for
'dying' synchronization.
