Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBB3B84F1
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhF3OWA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhF3OWA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 10:22:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC7C061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 07:19:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y4so2565984pfi.9
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j73ye2WfDEOMrwygrtYKVavEV7MVpq0JpTssNG054oM=;
        b=TmYzzLVMVTiuZjmxW/NiL2ZvKpXBRPYJcaRo+gszw0wIOZEv/DRCpgUu/oveFuve7S
         G1Qqm0VaS61KoUtXiHD36mktGAHBs9/huGR69H2CWL1Sq1/NHjZQ00163ZhFxuGQeKBV
         QutXoKt5uzRuz0fU2ExIYwV8uJ3Cfh4VM7qwOKHnKtvGr8ZTockdHbIYtXrAFJorsYjd
         bL0EVeyijJG0tXfzhNhDzx72EMZXpb+FxYUDEG1RnVUEb5WLIOY/oEXdAPwARnM6bJQo
         plcyRl5t02gHnefVOSavYpjGZlDQ+biPKHOQMnui9AJS14ZATuU+Ik7tb69RGlyi3Ygw
         uprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j73ye2WfDEOMrwygrtYKVavEV7MVpq0JpTssNG054oM=;
        b=qS2G5MM1DbU4TVfPejt+5jrkneY4rmWtyL0kTlcRnRpAdLIE9oXrtTIRE5VR/Ryshl
         Uz0r7HGKEKmskQmwScGAab0NYkm+WW3bk4NdKI0uDGoLnPYrfCv4rNLnSGzYIn9vz6Ls
         hKsZp5Gie/nlAkA1sbMvLdzoLtlKkNa1bHqJh6900FopKGVuLIh38QRffz69fk1PL49g
         n0CztacVEkXrxgLVVCAwzpfWgEmM8M5Vip+LWO7qClZPGzLexQ4F5rRBLlxTqnWMMD43
         GFXa0niH2JlIsPLuIEw6oWvEBV6XmbJELqocb0GFLhLInYbtENk05V08jO7eG2JOIrDK
         2xLQ==
X-Gm-Message-State: AOAM5326ObgQCVvla3ftZ2E4MEbOnB5DhfC9NDOHzqzV6Hrgkn7kIEhl
        sEG3LfD5PnX+rXv4Gr9prvbc3g==
X-Google-Smtp-Source: ABdhPJwBtuVStJlyie9D9CgQpUnmcQLINTExpQrUE4vxCQ/u/hmjFRV5cM7loUNGoNvoQQpzSRJRCg==
X-Received: by 2002:a63:df10:: with SMTP id u16mr34293524pgg.4.1625062771275;
        Wed, 30 Jun 2021 07:19:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:14ba])
        by smtp.gmail.com with ESMTPSA id v3sm22541782pfb.126.2021.06.30.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:19:30 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:19:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 04/18] mm/memcg: Remove soft_limit_tree_node()
Message-ID: <YNx9cLxvtSzOLVaa@cmpxchg.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-5-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:20AM +0100, Matthew Wilcox (Oracle) wrote:
> Opencode this one-line function in its three callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
