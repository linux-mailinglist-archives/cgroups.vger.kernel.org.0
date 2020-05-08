Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33411CBA2E
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHVwr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgEHVwq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 17:52:46 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C94C05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 14:52:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ep1so1591390qvb.0
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Bg23MpwaLt5ES1Q90+CSXO9u0G+8VEy9TthqACk8pE=;
        b=1rm4qMVbcyKhgRbqDol38rBrkbyaZbxpfkXsQfwESaWUofm9FQVmK/wxaUfeIUZygo
         HsGYt09Ll+D1Q0/NDvGuVng7N+gAh0575gb8z6n8u+dxMoQHoC1vfOYVhf68hgZoLvhb
         LvTWV94B9ObgkjWuVKW+yxNPICHdMTrcOc92uPtwZpCy5PSiU0iklgWmIEx1+ny+Lmdp
         r8n9oZQHT856fp9eRfvxZU5UPwlEyFophlObXiv3bFFtElwVs1Cw9q3D149s40LMK8a/
         ZWmePp2TvUuF/ICL2KJQ7+1+jY2pq+wlkDiMsN/8bp0c8W/1W2ZxCweHg7a/K6x7WB9D
         NnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Bg23MpwaLt5ES1Q90+CSXO9u0G+8VEy9TthqACk8pE=;
        b=BsVF42gNRfSPVXGpCie5xtuqyuEYaNeGwb43QRgduqw5G/drEJkWDhGQpHtgf/Lwry
         3crChYHJJ2f0bEQEeYEeTDNrUNPfSeSJcXZfRqxiU3j21qgUCRxG+Yvj+O+dsyDz3Efu
         3V/SdMMh6rbNC79E+bl0hxoIuJsQVwdLibPEzw0ARozM8TXJniL4df8u6SM8GSWczra6
         BEqkijz81IcgoC8b1jJhPwcWBDlAhK603/3wqBLcLOxApwBi6xNdZu7ZIT0/cWikg4iN
         uNee5WOqd+TsiZFGeTpKfCbk3kVpeajpEoA5B0dGiTC/AywRNrEpXfQ4SFpbpk6I9tAq
         JVtw==
X-Gm-Message-State: AGi0PubjmR+JF+3qNZJvUdcFy6yDDWqwYAlxo1wk5bajF+FCXx5zgCmo
        nZKYd4uzTAXMarYdyGT3WGL9mA==
X-Google-Smtp-Source: APiQypKmtl+1oHPPWXjPwav7h15WBhj4HMNp31tMAisZWuYqEd91uBiMzUO1EmthvbIEeETVN6J6bg==
X-Received: by 2002:a0c:f8c4:: with SMTP id h4mr4924155qvo.15.1588974765599;
        Fri, 08 May 2020 14:52:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id m7sm2547075qti.6.2020.05.08.14.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:52:45 -0700 (PDT)
Date:   Fri, 8 May 2020 17:52:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: swap: fix vmstats for huge pages
Message-ID: <20200508215228.GC226164@cmpxchg.org>
References: <20200508212215.181307-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508212215.181307-1-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 08, 2020 at 02:22:13PM -0700, Shakeel Butt wrote:
> Many of the callbacks called by pagevec_lru_move_fn() do not correctly
> update the vmstats for huge pages. Fix that. Also __pagevec_lru_add_fn()
> use the irq-unsafe alternative to update the stat as the irqs are
> already disabled.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
