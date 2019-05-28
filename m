Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA62D14E
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfE1WD4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 18:03:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42675 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfE1WD4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 18:03:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so144232pfh.9
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZB6HVXPOZ6dJd49xc2bEcD13tElE9byJqAMfahspmoo=;
        b=ToLngH1jdhNI9UHTF8mqD15qUyNQONEg/Z1t3IceMNsoGy9/azm9l4mpXuBFjzeaNU
         DF0dDXbXAvHbBYG0zaQQPpZ/V9sOMriSfNAjQuG5jB3Z+5sMan2GbE4PmLqavh+/yWBT
         dBgFl+Y0x0ZlpdGRI0ttZdHXZKhRYg/Mc4cf+maDZn3pGpuX+sEs1wWdvYCtv4U6SS8v
         2sZKF5aqRSTCE8fqQLDzWJzu+yMg5zVT2DhXjcFim48rFB+G6IWcYilRZeLczdJ2Jm8l
         iNuAb1Z6C7WuucQuNmOjutEP7zMEQcJU0AxxjHeZCcGSZVyvtBwq7unQv0RRuwvFOdlg
         hntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZB6HVXPOZ6dJd49xc2bEcD13tElE9byJqAMfahspmoo=;
        b=QuJwyg5EVBIuNqxNEUyAXjo3J0WHDVEA5phODjFVhiQG+qhDiB4z5sjOcMWdchYTPG
         z54IVj2Klk9k+e9iKEuR9xfL8shcNbPktBcp2uxAJOQjzHk+a7cttV4TVE8DvDzg04g0
         /qMf+gn/YLdZuhVlpvPMzZY4fd8eCuUviQq53Myf7hThSdPQqIbg212VhVuAChkWOAJ7
         dcuIcWeALdACLsedsZ2hNsxudpjMlgy7wG8lORYVIEyX06wuYEhsMf8uI17UComK4x5H
         OOw7QhicfmpORlCsFSwTSRvW7z544MgMoKm8+Khcc9QLwTVYAWNQ4aav6JLamDNSuMCT
         57DQ==
X-Gm-Message-State: APjAAAXJoA9XRQhBidvAhYrwSyWT7fTY3WQ/qwNQawG4HACt2YmfvmLE
        /+0LIcmnwsvedD/pCleNVeXelQ==
X-Google-Smtp-Source: APXvYqzrWHTxmX3tkqxvO2eICb8IW51vt1RCtasgNZVBi3RMlnod6+qiquwYFm4jFkcJvnbuNsMD4Q==
X-Received: by 2002:a62:75c6:: with SMTP id q189mr143220121pfc.98.1559081035831;
        Tue, 28 May 2019 15:03:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:77ab])
        by smtp.gmail.com with ESMTPSA id c97sm3674631pje.5.2019.05.28.15.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 15:03:55 -0700 (PDT)
Date:   Tue, 28 May 2019 18:03:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 5/7] mm: rework non-root kmem_cache lifecycle
 management
Message-ID: <20190528220353.GC26614@cmpxchg.org>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-6-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 01:07:33PM -0700, Roman Gushchin wrote:
> +	arr = rcu_dereference(cachep->memcg_params.memcg_caches);
> +
> +	/*
> +	 * Make sure we will access the up-to-date value. The code updating
> +	 * memcg_caches issues a write barrier to match this (see
> +	 * memcg_create_kmem_cache()).
> +	 */
> +	memcg_cachep = READ_ONCE(arr->entries[kmemcg_id]);

READ_ONCE() isn't an SMP barrier, it just prevents compiler
muckery. This needs an explicit smp_rmb() to pair with the smp_wmb()
on the other side.

I realize you're only moving this code, but it would be good to fix
that up while you're there.
