Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74861E6879
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405400AbgE1RQP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405364AbgE1RQM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 13:16:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CD4C08C5C7
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 10:16:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z1so693677qtn.2
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=atthkvZPtmuffgqI3U1N92nhhfohScsuYraFPx1a33w=;
        b=etNjUDmYG/GoUh6tlvW65FzID7MhbLN6fmu5w4+qhKKoJPNlpoymnwadrQfmgoqUiQ
         lRYk6V4zjlAp1JoiKlZG7EnTqD9m/LUK2LUxhTjK6XSYT1Qm5Wm13M/uiw0pbGdyJz84
         G4lqCSxJgN5+v+05NyelPzHo0kpcv6Ih5o4w6a6n68b318tTQF7/zNt8STf2OTad3Cx6
         c+5+5OIB9NVG04+b0XA4N+rWS376QGJKQC45cnbq29In09VIZYjftadLqnIw8Jro0HHB
         Uzpsy0cJlADEg5EH40MR2pIpshdxFwaahEEMvaLa2M1R8R0GrhmwOUGvKvbY4ZaT5aVC
         /H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atthkvZPtmuffgqI3U1N92nhhfohScsuYraFPx1a33w=;
        b=YWfcrDOzRrYfFDT805Xfed6m+SpML68xtTClTC0ppEocfJF5OLnUDiosPG/vjstZUG
         R52SgSfgKM5zuslgkuYQNxnNAoxi1ayTKwF7Pr9VN8SeOAPsNVqyj0bH3uT+ntjPDgWg
         Pm4UcjvAZwDChW1OGgwFluRDCBSYlxbA8e01OxD35nLQv287U4Lhkczw7CIZi3a8qxJY
         Xx2B+Gi27ispQQA7qEtv5ZeM1aJWoIMbddCEjyZn3M/SKhac5zE4NmP67IaZbMW7UzKW
         fIAnwid/W5B/FJES953tQleXkpE0GdMsXenCl2sy5opm/OlpKYK4/VD5/vfDqJ7HH62n
         yv9Q==
X-Gm-Message-State: AOAM5300qbQo6rK/L3K55Mf3DQE7F4cUXbHfSSmLOcFbxhIME6HYNC+L
        +ZXo7z0OeIzYH8hQwbmeRVA5Eg==
X-Google-Smtp-Source: ABdhPJwCS97f+Iq6+tL1/KnrLqj2AxEmCpMkEGzROblPiVDpZcR44Tj9rcHcOqb5SgmD+uPHIgwdJg==
X-Received: by 2002:ac8:7112:: with SMTP id z18mr4329049qto.274.1590686171203;
        Thu, 28 May 2020 10:16:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id 10sm5614427qkv.136.2020.05.28.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:16:10 -0700 (PDT)
Date:   Thu, 28 May 2020 13:15:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix an unused-function warning
Message-ID: <20200528171543.GB69521@cmpxchg.org>
References: <20200528095640.151454-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528095640.151454-1-arnd@arndb.de>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 28, 2020 at 11:56:26AM +0200, Arnd Bergmann wrote:
> On NOMMU kernels without CONFIG_MEMCG_KMEM, we now get a harmless
> warning about an unused function:
> 
> mm/memcontrol.c:2595:13: error: unused function 'cancel_charge' [-Werror,-Wunused-function]
> 
> Hide this function in a matching #ifdef.
> 
> Fixes: 5bd144bf764c ("mm: memcontrol: drop unused try/commit/cancel charge API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Arnd!
