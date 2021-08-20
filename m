Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2653F2D8B
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhHTN5y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbhHTN5x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 09:57:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA10C061757
        for <cgroups@vger.kernel.org>; Fri, 20 Aug 2021 06:57:15 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f22so1238852qkm.5
        for <cgroups@vger.kernel.org>; Fri, 20 Aug 2021 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJyHipZjn+A3UTVcbj+8xVGYmbEmgDxWJmSdu5/Aei8=;
        b=wF7LYu5sQHUWhmZ/2pO0l/fpD45tai9NK9qM04KFze6DgiXS007/iNB+WGyWl4z36/
         LMalj5UXM0fbkrl8h7O3lSxrfJEo0dBa8TfofFc/92h6FZmo9cIZfrMP5s79keMgNwOr
         PMtBmaGTd1cEVwAppYt6aRHyUkPWowwwYLUaG115yo7yYR/s4wjQjsxt+BBg3d6p3p1h
         BweB0duvM9cpyW+Q4OKP20YM0pH9/OM1mi5xmIz0LkpgnfBure8zXdMdjs2/Q9KBbZDd
         pz1Rn5tVIfdVkgMkbpsIb7T6bsU8E49qhEkT1QIn1xjIl++xtm1CO59w6FN1JJUdYZn6
         a98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJyHipZjn+A3UTVcbj+8xVGYmbEmgDxWJmSdu5/Aei8=;
        b=DwK9/KmzyuwouwasDZTjzC0uq1tp0BxBSvIpcX9WBlJvofPkrcDBHsSOSwZ5S0fZvf
         SC99/G3c9tlG9xBx3+gUoLpHi5bPG5A2KcD3NuCcfQB7fNLl3qK4ivfFqKxBdNfVkivM
         a/+HkZx4P7kUOLzZWazs7HWXvMYNetsMh3MkbLx48SfyPcc5rd4KY3O1fyElfLFL1Sh0
         /Z5HurYMPmlg/H6VxVPOZ+uROMiwOYHU3pVmX+9IrnTQ8WAohrD7/QstIUCQMiXdJaqo
         tCCtjzj6UTNmfP1fHo7MxDQ4b2CUTc1KzCy08usynqjQoZ/EUwQ2RigCJvbNMH9OkVIi
         2sow==
X-Gm-Message-State: AOAM530S7ST7m8XFzH0QGpJzu+9IJdB55Qg4Om/t+Ylb/o1gK6TMcXbM
        5ZdI5MaUfSdtqAeBN8ZevJG0wA==
X-Google-Smtp-Source: ABdhPJzOzvOJs4FxIGIyG38cNRMc7+HVf5uebbAp00uTD3cXDpP4URhrrvA8hAAo2oxKXOQsLBO2sg==
X-Received: by 2002:a37:9fcd:: with SMTP id i196mr8239495qke.247.1629467834153;
        Fri, 20 Aug 2021 06:57:14 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id m68sm1396241qkb.105.2021.08.20.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:57:13 -0700 (PDT)
Date:   Fri, 20 Aug 2021 09:58:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: unexport {,un}lock_page_memcg
Message-ID: <YR+1HfvIJ2K53flA@cmpxchg.org>
References: <20210820095815.445392-1-hch@lst.de>
 <20210820095815.445392-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820095815.445392-3-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 20, 2021 at 11:58:15AM +0200, Christoph Hellwig wrote:
> These are only used in built-in core mm code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Good catch.

It was initially exported for xfs dirtying, and is no longer needed
after that switched to iomap (and now __set_page_dirty_nobuffers).

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
