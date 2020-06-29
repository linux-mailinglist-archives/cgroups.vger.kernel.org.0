Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7025620D1BA
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgF2SnR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgF2Smw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FA2C02A57F;
        Mon, 29 Jun 2020 06:56:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id o38so12855166qtf.6;
        Mon, 29 Jun 2020 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LrEjvuOin918PAofPsAgLqEkYaBJUx4P898a1Pb6YYM=;
        b=JsskD35qz0tKWuO+mM+x0GiX77OCsGGD4vVCBnK6DOfFQsQR9uocw+MWCsVcLjFD/l
         uVT5fFqZckHiENcqGHRdTsCXwE6L9gIvEROpH+ej4xid3FM9It6v9BUHunTC3MK/j3/2
         TOdOUR9CVZSfBRkUZY9Od9x2BSf/eU/kgwwYswE3hg5EY0/jz385OEfhFGrTYLOf8nlq
         xnUbq5WJsd1oWvXr53EdHHZHwXG5g1p6167gqIJvrXO/Qz59KyepI7sdAiXoXS5aZ1Rt
         HTdttPbGp8H2jq7D7QfAoVhc2MJkN5zTVcmye06vcv9hAzgrOnnRVm08SpGDZwuPdBLs
         rLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LrEjvuOin918PAofPsAgLqEkYaBJUx4P898a1Pb6YYM=;
        b=Kacyb3PTGLOD+hxsmQQu2V6yL+PlhqjHb4GIaAALPfJM0WXCpu22lL5zs+2CYKN3QE
         lGmoiYskqPx0JjfPBnHes4bjFdnr/YPgbMR1hQmq4fIrGVn8UKKEXhE1TkdufBulficu
         rIGhncdmDYNkCqsPvsxgKM91sT8Q+0+OMfVHaJAs3W9e2pTGbJ5rnnxwacAL+J1hiY38
         oT9OAJ0/D/tszk26j13mZ9ImsaO+6SmwtG6c4uHxKTrP/exulPHEo0cz03cK9bvfpOBU
         qHZ40P48MSka+o9iGaN3UQgRtdqWsNvRStTqS8Lc8kRxAVGPeMVxzAQBv2m50amtQbGo
         zPWA==
X-Gm-Message-State: AOAM5338uaouzKgOJzb8rOYAYdGA5sq50C49VxoRpUvC96ovECKJa73R
        v/TtQahl7g+wvCkp0GuLmhR3U2kttvE=
X-Google-Smtp-Source: ABdhPJzVW9rKTRYYquAhom+ajTl8S5hOknpLXTSQ3LijLTqXn91ePIJzb9xDmTsfRnCr1uRKtQrd2Q==
X-Received: by 2002:ac8:154:: with SMTP id f20mr14767600qtg.331.1593439005608;
        Mon, 29 Jun 2020 06:56:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:26be])
        by smtp.gmail.com with ESMTPSA id f22sm19861844qko.89.2020.06.29.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 06:56:44 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:56:43 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: drive-by blk-cgroup cleanups
Message-ID: <20200629135643.GA233973@mtj.thefacebook.com>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 27, 2020 at 09:31:45AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> while looking into another "project" I ended up wading through the
> blkcq code for research and found a bunch of lose ends.  So here is
> a bunch of drive-by cleanups for the code.

The whole series looks great to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
